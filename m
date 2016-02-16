From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/18] convert trivial cases to FLEX_ARRAY macros
Date: Mon, 15 Feb 2016 22:36:20 -0500
Message-ID: <20160216033620.GA26430@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
 <20160215215244.GG10287@sigill.intra.peff.net>
 <CAPig+cSQG7gWStpRy76D_YzuCFPsXJLBzXCjQ-X_Q3sZthx3iw@mail.gmail.com>
 <20160216031554.GB13606@sigill.intra.peff.net>
 <20160216032626.GA19954@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 04:36:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVWR9-0002ok-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 04:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbcBPDgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 22:36:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:42745 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753324AbcBPDgX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 22:36:23 -0500
Received: (qmail 19355 invoked by uid 102); 16 Feb 2016 03:36:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 22:36:22 -0500
Received: (qmail 15771 invoked by uid 107); 16 Feb 2016 03:36:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 22:36:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 22:36:20 -0500
Content-Disposition: inline
In-Reply-To: <20160216032626.GA19954@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286313>

On Mon, Feb 15, 2016 at 10:26:26PM -0500, Jeff King wrote:

> We could do this on top of my series (I can also factor out the fix
> separately to go at the beginning if we don't want to hold the bugfix
> hostage).
> 
> -- >8 --
> Subject: [PATCH] reflog_expire_cfg: drop misleading "len" parameter

Here it is as a separate fix. Applying my series on top would need a
minor and obvious tweak. I'll hold a re-roll for more comments, but will
otherwise plan to stick this at the front of the series.

-- >8 --
Subject: [PATCH] reflog_expire_cfg: NUL-terminate pattern field

You can tweak the reflog expiration for a particular subset
of refs by configuring gc.foo.reflogexpire. We keep a linked
list of reflog_expire_cfg structs, each of which holds the
pattern and a "len" field for the length of the pattern. The
pattern itself is _not_ NUL-terminated.

However, we feed the pattern directly to wildmatch(), which
expects a NUL-terminated string, meaning it may keep reading
random junk after our struct.

We can fix this by allocating an extra byte for the NUL
(which is already zero because we use xcalloc). Let's also
drop the misleading "len" field, which is no longer
necessary. The existing use of "len" can be converted to use
strncmp().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/reflog.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index f39960e..9980731 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -396,7 +396,6 @@ static struct reflog_expire_cfg {
 	struct reflog_expire_cfg *next;
 	unsigned long expire_total;
 	unsigned long expire_unreachable;
-	size_t len;
 	char pattern[FLEX_ARRAY];
 } *reflog_expire_cfg, **reflog_expire_cfg_tail;
 
@@ -408,13 +407,12 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 		reflog_expire_cfg_tail = &reflog_expire_cfg;
 
 	for (ent = reflog_expire_cfg; ent; ent = ent->next)
-		if (ent->len == len &&
-		    !memcmp(ent->pattern, pattern, len))
+		if (!strncmp(ent->pattern, pattern, len) &&
+		    ent->pattern[len] == '\0')
 			return ent;
 
-	ent = xcalloc(1, (sizeof(*ent) + len));
+	ent = xcalloc(1, sizeof(*ent) + len + 1);
 	memcpy(ent->pattern, pattern, len);
-	ent->len = len;
 	*reflog_expire_cfg_tail = ent;
 	reflog_expire_cfg_tail = &(ent->next);
 	return ent;
-- 
2.7.1.574.gccd43a9
