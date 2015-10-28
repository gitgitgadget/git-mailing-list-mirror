From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] receive-pack: allow for hiding refs outside the
 namespace
Date: Wed, 28 Oct 2015 09:42:13 -0400
Message-ID: <20151028134212.GA9657@sigill.intra.peff.net>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
 <xmqqk2q9h05h.fsf@gitster.mtv.corp.google.com>
 <20151027053916.3030.8259@typhoon.lan>
 <20151027055911.4877.94179@typhoon.lan>
 <20151027143207.18755.82151@s-8d3a2f8b.on.site.uni-stuttgart.de>
 <xmqqfv0wcgzx.fsf@gitster.mtv.corp.google.com>
 <20151028070045.5031.43810@s-8d3a2f8b.on.site.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 14:42:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrQzd-0003yB-F7
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 14:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965648AbbJ1NmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 09:42:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:49138 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965646AbbJ1NmP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 09:42:15 -0400
Received: (qmail 7646 invoked by uid 102); 28 Oct 2015 13:42:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Oct 2015 08:42:15 -0500
Received: (qmail 1520 invoked by uid 107); 28 Oct 2015 13:42:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Oct 2015 09:42:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Oct 2015 09:42:13 -0400
Content-Disposition: inline
In-Reply-To: <20151028070045.5031.43810@s-8d3a2f8b.on.site.uni-stuttgart.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280364>

On Wed, Oct 28, 2015 at 08:00:45AM +0100, Lukas Fleischer wrote:

> My original question remains: Do we want to continue supporting things
> like transfer.hideRefs=.have (which currently magically hides all refs
> outside the current namespace)? For 100% backwards compatibility, we
> would have to. On the other hand, one could consider the current
> behavior a bug and one could argue that it is weird enough that probably
> nobody (apart from me) relies on it right now. If we decide to keep it
> anyway, I think it should be documented.

I don't think that hiding ".have" refs at that level is especially
useful. I do not use namespaces, but I do use alternates extensively,
and that is the original source of these ".have" refs. But filtering
them at the advertisement layer is very inefficient, as it is expensive
to get the list in the first place (we spawn ls-remote, which spawns
upload-pack in the alternate!). So we'd want to prevent that process
much earlier.

I have an unpublished patch to specially disable alternates
advertisement entirely (i.e., adding a new boolean config,
receive.advertiseAlternates). In my case, it is because the alternates
repositories have huge numbers of refs (sometimes ranging into the
gigabytes) and the performance hit on even loading that packed-refs file
is too large.

I suppose that behavior _could_ be triggered by ".have" appearing in the
hiderefs config, though (i.e., before accessing the alternate, check
ref_is_hidden(".have")). That seems a bit too subtle to me, though.

> Another patch I have in my patch queue adds support for a whitelist mode
> to hideRefs. There are several ways to implement that:
> 
> 1. Make transfer.hideRefs='' hide all refs (it currently does not). The
>    user can then whitelist refs explicitly using negative patterns
>    below that rule. This is how my current implementation works. Using
>    the empty string seemed most natural since hideRefs matches prefixes
>    and every string has the empty string as a prefix. If that seems too
>    weird, we could probably special case something like
>    transfer.hideRefs='*' instead.
> 
> 2. Detect whether hideRefs only contains negative patterns. Switch to
>    whitelist mode ("hide by default") in that case.
> 
> 3. Add another option to switch between "hide by default" and "show by
>    default".
> 
> I personally prefer the first option. Any other opinions?

I am just a bystander and would not use this myself, but I think the 1st
is the least ugly. I am not sure why ignoring "refs/" does not work,
though (it does not catch ".have", of course, but I think that is a
feature; there are a finite set of pseudo-refs, so you can ignore those,
too, if you want).

-Peff
