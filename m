From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 00:26:07 -0400
Message-ID: <20120620042607.GA10414@sigill.intra.peff.net>
References: <20120619232231.GA6328@sigill.intra.peff.net>
 <20120619232310.GA6496@sigill.intra.peff.net>
 <20120620035015.GA4213@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 06:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShCUh-0004RC-R5
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 06:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab2FTE0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 00:26:11 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33289
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325Ab2FTE0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 00:26:10 -0400
Received: (qmail 18495 invoked by uid 107); 20 Jun 2012 04:26:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 00:26:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 00:26:07 -0400
Content-Disposition: inline
In-Reply-To: <20120620035015.GA4213@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200285>

On Tue, Jun 19, 2012 at 10:50:15PM -0500, Jonathan Nieder wrote:

> Making .sp and .s targets depend on generated .h files like
> common-cmds.h is very important.  Otherwise, I would not be able to
> generate my git.s assembler listing or sparse-check git.c unless
> common-cmds.h has already been generated as a side-effect of some
> earlier build process.

I suspect in most cases that the earlier build process has happened, and
that's why nobody really complained.

> On the other hand, making .sp and .s targets depend on preexisting .h
> files and files like GIT-CFLAGS would not have any effect at all,
> because:
> 
>  - .sp targets are phony --- there is no stamp file that certifies
>    a given file has been checked by a "make sparse" run.  Maybe that
>    will change some day.
> 
>  - .s targets are rebuilt every time.  Maybe I am just weird, but I
>    find myself upgrading my compiler pretty often, so when I manually
>    ask for an assembler listing I am happy to see it regenerated
>    unconditionally using the new code generation rules.

I don't have a strong opinion, as I don't use either feature. I noticed
the generated header file was a problem, and didn't realize that we
force .s builds.

My counters to the above points (and again, I don't really care
that much) would be:

  1. The .sp and .s targets _do_ need the same -D macros that the .o
     targets get. So it ends up being very obvious that you are omitting
     them in something like:

       foo.o: GIT-VERSION-FILE
       foo.o foo.sp foo.s: EXTRA_CPPFLAGS = \
              -DGIT_VERSION='$(GIT_VERSION)'

     I tend to think it is more readable to simply specify the
     dependencies fully (even if they end up being irrelevant because we
     force-build) than to confuse a reader who is not aware of our
     force-build '.s' rule that is 500 lines away (I was not aware of it
     until you mentioned it).

  2. You describe the behavior now, and I certainly have no plans to
     change it. But there also plausible reasons for both cases to stop
     force-building, in which case these dependencies would become
     relevant.

In other words, I think relying on the force-build is a bit of a
layering violation. Of course, it is a Makefile, which is not exactly
structured programming, but I like to try.

> It turns out that this patch is only about common-cmds.h, which was
> the straightforward case.  Why not say so and save the reader from
> having to think so hard? ;)

Because I didn't realize it was the case at all. :) My intent was
actually to clean up these lines so that they would be correct when I
added GIT-VERSION-FILES and the like to them later.

So I think my preference would be to tack on a note to the commit
message saying "yeah, this doesn't do anything for meta-dependencies,
but it doesn't hurt either". OK?

-Peff
