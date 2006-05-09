From: Junio C Hamano <junkio@cox.net>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 09 May 2006 11:03:49 -0700
Message-ID: <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	<7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	<7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
	<Pine.LNX.4.64.0605081905240.6713@iabervon.org>
	<BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
	<7virogc90u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
	<7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
	<BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
	<BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
	<e3p5om$djs$1@sea.gmane.org>
	<Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 20:04:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdWYw-0005yS-Ky
	for gcvg-git@gmane.org; Tue, 09 May 2006 20:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWEISDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 14:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWEISDw
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 14:03:52 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:65496 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750833AbWEISDw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 14:03:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509180351.BOKM27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 May 2006 14:03:51 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19841>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, to summarize what people proposed (and that I remember):
>
> 1) [branch."AnY+String"]
>
> 2) multiple [branch]
>
> 3) magic <space>+<quoted>
>
> 4) [branch.just/allow-slashes/and-dashes]
>
> 5) the " for " notation

Thanks for a nice summary.

> Now, for the ease of use:
>
> (1), (3) and (4) are in the same league of easiness (except maybe that you 
> have to keep in mind to extra-quote in shell scripts with (1) and (3)), 
> (2) is especially good for people with a database mindset, and (5) is 
> annoying as hell.

One thing you might want to consider is variable types and
default values (eh, that makes two).

When Linus first introduced the config mechanism, he made it so
that a loosely coupled set of programs can take the "Why should
I care about other programs configuration" attitude, and
actively encouraged to do so by allowing custom config parsers
inherit from the default parser, like the way git_diff_config()
falls back on git_default_config() when it does not recognize
the variable.

It is quite a good design for most uses, except that it made it
inconvenient to implement things like "git-repo-config -l" and
"git-var -l".  The point of this design _is_ that they cannot
know what the set of possible variables, their types and the
default values when missing are, so by design the script that
used "git-var -l | grep" to read the configuration needed to
know that a boolean can be denoted by existence, value set to
zero or non-zero integer, or string "true"/"false" (i.e.
"filemode", "filemode=1", and "filemode = true" mean the same
thing; BTW I think we would probably want to add "yes"/"no"
here).

Later it was made easier to use by Pasky with "repo-config --type"
option.  The caller supplies the name of the variable and the
type and repo-config gets the value -- the caller knows what it
wants to use, so having it to know what type of things it is
interested in is not so bad, so the type problem was practically
solved.  But it still feels somewhat hacky.

With (2) and (5), we have a bound set of "se.ct.ion.variable";
we could enumerate the variables we care about, define what they
mean and what their types and default values are (we need to do
that for Documentation/config.txt anyway).  With many parts of
the standalone git plumbing programs migrating into builtins, I
think it is not a bad idea to have a central table of all the
configuration variables that the core knows about.  Porcelains
and scripts could define customized tables that describe the
sections/variables they also want to see and act on in the
configuration file, and call git-repo-config with that table as
an optional parameter.

> Now, for the ease of implementation:
>
> (1) and (3) are in the same league, they have to change the way the config 
> is parsed as well as make downcasing conditional in repo-config. (2) is 
> obviously hardest of all. (4) is very easy (one line in config.c), and (5) 
> easiest (nothing to do).
>
> Now, for the versatility, i.e. what you can express with the syntax:
>...
> Obviously, I deem (4) the best solution ATM, because it has all the 
> expressability needed, while being the simplest.

If we are shooting for "let's not do this again", I do not think
(4) without some quoting convention is good enough.  Today, we
are talking about branch names so we could give them artificial
limits, which could be weaker than what we already have on the
branch names, but we would later regret that, when we start
wanting to have other names in the configuration (e.g. people's
names).
