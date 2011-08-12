From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/7] Increment num_attr in parse_attr_line(), not parse_attr()
Date: Fri, 12 Aug 2011 23:43:06 +0200
Message-ID: <1313185390-19724-4-git-send-email-mhagger@alum.mit.edu>
References: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 23:43:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrzWA-0008Dc-Tc
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 23:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab1HLVnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 17:43:46 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40858 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab1HLVnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 17:43:45 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CLhCvI007606;
	Fri, 12 Aug 2011 23:43:38 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179251>

num_attr is incremented iff parse_attr() returns non-NULL.  So do the
counting in parse_attr_line() instead of within parse_attr().  This
allows an integer rather than a pointer to an integer to be passed to
parse_attr().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 attr.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index c33e413..cac550d 100644
--- a/attr.c
+++ b/attr.c
@@ -140,7 +140,7 @@ struct match_attr {
 static const char blank[] = " \t\r\n";
 
 static const char *parse_attr(const char *src, int lineno, const char *cp,
-			      int *num_attr, struct match_attr *res)
+			      int num_attr, struct match_attr *res)
 {
 	const char *ep, *equals;
 	int len;
@@ -167,7 +167,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 	} else {
 		struct attr_state *e;
 
-		e = &(res->state[*num_attr]);
+		e = &(res->state[num_attr]);
 		if (*cp == '-' || *cp == '!') {
 			e->setto = (*cp == '-') ? ATTR__FALSE : ATTR__UNSET;
 			cp++;
@@ -180,7 +180,6 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 		}
 		e->attr = git_attr_internal(cp, len);
 	}
-	(*num_attr)++;
 	return ep + strspn(ep, blank);
 }
 
@@ -226,9 +225,10 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		cp = name + namelen;
 		cp = cp + strspn(cp, blank);
 		while (*cp) {
-			cp = parse_attr(src, lineno, cp, &num_attr, res);
+			cp = parse_attr(src, lineno, cp, num_attr, res);
 			if (!cp)
 				return NULL;
+			num_attr++;
 		}
 		if (pass)
 			break;
-- 
1.7.6.8.gd2879
