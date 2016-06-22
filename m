Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4B120189
	for <e@80x24.org>; Wed, 22 Jun 2016 21:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbcFVVKB (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 17:10:01 -0400
Received: from kitenet.net ([66.228.36.95]:59300 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbcFVVKB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 17:10:01 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=HpmSlqlT;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466629760; bh=L0EAV6U2Sym70XtzDIx6E+mlovEW7IWQL7z6Z0dKAXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HpmSlqlTLWrZp4pvmLQCaADnXNJsqeH2r8LiY8NALHQPXN3Oz/1aD16zd4PXVLTkE
	 +bn0VpobkOw0y/b1AvCuLNAPnK7NueWBwqxt0H4JhJouZJl4d3sE25d93w12xBH+dQ
	 hI+CKzGCf3yNXR5IS3NJ5Odz4upZOPERWvUazKEY=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v4 6/8] better recovery from failure of smudgeToFile filter
Date:	Wed, 22 Jun 2016 17:09:16 -0400
Message-Id: <1466629758-8035-7-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1466629758-8035-1-git-send-email-joeyh@joeyh.name>
References: <1466629758-8035-1-git-send-email-joeyh@joeyh.name>
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC,SPF_SOFTFAIL,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If the smudgeToFile filter fails, it can leave the worktree file with the
wrong content, or even deleted. Recover from this by falling back to
running the smudge filter.

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 entry.c               | 55 ++++++++++++++++++++++++++++++++-------------------
 t/t0021-conversion.sh | 24 ++++++++++++++++++++++
 2 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/entry.c b/entry.c
index 97975e5..8322127 100644
--- a/entry.c
+++ b/entry.c
@@ -181,12 +181,6 @@ static int write_entry(struct cache_entry *ce,
 		int regular_file = ce_mode_s_ifmt == S_IFREG;
 		int smudge_to_file = regular_file
 			&& can_smudge_to_file(ce->name);
-		if (regular_file && ! smudge_to_file &&
-		    convert_to_working_tree(ce->name, new, size, &buf)) {
-			free(new);
-			new = strbuf_detach(&buf, &newsize);
-			size = newsize;
-		}
 
 		fd = open_output_fd(path, ce, to_tempfile);
 		if (fd < 0) {
@@ -194,7 +188,42 @@ static int write_entry(struct cache_entry *ce,
 			return error_errno("unable to create file %s", path);
 		}
 
+		if (smudge_to_file) {
+			close(fd);
+			if (! convert_to_working_tree_filter_to_file(ce->name, path, new, size)) {
+				smudge_to_file = 0;
+				/* The failing smudgeToFile filter may have
+				 * deleted or replaced the file; delete
+				 * the file and re-open for recovery write.
+				 */
+				unlink(path);
+				fd = open_output_fd(path, ce, to_tempfile);
+				if (fd < 0) {
+					free(new);
+					return error_errno("unable to create file %s", path);
+				}
+			}
+			else {
+				free(new);
+				/* The smudgeToFile filter may have replaced
+				 * or deleted the file; reopen it to make sure
+				 * that the file exists. */
+				fd = open(path, O_RDONLY);
+				if (fd < 0)
+					return error_errno("unable to create file %s", path);
+				if (!to_tempfile)
+					fstat_done = fstat_output(fd, state, &st);
+				close(fd);
+			}
+		}
+
 		if (! smudge_to_file) {
+			if (regular_file &&
+			    convert_to_working_tree(ce->name, new, size, &buf)) {
+				free(new);
+				new = strbuf_detach(&buf, &newsize);
+				size = newsize;
+			}
 			wrote = write_in_full(fd, new, size);
 			if (!to_tempfile)
 				fstat_done = fstat_output(fd, state, &st);
@@ -203,20 +232,6 @@ static int write_entry(struct cache_entry *ce,
 			if (wrote != size)
 				return error("unable to write file %s", path);
 		}
-		else {
-			close(fd);
-			convert_to_working_tree_filter_to_file(ce->name, path, new, size);
-			free(new);
-			/* The smudgeToFile filter may have replaced the
-			 * file; open it to make sure that the file
-			 * exists. */
-			fd = open(path, O_RDONLY);
-			if (fd < 0)
-				return error_errno("unable to create file %s", path);
-			if (!to_tempfile)
-				fstat_done = fstat_output(fd, state, &st);
-			close(fd);
-		}
 		break;
 	case S_IFGITLINK:
 		if (to_tempfile)
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index cba03fd..c0b4709 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -28,6 +28,14 @@ touch rot13-to-file.ran
 EOF
 chmod +x rot13-to-file.sh
 
+cat <<EOF >delete-file-and-fail.sh
+#!$SHELL_PATH
+destfile="\$1"
+rm -f "\$destfile"
+exit 1
+EOF
+chmod +x delete-file-and-fail.sh
+
 test_expect_success setup '
 	git config filter.rot13.smudge ./rot13.sh &&
 	git config filter.rot13.clean ./rot13.sh &&
@@ -310,6 +318,22 @@ test_expect_success 'smudgeToFile filter is used when checking out a file' '
 	rm -f rot13-to-file.ran
 '
 
+test_expect_success 'recovery from failure of smudgeToFile filter, using smudge filter' '
+	test_config filter.rot13.smudgeToFile false &&
+
+	rm -f fstest.t &&
+	git checkout -- fstest.t &&
+	cmp test fstest.t
+'
+
+test_expect_success 'recovery from failure of smudgeToFile filter that deletes the worktree file' '
+	test_config filter.rot13.smudgeToFile ./delete-file-and-fail.sh &&
+
+	rm -f fstest.t &&
+	git checkout -- fstest.t &&
+	cmp test fstest.t
+'
+
 test_expect_success 'cleanFromFile filter is not used when clean filter is not configured' '
 	test_config filter.noclean.smudge ./rot13.sh &&
 	test_config filter.noclean.cleanFromFile ./rot13-from-file.sh &&
-- 
2.9.0.587.ga3bedf2

