From: Petr Baudis <pasky@suse.cz>
Subject: Re: Quick merge status updates.
Date: Sun, 2 Jul 2006 22:49:06 +0200
Message-ID: <20060702204906.GG29115@pasky.or.cz>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net> <1151471040.4940.17.camel@dv> <7v7j3164xd.fsf@assigned-by-dhcp.cox.net> <1151489103.28036.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 22:49:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx8sT-0004Xf-Er
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 22:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWGBUtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 16:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWGBUtJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 16:49:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35725 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750783AbWGBUtI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 16:49:08 -0400
Received: (qmail 3452 invoked by uid 2001); 2 Jul 2006 22:49:06 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1151489103.28036.6.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23116>

Dear diary, on Wed, Jun 28, 2006 at 12:05:03PM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> said that...
> I think the BEGIN block has priority over other statements.  My solution
> was to put the @INC change in the BEGIN block as well.
> 
> This patch is working for me:
> 
> diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
> index e8fad02..1b23fa1 100755
> --- a/git-fmt-merge-msg.perl
> +++ b/git-fmt-merge-msg.perl
> @@ -5,7 +5,7 @@ #
>  # Read .git/FETCH_HEAD and make a human readable merge message
>  # by grouping branches and tags together to form a single line.
>  
> -unshift @INC, '@@INSTLIBDIR@@';
> +BEGIN { unshift @INC, '@@INSTLIBDIR@@'; }
>  use strict;
>  use Git;
>  use Error qw(:try);

I feel that it is time for another stupid question of mine - why can't
you just use lib?

	use lib ('@@INSTLIBDIR@@');

Looks a lot better than some @INC unshifting, and it should be
equivalent.

Let's pour in to the confusion:

The unshifting was introduced w/o BEGIN{} in

	From: Junio C Hamano <junkio@cox.net>
	Subject: Re: [PATCH 01/12] Introduce Git.pm (v4)
	Date:   Sat, 24 Jun 2006 04:57:31 -0700

but that patch is not in pu anymore while the description of the new
patch implicitly refers to it, which made it all a bit confusing.

So the purpose of the original patch was to make it play nicely with
$PERLLIB, but unshifting helps nothing, since:

	There's default @INC
	Perl spots PERLLIB and unshifts @INC
	We then unshift @INC too, taking precedence

So didn't the original patch rather want to do push?

	$ PERL5LIB=perl perl -le "BEGIN { unshift @INC, '/home/xpasky/lib/perl5/site_perl/5.8.8/i686-linux'; } use Git; print Git::hash_object('blob','Makefile');"
	17842a3657ae8e5b4fd3ddfeb69268a4b94cb97a
	$ PERL5LIB=perl perl -le "use Git; print Git::hash_object('blob','Makefile');"
	syntax error at perl/Git.pm line 44, near "h>"

(after inserting random junk to perl/Git.pm)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
