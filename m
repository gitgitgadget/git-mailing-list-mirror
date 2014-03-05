From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] push: detect local refspec errors early
Date: Wed, 5 Mar 2014 15:56:44 -0500
Message-ID: <20140305205644.GA13149@sigill.intra.peff.net>
References: <259061394012172@web5j.yandex.ru>
 <20140305190248.GB31252@sigill.intra.peff.net>
 <xmqqsiqwfjyd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry <wipedout@yandex.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:56:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLIrz-00077l-GX
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 21:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758AbaCEU4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 15:56:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:33655 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753448AbaCEU4r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 15:56:47 -0500
Received: (qmail 25351 invoked by uid 102); 5 Mar 2014 20:56:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Mar 2014 14:56:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Mar 2014 15:56:44 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsiqwfjyd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243480>

On Wed, Mar 05, 2014 at 12:51:06PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We can't fully process the refspecs until we have talked to the other
> > side, because they may involve matching refs from the remote; I don't
> > think git even really looks at them until after we've connected.
> >
> > But I think there are some obvious cases, like a bogus left-hand side
> > (i.e., what you have here) that cannot ever succeed, no matter what the
> > other side has. We could sanity check the refspecs before doing anything
> > else.
> 
> The user's wallclock time is more important than machine cycles,
> checking things we could check before having the user do things is a
> good principle to follow.
> 
> I wish that the solution did not have to involve doing the same
> computation twice, but I do not think there is a clean way around
> that in this codepath.

Yeah, there are two inefficiencies here:

  1. We parse the refspecs twice. In theory we could parse them once,
     feed the result to check_push_refspecs, then again to
     match_push_refspecs. That wouldn't be too hard a refactor.

  2. We match the "src" side to local refs twice. Getting rid of this
     would involve splitting match_push_refs into two (analyzing the
     "src" half and the "dst" half), somehow storing the intermediate
     the two calls, and only contacting the remote after the first step
     is done. This is probably trickier.

I'd be happy if somebody wanted to do those cleanups on top, but I don't
personally have an interest in spending time on them. The amount of
duplicated computation we're talking about here is not very much (and
the number of refspecs tends to be small, anyway).

-Peff
