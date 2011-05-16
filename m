From: Jeff King <peff@peff.net>
Subject: Re: RFC proposal: set git defaults options from config
Date: Mon, 16 May 2011 07:02:56 -0400
Message-ID: <20110516110256.GB23889@sigill.intra.peff.net>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com>
 <4DCB88C1.20105@drmicha.warpmail.net>
 <20110512080425.GA11870@sigill.intra.peff.net>
 <4DCB96F9.2020700@drmicha.warpmail.net>
 <20110512082210.GA16813@sigill.intra.peff.net>
 <4DCBF01F.9040009@warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	David Pisoni <dpisoni@gmail.com>,
	GIt Mailing List <git@vger.kernel.org>,
	Git Maintainer <gitster@pobox.com>
To: Michael J Gruber <drmicha@warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 16 13:03:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLvZp-0006nw-DM
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 13:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab1EPLDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 07:03:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33344
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754400Ab1EPLDA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 07:03:00 -0400
Received: (qmail 13350 invoked by uid 107); 16 May 2011 11:05:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 07:05:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 07:02:56 -0400
Content-Disposition: inline
In-Reply-To: <4DCBF01F.9040009@warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173726>

On Thu, May 12, 2011 at 04:35:11PM +0200, Michael J Gruber wrote:

> Mechanism
> =========
> 
> I propose the following mechanism for setting default command line
> options from the config:
> 
> options.<cmd> = <value>
> 
> is a "multivar" in git-config speak, i.e. it can appear multiple times.
> When running "git <cmd> <opts>", our wrapper executes
> 
> git <cmd> <values> <opt>
> 
> where <values> is determined by the following rule in pseudocode:
> 
> if $GIT_OPTIONS_<cmd> is unset:
>   <values> := empty
> else:
>   for <value> in $(git config --get-all options.cmd):
>     if <value> matches the regexp in $GIT_OPTIONS_<CMD>:
>       append <value> to <values>

As a user, how would I active this for all commands when not running a
script? I see why you defensively say "if unset, don't enable this
feature at all".  As a user, should I have to set GIT_OPTIONS_CMD for
everything that I want to configure? I hope not.

I think we need one extra variable to say generally "I am in strict
plumbing mode" or "I am in user mode". So you would want something like:

  if $GIT_STRICT is unset:
    <values> := $(git config --get-all options.cmd)
  else if $GIT_OPTIONS_<cmd> is unset:
    <values> := empty
  else:
    [match values by regex as you do]

But then you have a question of when GIT_STRICT gets set. An obvious
place is to set it in the git wrapper, so that "git foo" will have its
subcommands properly strict.

But that doesn't help scripts which are not called from the git wrapper;
they need to set GIT_STRICT themselves, so we need a phase-in period for
them to do so.

> NOTES
> =====
> 
> * This can be done by commit_pager_choice() or by a call right after
> that in those places.

Ah, so reading this, I have a sense that you were intending to make the
equivalent of GIT_STRICT be "am I running a pager" (or "am I outputting
to a terminal)?

Which is somewhat safer, as it is purely something for programs to opt
into. And as a heuristic, it's mostly good. I can come up with examples
where a script might not want to allow some options to be passed, even
though output is to the user, but they are probably stretching (e.g.,
something like "--allow-textconv" in a script that is meant to restrict
the users rights).

> * regexp notation/version to be decided

I think I would just as soon have a list of allowed options. We're
hopefully not doing the regex over the value of the option, like
"--pretty=foo is OK, but --pretty=bar is not". It seems like this
unnecessarily complicate the common case (you don't care what the value
is, but you have to tack on (|=.*) to every option matcher), and the
added flexibility is probably not going to be useful.

So I expect options regex are just going to look like:

  --(foo|bar|baz|bleep)

at which point we might as well just make it a list. And for the sake of
sanity, we may want to provide some default lists for scripts to OK,
like some minimal set of rev limiting options or something, so that
scripts don't end up specifying the same sets over and over.

> * We should probably do this for long options only (and insert
> "--<value>" rather than "<value>" to spare the "--" in config).

Yeah. Anything that doesn't have a long option and is useful enough to
be used in this way should probably get one.

> Taking cover...

I dunno. It's not so bad. But I think we probably want to start with an
environment variable to say "I am a script, be strict", let scripts
start picking that up, and then phase in the ability to turn on options
selectively.

-Peff
