From: mhagger@alum.mit.edu
Subject: [RFC 1/7] check_refname_component(): iterate via index rather than via pointer
Date: Tue,  1 May 2012 01:02:49 +0200
Message-ID: <1335826975-3093-2-git-send-email-mhagger@alum.mit.edu>
References: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 01:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOzch-0000Mi-2Z
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 01:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267Ab2D3XDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 19:03:09 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41739 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679Ab2D3XDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 19:03:08 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0D9D4.dip.t-dialin.net [79.192.217.212])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3UN2xbA028766;
	Tue, 1 May 2012 01:03:00 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196627>

From: Michael Haggerty <mhagger@alum.mit.edu>

This will make later changes easier.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 09322fe..927d36c 100644
--- a/refs.c
+++ b/refs.c
@@ -35,12 +35,12 @@ static inline int bad_ref_char(int ch)
  */
 static int check_refname_component(const char *refname, int flags)
 {
-	const char *cp;
+	int i, len = strlen(refname);
 	char last = '\0';
 
-	for (cp = refname; ; cp++) {
-		char ch = *cp;
-		if (ch == '\0' || ch == '/')
+	for (i = 0; i < len; i++) {
+		char ch = refname[i];
+		if (ch == '/')
 			break;
 		if (bad_ref_char(ch))
 			return -1; /* Illegal character in refname. */
@@ -50,7 +50,7 @@ static int check_refname_component(const char *refname, int flags)
 			return -1; /* Refname contains "@{". */
 		last = ch;
 	}
-	if (cp == refname)
+	if (i == 0)
 		return 0; /* Component has zero length. */
 	if (refname[0] == '.') {
 		if (!(flags & REFNAME_DOT_COMPONENT))
@@ -59,12 +59,12 @@ static int check_refname_component(const char *refname, int flags)
 		 * Even if leading dots are allowed, don't allow "."
 		 * as a component (".." is prevented by a rule above).
 		 */
-		if (refname[1] == '\0')
+		if (len == 1)
 			return -1; /* Component equals ".". */
 	}
-	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
+	if (i >= 5 && !memcmp(&refname[i - 5], ".lock", 5))
 		return -1; /* Refname ends with ".lock". */
-	return cp - refname;
+	return i;
 }
 
 int check_refname_format(const char *refname, int flags)
-- 
1.7.10
