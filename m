From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Enable parallelism in git submodule update.
Date: Sat, 28 Jul 2012 12:52:01 +0200
Message-ID: <20120728105159.GB13370@book.hvoigt.net>
References: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com> <7vwr1ozxz5.fsf@alter.siamese.dyndns.org> <CAHOQ7J_jYAe7r1q6Cg9OJb8f+79UfS=JfRk9NrS4R4a+oLM8LA@mail.gmail.com> <7vk3xoyeex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 12:52:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv4de-0006JB-HH
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 12:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab2G1KwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 06:52:10 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:33506 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab2G1KwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 06:52:09 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Sv4cs-0003xR-EQ; Sat, 28 Jul 2012 12:52:02 +0200
Content-Disposition: inline
In-Reply-To: <7vk3xoyeex.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202429>

Hi,

On Fri, Jul 27, 2012 at 04:25:58PM -0700, Junio C Hamano wrote:
> Stefan Zager <szager@google.com> writes:
> 
> > On Fri, Jul 27, 2012 at 2:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> Stefan Zager <szager@google.com> writes:
> >>
> >> > +             module_list "$@" | awk '{print $4}' | xargs -L 1 -P
> >> "$jobs" git submodule update $orig_args
> >>
> >> Capital-P option to xargs is not even in POSIX, no?
> >
> > I wasn't aware of that, but you appear to be correct.  Don't know if you
> > have a policy about that, but anecdotally, -P is supported on my linux,
> > mac, and win/msys systems.
> 
> About "policy", we use POSIX as a rough yardstick to warn us that we
> might be breaking people on minority platforms.  We do _not_ say "It
> is in POSIX, so it is safe to use it", but we say "It is not even in
> POSIX, so we need to think twice."  We do not usually say "Linux,
> Mac and Windows are the only things that matter, and they all
> support it."
> 
> Of course, any set of rules have exceptions ;-) There are a few
> things to which we say "Even though it is not in POSIX, everybody
> who matters supports it, and without taking advantage of it, what we
> want to achieve will become too cumbersome to express".

I was about to write that since this is limited to a given --jobs
options the majority platforms should be enough as a start and others
could add a parallelism mechanism later. Its only a matter of efficiency
and not features.

But if you look at my other post to this thread I described that we need
some UI output extension so the user can still make sense of it.
In short: The user should be able distinguish which job said what.

I was already thinking about how an output caching could be implemented in
core git. How about exposing it as a git command like this?

	git run [-j<number>] ...

It works like the xargs call above except that it caches each jobs
output to stderr and stdout until its done and then replays the output
to stderr/out in the correct order.

We could design the code so that it can be reused later on to do the
caching in parallel fetch/push/... .

What do you think? If we decide to go this route I would have a look
into whipping something up.

Cheers Heiko
