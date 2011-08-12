From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 7/7] Unroll the loop over passes
Date: Fri, 12 Aug 2011 23:43:10 +0200
Message-ID: <1313185390-19724-8-git-send-email-mhagger@alum.mit.edu>
References: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 23:44:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrzWc-0008Rk-0G
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 23:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab1HLVoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 17:44:13 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40870 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab1HLVoL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 17:44:11 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CLhCvM007606;
	Fri, 12 Aug 2011 23:44:04 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179255>

The passes no longer share much code, and the unrolled code is easier
to understand.

Use a new index variable instead of num_attr for the second loop, as
we are no longer counting attributes but rather indexing through them.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 attr.c |   51 ++++++++++++++++++++++++++-------------------------
 1 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/attr.c b/attr.c
index b56542e..6abaaec 100644
--- a/attr.c
+++ b/attr.c
@@ -191,10 +191,9 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 					  int lineno, int macro_ok)
 {
 	int namelen;
-	int num_attr;
+	int num_attr, i;
 	const char *cp, *name, *states;
 	struct match_attr *res = NULL;
-	int pass;
 	int is_macro;
 
 	cp = line + strspn(line, blank);
@@ -226,30 +225,32 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	states = name + namelen;
 	states += strspn(states, blank);
 
-	for (pass = 0; pass < 2; pass++) {
-		/* pass 0 counts and allocates, pass 1 fills */
-		for (cp = states, num_attr = 0; *cp; num_attr++) {
-			cp = parse_attr(src, lineno, cp,
-				pass ? &(res->state[num_attr]) : NULL);
-			if (!cp)
-				return NULL;
-		}
-		if (pass)
-			break;
-		res = xcalloc(1,
-			      sizeof(*res) +
-			      sizeof(struct attr_state) * num_attr +
-			      (is_macro ? 0 : namelen + 1));
-		if (is_macro)
-			res->u.attr = git_attr_internal(name, namelen);
-		else {
-			res->u.pattern = (char *)&(res->state[num_attr]);
-			memcpy(res->u.pattern, name, namelen);
-			res->u.pattern[namelen] = 0;
-		}
-		res->is_macro = is_macro;
-		res->num_attr = num_attr;
+	/* First pass to count the attr_states */
+	for (cp = states, num_attr = 0; *cp; num_attr++) {
+		cp = parse_attr(src, lineno, cp, NULL);
+		if (!cp)
+			return NULL;
 	}
+
+	res = xcalloc(1,
+		      sizeof(*res) +
+		      sizeof(struct attr_state) * num_attr +
+		      (is_macro ? 0 : namelen + 1));
+	if (is_macro)
+		res->u.attr = git_attr_internal(name, namelen);
+	else {
+		res->u.pattern = (char *)&(res->state[num_attr]);
+		memcpy(res->u.pattern, name, namelen);
+		res->u.pattern[namelen] = 0;
+	}
+	res->is_macro = is_macro;
+	res->num_attr = num_attr;
+
+	/* Second pass to fill the attr_states */
+	for (cp = states, i = 0; *cp; i++) {
+		cp = parse_attr(src, lineno, cp, &(res->state[i]));
+	}
+
 	return res;
 }
 
-- 
1.7.6.8.gd2879
