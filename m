From: Jeff King <peff@peff.net>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Sun, 6 Dec 2015 02:01:44 -0500
Message-ID: <20151206070144.GA17902@sigill.intra.peff.net>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
 <CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
 <20151204212712.GA22493@sigill.intra.peff.net>
 <CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
 <20151204215158.GA27987@sigill.intra.peff.net>
 <xmqqh9jxrfy5.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BSNm6=E6Mo6etv_Lvdd2kpqQ7EEMBAoP-AQraYy3xU8w@mail.gmail.com>
 <xmqqmvtons4j.fsf@gitster.mtv.corp.google.com>
 <20151206063718.GA549@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jason Paller-Rzepka <jasonpr@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 08:02:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5TKo-000580-Kc
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 08:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbbLFHBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 02:01:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:37871 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbbLFHBr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 02:01:47 -0500
Received: (qmail 6858 invoked by uid 102); 6 Dec 2015 07:01:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 06 Dec 2015 01:01:47 -0600
Received: (qmail 8085 invoked by uid 107); 6 Dec 2015 07:01:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 06 Dec 2015 02:01:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Dec 2015 02:01:44 -0500
Content-Disposition: inline
In-Reply-To: <20151206063718.GA549@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282043>

On Sun, Dec 06, 2015 at 01:37:18AM -0500, Jeff King wrote:

> And indeed, replacing the logic with what I wrote does make the backfill
> go away in my test case. But it's so far from what is there that I feel
> like I must be missing something.

I think one thing I was missing is that we need to just grab the
_object_, but we need to realize that the ref needs updating[1]. So we
cannot skip backfill of any tag that we do not already have, even if we
already have the tag object.

Which made me wonder why this:

  git init parent &&
  git -C parent commit --allow-empty -m one &&
  git clone parent child &&
  git -C parent commit --allow-empty -m two &&
  git -C parent tag -m mytag foo &&
  git -C parent commit --allow-empty -m three &&
  git -C child fetch

does not appear to need to backfill to pick up refs/tags/foo. But it
does. It's just that it hits the quickfetch() code path and does not
have to ask the other side for a pack. And that explains why it does hit
in the --shallow case: we explicitly disable quickfetch in such cases.

For the unshallow case, of course we could use it (but only for the
second, backfill fetch). Something like this seems to work for me:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ed84963..b33b90f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -881,6 +881,8 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
+	if (unshallow)
+		depth = NULL;
 	fetch_refs(transport, ref_map);
 
 	if (gsecondary) {

But I admit I am not at all confident that it doesn't cause other
problems, or that it covers all cases. Even in a shallow repo, we should
be able to quickfetch individual tags, shouldn't we? I wonder if we
could just always set "depth = NULL" here.

-Peff

[1] I'm still puzzled why find_non_local_tags uses has_sha1_file() on
    the tag object at all, then.
