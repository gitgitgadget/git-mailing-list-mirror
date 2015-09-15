From: Jeff King <peff@peff.net>
Subject: [PATCH 14/67] compat/inet_ntop: fix off-by-one in inet_ntop4
Date: Tue, 15 Sep 2015 11:31:19 -0400
Message-ID: <20150915153119.GN29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:31:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsCg-0007N2-8W
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbbIOPbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:31:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:59306 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752694AbbIOPbW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:31:22 -0400
Received: (qmail 11472 invoked by uid 102); 15 Sep 2015 15:31:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:31:21 -0500
Received: (qmail 6988 invoked by uid 107); 15 Sep 2015 15:31:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:31:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:31:19 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277915>

Our compat inet_ntop4 function writes to a temporary buffer
with snprintf, and then uses strcpy to put the result into
the final "dst" buffer. We check the return value of
snprintf against the size of "dst", but fail to account for
the NUL terminator. As a result, we may overflow "dst" with
a single NUL. In practice, this doesn't happen because the
output of inet_ntop is limited, and we provide buffers that
are way oversized.

We can fix the off-by-one check easily, but while we are
here let's also use strlcpy for increased safety, just in
case there are other bugs lurking.

As a side note, this compat code seems to be BSD-derived.
Searching for "vixie inet_ntop" turns up NetBSD's latest
version of the same code, which has an identical fix (and
switches to strlcpy, too!).

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/inet_ntop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index 90b7cc4..6830726 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -53,11 +53,11 @@ inet_ntop4(const u_char *src, char *dst, size_t size)
 	nprinted = snprintf(tmp, sizeof(tmp), fmt, src[0], src[1], src[2], src[3]);
 	if (nprinted < 0)
 		return (NULL);	/* we assume "errno" was set by "snprintf()" */
-	if ((size_t)nprinted > size) {
+	if ((size_t)nprinted >= size) {
 		errno = ENOSPC;
 		return (NULL);
 	}
-	strcpy(dst, tmp);
+	strlcpy(dst, tmp, size);
 	return (dst);
 }
 
@@ -154,7 +154,7 @@ inet_ntop6(const u_char *src, char *dst, size_t size)
 		errno = ENOSPC;
 		return (NULL);
 	}
-	strcpy(dst, tmp);
+	strlcpy(dst, tmp, size);
 	return (dst);
 }
 #endif
-- 
2.6.0.rc2.408.ga2926b9
