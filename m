From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Documentation: git-daemon inetd configuration fix
Date: Fri, 16 Mar 2007 01:43:02 -0700
Message-ID: <7vabydwpd5.fsf@assigned-by-dhcp.cox.net>
References: <11740316693552-git-send-email-matthias@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Kestenholz <matthias@spinlock.ch>
X-From: git-owner@vger.kernel.org Fri Mar 16 09:43:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS81l-0002CM-Vn
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 09:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbXCPInG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 04:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbXCPInG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 04:43:06 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47434 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbXCPInE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 04:43:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070316084302.WBCQ748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Mar 2007 04:43:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bLj21W00J1kojtg0000000; Fri, 16 Mar 2007 04:43:02 -0400
In-Reply-To: <11740316693552-git-send-email-matthias@spinlock.ch> (Matthias
	Kestenholz's message of "Fri, 16 Mar 2007 08:54:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42335>

Matthias Kestenholz <matthias@spinlock.ch> writes:

>  On my debian server, this change was needed to get git-daemon running.
>  I am no inetd expert, so I don't know where the error was.
>
>  Perhaps this patch might help someone else.
>
>
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index 9ddab71..499c1f3 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -177,7 +177,7 @@ git-daemon as inetd server::
>  +
>  ------------------------------------------------
>  	git stream tcp nowait nobody  /usr/bin/git-daemon
> -		git-daemon --inetd --verbose --export-all
> +		/usr/bin/git-daemon --inetd --verbose --export-all
>  		/pub/foo /pub/bar
>  ------------------------------------------------

That sounds _very_ wrong.  What you changed is argv[0] (i.e. the
beginning of "service program arguments" field) and it should
not matter what you have there for inetd to launch git-daemon.
Presumably your inetd runs with /usr/bin in your path so even
the "service program" field (the one after 'nobody') should not
need the full path (but it is a good idea to be explicit in that
field as a principle), but needing the full path in argv[0]?

On _my_ debian box, I do not need a full path there, so it is
not even Debian in general but problem is on your particular
box.  Can you dig a bit more to see what you are doing any
differently?

For example, do you really mean the "service program arguments"
field that matters?

One plausible mistake scenario you _could_ have made is
something like this.  You compile git yourself and install it in
/home/matt/bin/git-daemon, and you needed to spell that path out
in "service program" field, but you found it out by trial and
error, and during that experiment you did not change "service
program" field (which actually matters) but "service program
arguments" field first.  And the working configuration you
happened to end up with was like this:

	git stream tcp nowait nobody /home/matt/bin/git-daemon \
        	/home/matt/bin/git-daemon --inetd ...

and then you tried to generalize it like this:

	git stream tcp nowait nobody /usr/bin/git-daemon \
        	/usr/bin/git-daemon --inetd ...

For one thing, I just tried to make sure argv[0] does not matter
at all by having this entry in my inetd.conf:

	git stream tcp nowait nobody /git/bin/git-daemon \
        	foobla --inetd ...

/git/bin is where I installed my git.  If I replace foobla with
anything else, it responds just fine.
