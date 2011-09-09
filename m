From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/6] Change bad_ref_char() to return a boolean value
Date: Fri,  9 Sep 2011 13:46:13 +0200
Message-ID: <1315568778-3592-2-git-send-email-mhagger@alum.mit.edu>
References: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 13:46:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1zXu-0005nF-9J
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 13:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933504Ab1IILqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 07:46:43 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:46241 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758766Ab1IILql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 07:46:41 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R1zTU-0002Qy-Ht; Fri, 09 Sep 2011 13:42:24 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181055>

Previously most bad characters were indicated by returning 1, but "*"
was special-cased to return 2 instead of 1.  One caller examined the
return value to see whether the special case occurred.

But it is easier (to document and understand) for bad_ref_char()
simply to return a boolean value, treating "*" like any other bad
character.  Special-case the handling of "*" (which only occurs in
very specific circumstances) at the caller.  The resulting calling
code thereby also becomes more transparent.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

This is just a random refactoring.

 refs.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index a615043..fd29d89 100644
--- a/refs.c
+++ b/refs.c
@@ -860,22 +860,21 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
  * - it contains a "\" (backslash)
  */
 
+/* Return true iff ch is not allowed in reference names. */
 static inline int bad_ref_char(int ch)
 {
 	if (((unsigned) ch) <= ' ' || ch == 0x7f ||
 	    ch == '~' || ch == '^' || ch == ':' || ch == '\\')
 		return 1;
 	/* 2.13 Pattern Matching Notation */
-	if (ch == '?' || ch == '[') /* Unsupported */
+	if (ch == '*' || ch == '?' || ch == '[') /* Unsupported */
 		return 1;
-	if (ch == '*') /* Supported at the end */
-		return 2;
 	return 0;
 }
 
 int check_ref_format(const char *ref)
 {
-	int ch, level, bad_type, last;
+	int ch, level, last;
 	int ret = CHECK_REF_FORMAT_OK;
 	const char *cp = ref;
 
@@ -890,9 +889,8 @@ int check_ref_format(const char *ref)
 		/* we are at the beginning of the path component */
 		if (ch == '.')
 			return CHECK_REF_FORMAT_ERROR;
-		bad_type = bad_ref_char(ch);
-		if (bad_type) {
-			if (bad_type == 2 && (!*cp || *cp == '/') &&
+		if (bad_ref_char(ch)) {
+			if (ch == '*' && (!*cp || *cp == '/') &&
 			    ret == CHECK_REF_FORMAT_OK)
 				ret = CHECK_REF_FORMAT_WILDCARD;
 			else
@@ -902,8 +900,7 @@ int check_ref_format(const char *ref)
 		last = ch;
 		/* scan the rest of the path component */
 		while ((ch = *cp++) != 0) {
-			bad_type = bad_ref_char(ch);
-			if (bad_type)
+			if (bad_ref_char(ch))
 				return CHECK_REF_FORMAT_ERROR;
 			if (ch == '/')
 				break;
-- 
1.7.6.8.gd2879
