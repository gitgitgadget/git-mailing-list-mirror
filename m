From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] rev-parse --symbolic-full-name: don't print '^' if SHA1 is
 not a ref
Date: Fri, 23 May 2008 16:13:05 +0200
Message-ID: <4836D0F1.4090007@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 16:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY23-0004Wa-Lw
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbYEWONL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbYEWONK
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:13:10 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18598 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbYEWONJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:13:09 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JzY13-0004pE-VB; Fri, 23 May 2008 16:13:06 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8163A6D9; Fri, 23 May 2008 16:13:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82700>

From: Johannes Sixt <johannes.sixt@telecom.at>

The intention of --symbolic-full-name is to not print anything if a
revision is not an exact ref. But this command:

    $ git-rev-parse --symbolic-full-name --not master~1

still emitted a sole '^' to stdout (provided that there's no other ref at
master~1). This fixes it.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-rev-parse.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 0e59707..afa4d6d 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -96,6 +96,14 @@ static void show(const char *arg)
 		puts(arg);
 }

+/* Like show(), but with a negation prefix according to type */
+static void show_with_type(int type, const char *arg)
+{
+	if (type != show_type)
+		putchar('^');
+	show(arg);
+}
+
 /* Output a revision, only if filter allows it */
 static void show_rev(int type, const unsigned char *sha1, const char *name)
 {
@@ -104,8 +112,6 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
 	def = NULL;
 	revs_count++;

-	if (type != show_type)
-		putchar('^');
 	if (symbolic && name) {
 		if (symbolic == SHOW_SYMBOLIC_FULL) {
 			unsigned char discard[20];
@@ -122,20 +128,20 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
 				 */
 				break;
 			case 1: /* happy */
-				show(full);
+				show_with_type(type, full);
 				break;
 			default: /* ambiguous */
 				error("refname '%s' is ambiguous", name);
 				break;
 			}
 		} else {
-			show(name);
+			show_with_type(type, name);
 		}
 	}
 	else if (abbrev)
-		show(find_unique_abbrev(sha1, abbrev));
+		show_with_type(type, find_unique_abbrev(sha1, abbrev));
 	else
-		show(sha1_to_hex(sha1));
+		show_with_type(type, sha1_to_hex(sha1));
 }

 /* Output a flag, only if filter allows it. */
-- 
1.5.5.1.125.gb9f88
