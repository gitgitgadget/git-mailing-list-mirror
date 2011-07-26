From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/19] git-check-attr: Fix command-line handling to match docs
Date: Tue, 26 Jul 2011 16:13:01 +0200
Message-ID: <1311689582-3116-19-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:35:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlijJ-0006hz-Jw
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab1GZOfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:35:25 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:40372 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753423Ab1GZOfY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:35:24 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-UZ; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177887>

According to the git-check-attr synopsis, if the '--stdin' option is
used then no pathnames are expected on the command line.  Change the
behavior to match this description; namely, if '--stdin' is used but
not '--', then treat all command-line arguments as attribute names.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Previously, such invocations either had exactly one argument (and
functioned the same as with this patch), or they failed with the
message "Can't specify files with --stdin".

 Documentation/git-check-attr.txt |    7 +++++--
 builtin/check-attr.c             |   15 +++++++++------
 t/t0003-attributes.sh            |    1 -
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 3afa9b1..902d5ca 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -33,8 +33,11 @@ OPTIONS
 
 \--::
 	Interpret all preceding arguments as attributes and all following
-	arguments as path names. If not supplied, only the first argument will
-	be treated as an attribute.
+	arguments as path names.
+
+If none of `--stdin`, `--all`, or `--` is used, the first argument
+will be treated as an attribute and the rest of the arguments as
+pathnames.
 
 OUTPUT
 ------
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index ecf420f..29613d4 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -111,15 +111,18 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	} else if (doubledash == 0) {
 		error_with_usage("No attribute specified");
 	} else if (doubledash < 0) {
-		/*
-		 * There is no double dash; treat the first
-		 * argument as an attribute.
-		 */
 		if (!argc)
 			error_with_usage("No attribute specified");
 
-		cnt = 1;
-		filei = 1;
+		if (stdin_paths) {
+			/* Treat all arguments as attribute names. */
+			cnt = argc;
+			filei = argc;
+		} else {
+			/* Treat exactly one argument as an attribute name. */
+			cnt = 1;
+			filei = 1;
+		}
 	} else {
 		cnt = doubledash;
 		filei = doubledash + 1;
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index a49f8a9..5acb2d5 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -70,7 +70,6 @@ test_expect_success 'command line checks' '
 	echo "f" | test_must_fail git check-attr --stdin &&
 	echo "f" | test_must_fail git check-attr --stdin -- f &&
 	echo "f" | test_must_fail git check-attr --stdin test -- f &&
-	echo "f" | test_must_fail git check-attr --stdin test f &&
 	test_must_fail git check-attr "" -- f
 
 '
-- 
1.7.6.8.gd2879
