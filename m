From: Jeff King <peff@peff.net>
Subject: [PATCH 25/68] receive-pack: convert strncpy to xsnprintf
Date: Thu, 24 Sep 2015 17:07:00 -0400
Message-ID: <20150924210700.GV30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:07:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDjU-0001n6-Li
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbbIXVHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:35961 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752997AbbIXVHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:03 -0400
Received: (qmail 11946 invoked by uid 102); 24 Sep 2015 21:07:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:02 -0500
Received: (qmail 29183 invoked by uid 107); 24 Sep 2015 21:07:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:00 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278583>

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
2.6.0.rc3.454.g204ad51
