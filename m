From: Jeff King <peff@peff.net>
Subject: Re: Bug in git-stash(.sh) ?
Date: Tue, 1 May 2012 09:42:55 -0400
Message-ID: <20120501134254.GA11900@sigill.intra.peff.net>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
 <87wr4za9mr.fsf@gmail.com>
 <m2pqasb8mr.fsf@linux-m68k.org>
 <xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
 <CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw@mail.gmail.com>
 <20380.33897.666338.766096@winooski.ccs.neu.edu>
 <20120429220132.GB4491@sigill.intra.peff.net>
 <20381.49180.329586.983166@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Hodique <yann.hodique@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eli Barzilay <public-eli-oSK4jVRJLyZg9hUCZPvPmw@plane.gmane.org>,
	git@vger.kernel.org,
	Eli Barzilay <public-eli-oSK4jVRJLyZg9hUCZPvPmw@plane.gmane.org>,
	magit@googlegroups.com
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Tue May 01 15:43:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPDMA-0007uY-Vv
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 15:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757692Ab2EANnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 09:43:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53058
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755661Ab2EANnA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 09:43:00 -0400
Received: (qmail 4471 invoked by uid 107); 1 May 2012 13:43:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 09:43:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 09:42:55 -0400
Content-Disposition: inline
In-Reply-To: <20381.49180.329586.983166@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196681>

On Sun, Apr 29, 2012 at 06:26:36PM -0400, Eli Barzilay wrote:

> > which led to f4ea32f (improve reflog date/number heuristic,
> > 2009-09-24).  That fixed the case of:
> > 
> >   git config log.date iso
> >   git log -g --oneline
> > 
> > But later, 8f8f547 (Introduce new pretty formats %g[sdD] for reflog
> > information, 2009-10-19) added another way to show selectors, and it
> > did not respect the date_mode_explicit flag from f4ea32f. Which I
> > think is a bug.
> > 
> > So the right solution is to pass the date_mode_explicit flag through
> > to the pretty-print --format code, and then pass it along to the
> > reflog code.
> 
> Assuming that I followed all of that correctly, it still seems bogus
> to do that, given that %gd and %gD are described as producing reflog
> selector, and given that Junio's note that stash operations are really
> intended to be used only with these selectos.

Keep in mind this bug is not about stash at all; it is about showing
reflog selectors. Those are a more general mechanism, and are used for
more than just stash. The fact that user config affects the format of
"%gd" is a bug; it should follow the same rules as the regular reflog
pretty-printing (and the behavior of neither should be affected by user
config, as scripts rely on the output being consistent).

Once that is fixed, then we can consider whether something more should
happen for stash (though I am inclined to say that is enough; it is a
feature that you can do "git stash list --date=relative" to see the
stash timestamps).

> What looks more sensible to me given the necessity of %gd (and the
> fact that it's different from %cd/%ad) is to change things as follows:
> 
>   * %gd produces only the date, with the "default" having the same
>     meaning as elsewhere (so it doesn't show the index numbers)

%gd is part of the public interface and will not change its semantics
(or at least not without a long deprecation period).  It's a shame that
"d" is taken for the selector, when it would be better to mean "date" as
it does for author and committer. But I don't know if it's worth
changing at this point.

We could add new placeholders with different semantics, though. When I
added reflog identity placeholders a few months ago, there was a brief
discussion on adding a date placeholder:

  http://article.gmane.org/gmane.comp.version-control.git/185043

but the related work hasn't progressed.

>   * Some new %gi uses the index number: stash@{1}, and %gI produces
>     refs/stash@{1}, unrelated to any date setting
>   * git-stash.sh uses %gi so the output has the numbers
>   * Some new option for "stash list" for the format string, so it's
>     possible to show the dates if you want to with something like
>     git stash list --format:"%gi: %gs (%gd)"

I don't have a huge problem with that. But what issue is it really
solving? Are people using "git stash list --date=iso" and then getting
confused by the output? Or is it simply a matter of mistakenly applying
the config when it should not be? The latter needs fixed in either case.

-Peff
