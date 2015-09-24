From: Jeff King <peff@peff.net>
Subject: [PATCH 46/68] remove_leading_path: use a strbuf for internal storage
Date: Thu, 24 Sep 2015 17:07:47 -0400
Message-ID: <20150924210747.GQ30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:08:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDkX-00028o-OG
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbbIXVHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:36002 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753930AbbIXVHu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:50 -0400
Received: (qmail 12085 invoked by uid 102); 24 Sep 2015 21:07:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:49 -0500
Received: (qmail 29389 invoked by uid 107); 24 Sep 2015 21:08:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:47 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278596>

This function strcpy's directly into a PATH_MAX-sized
buffer. There's only one caller, which feeds the git_dir into
it, so it's not easy to trigger in practice (even if you fed
a large $GIT_DIR through the environment or .git file, it
would have to actually exist and be accessible on the
filesystem to get to this point). We can fix it by moving to
a strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
 path.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/path.c b/path.c
index 60e0390..c597473 100644
--- a/path.c
+++ b/path.c
@@ -632,7 +632,7 @@ const char *relative_path(const char *in, const char *prefix,
  */
 const char *remove_leading_path(const char *in, const char *prefix)
 {
-	static char buf[PATH_MAX + 1];
+	static struct strbuf buf = STRBUF_INIT;
 	int i = 0, j = 0;
 
 	if (!prefix || !prefix[0])
@@ -661,11 +661,13 @@ const char *remove_leading_path(const char *in, const char *prefix)
 		return in;
 	while (is_dir_sep(in[j]))
 		j++;
+
+	strbuf_reset(&buf);
 	if (!in[j])
-		strcpy(buf, ".");
+		strbuf_addstr(&buf, ".");
 	else
-		strcpy(buf, in + j);
-	return buf;
+		strbuf_addstr(&buf, in + j);
+	return buf.buf;
 }
 
 /*
-- 
2.6.0.rc3.454.g204ad51
