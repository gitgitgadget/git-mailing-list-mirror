From: Jeff King <peff@peff.net>
Subject: Re: "git am" and then "git am -3" regression?
Date: Sun, 26 Jul 2015 01:21:00 -0400
Message-ID: <20150726052100.GA31790@peff.net>
References: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
 <20150724180921.GA17730@peff.net>
 <CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 07:21:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJEN3-0008CG-ET
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 07:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbbGZFVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 01:21:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:34969 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932130AbbGZFVD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 01:21:03 -0400
Received: (qmail 24389 invoked by uid 102); 26 Jul 2015 05:21:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Jul 2015 00:21:03 -0500
Received: (qmail 31261 invoked by uid 107); 26 Jul 2015 05:21:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Jul 2015 01:21:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Jul 2015 01:21:00 -0400
Content-Disposition: inline
In-Reply-To: <CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274635>

On Sun, Jul 26, 2015 at 01:03:59PM +0800, Paul Tan wrote:

> > Ideally the code would just be ordered as:
> >
> >   - load config from git-config
> >
> >   - override that with defaults inherited from a previous run
> >
> >   - override that with command-line parsing
> 
> So I'm more in favor of this solution. It's feels much more natural to
> me, rather than attempting to workaround the existing code structure.

Yeah, I really prefer it, too. I just didn't know if there would be
other confusing fallouts from changing the ordering. But since you have
been deep in this code recently, I trust your judgement. :)

> > It does look like that is how Paul's builtin/am.c does it, which makes
> > me think it might not be broken. It's also possibly I've horribly
> > misdiagnosed the bug. ;)
> 
> Nah, it follows the same structure as git-am.sh and so will exhibit
> the same behavior. It currently does something like this:
> 
> 1. am_state_init() (config settings are loaded)
> 2. parse_options()
> 3. if (am_in_progress()) am_load(); else am_setup();

Ah, right. I took the am_state_init() to be the part where we loaded the
existing options, and didn't notice the later am_load().

> The next question is, should any options set on the command-line
> affect subsequent invocations? If yes, then the control flow will be
> like:
> 
> 1. am_state_init();
> 2. if (am_in_progress()) am_load();
> 3. parse_options();
> 4. if (am_in_progress()) am_save_opts(); else am_setup();
> 
> where am_save_opts() will write the updated variables back to the
> state directory. What do you think?

I don't think we need to go that direction.  The usual thought process
(mine, anyway) is:

  1. I want to apply a series, and I want to use option A.

  2. Oops, one of the patches didn't apply. Let's retry it with option B
     (usually "-3").

  3. OK, that worked. Now let's try the rest of the patches.

I wouldn't expect in step 3 to have options from step 2 persist. That
was just about wiggling that _one_ patch. Whereas options from step 1
are about the whole series.

> Since the builtin-am series is in 'next' already, and the fix in C is
> straightforward, to save time and effort I'm wondering if we could
> just do "am.threeWay patch -> builtin-am series -> bugfix patch in C".
> My university term is starting soon so I may not have so much time,
> but I'll see what I can do :-/

Yeah, having to worry about two implementations of "git am" is a real
pain. If we are close on merging the builtin version, it makes sense to
me to hold off on the am.threeway feature until that is merged. Trying
to fix the ordering of the script that is going away isn't a good use of
anybody's time.

-Peff
