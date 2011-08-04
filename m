From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 22/23] git-check-attr: Fix command-line handling to match docs
Date: Thu,  4 Aug 2011 06:36:32 +0200
Message-ID: <1312432593-9841-23-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qopgq-0005WA-VQ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab1HDEhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:37 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39689 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab1HDEhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:08 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agI2029203;
	Thu, 4 Aug 2011 06:37:05 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178688>

According to the git-check-attr synopsis, if the '--stdin' option is
used then no pathnames are expected on the command line.  Change the
behavior to match this description; namely, if '--stdin' is used but
not '--', then treat all command-line arguments as attribute names.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-check-attr.txt |    7 +++++--
 builtin/check-attr.c             |   15 +++++++++------
 t/t0003-attributes.sh            |    1 -
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 798e5d5..1f7312a 100644
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
index b0d2ebc..f20772a 100644
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
