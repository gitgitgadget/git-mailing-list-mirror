From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb:  Make git_get_refs_list do work of  git_get_references
Date: Sat, 16 Sep 2006 19:12:27 -0700
Message-ID: <7vejub8cms.fsf@assigned-by-dhcp.cox.net>
References: <200609170226.39330.jnareb@gmail.com>
	<7vodtf8eym.fsf@assigned-by-dhcp.cox.net>
	<864pv7tgmx.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 04:12:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOm92-0005cZ-5K
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 04:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWIQCM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 22:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWIQCM3
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 22:12:29 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36061 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964908AbWIQCM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 22:12:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917021227.EIRL6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Sat, 16 Sep 2006 22:12:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PECF1V00Q1kojtg0000000
	Sat, 16 Sep 2006 22:12:15 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <864pv7tgmx.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "16 Sep 2006 18:40:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27151>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>
> Junio> Jakub Narebski <jnareb@gmail.com> writes:
>>> Make git_get_refs_list do also work of git_get_references, to avoid
>>> calling git-peek-remote twice. It now returns either list of refs as
>>> before in scalar context, or references hash and list of refs in list
>>> context.
>
> Junio> I do not think we want to have too many functions that return
> Junio> different things depending on contexts.  Forcing callers to
> Junio> remember what the function does in which context is bad.
>
> That's even an inaccurate description, so an expert in Perl (I've
> known a few) would just scratch his head.
>
> You cannot ever ever return a list in a scalar context.  Ever.  Never ever.

That much I think I know.

The code I was complaining about tries to do something like
this:

	sub that_sub {
        	...
                return wantarray ? (\@bar, \%foo) : \@bar;
	}

and it is not done for optimization purposes (i.e. "if the
caller only wants one and we are returning \@bar then we do not
have to compute \%foo which is a big win" is not why it does
this wantarray business).

So the callers when interested in the sequence of things in 'bar'
typically say:

	my $the_list = that_sub(...);
        for (@$the_list) {
        	...
	}

while other callers say:

	my ($the_hash, $the_list) = that_sub(...);
	... use %$the_hash and @$the_list as see fit ...

And I was saying that getting rid of the "return wantwarray ? :"
business and write the first class of callers like this

	my ($the_list) = that_sub(...);
        for (@$the_list) {
        	...
	}

would be much less confusing.
