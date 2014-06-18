From: Jeff King <peff@peff.net>
Subject: [PATCH 01/16] parse_diff_color_slot: drop ofs parameter
Date: Wed, 18 Jun 2014 15:41:50 -0400
Message-ID: <20140618194149.GA22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:41:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLk4-0005Wl-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbaFRTlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:41:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:46934 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754664AbaFRTlv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:41:51 -0400
Received: (qmail 29825 invoked by uid 102); 18 Jun 2014 19:41:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:41:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:41:50 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252033>

This function originally took a whole config variable name
("var") and an offset ("ofs"). It checked "var+ofs" against
each color slot, but reported errors using the whole "var".

However, since 8b8e862 (ignore unknown color configuration,
2009-12-12), it returns -1 rather than printing its own
error, and therefore only cares about var+ofs. We can drop
the ofs parameter and teach its sole caller to derive the
pointer itself.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index bba9a55..77c5eb4 100644
--- a/diff.c
+++ b/diff.c
@@ -52,23 +52,23 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
 };
 
-static int parse_diff_color_slot(const char *var, int ofs)
+static int parse_diff_color_slot(const char *var)
 {
-	if (!strcasecmp(var+ofs, "plain"))
+	if (!strcasecmp(var, "plain"))
 		return DIFF_PLAIN;
-	if (!strcasecmp(var+ofs, "meta"))
+	if (!strcasecmp(var, "meta"))
 		return DIFF_METAINFO;
-	if (!strcasecmp(var+ofs, "frag"))
+	if (!strcasecmp(var, "frag"))
 		return DIFF_FRAGINFO;
-	if (!strcasecmp(var+ofs, "old"))
+	if (!strcasecmp(var, "old"))
 		return DIFF_FILE_OLD;
-	if (!strcasecmp(var+ofs, "new"))
+	if (!strcasecmp(var, "new"))
 		return DIFF_FILE_NEW;
-	if (!strcasecmp(var+ofs, "commit"))
+	if (!strcasecmp(var, "commit"))
 		return DIFF_COMMIT;
-	if (!strcasecmp(var+ofs, "whitespace"))
+	if (!strcasecmp(var, "whitespace"))
 		return DIFF_WHITESPACE;
-	if (!strcasecmp(var+ofs, "func"))
+	if (!strcasecmp(var, "func"))
 		return DIFF_FUNCINFO;
 	return -1;
 }
@@ -240,7 +240,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return -1;
 
 	if (starts_with(var, "diff.color.") || starts_with(var, "color.diff.")) {
-		int slot = parse_diff_color_slot(var, 11);
+		int slot = parse_diff_color_slot(var + 11);
 		if (slot < 0)
 			return 0;
 		if (!value)
-- 
2.0.0.566.gfe3e6b2
