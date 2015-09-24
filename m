From: Jeff King <peff@peff.net>
Subject: [PATCH 48/68] diagnose_invalid_index_path: use strbuf to avoid
 strcpy/strcat
Date: Thu, 24 Sep 2015 17:07:52 -0400
Message-ID: <20150924210751.GS30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:08:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDkQ-00028o-7R
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbbIXVH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:36004 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753669AbbIXVHy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:54 -0400
Received: (qmail 12091 invoked by uid 102); 24 Sep 2015 21:07:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:54 -0500
Received: (qmail 29395 invoked by uid 107); 24 Sep 2015 21:08:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:52 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278594>

We dynamically allocate a buffer and then strcpy and strcat
into it. This isn't buggy, but we'd prefer to avoid these
suspicious functions.

This would be a good candidate for converstion to xstrfmt,
but we need to record the length for dealing with index
entries. A strbuf handles that for us.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 80753b6..3242c5e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1293,8 +1293,7 @@ static void diagnose_invalid_index_path(int stage,
 	const struct cache_entry *ce;
 	int pos;
 	unsigned namelen = strlen(filename);
-	unsigned fullnamelen;
-	char *fullname;
+	struct strbuf fullname = STRBUF_INIT;
 
 	if (!prefix)
 		prefix = "";
@@ -1314,21 +1313,19 @@ static void diagnose_invalid_index_path(int stage,
 	}
 
 	/* Confusion between relative and absolute filenames? */
-	fullnamelen = namelen + strlen(prefix);
-	fullname = xmalloc(fullnamelen + 1);
-	strcpy(fullname, prefix);
-	strcat(fullname, filename);
-	pos = cache_name_pos(fullname, fullnamelen);
+	strbuf_addstr(&fullname, prefix);
+	strbuf_addstr(&fullname, filename);
+	pos = cache_name_pos(fullname.buf, fullname.len);
 	if (pos < 0)
 		pos = -pos - 1;
 	if (pos < active_nr) {
 		ce = active_cache[pos];
-		if (ce_namelen(ce) == fullnamelen &&
-		    !memcmp(ce->name, fullname, fullnamelen))
+		if (ce_namelen(ce) == fullname.len &&
+		    !memcmp(ce->name, fullname.buf, fullname.len))
 			die("Path '%s' is in the index, but not '%s'.\n"
 			    "Did you mean ':%d:%s' aka ':%d:./%s'?",
-			    fullname, filename,
-			    ce_stage(ce), fullname,
+			    fullname.buf, filename,
+			    ce_stage(ce), fullname.buf,
 			    ce_stage(ce), filename);
 	}
 
@@ -1338,7 +1335,7 @@ static void diagnose_invalid_index_path(int stage,
 		die("Path '%s' does not exist (neither on disk nor in the index).",
 		    filename);
 
-	free(fullname);
+	strbuf_release(&fullname);
 }
 
 
-- 
2.6.0.rc3.454.g204ad51
