From: Jeff King <peff@peff.net>
Subject: [PATCH 25/67] receive-pack: convert strncpy to xsnprintf
Date: Tue, 15 Sep 2015 11:43:08 -0400
Message-ID: <20150915154308.GY29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:43:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsO7-0004Xu-5o
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbbIOPnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:43:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:59343 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752738AbbIOPnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:43:10 -0400
Received: (qmail 11984 invoked by uid 102); 15 Sep 2015 15:43:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:43:10 -0500
Received: (qmail 7220 invoked by uid 107); 15 Sep 2015 15:43:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:43:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:43:08 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277927>

This strncpy is pointless; we pass the strlen() of the src
string, meaning that it works just like a memcpy. Worse,
though, is that the size has no relation to the destination
buffer, meaning it is a potential overflow.  In practice,
it's not. We pass only short constant strings like
"warning: " and "error: ", which are much smaller than the
destination buffer.

We can make this much simpler by just using xsnprintf, which
will check for overflow and return the size for our next
vsnprintf, without us having to run a separate strlen().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e6b93d0..04d2bdf 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -280,10 +280,10 @@ static void rp_warning(const char *err, ...) __attribute__((format (printf, 1, 2
 
 static void report_message(const char *prefix, const char *err, va_list params)
 {
-	int sz = strlen(prefix);
+	int sz;
 	char msg[4096];
 
-	strncpy(msg, prefix, sz);
+	sz = xsnprintf(msg, sizeof(msg), "%s", prefix);
 	sz += vsnprintf(msg + sz, sizeof(msg) - sz, err, params);
 	if (sz > (sizeof(msg) - 1))
 		sz = sizeof(msg) - 1;
-- 
2.6.0.rc2.408.ga2926b9
