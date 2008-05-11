From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] rev-parse --verify: do not output anything on error
Date: Sun, 11 May 2008 18:28:25 +0200
Message-ID: <20080511182825.42bc6ec9.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 18:24:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvELl-0002qC-6J
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbYEKQXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 12:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbYEKQXo
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:23:44 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:33965 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbYEKQXn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 12:23:43 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 896731AB303;
	Sun, 11 May 2008 18:23:42 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 4EE041AB2F4;
	Sun, 11 May 2008 18:23:42 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81789>

Before this patch, when "git rev-parse --verify" was passed at least one
good rev and then anything, it would output something for the good rev
even if it would latter exit on error.

With this patch, we only output something if everything is ok.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-parse.c         |   38 +++++++++++++++++++++++---------------
 t/t1503-rev-parse-verify.sh |   12 +++---------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 7dbf282..03b5f59 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -28,8 +28,6 @@ static int symbolic;
 static int abbrev;
 static int output_sq;
 
-static int revs_count;
-
 /*
  * Some arguments are relevant "revision" arguments,
  * others are about output format or other details.
@@ -102,7 +100,6 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
 	if (!(filter & DO_REVS))
 		return;
 	def = NULL;
-	revs_count++;
 
 	if (type != show_type)
 		putchar('^');
@@ -150,7 +147,7 @@ static int show_flag(const char *arg)
 	return 0;
 }
 
-static void show_default(void)
+static int show_default(void)
 {
 	const char *s = def;
 
@@ -160,9 +157,10 @@ static void show_default(void)
 		def = NULL;
 		if (!get_sha1(s, sha1)) {
 			show_rev(NORMAL, sha1, s);
-			return;
+			return 1;
 		}
 	}
+	return 0;
 }
 
 static int show_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
@@ -375,8 +373,9 @@ static void die_no_single_rev(int quiet)
 
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
-	int i, as_is = 0, verify = 0, quiet = 0;
+	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type;
 	unsigned char sha1[20];
+	const char *name;
 
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
@@ -568,12 +567,17 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		/* Not a flag argument */
 		if (try_difference(arg))
 			continue;
-		if (!get_sha1(arg, sha1)) {
-			show_rev(NORMAL, sha1, arg);
-			continue;
+		name = arg;
+		type = NORMAL;
+		if (*arg == '^') {
+			name++;
+			type = REVERSED;
 		}
-		if (*arg == '^' && !get_sha1(arg+1, sha1)) {
-			show_rev(REVERSED, sha1, arg+1);
+		if (!get_sha1(name, sha1)) {
+			if (verify)
+				revs_count++;
+			else
+				show_rev(type, sha1, name);
 			continue;
 		}
 		if (verify)
@@ -583,10 +587,14 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			continue;
 		verify_filename(prefix, arg);
 	}
-	if (verify && revs_count == 1)
-		return 0;
-	show_default();
-	if (verify && revs_count != 1)
+	if (verify) {
+		if (revs_count == 1) {
+			show_rev(type, sha1, name);
+			return 0;
+		} else if (revs_count == 0 && show_default())
+			return 0;
 		die_no_single_rev(quiet);
+	} else
+		show_default();
 	return 0;
 }
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index e93f1b3..95244c9 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -83,17 +83,11 @@ test_expect_success 'fails silently when using -q' '
 	test -z "$(cat error)"
 '
 
-test_expect_success '1 no stdout output on error' '
+test_expect_success 'no stdout output on error' '
 	test -z "$(git rev-parse --verify)" &&
 	test -z "$(git rev-parse --verify foo)" &&
-	test -z "$(git rev-parse --verify baz HEAD)"
-'
-
-test_expect_failure '2 no stdout output on error' '
-	test -z "$(git rev-parse --verify HEAD bar)"
-'
-
-test_expect_failure '3 no stdout output on error' '
+	test -z "$(git rev-parse --verify baz HEAD)" &&
+	test -z "$(git rev-parse --verify HEAD bar)" &&
 	test -z "$(git rev-parse --verify $HASH2 HEAD)"
 '
 
-- 
1.5.5.1.347.g779f4
