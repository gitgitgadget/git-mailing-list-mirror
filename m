From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/18] convert trivial cases to FLEX_ARRAY macros
Date: Mon, 15 Feb 2016 22:26:27 -0500
Message-ID: <20160216032626.GA19954@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
 <20160215215244.GG10287@sigill.intra.peff.net>
 <CAPig+cSQG7gWStpRy76D_YzuCFPsXJLBzXCjQ-X_Q3sZthx3iw@mail.gmail.com>
 <20160216031554.GB13606@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 04:26:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVWHZ-0002Y4-Rk
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 04:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbcBPD0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 22:26:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:42734 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752932AbcBPD03 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 22:26:29 -0500
Received: (qmail 18922 invoked by uid 102); 16 Feb 2016 03:26:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 22:26:29 -0500
Received: (qmail 15694 invoked by uid 107); 16 Feb 2016 03:26:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 22:26:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 22:26:27 -0500
Content-Disposition: inline
In-Reply-To: <20160216031554.GB13606@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286310>

On Mon, Feb 15, 2016 at 10:15:54PM -0500, Jeff King wrote:

> > Answering my own question: Looking at reflog_expire_config() and
> > parse_config_key(), I gather that 'len' already accounts for the NUL,
> > thus the new code is overallocating (which should not be a problem).
> 
> Actually, I think the original underallocates. If we have
> gc.foobar.reflogExpire, then "pattern" will poitn to "foobar" and "len"
> will be 6. Meaning we allocate without a trailing NUL.
> 
> That _should_ be OK, because the struct has a "len" field, and readers
> can be careful not to go past it. And indeed, in the loop above, we
> check the length and use memcmp().
> 
> But later, in set_reflog_expiry_param(), we walk through the list and
> hand ent->pattern directly to wildmatch, which assumes a NUL-terminated
> string. In practice, it probably works out 7 out of 8 times, because
> malloc will align the struct, and we're on a zeroed page, so unless the
> string is exactly 8 characters, we'll get some extra NULs afterwards.
> But I could demonstrate it by doing:
> 
>   gdb --args git -c gc.foobar12.reflogexpire=never reflog expire --all
> 
> and breaking on wildmatch, which yields:
> 
>   Breakpoint 1, wildmatch (pattern=0x85eb70 "foobar12Q", text=0x85e4d4
> 	"refs/heads/master", flags=0, wo=0x0)
> 
> So this is in fact fixing a bug. I can't say I'm terribly surprised
> nobody noticed it, as per-ref reflog expiration is pretty obscure.

We could do this on top of my series (I can also factor out the fix
separately to go at the beginning if we don't want to hold the bugfix
hostage).

-- >8 --
Subject: [PATCH] reflog_expire_cfg: drop misleading "len" parameter

You can tweak the reflog expiration for a particular subset
of refs by configuring gc.foo.reflogexpire. We keep a linked
list of reflog_expire_cfg structs, each of which holds the
pattern and a "len" field for the length of the pattern.

However, we feed the pattern directly to wildmatch(), which
means that it must be a NUL-terminated string. Before the
recent conversion to FLEX_ALLOC_MEM, we got this wrong, and
could feed extra garbage to wildmatch(). That's now fixed,
but the "len" parameter is simply misleading. The pattern is
a string, and we don't need to record its length.

To get rid of it, we do need to tweak the "do we have it
already?" search in find_cfg_ent(), but we can do so without
having a recorded length by just using strncmp.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/reflog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 7c1990f..2d46b64 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -394,7 +394,6 @@ static struct reflog_expire_cfg {
 	struct reflog_expire_cfg *next;
 	unsigned long expire_total;
 	unsigned long expire_unreachable;
-	size_t len;
 	char pattern[FLEX_ARRAY];
 } *reflog_expire_cfg, **reflog_expire_cfg_tail;
 
@@ -406,12 +405,11 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 		reflog_expire_cfg_tail = &reflog_expire_cfg;
 
 	for (ent = reflog_expire_cfg; ent; ent = ent->next)
-		if (ent->len == len &&
-		    !memcmp(ent->pattern, pattern, len))
+		if (!strncmp(ent->pattern, pattern, len) &&
+		    ent->pattern[len] == '\0')
 			return ent;
 
 	FLEX_ALLOC_MEM(ent, pattern, pattern, len);
-	ent->len = len;
 	*reflog_expire_cfg_tail = ent;
 	reflog_expire_cfg_tail = &(ent->next);
 	return ent;
-- 
2.7.1.574.gccd43a9
