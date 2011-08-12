From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/7] Change parse_attr() to take a pointer to struct attr_state
Date: Fri, 12 Aug 2011 23:43:07 +0200
Message-ID: <1313185390-19724-5-git-send-email-mhagger@alum.mit.edu>
References: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 23:44:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrzWI-0008HH-BH
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 23:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423Ab1HLVnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 17:43:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40861 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab1HLVnx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 17:43:53 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CLhCvJ007606;
	Fri, 12 Aug 2011 23:43:44 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179252>

parse_attr() only needs access to the attr_state to which it should
store its results, not to the whole match_attr structure.  This change
also removes the need for it to know num_attr.  Change its signature
accordingly and add a comment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 attr.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/attr.c b/attr.c
index cac550d..f23f62a 100644
--- a/attr.c
+++ b/attr.c
@@ -139,8 +139,15 @@ struct match_attr {
 
 static const char blank[] = " \t\r\n";
 
+/*
+ * Parse a whitespace-delimited attribute state (i.e., "attr",
+ * "-attr", "!attr", or "attr=value") from the string starting at src.
+ * If e is not NULL, write the results to *e.  Return a pointer to the
+ * remainder of the string (with leading whitespace removed), or NULL
+ * if there was an error.
+ */
 static const char *parse_attr(const char *src, int lineno, const char *cp,
-			      int num_attr, struct match_attr *res)
+			      struct attr_state *e)
 {
 	const char *ep, *equals;
 	int len;
@@ -153,7 +160,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 		len = equals - cp;
 	else
 		len = ep - cp;
-	if (!res) {
+	if (!e) {
 		if (*cp == '-' || *cp == '!') {
 			cp++;
 			len--;
@@ -165,9 +172,6 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			return NULL;
 		}
 	} else {
-		struct attr_state *e;
-
-		e = &(res->state[num_attr]);
 		if (*cp == '-' || *cp == '!') {
 			e->setto = (*cp == '-') ? ATTR__FALSE : ATTR__UNSET;
 			cp++;
@@ -225,7 +229,8 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		cp = name + namelen;
 		cp = cp + strspn(cp, blank);
 		while (*cp) {
-			cp = parse_attr(src, lineno, cp, num_attr, res);
+			cp = parse_attr(src, lineno, cp,
+				pass ? &(res->state[num_attr]) : NULL);
 			if (!cp)
 				return NULL;
 			num_attr++;
-- 
1.7.6.8.gd2879
