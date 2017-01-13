Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE80020798
	for <e@80x24.org>; Fri, 13 Jan 2017 10:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbdAMK2a (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 05:28:30 -0500
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:53462 "EHLO
        koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbdAMK23 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 05:28:29 -0500
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jan 2017 05:27:59 EST
Received: from hurricane.booking.pcln.com (unknown [5.57.20.50])
        by koekblik.kaarsemaker.net (Postfix) with ESMTP id B0C41804EC;
        Fri, 13 Jan 2017 11:20:30 +0100 (CET)
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 2/2] diff --no-index: support reading from pipes
Date:   Fri, 13 Jan 2017 11:20:21 +0100
Message-Id: <20170113102021.6054-3-dennis@kaarsemaker.net>
X-Mailer: git-send-email 2.11.0-234-gaf85957
In-Reply-To: <20170113102021.6054-1-dennis@kaarsemaker.net>
References: <20170113102021.6054-1-dennis@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff <(command1) <(command2) provides useful output, let's make it
possible for git to do the same.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 diff-no-index.c          |  8 ++++++++
 diff.c                   | 13 +++++++++++--
 t/t4053-diff-no-index.sh | 10 ++++++++++
 t/test-lib.sh            |  4 ++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 826fe97ffc..2123da435b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -83,6 +83,14 @@ static struct diff_filespec *noindex_filespec(const char *name, int mode)
 		name = "/dev/null";
 	s = alloc_filespec(name);
 	fill_filespec(s, null_sha1, 0, mode);
+	/*
+	 * In --no-index mode, we support reading from pipes. canon_mode, called by
+	 * fill_filespec, gets confused by this and thinks we now have subprojects.
+	 * Detect this and tell the rest of the diff machinery to treat pipes as
+	 * normal files.
+	 */
+	if (S_ISGITLINK(s->mode))
+		s->mode = S_IFREG | ce_permissions(mode);
 	if (name == file_from_standard_input)
 		populate_from_stdin(s);
 	return s;
diff --git a/diff.c b/diff.c
index 2fc0226338..bb04eab331 100644
--- a/diff.c
+++ b/diff.c
@@ -2839,9 +2839,18 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		fd = open(s->path, O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
-		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (!S_ISREG(st.st_mode)) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_read(&sb, fd, 0);
+			s->size = sb.len;
+			s->data = strbuf_detach(&sb, NULL);
+			s->should_free = 1;
+		}
+		else {
+			s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+			s->should_munmap = 1;
+		}
 		close(fd);
-		s->should_munmap = 1;
 
 		/*
 		 * Convert from working tree format to canonical git format
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index c6046fef19..ba343566c0 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -157,4 +157,14 @@ test_expect_success SYMLINKS 'diff --no-index --no-dereference does not follow s
 	test_cmp expect actual
 '
 
+test_expect_success PROCESS_SUBSTITUTION 'diff --no-index works on fifos' '
+	cat >expect <<\EOF
+		@@ -1 +1 @@
+		-1
+		+2
+	EOF
+	test_expect_code 1 git diff --no-index <(echo 1) <(echo 2) | tail -n +5 > actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 11562bde10..78f3d24651 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1128,3 +1128,7 @@ build_option () {
 test_lazy_prereq LONG_IS_64BIT '
 	test 8 -le "$(build_option sizeof-long)"
 '
+
+test_lazy_prereq PROCESS_SUBSTITUTION '
+	eval "foo=<(echo test)" 2>/dev/null
+'
-- 
2.11.0-234-gaf85957

