From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Complete rewrite of the configuration parser
Date: Sat, 12 May 2007 12:59:49 -0700
Message-ID: <7v4pmhyfre.fsf@assigned-by-dhcp.cox.net>
References: <7v8xbvj5mx.fsf@arte.twinsun.com>
	<11789982521112-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sat May 12 22:00:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmxl8-0000Ez-Jy
	for gcvg-git@gmane.org; Sat, 12 May 2007 22:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757734AbXELT7w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 15:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757884AbXELT7v
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 15:59:51 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:65191 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757865AbXELT7v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 15:59:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512195949.WQPD22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 15:59:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yKzp1W0021kojtg0000000; Sat, 12 May 2007 15:59:49 -0400
cc: Petr Baudis <pasky@suse.cz>
In-Reply-To: <11789982521112-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Sat, 12 May 2007 21:30:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47086>

Frank Lichtenheld <frank@lichtenheld.de> writes:

>  Maybe a bit overkill if one only wants to solve the problem Junio discovered
>  but I believe it's still worthwile.
>
>  Has a lot of overlap with perl/Git.pm though...
>
>  Not extensively tested but it at least passes the test cases and creates a useful
>  log which should take care of the two main code paths (get_gitcvs and
>  get_gitcvs_bool).

I agree that the general direction should be to do something
like this in perl/Git.pm (Pasky CC'ed).  As there are some
things that current Git.pm config interface does not offer an
easy access to what you would want to do, we need to enumerate
what you need, decide if they are of general interest and design
what to put in Git.pm and what to implement in GITCVS::config as
a special-purpose feature.

perl/Git.pm currently gives us only this: 

 - grab all values for a named variable, in an array;

 - return canonicalized value for a named boolean variable;

GITCVS::config wants to read *everything* from config and
returns a 'config' instance you can:

 - enumerate keys (you do not have this, but it is easy to add);

 - retrieve a value for a key (either one- or two-level);

 - retrieve a canonicalized bool value for a key (either one- or
   two-level);

 - treat a request for "gitcvs.method.option" variable to fall
   back on "gitcvs.option" if the former is not given;

 - the same for boolean variant.

I think the best abstraction is to have the "read everything"
interface in perl/Git.pm side, make the current Git::config()
and Git::config_bool() interface to use it (without issuing
extra 'git config --get-all').  I am not sure it is common for
Git.pm users to want the behaviour of "section.method.option"
falling back to "section.option", but if it is common enough, it
probably is a good idea to have:

	sub config_fallback {
        	my ($self, $section, $specific, $var) = @_;
                my $cfg = $self->config();

                if (exists $cfg{"$section.$specific.$var"}) {
                	return $cfg{"$section.$specific.$var"};
		}
                if (exists $cfg{"$section.$var"}) {
                	return $cfg{"$section.$var"};
		}
                return undef;
	}

on perl/Git.pm side.

But all of this is post 1.5.2 material; we would want to have a
minimal fixup on 'master' before 1.5.2, independent of this
rewrite.
