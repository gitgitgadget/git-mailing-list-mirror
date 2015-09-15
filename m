From: Jeff King <peff@peff.net>
Subject: [PATCH 18/67] find_short_object_filename: convert sprintf to
 xsnprintf
Date: Tue, 15 Sep 2015 11:38:48 -0400
Message-ID: <20150915153848.GR29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:38:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsJs-0008C0-0x
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbbIOPiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:38:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:59321 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753020AbbIOPiu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:38:50 -0400
Received: (qmail 11779 invoked by uid 102); 15 Sep 2015 15:38:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:38:50 -0500
Received: (qmail 7088 invoked by uid 107); 15 Sep 2015 15:38:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:38:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:38:48 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277919>

We use sprintf() to format some hex data into a buffer. The
buffer is clearly long enough, and using snprintf here is
not necessary. And in fact, it does not really make anything
easier to audit, as the size we feed to snprintf accounts
for the magic extra 42 bytes found in each alt->name field
of struct alternate_object_database (which is there exactly
to do this formatting).

Still, it is nice to remove an sprintf call and replace it
with an xsnprintf and explanatory comment, which makes it
easier to audit the code base for overflows.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 416e408..ed42f79 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -96,11 +96,15 @@ static void find_short_object_filename(int len, const char *hex_pfx, struct disa
 	}
 	fakeent->next = alt_odb_list;
 
-	sprintf(hex, "%.2s", hex_pfx);
+	xsnprintf(hex, sizeof(hex), "%.2s", hex_pfx);
 	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
 		struct dirent *de;
 		DIR *dir;
-		sprintf(alt->name, "%.2s/", hex_pfx);
+		/*
+		 * every alt_odb struct has 42 extra bytes after the base
+		 * for exactly this purpose
+		 */
+		xsnprintf(alt->name, 42, "%.2s/", hex_pfx);
 		dir = opendir(alt->base);
 		if (!dir)
 			continue;
-- 
2.6.0.rc2.408.ga2926b9
