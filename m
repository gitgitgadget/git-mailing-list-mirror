From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --with-tcltk and --without-tcltk to configure.
Date: Thu, 29 Mar 2007 01:00:35 -0700
Message-ID: <7vwt107a3g.fsf@assigned-by-dhcp.cox.net>
References: <7vmz20xuxq.fsf@assigned-by-dhcp.cox.net>
	<20070326100344.GV14837@codelabs.ru>
	<7vejnbtjdq.fsf@assigned-by-dhcp.cox.net>
	<20070327065940.GC51155@codelabs.ru>
	<20070327102437.GM14837@codelabs.ru>
	<7vtzw7nej6.fsf@assigned-by-dhcp.cox.net>
	<20070327110714.GA14837@codelabs.ru>
	<7vps6um8wv.fsf@assigned-by-dhcp.cox.net>
	<20070328091209.GQ14837@codelabs.ru>
	<7vps6tf8te.fsf@assigned-by-dhcp.cox.net>
	<20070329074424.GD59098@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Thu Mar 29 10:00:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWpYp-0000yc-8d
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 10:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbXC2IAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 04:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbXC2IAk
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 04:00:40 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37834 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbXC2IAj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 04:00:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329080037.PLVH792.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 04:00:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gY0b1W0091kojtg0000000; Thu, 29 Mar 2007 04:00:36 -0400
In-Reply-To: <20070329074424.GD59098@codelabs.ru> (Eygene Ryabinkin's message
	of "Thu, 29 Mar 2007 11:44:24 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43409>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> Wed, Mar 28, 2007 at 12:48:45PM -0700, Junio C Hamano wrote:
>> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
>> ...
>> > +gitk-wish: gitk GIT-GUI-VARS
>> > +	$(QUIET_GEN)rm -f $@ $@+ && \
>> > +	sed -e'1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' < gitk > $@+ && \
>> > +	chmod +x $@+ && \
>> > +	mv -f $@+ $@
>> ...
> Thanks! And for the sanity: I do not think that the single quote
> in the path it sane too. But as I was teached, "if we should
> quote something, we must quote it". ;))

Actually, look at the wish script you are running sed on.

	exec wish "$0" -- "$@"

If you substitute "wish" with "/i use stupid/$PATH/to/wish", I
think Tcl splits the path at SP and does not protect $var
reference, so the careful quoting in the Makefile is still not
good enough ;-).

But come to think of it, it lets shell handle $PATH to find wish
anyway, so *unless* we have specific version dependency to wish
that wish binary normally found on user's $PATH is inadequate,
we probably should not even need to be doing any of this path
munging.  You might end up discovering the path to wish binary
in your autoconf script, we do not have to use it.  ./configure
can just see if there is wish, and set NO_TCLTK appropriately
without any of the path business.

What do you think?

> By the way, when I was creating the git.spec from the git.spec.in,
> I had the 'Version' field equal to the '1.5.1-rc1.GIT' and RPM
> does not like the '-' characters inside the versions.

That is semi-intended, in that you are not even supposed to be
building with "1.5.1-rc1.GIT".  The version file in the tarball
that git.spec file lives in should use git-describe, built from
the source before the tarball was made, to get the version
number, and wouldn't be "$anything.GIT", which is the last-ditch
fallback string, which is set by GIT-VERSION-GEN for people who
build in a wrong way.
