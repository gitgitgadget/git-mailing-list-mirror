From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] interpolate.[ch]: Add a function to find which interpolations
 are active.
Date: Tue, 6 Nov 2007 23:38:03 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711062336510.4362@racer.site>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>
 <Pine.LNX.4.64.0711041915290.4362@racer.site> <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>
 <472F7B2F.4050608@lsrfire.ath.cx> <7vejf4kwry.fsf@gitster.siamese.dyndns.org>
 <4730EB4E.4080903@lsrfire.ath.cx> <Pine.LNX.4.64.0711062335150.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Nov 07 00:39:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpY0o-0000Dj-6r
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 00:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbXKFXjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 18:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754673AbXKFXi7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 18:38:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:40530 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753761AbXKFXi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 18:38:59 -0500
Received: (qmail invoked by alias); 06 Nov 2007 23:38:57 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp036) with SMTP; 07 Nov 2007 00:38:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19T9AJI5CZTDFpQ4UHPZ2ROrbnfWlxz93urDyX6u/
	0VtRu3T+Scg/z+
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711062335150.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63752>


Some substitutions require pretty expensive operations.  So it makes
sense to find out which are needed to begin with.  Call
interp_find_active() to set the new "active" field in the interpolation
table.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This is the patch that Rene proposed, but squashed into my earlier
	patch.

 interpolate.c |   20 ++++++++++++++++++++
 interpolate.h |    3 +++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/interpolate.c b/interpolate.c
index 6ef53f2..bbd89bb 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -102,3 +102,23 @@ unsigned long interpolate(char *result, unsigned long reslen,
 		*dest = '\0';
 	return newlen;
 }
+
+void interp_find_active(const char *orig,
+		struct interp *interps, int ninterps)
+{
+	char c;
+	int i;
+
+	for (i = 0; i < ninterps; i++)
+		interps[i].active = 0;
+
+	while ((c = *(orig++)))
+		if (c == '%')
+			/* Try to match an interpolation string. */
+			for (i = 0; i < ninterps; i++)
+				if (!prefixcmp(orig, interps[i].name + 1)) {
+					interps[i].active = 1;
+					orig += strlen(interps[i].name + 1);
+					break;
+				}
+}
diff --git a/interpolate.h b/interpolate.h
index 77407e6..d23531a 100644
--- a/interpolate.h
+++ b/interpolate.h
@@ -14,6 +14,7 @@
 struct interp {
 	const char *name;
 	char *value;
+	int active:1;
 };
 
 extern void interp_set_entry(struct interp *table, int slot, const char *value);
@@ -22,5 +23,7 @@ extern void interp_clear_table(struct interp *table, int ninterps);
 extern unsigned long interpolate(char *result, unsigned long reslen,
 				 const char *orig,
 				 const struct interp *interps, int ninterps);
+extern void interp_find_active(const char *orig,
+				struct interp *interps, int ninterps);
 
 #endif /* INTERPOLATE_H */
-- 
1.5.3.5.1597.g7191
