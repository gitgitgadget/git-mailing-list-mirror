From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff,difftool: Don't use the {0,2} notation in usage
 strings
Date: Thu, 4 Nov 2010 14:55:45 -0400
Message-ID: <20101104185545.GB31016@sigill.intra.peff.net>
References: <20101024155121.GA9503@headley>
 <AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
 <87wrp12p00.fsf@gmail.com>
 <AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
 <87fwvl2d4d.fsf@gmail.com>
 <87hbfxgg86.fsf_-_@gmail.com>
 <20101104174917.GA30628@sigill.intra.peff.net>
 <20101104180242.GA16431@burratino>
 <20101104181357.GA31016@sigill.intra.peff.net>
 <20101104183851.GA16865@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 19:55:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE4y0-0000VM-9w
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 19:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab0KDSzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 14:55:10 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:39509 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab0KDSzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 14:55:07 -0400
Received: (qmail 1571 invoked by uid 111); 4 Nov 2010 18:55:04 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 04 Nov 2010 18:55:04 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Nov 2010 14:55:45 -0400
Content-Disposition: inline
In-Reply-To: <20101104183851.GA16865@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160748>

On Thu, Nov 04, 2010 at 01:38:51PM -0500, Jonathan Nieder wrote:

> Makes sense.  There is just one particularity of
> 
> 	git diff --cached [<commit>]
> 
> I am worried about.  Namely: according to a recent patch,
> 
> 	git diff --cached
> 
> should not be considered as
> 
> 	git diff --cached HEAD
> 
> with the "HEAD" implicit, but a distinct operation meaning
> "show me what changes git commit would store".

Yeah, I'm not sure I agree with that change, for the reason that it
makes "git diff" more conceptually complex. Generally we think of "no
commit" as "behave as if HEAD was given". But now it's not, but only in
this one particular place.

I guess I should go complain in that thread, though...

> >> I would rather treat --cached as one of the options ("instead of
> >> comparing the worktree, compare its cached content in the index to the
> >> specified commit"),
> >
> > Except it is not quite that. For the first two that I listed above,
> > --cached makes that distinction. But --cached doesn't make sense at all
> > in the third or fourth ones. So I think in practice it ends up defining
> > a mode of operation more than simply an option.
> 
> Not sure I understand your logic.  Is your point that --cached in
> those cases does not print
> 
> 	fatal: --cached does not make sense in this operation mode
> 
> but
> 
> 	usage: git diff <options> <rev>{0,2} -- <path>*
> 
> that implies the operation mode is not known?

No, I am fine with what it actually prints[1]. But my point is that
"--cached" is not simply an option that should go in [options] in each
synopsis line. Even though it _looks_ like an option (because it starts
with --, and can go anywhere in the options list) it changes the syntax
of the rest of the command line (in particular, you can provide 0 or 1
commits, not 2, and you cannot use --no-index)[2].

Removing it from the synopsis and just listing it as an option does not
capture that aspect.

And yes, it's obviously a gray area. There are other mutually exclusive
options that are really just normal options. I just happen to think that
the action of "--cached" changes the operation significantly enough to
be considered a separate mode.  Just as we do with "-m" and "-d" for
git-branch.

-Peff

[1] If we are on a quest to remove <rev>{0,2}, this is one other spot to
    do it.

[2] This ties in with an idea mentioned in years past (but never
    actually implemented) to have some symbolic name for referring to
    the working tree and index, like:

       git diff HEAD INDEX

    which makes it quite obvious what is going on, and that diff really
    only has one syntactic mode: diff thing A and thing B. The details
    of that depend on what thing A and thing B actually resolve to. But
    in theory that is identical to "git diff --cached HEAD".
