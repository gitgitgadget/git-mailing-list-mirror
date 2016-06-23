Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0AE41FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 17:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbcFWReA (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 13:34:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:59197 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750919AbcFWReA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 13:34:00 -0400
Received: (qmail 29938 invoked by uid 102); 23 Jun 2016 17:33:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:33:59 -0400
Received: (qmail 12802 invoked by uid 107); 23 Jun 2016 17:34:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:34:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 13:33:57 -0400
Date:	Thu, 23 Jun 2016 13:33:57 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Simon Courtois <scourtois@cubyx.fr>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/7] add skip_prefix_mem helper
Message-ID: <20160623173357.GC15774@sigill.intra.peff.net>
References: <20160623173048.GA19923@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160623173048.GA19923@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The skip_prefix function has been very useful for
simplifying pointer arithmetic and avoiding repeated magic
numbers, but we have no equivalent for length-limited
buffers. So we're stuck with:

  if (3 <= len && skip_prefix(buf, "foo", &buf))
	  len -= 3;

That's not that complicated, but it needs to use magic
numbers for the length of the prefix (or else write out
strlen("foo"), repeating the string). By using a helper, we
can get the string length behind the scenes (and often at
compile time for string literals).

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously a helper to be used later in the series. I didn't hunt around
for other places that could make use of it, but I suspect there are
some.

 git-compat-util.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 49d4029..c99cddc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -473,6 +473,23 @@ static inline int skip_prefix(const char *str, const char *prefix,
 	return 0;
 }
 
+/*
+ * Like skip_prefix, but promises never to read past "len" bytes of the input
+ * buffer, and returns the remaining number of bytes in "out" via "outlen".
+ */
+static inline int skip_prefix_mem(const char *buf, size_t len,
+				  const char *prefix,
+				  const char **out, size_t *outlen)
+{
+	size_t prefix_len = strlen(prefix);
+	if (prefix_len <= len && !memcmp(buf, prefix, prefix_len)) {
+		*out = buf + prefix_len;
+		*outlen = len - prefix_len;
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * If buf ends with suffix, return 1 and subtract the length of the suffix
  * from *len. Otherwise, return 0 and leave *len untouched.
-- 
2.9.0.209.g845fbc1

