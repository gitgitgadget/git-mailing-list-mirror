Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D882018F
	for <e@80x24.org>; Mon, 11 Jul 2016 22:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbcGKWrR (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 18:47:17 -0400
Received: from kitenet.net ([66.228.36.95]:32778 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbcGKWrO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 18:47:14 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=VKChWnWm;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1468277198; bh=e7pd1+fJ7kJE3zbr6Uuf5rQkwlF5ZqMSMu31as4SNuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKChWnWmsu86vvKjaYknMgW76bozccToHJNzUBKXMXKt57vEc+PiDgxiMNKvA57iJ
	 /S26T8zVRqNUsPdzXsLMoCVA+T2EPLwSv/dLjBIwrTT+yveUiaH2Q4U9jzqDkU/GYy
	 8iEtbg7ly/pnrWgjApNsnbMY5OogcAINTDod/flY=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v5 8/8] use smudgeToFile filter in recursive merge
Date:	Mon, 11 Jul 2016 18:45:12 -0400
Message-Id: <1468277112-9909-9-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
References: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Recursive merge updates the work tree and so should use the smudgeToFile
filter.

At this point, smudgeToFile is run by everything that updates work
tree files.

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 merge-recursive.c     | 53 ++++++++++++++++++++++++++++++++++++++++-----------
 t/t0021-conversion.sh | 16 +++++++++++++++-
 2 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a4a1195..5fe3f50 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -758,6 +758,7 @@ static void update_file_flags(struct merge_options *o,
 		enum object_type type;
 		void *buf;
 		unsigned long size;
+		int isreg;
 
 		if (S_ISGITLINK(mode)) {
 			/*
@@ -774,22 +775,16 @@ static void update_file_flags(struct merge_options *o,
 			die(_("cannot read object %s '%s'"), oid_to_hex(oid), path);
 		if (type != OBJ_BLOB)
 			die(_("blob expected for %s '%s'"), oid_to_hex(oid), path);
-		if (S_ISREG(mode)) {
-			struct strbuf strbuf = STRBUF_INIT;
-			if (convert_to_working_tree(path, buf, size, &strbuf)) {
-				free(buf);
-				size = strbuf.len;
-				buf = strbuf_detach(&strbuf, NULL);
-			}
-		}
 
 		if (make_room_for_path(o, path) < 0) {
 			update_wd = 0;
 			free(buf);
 			goto update_index;
 		}
-		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
+		isreg = S_ISREG(mode);
+		if (isreg || (!has_symlinks && S_ISLNK(mode))) {
 			int fd;
+			int smudge_to_file;
 			if (mode & 0100)
 				mode = 0777;
 			else
@@ -797,8 +792,44 @@ static void update_file_flags(struct merge_options *o,
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 			if (fd < 0)
 				die_errno(_("failed to open '%s'"), path);
-			write_in_full(fd, buf, size);
-			close(fd);
+
+			smudge_to_file = can_smudge_to_file(path);
+			if (smudge_to_file) {
+				close(fd);
+				fd = convert_to_working_tree_filter_to_file(path, path, buf, size);
+				if (fd < 0) {
+					/*
+					 * smudgeToFile filter failed;
+					 * continue with regular file
+					 * creation.
+					 */
+					smudge_to_file = 0;
+					fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
+					if (fd < 0)
+						die_errno(_("failed to open '%s'"), path);
+				}
+				else {
+					close(fd);
+				}
+			}
+
+			/*
+			 * Not an else of above if (smudge_to_file) because
+			 * the smudgeToFile filter may fail and in that case
+			 * this is run to recover.
+			 */
+			if (!smudge_to_file) {
+				if (isreg) {
+					struct strbuf strbuf = STRBUF_INIT;
+					if (convert_to_working_tree(path, buf, size, &strbuf)) {
+						free(buf);
+						size = strbuf.len;
+						buf = strbuf_detach(&strbuf, NULL);
+					}
+				}
+				write_in_full(fd, buf, size);
+				close(fd);
+			}
 		} else if (S_ISLNK(mode)) {
 			char *lnk = xmemdupz(buf, size);
 			safe_create_leading_directories_const(path);
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 42b28aa..64b2b8f 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -334,10 +334,24 @@ test_expect_success 'recovery from failure of smudgeToFile filter that deletes t
 	test_cmp test fstest.t
 '
 
+test_expect_success 'smudgeToFile filter is used in merge' '
+	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
+
+	git commit -m "added fstest.t" fstest.t &&
+	git checkout -b old &&
+	git reset --hard HEAD^ &&
+	git merge master &&
+	git checkout master &&
+
+	test -e rot13-to-file.ran &&
+	rm -f rot13-to-file.ran &&
+
+	test_cmp test fstest.t
+'
+
 test_expect_success 'smudgeToFile filter is used by git am' '
 	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
 
-	git commit fstest.t -m "added fstest.t" &&
 	git format-patch HEAD^ --stdout >fstest.patch &&
 	git reset --hard HEAD^ &&
 	git am fstest.patch &&
-- 
2.8.1

