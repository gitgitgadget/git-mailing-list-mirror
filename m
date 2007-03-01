From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Thu, 01 Mar 2007 02:04:00 -0800
Message-ID: <7vr6s9th4f.fsf@assigned-by-dhcp.cox.net>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net>
	<200703010840.54377.andyparkins@gmail.com>
	<46a038f90703010113o256f19a2qb1c16f4c85e5bd1c@mail.gmail.com>
	<200703010941.20161.andyparkins@gmail.com>
	<7vk5y1uwhg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 11:05:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMiAC-0001FT-A7
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 11:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbXCAKEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 05:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbXCAKE1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 05:04:27 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:40041 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964810AbXCAKEB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 05:04:01 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301100401.PZMI748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 05:04:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VN401W00W1kojtg0000000; Thu, 01 Mar 2007 05:04:01 -0500
In-Reply-To: <7vk5y1uwhg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 01 Mar 2007 01:46:51 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41072>

Junio C Hamano <junkio@cox.net> writes:

> Andy Parkins <andyparkins@gmail.com> writes:
>
>> Erm, yes, I know that.  But who is going to set that switch?
>> This isn't real CVS where the repository records that
>> information.  At the moment git does not know whether any
>> given file is binary or text.
>
> What do you think I have been hacking around pathattr stuff
> today for ;-)? 

A bit more clarification.  Although I won't be hacking on it
anymore since it is almost my bedtime,...

I think the 4 patch series I sent out tonight was fun but
slightly misdesigned.  I should have made the classification of
paths and actions on them separate sections.  That is, instead
of saying:

	[pathattr "a/v"]
        	path = "*.mpg"
                path = "*.mp3"
                path = "*.jpg"
		conv_i = none
                conv_o = none
	[pathattr "text"]
        	path = "*" ; all the rest
                conv_i = crlf
                conv_o = crlf

we should make two kinds of configuration.  Classification of
paths is property of the project and does not depend on where
the user uses the paths from the project:

	[pathattr "a/v"]
        	path = "*.mpg"
                path = "*.mp3"
                path = "*.jpg"
	[pathattr "text"]
        	path = "*" ; all the rest

while how they are handled can be platform dependent.  On UNIX,
you might have this in $HOME/.gitconfig:

	[handler "a/v"]
        	pretty = "cmd xine %s" ; nb. there is no 'cmd' yet...
	[handler "text"]
		pretty = "pipe fmt -"

while on another system, you might have:

	[handler "a/v"]
        	pretty = "cmd mediaplayer %s"
	[handler "text"]
                conv_i = crlf
                conv_o = crlf

One thing to note is that [pathattr "kind"] may need to behave
like existing .gitignore in that they are read from directories,
but [handler "kind"] does not have to.

We probably need to expose pathattr_lookup(path) to scripts, and
cvsserver could use that interface to query.  The interface may
look like this:

	$ git pathattr --lookup porn.mpg
        a/v
        $ git config --get handler.a/v
	cmd xine %s

and kopts_from_path would look like:

	sub kopts_from_path {
        	my ($path) = shift;
                my $kind = `git pathattr $path`;
		my $conv_o = `git config --get "handler.$kind"`

                if ($conv_o eq 'crlf') {
			return '-kb';
		}
		return '';
	}

Hmm?
