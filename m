From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Thu, 15 Feb 2007 02:36:00 -0800
Message-ID: <7vodnvemi7.fsf@assigned-by-dhcp.cox.net>
References: <200702140909.28369.andyparkins@gmail.com>
	<slrnet5p5h.s9h.siprbaum@xp.machine.xx>
	<Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfy98o78i.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wkshtxg.fsf@assigned-by-dhcp.cox.net>
	<7v4ppnhkps.fsf@assigned-by-dhcp.cox.net>
	<20070215095903.GA6292@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, hanwen@xs4all.nl,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 11:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHdyL-0001IX-FP
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 11:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965812AbXBOKgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 05:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965814AbXBOKgG
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 05:36:06 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63981 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965812AbXBOKgE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 05:36:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070215103603.YMKF21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Feb 2007 05:36:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Pmc01W00X1kojtg0000000; Thu, 15 Feb 2007 05:36:02 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39811>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
> ...
>> I am still not sure what good GIT_CONFIG would be to completely
>> override everything else, though.
>
> I just started using GIT_CONFIG in the experimental version of
> git-svn[1] which allows me to use .git/svn/config for tracking some
> metadata bits.
>
> I didn't want to pollute the users' .git/config with automatically read
> and state data in .git/config; so I started using .git/svn/config to
> avoid littering .git/svn/ with any tiny pieces of data I might need.

Ah, so the intended usage is to use git-config to store in and
retrieve from a file that does not have anything to do with the
core git data, and the using script would say:

	value=$(GIT_CONFIG=$that_extra_file git-config --get some.variable)
        ... do whatever with $value which does not have
        ... anything to do with git core itself
        gitvalue=$(git-config --get some.git.variable)
	... use gitvalue which has some relevance to git core
	GIT_CONFIG=$that_extra_file git-config some.variable $newvalue

I was more worried about the fact that the current GIT_CONFIG
totally *ignores* the variables in .git/config.  With a
narrower-than-usual umask, not reading core.sharedrepository
would result in quite an undesired result.  But as long as the
intended usage follows the patter like above, in other words,
the user (a script) will never export GIT_CONFIG when using core
git plumbing or porcelain, I think it is Ok.
