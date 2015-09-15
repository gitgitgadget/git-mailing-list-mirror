From: Jeff King <peff@peff.net>
Subject: [PATCH 67/67] name-rev: use strip_suffix to avoid magic numbers
Date: Tue, 15 Sep 2015 12:16:59 -0400
Message-ID: <20150915161659.GO29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:17:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbsuq-00041t-DM
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbbIOQRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:17:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:59489 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752110AbbIOQRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:17:01 -0400
Received: (qmail 14746 invoked by uid 102); 15 Sep 2015 16:17:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:17:01 -0500
Received: (qmail 8079 invoked by uid 107); 15 Sep 2015 16:17:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:17:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:16:59 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277972>

The manual size computations here are correct, but using
strip_suffix makes that obvious, and hopefully communicates
the intent of the code more clearly.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/name-rev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 8a3a0cd..0377fc1 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -55,16 +55,15 @@ copy_data:
 			parents;
 			parents = parents->next, parent_number++) {
 		if (parent_number > 1) {
-			int len = strlen(tip_name);
+			size_t len;
 			char *new_name;
 
-			if (len > 2 && !strcmp(tip_name + len - 2, "^0"))
-				len -= 2;
+			strip_suffix(tip_name, "^0", &len);
 			if (generation > 0)
-				new_name = xstrfmt("%.*s~%d^%d", len, tip_name,
+				new_name = xstrfmt("%.*s~%d^%d", (int)len, tip_name,
 						   generation, parent_number);
 			else
-				new_name = xstrfmt("%.*s^%d", len, tip_name,
+				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
 						   parent_number);
 
 			name_rev(parents->item, new_name, 0,
-- 
2.6.0.rc2.408.ga2926b9
