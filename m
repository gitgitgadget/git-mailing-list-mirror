From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] git mv file directory/ creates the file directory
Date: Mon, 02 Dec 2013 18:07:54 +0100
Message-ID: <vpq61r7npud.fsf@anie.imag.fr>
References: <vpqli03sh61.fsf@anie.imag.fr> <20131202133544.GA8755@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 18:08:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnWyb-0007mu-70
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 18:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002Ab3LBRIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 12:08:00 -0500
Received: from mx1.imag.fr ([129.88.30.5]:41185 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab3LBRIA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 12:08:00 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id rB2H7qY1031058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Dec 2013 18:07:52 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rB2H7som000938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 2 Dec 2013 18:07:54 +0100
In-Reply-To: <20131202133544.GA8755@lanh> (Duy Nguyen's message of "Mon, 2 Dec
	2013 20:35:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 02 Dec 2013 18:07:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rB2H7qY1031058
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1386608875.9544@BSUloBgTItFLAZ4JZljiVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238638>

Duy Nguyen <pclouds@gmail.com> writes:

> This may be a start. Does not seem to break anything..

I did not thoroughly review/test, but it does fix my case. Below is the
same patch with one test case. No time to do more right now.

Thanks,

>From 99985341ed1312cf6a7b63e14be7da0d51c701b4 Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Mon, 2 Dec 2013 18:03:20 +0100
Subject: [PATCH] WIP: error out on git mv file no-such-dir/

---
 builtin/mv.c  | 18 +++++++++++-------
 t/t7001-mv.sh |  9 +++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 2e0e61b..0fcccd5 100644
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
@@ -87,16 +91,16 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 	source = internal_copy_pathspec(prefix, argv, argc, 0);
 	modes = xcalloc(argc, sizeof(enum update_mode));
-	dest_path = internal_copy_pathspec(prefix, argv + argc, 1, 0);
+	dest_path = internal_copy_pathspec(prefix, argv + argc, 1, KEEP_TRAILING_SLASH);
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
index b90e985..7e74bf3 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -72,6 +72,15 @@ rm -f idontexist untracked1 untracked2 \
      .git/index.lock
 
 test_expect_success \
+    'moving to target with trailing slash' \
+    'test_must_fail git mv path0/COPYING no-such-dir/ &&
+     git mv path0/ no-such-dir/'
+
+test_expect_success \
+    'clean up' \
+    'git reset --hard'
+
+test_expect_success \
     'adding another file' \
     'cp "$TEST_DIRECTORY"/../README path0/README &&
      git add path0/README &&
-- 
1.8.5.rc3.4.g8bd3721

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
