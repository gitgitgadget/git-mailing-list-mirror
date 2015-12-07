From: Jeff King <peff@peff.net>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Mon, 7 Dec 2015 16:42:58 -0500
Message-ID: <20151207214257.GA32082@sigill.intra.peff.net>
References: <CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
 <20151204212712.GA22493@sigill.intra.peff.net>
 <CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
 <20151204215158.GA27987@sigill.intra.peff.net>
 <xmqqh9jxrfy5.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BSNm6=E6Mo6etv_Lvdd2kpqQ7EEMBAoP-AQraYy3xU8w@mail.gmail.com>
 <xmqqmvtons4j.fsf@gitster.mtv.corp.google.com>
 <20151206063718.GA549@sigill.intra.peff.net>
 <20151206070144.GA17902@sigill.intra.peff.net>
 <xmqqa8pmlzjc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jason Paller-Rzepka <jasonpr@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 22:43:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a63Yp-0000Bg-Ex
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 22:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844AbbLGVnC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 16:43:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:38547 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755589AbbLGVnA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 16:43:00 -0500
Received: (qmail 19716 invoked by uid 102); 7 Dec 2015 21:43:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 15:43:00 -0600
Received: (qmail 23930 invoked by uid 107); 7 Dec 2015 21:43:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 16:43:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2015 16:42:58 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa8pmlzjc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282130>

On Mon, Dec 07, 2015 at 01:27:51PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think one thing I was missing is that we need to just grab the
> > _object_, but we need to realize that the ref needs updating[1]. So we
> > cannot skip backfill of any tag that we do not already have, even if we
> > already have the tag object.
> > ...
> > [1] I'm still puzzled why find_non_local_tags uses has_sha1_file() on
> >     the tag object at all, then.
> 
> The designed semantics of auto-following tags (not necessarily as
> implemented or documented, i.e. there may be implementation or
> documentation bugs), I think, is to arrive at the same state as
> doing a fetch (or a push) without the auto-following and then doing
> a separate fetch (or a push) of tags that point at the objects that
> are reachable from the tips of refs after finishing the first
> (i.e. without auto-follow) fetch (or a push).  In a scenario where
> we already have a commit reachable from existing remote-tracking
> branch and the current transfer (be it a fetch or a push, with or
> without auto-follow) does not update any remote-tracking branch
> (because the source side did not have any changes), if the source
> side added a tag that refers to that commit that the receiving end
> lacks, that tag needs to be transferred and then stored.
> 
> So has_sha1_file() is not the right test---if anything, it needs to
> be checking if the object being checked is reachable from a tip of
> some ref.
> 
> But of course, that test is rather expensive, so perhaps the
> implementation cheated and uses has_sha1_file() instead?  The only
> case it would misidentify would be after an aborted fetch (or push)
> left unconnected island of objects and some of these objects that
> are not reachable are pointed at by tags the receiving end does not
> have.

I may have confused myself. There are actually two has_sha1_file() calls
in find_non_local_tags.

I agree it is the only sensible test for "do we have the commit this tag
peels to, and if so, we want to grab the tag".  Reachability is too
expensive to compute.

But for the other one ("do we have the tag object itself"), I initially
claimed "if we have the tag object already, we do not have to do the
backfill fetch". Which is not quite true. We have to update the ref even
if we have the tag object. But then, what if we have the tag object for
other reasons (e.g., because another tag points at it?).

E.g. in this sequence:

  git -C parent commit --allow-empty -m base
  git -C parent tag -m mytag foo
  git clone parent child
  git -C parent update-ref refs/tags/bar foo
  git -C child fetch

we must backfill refs/tags/bar during the fetch, even though we already
have the object. I don't see any point in checking has_sha1_file() for
the tagged object at all. If we don't have it, we obviously must fetch.
And if we do have it, we must fetch the ref, even if that results in no
objects transferred.

It's entirely possible I'm just confused, and AFAICT nobody has noticed
any breakage here, so please don't feel you need to spend a lot of time
humoring me. I'm just writing up my confusion for posterity. :)

-Peff
