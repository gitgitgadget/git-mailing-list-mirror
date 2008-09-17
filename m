From: Jonathan del Strother <jon.delStrother@bestbefore.tv>
Subject: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 11:49:24 +0100
Message-ID: <1221648564-56239-1-git-send-email-jon.delStrother@bestbefore.tv>
References: <1221610063-33610-1-git-send-email-jon.delStrother@bestbefore.tv>
Cc: vmiklos@frugalware.org,
	Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 12:51:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfucl-00073q-As
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 12:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbYIQKt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 06:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbYIQKt5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 06:49:57 -0400
Received: from cumberland.bestbefore.tv ([82.165.41.205]:36043 "EHLO
	cumberland.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYIQKt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 06:49:57 -0400
Received: (qmail 20210 invoked from network); 17 Sep 2008 11:49:55 +0100
Received: from gir.mp.bestbefore.tv (HELO localhost.localdomain) (89.105.122.147)
  by cumberland.bestbefore.tv with SMTP; 17 Sep 2008 11:49:55 +0100
X-Mailer: git-send-email 1.6.0.2.250.g2fdd2.dirty
In-Reply-To: <1221610063-33610-1-git-send-email-jon.delStrother@bestbefore.tv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96087>

Add support for recognition of Objective-C class & instance methods, C functions, and class implementation/interfaces.

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---

This version of the patch adds the negate line to avoid picking up if()/while()/etc statements as funcnames
I also took the liberty of replacing the invisible tab characters in the java pattern with \t's - is that OK?

 Documentation/gitattributes.txt |    2 ++
 diff.c                          |   19 ++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 6f3551d..c1f13e2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -315,6 +315,8 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
+- `objc` suitable for source code in the Objective-C language.
+
 - `pascal` suitable for source code in the Pascal/Delphi language.
 
 - `php` suitable for source code in the PHP language.
diff --git a/diff.c b/diff.c
index 998dcaa..fdfdf26 100644
--- a/diff.c
+++ b/diff.c
@@ -1398,17 +1398,26 @@ static struct builtin_funcname_pattern {
 } builtin_funcname_pattern[] = {
 	{ "bibtex", "\\(@[a-zA-Z]\\{1,\\}[ \t]*{\\{0,1\\}[ \t]*[^ \t\"@',\\#}{~%]*\\).*$" },
 	{ "html", "^\\s*\\(<[Hh][1-6]\\s.*>.*\\)$" },
-	{ "java", "!^[ 	]*\\(catch\\|do\\|for\\|if\\|instanceof\\|"
+
+	{ "java", "!^[ \t]*\\(catch\\|do\\|for\\|if\\|instanceof\\|"
 			"new\\|return\\|switch\\|throw\\|while\\)\n"
-			"^[ 	]*\\(\\([ 	]*"
+			"^[ \t]*\\(\\([ \t]*"
 			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
-			"[ 	]*([^;]*\\)$" },
+			"[ \t]*([^;]*\\)$" },
+
+	{ "objc", "![ \t]*\\(do\\|for\\|if\\|else\\|return\\|switch\\|while\\)\n" /* Negate C statements that can look like functions */
+			"^[ \t]*\\([-+][ \t]*([ \t]*[A-Za-z_][A-Za-z_0-9]*.*).*\\)$" /* Objective-C methods */
+			"\\|"
+			"^[ \t]*\\(\\([ \t]*[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}[ \t]*([^;]*\\)$" /* C functions */
+			"\\|"
+			"^@\\(implementation\\|interface\\|protocol\\).*"}, /* Objective-C class/protocol definitions */
+
 	{ "pascal", "^\\(\\(procedure\\|function\\|constructor\\|"
 			"destructor\\|interface\\|implementation\\|"
 			"initialization\\|finalization\\)[ \t]*.*\\)$"
 			"\\|"
-			"^\\(.*=[ \t]*\\(class\\|record\\).*\\)$"
-			},
+			"^\\(.*=[ \t]*\\(class\\|record\\).*\\)$"},
+
 	{ "php", "^[\t ]*\\(\\(function\\|class\\).*\\)" },
 	{ "python", "^\\s*\\(\\(class\\|def\\)\\s.*\\)$" },
 	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$" },
-- 
1.6.0.2.250.g2fdd2.dirty
