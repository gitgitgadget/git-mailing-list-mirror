From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 56/67] avoid sprintf and strcpy with flex arrays
Date: Mon, 21 Sep 2015 13:19:18 -0400
Message-ID: <20150921171918.GA29964@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915160956.GD29753@sigill.intra.peff.net>
 <CAPig+cSL3W58TSYEAFz3twvxt_brB=kY=LEwX6m5RhBsg6VV6g@mail.gmail.com>
 <20150921151521.GA25286@sigill.intra.peff.net>
 <CAPig+cQwGHNPUG2MB2v5XXTQ+RP5L5J_EU4=nawzLjCN89s1ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 19:19:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze4kY-0000Yp-8v
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 19:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116AbbIURTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 13:19:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:34008 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757064AbbIURTV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 13:19:21 -0400
Received: (qmail 23698 invoked by uid 102); 21 Sep 2015 17:19:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Sep 2015 12:19:20 -0500
Received: (qmail 28657 invoked by uid 107); 21 Sep 2015 17:19:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Sep 2015 13:19:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Sep 2015 13:19:18 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQwGHNPUG2MB2v5XXTQ+RP5L5J_EU4=nawzLjCN89s1ZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278315>

On Mon, Sep 21, 2015 at 01:11:09PM -0400, Eric Sunshine wrote:

> >> > -       p = xcalloc(1, sizeof(*p) + strlen(tmp_file) + 2);
> >> > -       strcpy(p->pack_name, tmp_file);
> >> > +       namelen = strlen(tmp_file) + 2;
> >>
> >> You mentioned this specially in the commit message, but from a brief
> >> read of the code, it's still not obvious (to me) why this is +2 rather
> >> than +1. Since you're touching the code anyhow, perhaps add an in-code
> >> comment explaining it?
> >
> > To be honest, I'm not sure what's going on with the "+ 2" here.
> >
> > In many cases with packed_git we allocate with "foo.idx" and want to be
> > able to later write "foo.pack" into the same buffer. But here we are
> > putting in a tmpfile name. This comes from 8455e48, but I don't see any
> > clue there. I wonder if the "+2" was simply cargo-culted from other
> > instances.
> 
> Ah, ok. I guess I misunderstood the commit message to mean or imply
> that the +2 was correct and sensible and well-understood.

I think it was more that I looked at other instances of packed_git, and
realized they could not be safely converted. I think "struct
alternate_object_database" has similar problems.

-Peff

PS As I mentioned earlier, I did end up adding a FLEX_ALLOC() macro in
   another series that builds on top of this. I haven't posted it yet,
   but check out:

     https://github.com/peff/git/commit/ba491c527572c763286b4b9519aef3c30482c2d1

   and

     https://github.com/peff/git/commit/d88444d5ba00bd875ef5291dca3b71dd046186dc

   if you are curious.
