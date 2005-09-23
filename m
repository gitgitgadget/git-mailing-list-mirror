From: Junio C Hamano <junkio@cox.net>
Subject: Re: /bin/sh portability question
Date: Fri, 23 Sep 2005 01:24:13 -0700
Message-ID: <7vzmq4faz6.fsf@assigned-by-dhcp.cox.net>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 10:24:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIiqx-000714-DQ
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 10:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVIWIYQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 04:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVIWIYQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 04:24:16 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:236 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750803AbVIWIYP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 04:24:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050923082414.TMVS26651.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 04:24:14 -0400
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-Reply-To: <20050923075058.GA25473@bohr.gbar.dtu.dk> (Peter Eriksen's
	message of "Fri, 23 Sep 2005 09:50:58 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9161>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> 1) Maybe I didn't notice some new configuration option,
>    but strcasestr is still not found with a simple "gmake".

Perhaps "gmake NO_STRCASESTR=YesPlease"?

Do people use glibc or other alternative C libraries on Solaris
these days?  If nobody does, and everybody on SunOS lack
strcasestr, we could make SunOS imply NO_STRCASESTR in the
Makefile.

> 2) In many of the shell scripts there is the idiom:

>    I think it's because (on my Solaris at least), sh is really 
>    sh and is not symlinked to bash, and sh doesn't like that 
>    syntax.

Writing $(command) instead of `command` is not a bashism; Korn
supports it and even ash seems to.  But saying that would not
reduce the pain from non-sysadmins.

In many places we could just rewrite them to old-timer back-tick
form, unless we nest, in which case you would end up doing
something like this for readability:

	foo=$(command $(command to compute arg to it))

	arg=`command to compute arg to it`
        foo=`command "$arg"`

I haven't assessed the extent of damage if we tried to use ``
for portability lately (I did once, and it did not look too bad
back then).  If somebody comes up with a readable patch, I might
be persuaded to take it [*1*].

Another thing that will bite you is the use of shell arrays -- I
was trying to stay away from it but at least git-grep uses it
now (and hopefully nobody else).  It may not be a bad idea to
rewrite that one script in Perl or Python.


[Footnotes]

*1* Personally I feel that the only bug in Bourne was that it
did not spell command substitution as $().
