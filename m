Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335932095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbdCRV0r (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:26:47 -0400
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:52114 "EHLO
        koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdCRV0o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 17:26:44 -0400
Received: from localhost.localdomain (unknown [145.129.9.233])
        by koekblik.kaarsemaker.net (Postfix) with ESMTP id 2C45380389;
        Sat, 18 Mar 2017 22:00:34 +0100 (CET)
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v3 2/2] diff --no-index: support reading from pipes
Date:   Sat, 18 Mar 2017 22:00:38 +0100
Message-Id: <20170318210038.22638-3-dennis@kaarsemaker.net>
X-Mailer: git-send-email 2.12.0-437-g0cc2799
In-Reply-To: <20170318210038.22638-1-dennis@kaarsemaker.net>
References: <20170318210038.22638-1-dennis@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff <(command1) <(command2) provides useful output, let's make it
possible for git to do the same.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 diff-no-index.c          |  9 +++++++++
 diff.c                   | 18 ++++++++++++++++--
 t/t4053-diff-no-index.sh | 10 ++++++++++
 t/test-lib.sh            |  4 ++++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index fe48f32ddd..1262a587e5 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -83,6 +83,15 @@ static struct diff_filespec *noindex_filespec(const char *name, int mode)
 		name = "/dev/null";
 	s = alloc_filespec(name);
 	fill_filespec(s, null_sha1, 0, mode);
+	/*
+	 * In --no-index mode, we support reading from pipes. canon_mode, called by
+	 * fill_filespec, gets confused by this and thinks we now have subprojects.
+	 * To help the rest of the diff machinery along, we now override what
+	 * canon_mode says. This is done here instead of in canon_mode, because the
+	 * rest of git does not (and should not) support pipes.
+	 */
+	if (S_ISFIFO(mode))
+		s->mode = S_IFREG | ce_permissions(mode);
 	if (name == file_from_standard_input)
 		populate_from_stdin(s);
 	return s;
diff --git a/diff.c b/diff.c
index 2afecfb939..4f74a54d74 100644
--- a/diff.c
+++ b/diff.c
@@ -2765,6 +2765,11 @@ static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
 	return 0;
 }
 
+static int should_mmap_file_contents(struct stat *st)
+{
+	return S_ISREG(st->st_mode);
+}
+
 /*
  * While doing rename detection and pickaxe operation, we may need to
  * grab the data for the blob (or file) for our own in-core comparison.
@@ -2839,9 +2844,18 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		fd = open(s->path, O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
-		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (!should_mmap_file_contents(&st)) {
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
index 8c87bffb34..2d9b322315 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -171,4 +171,14 @@ test_expect_success SYMLINKS 'diff --no-index --no-dereference does not follow s
 	test_cmp expect actual
 '
 
+test_expect_success PROCESS_SUBSTITUTION 'diff --no-index works on fifos' '
+	cat >expect <<-EOF &&
+		@@ -1 +1 @@
+		-1
+		+2
+	EOF
+	test_expect_code 1 git diff --no-index --dereference <(echo 1) <(echo 2) | tail -n +5 > actual &&
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
2.12.0-437-g0cc2799

