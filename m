From: Junio C Hamano <junkio@cox.net>
Subject: Re: Quick merge status updates.
Date: Sun, 02 Jul 2006 14:33:47 -0700
Message-ID: <7v64if3d50.fsf@assigned-by-dhcp.cox.net>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
	<1151471040.4940.17.camel@dv>
	<7v7j3164xd.fsf@assigned-by-dhcp.cox.net>
	<1151489103.28036.6.camel@dv> <20060702204906.GG29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 23:33:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx9Zi-0001CK-DL
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 23:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWGBVdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 17:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWGBVdv
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 17:33:51 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59366 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750920AbWGBVdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 17:33:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702213348.MTKW11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 17:33:48 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060702204906.GG29115@pasky.or.cz> (Petr Baudis's message of
	"Sun, 2 Jul 2006 22:49:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23122>

Petr Baudis <pasky@suse.cz> writes:

> So the purpose of the original patch was to make it play nicely with
> $PERLLIB, but unshifting helps nothing, since:
>
> 	There's default @INC
> 	Perl spots PERLLIB and unshifts @INC
> 	We then unshift @INC too, taking precedence

I tried this:

 0. check out the branch that has the Perly git ("pu").  build
    and install normally to have a perfectly working version
    accessible on your usual $PATH.

 1. apply the patch [1] below to make it use "use lib" instead of
    "unshift".

 2. break perl/Git.pm being built to pretend we introduced a bug
    in the work in progress by applying the patch [2] below.

 3. without installing the broken Git.pm, run "make test", and
    see a test that uses "git pull" and needs to create a true
    merge succeed.  It tells me that everything including
    perl/Git.pm is GOOD, and I'd find the breakage only after
    installing and running the test again.

If you make the freshly built script to say "use lib" to use
Git.pm and its friends from the installed location, it defeats
the attempt by test-lib.sh to override it to test what we
freshly built -- the use of "unshift @INC" is to work that
around and is parallel to the way Python stuff works around the
same problem.

[Footnotes]
*1* "use lib" patch.

diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index 1b23fa1..3a42950 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -5,7 +5,7 @@ #
 # Read .git/FETCH_HEAD and make a human readable merge message
 # by grouping branches and tags together to form a single line.
 
-BEGIN { unshift @INC, '@@INSTLIBDIR@@'; }
+use lib '@@INSTLIBDIR@@';
 use strict;
 use Git;
 use Error qw(:try);

*2* "break Git.pm" patch.

diff --git a/perl/Git.pm b/perl/Git.pm
index b4ee88b..34b4f12 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -6,6 +6,7 @@ Git - Perl interface to the Git version 
 
 
 package Git;
+syntax error -- kill me
 
 use strict;
 
