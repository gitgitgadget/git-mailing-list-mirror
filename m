From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 01/18] advice: add error_resolve_conflict() function
Date: Thu, 25 Nov 2010 22:20:32 +0100
Message-ID: <20101125212050.5188.50630.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:54:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrGH-0006Rm-9q
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507Ab0KZFyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:54:18 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47141 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab0KZFyR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:54:17 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6856BA6101;
	Fri, 26 Nov 2010 06:54:10 +0100 (CET)
X-git-sha1: a65fa9f54be287fe025a4b11bda0d80eaed61bcd 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162184>

in case we don't want to die, but still want the right
error message to be printed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 advice.c |   25 +++++++++++++++++++++----
 advice.h |    1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 0be4b5f..d4ba29f 100644
--- a/advice.c
+++ b/advice.c
@@ -34,6 +34,13 @@ int git_default_advice_config(const char *var, const char *value)
 	return 0;
 }
 
+const char unmerged_file_advice[] =
+	"'%s' is not possible because you have unmerged files.\n"
+	"Please, fix them up in the work tree, and then use 'git add/rm <file>' as\n"
+	"appropriate to mark resolution and make a commit, or use 'git commit -a'.";
+const char unmerged_file_no_advice[] =
+	"'%s' is not possible because you have unmerged files.";
+
 void NORETURN die_resolve_conflict(const char *me)
 {
 	if (advice_resolve_conflict)
@@ -41,9 +48,19 @@ void NORETURN die_resolve_conflict(const char *me)
 		 * Message used both when 'git commit' fails and when
 		 * other commands doing a merge do.
 		 */
-		die("'%s' is not possible because you have unmerged files.\n"
-		    "Please, fix them up in the work tree, and then use 'git add/rm <file>' as\n"
-		    "appropriate to mark resolution and make a commit, or use 'git commit -a'.", me);
+		die(unmerged_file_advice, me);
+	else
+		die(unmerged_file_no_advice, me);
+}
+
+int error_resolve_conflict(const char *me)
+{
+	if (advice_resolve_conflict)
+		/*
+		 * Message used both when 'git commit' fails and when
+		 * other commands doing a merge do.
+		 */
+		return error(unmerged_file_advice, me);
 	else
-		die("'%s' is not possible because you have unmerged files.", me);
+		return error(unmerged_file_no_advice, me);
 }
diff --git a/advice.h b/advice.h
index 3244ebb..7b7cea5 100644
--- a/advice.h
+++ b/advice.h
@@ -13,5 +13,6 @@ extern int advice_detached_head;
 int git_default_advice_config(const char *var, const char *value);
 
 extern void NORETURN die_resolve_conflict(const char *me);
+extern int error_resolve_conflict(const char *me);
 
 #endif /* ADVICE_H */
-- 
1.7.3.2.504.g59d466
