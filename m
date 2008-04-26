From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] rev-parse: teach "--verify" to be quiet when using "-q" or
 "--quiet"
Date: Sat, 26 Apr 2008 13:57:23 +0200
Message-ID: <20080426135723.2b9e7c16.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 13:53:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpixn-0003ur-BM
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 13:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbYDZLwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 07:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbYDZLwU
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 07:52:20 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:33692 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783AbYDZLwU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 07:52:20 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E0CB51AB2E1
	for <git@vger.kernel.org>; Sat, 26 Apr 2008 13:52:17 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id B091F1AB2D4
	for <git@vger.kernel.org>; Sat, 26 Apr 2008 13:52:17 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80369>

Currently "git rev-parse --verify <something>" is often used with
its error output redirected to /dev/null. This patch makes it
easier to do that.

The -q|--quiet option is designed to work the same way as it does
for "git symbolic-ref".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-rev-parse.txt |    5 +++++
 builtin-rev-parse.c             |   20 ++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

	By the way it's strange that for example:

	$ git rev-parse --verify <good-rev> <junk>

	works whatever <junk> is, as long as <good-rev> can be
	parsed.

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 6513c2e..110e7ba 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -52,6 +52,11 @@ OPTIONS
 	The parameter given must be usable as a single, valid
 	object name.  Otherwise barf and abort.
 
+-q, --quiet::
+	Only meaningful in `--verify` mode. Do not output an error
+	message if the first argument is not a valid object name;
+	instead exit with non-zero status silently.
+
 --sq::
 	Usually the output is made one line per flag and
 	parameter.  This option makes output a single line,
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 0351d54..9384a99 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -365,9 +365,17 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void die_no_single_rev(int quiet)
+{
+	if (quiet)
+		exit(1);
+	else
+		die("Needed a single revision");
+}
+
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
-	int i, as_is = 0, verify = 0;
+	int i, as_is = 0, verify = 0, quiet = 0;
 	unsigned char sha1[20];
 
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
@@ -432,6 +440,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				verify = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--quiet") || !strcmp(arg, "-q")) {
+				quiet = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--short") ||
 			    !prefixcmp(arg, "--short=")) {
 				filter &= ~(DO_FLAGS|DO_NOREV);
@@ -549,7 +561,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (show_flag(arg) && verify)
-				die("Needed a single revision");
+				die_no_single_rev(quiet);
 			continue;
 		}
 
@@ -568,11 +580,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		if (!show_file(arg))
 			continue;
 		if (verify)
-			die("Needed a single revision");
+			die_no_single_rev(quiet);
 		verify_filename(prefix, arg);
 	}
 	show_default();
 	if (verify && revs_count != 1)
-		die("Needed a single revision");
+		die_no_single_rev(quiet);
 	return 0;
 }
-- 
1.5.5.130.g68d41
