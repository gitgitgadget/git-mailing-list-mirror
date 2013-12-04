From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] mv: let 'git mv file no-such-dir/' error out
Date: Wed,  4 Dec 2013 18:37:01 +0100
Message-ID: <1386178621-12822-1-git-send-email-Matthieu.Moy@imag.fr>
References: <CACsJy8BdXkzzZpEaOvqkJ8ckubbQ0ArOMUT8qnMHMDscupfj_A@mail.gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 04 18:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoGOg-0002i3-Q3
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 18:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106Ab3LDRh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 12:37:59 -0500
Received: from mx2.imag.fr ([129.88.30.17]:45989 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327Ab3LDRh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 12:37:58 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id rB4Hb2LC013619
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Dec 2013 18:37:02 +0100
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VoGNk-0005PG-Ip; Wed, 04 Dec 2013 18:37:04 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VoGNk-0003La-5Y; Wed, 04 Dec 2013 18:37:04 +0100
X-Mailer: git-send-email 1.8.5.rc3.4.g8bd3721
In-Reply-To: <CACsJy8BdXkzzZpEaOvqkJ8ckubbQ0ArOMUT8qnMHMDscupfj_A@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 04 Dec 2013 18:37:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rB4Hb2LC013619
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1386783425.00323@enhvH2tUYihqLMKkTpeA9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238792>

Git used to trim the trailing slash, and make the command equivalent to
'git mv file no-such-dir', which created the file no-such-dir (while the
trailing slash explicitly stated that it could only be a directory).

This patch skips the trailing slash removal for the destination path. The
path with its trailing slash is passed to rename(2), which errors out
with the appropriate message:

  $ git mv file no-such-dir/
  fatal: renaming 'file' failed: Not a directory

Original-patch-by: Duy Nguyen <pclouds@gmail.com>
Tests, tweaks and commit message by: Matthieu Moy <Matthieu.Moy@imag.fr>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
So, this patch adds more tests, as suggested by Duy. They all pass
without modifying the code.

 builtin/mv.c  | 23 ++++++++++++++++-------
 t/t7001-mv.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 2e0e61b..08fbc03 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -16,9 +16,12 @@ static const char * const builtin_mv_usage[] = {
 	NULL
 };
 
+#define DUP_BASENAME 1
+#define KEEP_TRAILING_SLASH 2
+
 static const char **internal_copy_pathspec(const char *prefix,
 					   const char **pathspec,
-					   int count, int base_name)
+					   int count, unsigned flags)
 {
 	int i;
 	const char **result = xmalloc((count + 1) * sizeof(const char *));
@@ -27,11 +30,12 @@ static const char **internal_copy_pathspec(const char *prefix,
 	for (i = 0; i < count; i++) {
 		int length = strlen(result[i]);
 		int to_copy = length;
-		while (to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
+		while (!(flags & KEEP_TRAILING_SLASH) &&
+		       to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
 			to_copy--;
-		if (to_copy != length || base_name) {
+		if (to_copy != length || flags & DUP_BASENAME) {
 			char *it = xmemdupz(result[i], to_copy);
-			if (base_name) {
+			if (flags & DUP_BASENAME) {
 				result[i] = xstrdup(basename(it));
 				free(it);
 			} else
@@ -87,16 +91,21 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 	source = internal_copy_pathspec(prefix, argv, argc, 0);
 	modes = xcalloc(argc, sizeof(enum update_mode));
-	dest_path = internal_copy_pathspec(prefix, argv + argc, 1, 0);
+	/*
+	 * Keep trailing slash, needed to let
+	 * "git mv file no-such-dir/" error out.
+	 */
+	dest_path = internal_copy_pathspec(prefix, argv + argc, 1,
+					   KEEP_TRAILING_SLASH);
 	submodule_gitfile = xcalloc(argc, sizeof(char *));
 
 	if (dest_path[0][0] == '\0')
 		/* special case: "." was normalized to "" */
-		destination = internal_copy_pathspec(dest_path[0], argv, argc, 1);
+		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	else if (!lstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
 		dest_path[0] = add_slash(dest_path[0]);
-		destination = internal_copy_pathspec(dest_path[0], argv, argc, 1);
+		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	} else {
 		if (argc != 1)
 			die("destination '%s' is not a directory", dest_path[0]);
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index b90e985..2f82478 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -70,6 +70,35 @@ test_expect_success \
 rm -f idontexist untracked1 untracked2 \
      path0/idontexist path0/untracked1 path0/untracked2 \
      .git/index.lock
+rmdir path1
+
+test_expect_success \
+    'moving to absent target with trailing slash' \
+    'test_must_fail git mv path0/COPYING no-such-dir/ &&
+     test_must_fail git mv path0/COPYING no-such-dir// &&
+     git mv path0/ no-such-dir/ &&
+     test_path_is_dir no-such-dir/'
+
+test_expect_success \
+    'clean up' \
+    'git reset --hard'
+
+test_expect_success \
+    'moving to existing untracked target with trailing slash' \
+    'mkdir path1 &&
+     git mv path0/ path1/ &&
+     test_path_is_dir path1/path0/'
+
+test_expect_success \
+    'moving to existing tracked target with trailing slash' \
+    'mkdir path2 &&
+     >path2/file && git add path2/file &&
+     git mv path1/path0/ path2/ &&
+     test_path_is_dir path2/path0/'
+
+test_expect_success \
+    'clean up' \
+    'git reset --hard'
 
 test_expect_success \
     'adding another file' \
-- 
1.8.5.rc3.4.g8bd3721
