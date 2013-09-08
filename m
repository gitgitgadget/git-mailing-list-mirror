From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] config: set errno in numeric git_parse_* functions
Date: Sun, 8 Sep 2013 04:36:42 -0400
Message-ID: <20130908083642.GC29554@sigill.intra.peff.net>
References: <20130908082724.GA27184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 10:36:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIaUH-00067T-Ub
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab3IHIgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:36:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:43779 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab3IHIgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 04:36:46 -0400
Received: (qmail 11477 invoked by uid 102); 8 Sep 2013 08:36:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 03:36:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 04:36:42 -0400
Content-Disposition: inline
In-Reply-To: <20130908082724.GA27184@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234222>

When we are parsing an integer or unsigned long, we use
the strto*max functions, which properly set errno to ERANGE
if we get a large value. However, we also do further range
checks after applying our multiplication factor, but do not
set ERANGE. This means that a caller cannot tell if an error
was caused by ERANGE or if the input was simply not a valid
number.

This patch teaches git_parse_signed and git_parse_unsigned
reliably set ERANGE for range errors, and EINVAL for other
errors.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm a little iffy on using errno like this. The "normal" way in git
would be to return an enum like:

  enum config_parse_error {
    CONFIG_PARSE_SUCCESS = 0,
    CONFIG_PARSE_RANGE = -1,
    CONFIG_PARSE_INVALID_UNIT = -2
  };

But that would be changing the return semantics of git_parse_ulong
(which currently is "0" for fail, "1" for success) without changing its
signature. I figured this was the path of least resistance since we
already get ERANGE out of strtoimax, but I'm happy to switch it, too.

 config.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 0a65ac2..7332b06 100644
--- a/config.c
+++ b/config.c
@@ -480,16 +480,21 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 		val = strtoimax(value, &end, 0);
 		if (errno == ERANGE)
 			return 0;
-		if (!parse_unit_factor(end, &factor))
+		if (!parse_unit_factor(end, &factor)) {
+			errno = EINVAL;
 			return 0;
+		}
 		uval = abs(val);
 		uval *= factor;
-		if (uval > max || abs(val) > uval)
+		if (uval > max || abs(val) > uval) {
+			errno = ERANGE;
 			return 0;
+		}
 		val *= factor;
 		*ret = val;
 		return 1;
 	}
+	errno = EINVAL;
 	return 0;
 }
 
@@ -505,13 +510,18 @@ int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 		if (errno == ERANGE)
 			return 0;
 		oldval = val;
-		if (!parse_unit_factor(end, &val))
+		if (!parse_unit_factor(end, &val)) {
+			errno = EINVAL;
 			return 0;
-		if (val > max || oldval > val)
+		}
+		if (val > max || oldval > val) {
+			errno = ERANGE;
 			return 0;
+		}
 		*ret = val;
 		return 1;
 	}
+	errno = EINVAL;
 	return 0;
 }
 
-- 
1.8.4.2.g87d4a77
