Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67A61FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 20:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbcFPUd5 (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 16:33:57 -0400
Received: from kitenet.net ([66.228.36.95]:45024 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754493AbcFPUd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 16:33:56 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=BBVddv3z;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466109184; bh=2D3pY3rEQ05Sz5WtULc/whI9n+5HtDrcRJnND+dkMII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBVddv3zBBbHo+Pw9gxdXdHbZhej5BZfC6l+FJWrVvnWxQM18D2V9ZWMMaMz5NMkU
	 MUfQQ075D+nkPqSWusUsO5z95RVmG+50iELo9wGyC/w92ZatYMVjk/3xJncLX3HUsR
	 MBJv6QNhDcHEFneVoI86b37dmW0ruLDcNIjf0dDY=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH 4/4] use smudge-to-file in git checkout etc
Date:	Thu, 16 Jun 2016 16:32:59 -0400
Message-Id: <20160616203259.5886-5-joeyh@joeyh.name>
X-Mailer: git-send-email 2.9.0.4.g2856e74.dirty
In-Reply-To: <20160616203259.5886-1-joeyh@joeyh.name>
References: <20160616203259.5886-1-joeyh@joeyh.name>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This makes git checkout, git reset, etc use smudge-to-file.

Includes test cases.

(There's a call to convert_to_working_tree in merge-recursive.c
that could also be made to use smudge-to-file as well.)

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 entry.c               | 34 +++++++++++++++++++++++++++-------
 t/t0021-conversion.sh | 44 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/entry.c b/entry.c
index 519e042..6a23159 100644
--- a/entry.c
+++ b/entry.c
@@ -175,8 +175,12 @@ static int write_entry(struct cache_entry *ce,
 
 		/*
 		 * Convert from git internal format to working tree format
+		 * unless the smudge-to-file filter can write to the
+		 * file directly.
 		 */
+		int smudge_to_file = can_smudge_to_file(ce->name);
 		if (ce_mode_s_ifmt == S_IFREG &&
+		    ! smudge_to_file &&
 		    convert_to_working_tree(ce->name, new, size, &buf)) {
 			free(new);
 			new = strbuf_detach(&buf, &newsize);
@@ -189,13 +193,29 @@ static int write_entry(struct cache_entry *ce,
 			return error_errno("unable to create file %s", path);
 		}
 
-		wrote = write_in_full(fd, new, size);
-		if (!to_tempfile)
-			fstat_done = fstat_output(fd, state, &st);
-		close(fd);
-		free(new);
-		if (wrote != size)
-			return error("unable to write file %s", path);
+		if (! can_smudge_to_file(ce->name)) {
+			wrote = write_in_full(fd, new, size);
+			if (!to_tempfile)
+				fstat_done = fstat_output(fd, state, &st);
+			close(fd);
+			free(new);
+			if (wrote != size)
+				return error("unable to write file %s", path);
+		}
+		else {
+			close(fd);
+			convert_to_working_tree_filter_to_file(ce->name, path, new, size);
+			free(new);
+			if (!to_tempfile) {
+				/* Re-open the file to stat it; the
+				 * smudge-to-file filter may have replaced
+				 * the file. */
+				fd = open(path, O_RDONLY);
+				if (fd < 0) {
+					return error_errno("unable to create file %s", path);
+				}
+			}
+		}
 		break;
 	case S_IFGITLINK:
 		if (to_tempfile)
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 1043ea5..b0e2e5e 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -14,12 +14,20 @@ chmod +x rot13.sh
 
 cat <<EOF >rot13-from-file.sh
 #!$SHELL_PATH
-fsfile="\$1"
+srcfile="\$1"
 touch rot13-from-file.ran
-cat "\$fsfile" | ./rot13.sh
+cat "\$srcfile" | ./rot13.sh
 EOF
 chmod +x rot13-from-file.sh
 
+cat <<EOF >rot13-to-file.sh
+#!$SHELL_PATH
+destfile="\$1"
+touch rot13-to-file.ran
+./rot13.sh > "\$destfile"
+EOF
+chmod +x rot13-to-file.sh
+
 test_expect_success setup '
 	git config filter.rot13.smudge ./rot13.sh &&
 	git config filter.rot13.clean ./rot13.sh &&
@@ -291,17 +299,37 @@ test_expect_success 'clean-from-file filter is used when adding a file' '
 	cmp test.t fstest.t
 '
 
+test_expect_success 'smudge-to-file filter is used when checking out a file' '
+	test_config filter.rot13.smudge-to-file "./rot13-to-file.sh %p" &&
+
+	rm -f fstest.t &&
+	git checkout -- fstest.t &&
+	cmp test.t fstest.t &&
+
+	test -e rot13-to-file.ran &&
+	rm -f rot13-to-file.ran
+'
+
 test_expect_success 'clean-from-file filter is not used when clean filter is not configured' '
-	test_config filter.no.smudge ./rot13.sh &&
-	test_config filter.no.clean-from-file "./rot13-from-file.sh %p" &&
+	test_config filter.noclean.smudge ./rot13.sh &&
+	test_config filter.noclean.clean-from-file "./rot13-from-file.sh %p" &&
 
-	echo "*.no filter=no" >.gitattributes &&
+	echo "*.no filter=noclean" >.gitattributes &&
 
 	cat test.t >test.no &&
 	git add test.no &&
-	test ! -e rot13-from-file.ran &&
-	git cat-file blob :test.no >actual &&
-	cmp test.t actual
+	test ! -e rot13-from-file.ran
+'
+
+test_expect_success 'smudge-to-file filter is not used when smudge filter is not configured' '
+	test_config filter.nosmudge.clean ./rot13.sh &&
+	test_config filter.nosmudge.smudge-to-file "./rot13-to-file.sh %p" &&
+
+	echo "*.no filter=nosmudge" >.gitattributes &&
+
+	rm -f fstest.t &&
+	git checkout -- fstest.t &&
+	test ! -e rot13-to-file.ran
 '
 
 test_done
-- 
2.9.0.4.g2856e74.dirty

