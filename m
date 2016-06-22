Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF82D20189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbcFVUWO (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:22:14 -0400
Received: from kitenet.net ([66.228.36.95]:57474 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbcFVUWN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:22:13 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=O764ySKK;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466626900; bh=tZKTza6j5Bgb+MetOZlihKbjqJkwh636uFG94s8yMqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O764ySKKLMoyvYyu6U3Rr1PCLR24UkPIyfDYrd20aUJ3KmE1Lch9lR8mgd3k8BkwI
	 rMjcR1dKLyJ4Tmy26kuIeChHwlpE+waTyVQWVFEAAW8NGTNW40aeh16IrbYh9r4+FV
	 kHNNW6iL71KW9lXxr3W5SeTl63u24mYGOmtmravk=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v3 8/8] use smudgeToFile filter in recursive merge
Date:	Wed, 22 Jun 2016 16:21:33 -0400
Message-Id: <20160622202133.23565-9-joeyh@joeyh.name>
X-Mailer: git-send-email 2.9.0.8.gf959b2a
In-Reply-To: <20160622202133.23565-1-joeyh@joeyh.name>
References: <20160622202133.23565-1-joeyh@joeyh.name>
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC,SPF_SOFTFAIL,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
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
 merge-recursive.c     | 42 ++++++++++++++++++++++++++++++++----------
 t/t0021-conversion.sh | 16 +++++++++++++++-
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 65cb5d6..012fe38 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -765,14 +765,6 @@ static void update_file_flags(struct merge_options *o,
 			die(_("cannot read object %s '%s'"), sha1_to_hex(sha), path);
 		if (type != OBJ_BLOB)
 			die(_("blob expected for %s '%s'"), sha1_to_hex(sha), path);
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
@@ -781,6 +773,7 @@ static void update_file_flags(struct merge_options *o,
 		}
 		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
 			int fd;
+			int isreg = S_ISREG(mode);
 			if (mode & 0100)
 				mode = 0777;
 			else
@@ -788,8 +781,37 @@ static void update_file_flags(struct merge_options *o,
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 			if (fd < 0)
 				die_errno(_("failed to open '%s'"), path);
-			write_in_full(fd, buf, size);
-			close(fd);
+
+			int smudge_to_file = can_smudge_to_file(path);
+			if (smudge_to_file) {
+				close(fd);
+				fd = convert_to_working_tree_filter_to_file(path, path, buf, size);
+				if (fd < 0) {
+					/* smudgeToFile filter failed;
+					 * continue with regular file
+					 * creation. */
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
+			if (! smudge_to_file) {
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
index fd07bd6..2722013 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -334,10 +334,24 @@ test_expect_success 'recovery from failure of smudgeToFile filter that deletes t
 	cmp test fstest.t
 '
 
+test_expect_success 'smudgeToFile filter is used in merge' '
+	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
+
+	git commit -m "added fstest.t" fstest.t &&
+	git checkout -b old &&
+	git reset --hard HEAD^ &&
+	git merge master &&
+
+	test -e rot13-to-file.ran &&
+	rm -f rot13-to-file.ran &&
+
+	cmp test fstest.t &&
+	git checkout master
+'
+
 test_expect_success 'smudgeToFile filter is used by git am' '
 	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
 
-	git commit fstest.t -m "added fstest.t" &&
 	git format-patch HEAD^ --stdout > fstest.patch &&
 	git reset --hard HEAD^ &&
 	git am < fstest.patch &&
-- 
2.9.0.8.g973eabb.dirty

