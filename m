From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] interpolate.[ch]: Add a function to find which interpolations
 are active.
Date: Sun, 4 Nov 2007 19:15:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711041915120.4362@racer.site>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 04 20:16:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IokxU-0006AD-PD
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 20:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbXKDTQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 14:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbXKDTQM
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 14:16:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:57958 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753425AbXKDTQL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 14:16:11 -0500
Received: (qmail invoked by alias); 04 Nov 2007 19:16:10 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp029) with SMTP; 04 Nov 2007 20:16:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gm+twIXigw4IQu/bgQhZcr+FTeaLh9xAZUyFjL7
	F+f1KHudONucqb
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711041912190.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63433>


Some substitutions require pretty expensive operations.  So it make
sense to find out which are needed to begin with.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 interpolate.c |   20 ++++++++++++++++++++
 interpolate.h |    2 ++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/interpolate.c b/interpolate.c
index 6ef53f2..80eeb36 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -102,3 +102,23 @@ unsigned long interpolate(char *result, unsigned long reslen,
 		*dest = '\0';
 	return newlen;
 }
+
+char *interp_find_active(const char *orig,
+		const struct interp *interps, int ninterps)
+{
+	char *result = xcalloc(1, ninterps);
+	char c;
+	int i;
+
+	while ((c = *(orig++)))
+		if (c == '%')
+			/* Try to match an interpolation string. */
+			for (i = 0; i < ninterps; i++)
+				if (!prefixcmp(orig, interps[i].name + 1)) {
+					result[i] = 1;
+					orig += strlen(interps[i].name + 1);
+					break;
+				}
+
+	return result;
+}
diff --git a/interpolate.h b/interpolate.h
index 77407e6..2d197c5 100644
--- a/interpolate.h
+++ b/interpolate.h
@@ -22,5 +22,7 @@ extern void interp_clear_table(struct interp *table, int ninterps);
 extern unsigned long interpolate(char *result, unsigned long reslen,
 				 const char *orig,
 				 const struct interp *interps, int ninterps);
+extern char *interp_find_active(const char *orig,
+				const struct interp *interps, int ninterps);
 
 #endif /* INTERPOLATE_H */
-- 
1.5.3.5.1549.g91a3
