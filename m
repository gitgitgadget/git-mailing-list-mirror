From: Jonathan del Strother <jon.delStrother@bestbefore.tv>
Subject: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 14:29:01 +0100
Message-ID: <1221658141-75698-1-git-send-email-jon.delStrother@bestbefore.tv>
References: <57518fd10809170526i5c1e7dadgc38bb00e8073ba55@mail.gmail.com>
Cc: vmiklos@frugalware.org, Johannes.Schindelin@gmx.de,
	Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 15:31:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfx7a-0002GK-Ma
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 15:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYIQN3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 09:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbYIQN3f
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 09:29:35 -0400
Received: from cumberland.bestbefore.tv ([82.165.41.205]:50913 "EHLO
	cumberland.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbYIQN3e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 09:29:34 -0400
Received: (qmail 24384 invoked from network); 17 Sep 2008 14:29:32 +0100
Received: from gir.mp.bestbefore.tv (HELO localhost.localdomain) (89.105.122.147)
  by cumberland.bestbefore.tv with SMTP; 17 Sep 2008 14:29:32 +0100
X-Mailer: git-send-email 1.6.0.2.250.ge7a3b.dirty
In-Reply-To: <57518fd10809170526i5c1e7dadgc38bb00e8073ba55@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96110>

Add support for recognition of Objective-C class & instance methods, C functions, and class implementation/interfaces.

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
This version anchors the negated match to the beginning of the line, and shuffles the comments around to avoid the excessively long lines.  Better?


 Documentation/gitattributes.txt |    2 ++
 diff.c                          |   24 +++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

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
index 998dcaa..e5ec503 100644
--- a/diff.c
+++ b/diff.c
@@ -1398,17 +1398,31 @@ static struct builtin_funcname_pattern {
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
+	{ "objc",
+			/* Negate C statements that can look like functions */
+			"!^[ \t]*\\(do\\|for\\|if\\|else\\|return\\|switch\\|while\\)\n"
+			/* Objective-C methods */
+			"^[ \t]*\\([-+][ \t]*([ \t]*[A-Za-z_][A-Za-z_0-9]*.*).*\\)$"
+			"\\|"
+			/* C functions */
+			"^[ \t]*\\(\\([ \t]*[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}[ \t]*([^;]*\\)$"
+			"\\|"
+			/* Objective-C class/protocol definitions */
+			"^@\\(implementation\\|interface\\|protocol\\).*"},
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
1.6.0.2.250.ge7a3b.dirty
