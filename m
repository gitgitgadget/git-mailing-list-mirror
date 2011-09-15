From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/22] Make collapse_slashes() allocate memory for its result
Date: Thu, 15 Sep 2011 23:10:28 +0200
Message-ID: <1316121043-29367-8-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:11:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JDW-00066p-Pd
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934977Ab1IOVLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:11:10 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40091 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934775Ab1IOVLG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:11:06 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8m-00019o-JQ; Thu, 15 Sep 2011 23:06:36 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181502>

This will make upcoming changes a tiny bit easier.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/check-ref-format.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 8f41696..989ee5c 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -12,25 +12,28 @@ static const char builtin_check_ref_format_usage[] =
 "   or: git check-ref-format --branch <branchname-shorthand>";
 
 /*
- * Remove leading slashes and replace each run of adjacent slashes in
- * src with a single slash, and write the result to dst.
+ * Return a copy of refname but with leading slashes removed and runs
+ * of adjacent slashes replaced with single slashes.
  *
  * This function is similar to normalize_path_copy(), but stripped down
  * to meet check_ref_format's simpler needs.
  */
-static void collapse_slashes(char *dst, const char *src)
+static char *collapse_slashes(const char *refname)
 {
+	char *ret = xmalloc(strlen(refname) + 1);
 	char ch;
 	char prev = '/';
+	char *cp = ret;
 
-	while ((ch = *src++) != '\0') {
+	while ((ch = *refname++) != '\0') {
 		if (prev == '/' && ch == prev)
 			continue;
 
-		*dst++ = ch;
+		*cp++ = ch;
 		prev = ch;
 	}
-	*dst = '\0';
+	*cp = '\0';
+	return ret;
 }
 
 static int check_ref_format_branch(const char *arg)
@@ -47,9 +50,7 @@ static int check_ref_format_branch(const char *arg)
 
 static void refname_format_print(const char *arg)
 {
-	char *refname = xmalloc(strlen(arg) + 1);
-
-	collapse_slashes(refname, arg);
+	char *refname = collapse_slashes(arg);
 	printf("%s\n", refname);
 }
 
-- 
1.7.6.8.gd2879
