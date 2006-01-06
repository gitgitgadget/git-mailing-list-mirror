From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-mv.perl: use stderr for error output and cleanup
Date: Fri, 06 Jan 2006 14:38:25 -0800
Message-ID: <7vek3lq8wu.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601050349s6bec1a36jc410fd315fbbc4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 23:38:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0EX-0007m3-Hg
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWAFWia (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWAFWi3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:38:29 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48519 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932640AbWAFWi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:38:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060106223618.IYWU17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 17:36:18 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14222>

Alex Riesen <raa.lkml@gmail.com> writes:

> It is cleaned up in the "Perl' meaning" of process: trivial loops
> replaced with map{}

I agree with dies and warns, but I am slightly negative about
this one.

> -	foreach my $fileName (@deletedfiles) {
> -		print H "$fileName\0";
> -	}
> +	print H map {"$_\0"} @deletedfiles;

Although there is always one more way to do the same thing in
Perl, and there are good idioms that make well written Perl
programs very compact and clear, I tend to value readability for
(competent) programmers whose native language happens to be
something other than Perl.

I think using map{} to build a list to be printed without
inter-element spaces is far less intuitive than how the code was
originally written for non Perl readers.  Using join("\0", @df)
might be easier to read but you would then need terminating NUL,
and either one of the following are worse:

  do { local ($") = "\0"; print "@deletedfiles\0" } # this one is buggy
  do { local ($\) = "\0"; print for (@deletedfiles); } # impossible to read

So I'd prefer not touching for (@df) { print H "$_\n" } loops.
