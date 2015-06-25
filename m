From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] introduce "preciousObjects" repository extension
Date: Thu, 25 Jun 2015 06:07:37 -0400
Message-ID: <20150625100737.GA26795@peff.net>
References: <20150623105042.GA10888@peff.net>
 <20150623105411.GB12518@peff.net>
 <xmqq1th2cezr.fsf@gitster.dls.corp.google.com>
 <20150624075019.GA827@peff.net>
 <xmqqvbed9gf7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 12:12:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8494-0000Il-2e
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 12:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbbFYKMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 06:12:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:51535 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752836AbbFYKHk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 06:07:40 -0400
Received: (qmail 27726 invoked by uid 102); 25 Jun 2015 10:07:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 05:07:40 -0500
Received: (qmail 4663 invoked by uid 107); 25 Jun 2015 10:07:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 06:07:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jun 2015 06:07:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbed9gf7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272655>

On Wed, Jun 24, 2015 at 10:15:08AM -0700, Junio C Hamano wrote:

> > I agree that would be better. I originally just blocked all use of
> > git-repack, but at the last minute softened it to just "repack -d". I'm
> > not sure if that would actually help anyone in practice. Sure, doing
> > "git repack" without any options is not destructive, but I wonder if
> > anybody actually does it.
> 
> Hmph, if you cannot afford to lose objects that are unreachable from
> your refs (because you know your repository has borrowers) but are
> suffering from too many packs, wouldn't "repack -a" be the most
> natural thing to do?  Maybe I am biased, but "git gc" is not the
> first thing that comes to my mind in that situation.

My assumption was that people fall into one of two categories:

  - people who just run `git gc`

  - people who are doing something clever, and will use `git
    repack` to do a full repack after making sure it is safe to do so.

    E.g., after "clone -s", it might be OK to do:

      for i in ../*.git; do
        git fetch $i +refs/*:refs/remotes/$i/*
      done
      git -c extensions.preciousObjects=false repack -ad

    But only the user can make that decision; git does not know whether
    "../*.git" is the complete set of children.

Certainly "git repack -a" is a safe stopgap in the shared-object parent,
but eventually you will want to do the clever thing. :)

I think it is OK to use this patch as a starting point, and for people
to loosen the rules later if there is a combination of repack flags that
are safe to run but not covered by the current logic (there is no
regression, since preciousObjects is a new extension, and going forward
it is OK to allow new safe things to open up workflows, but not the
other way around).

It may even be that the current patch even allows any sane workflow; I
am only claiming that I did not think too hard on it, and tried to err
on the side of safety, and allowing the workflow above.

-Peff
