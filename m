From: Junio C Hamano <junkio@cox.net>
Subject: Re: Quick merge status updates.
Date: Sun, 02 Jul 2006 15:50:50 -0700
Message-ID: <7vveqf1v05.fsf@assigned-by-dhcp.cox.net>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
	<1151471040.4940.17.camel@dv>
	<7v7j3164xd.fsf@assigned-by-dhcp.cox.net>
	<1151489103.28036.6.camel@dv> <20060702204906.GG29115@pasky.or.cz>
	<7v64if3d50.fsf@assigned-by-dhcp.cox.net>
	<20060702214931.GJ29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 00:51:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxAmG-0002Xa-6M
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 00:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWGBWuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 18:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWGBWuw
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 18:50:52 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:6787 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750867AbWGBWuv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 18:50:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702225051.WSTM6385.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 18:50:51 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060702214931.GJ29115@pasky.or.cz> (Petr Baudis's message of
	"Sun, 2 Jul 2006 23:49:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23132>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Sun, Jul 02, 2006 at 11:33:47PM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> I tried this:
>> 
>>  0. check out the branch that has the Perly git ("pu").  build
>>     and install normally to have a perfectly working version
>>     accessible on your usual $PATH.
>> 
>>  1. apply the patch [1] below to make it use "use lib" instead of
>>     "unshift".
>> 
>>  2. break perl/Git.pm being built to pretend we introduced a bug
>>     in the work in progress by applying the patch [2] below.
>> 
>>  3. without installing the broken Git.pm, run "make test", and
>>     see a test that uses "git pull" and needs to create a true
>>     merge succeed.  It tells me that everything including
>>     perl/Git.pm is GOOD, and I'd find the breakage only after
>>     installing and running the test again.
>
> So, just to clarify and make sure we understand each other perfectly,
> you claim that when skipping (1), (3) _does_ FAIL for you? Because it
> really doesn't for me and I can't see how could it ever fail without
> installing the broken version first.

Gaah.  You are right.

PERL5LIB does not seem to just do a push (and that was I thought
why unshift was a way to defeat it) but do something more evil.

With this:

diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index 1b23fa1..5d1ae44 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -6,9 +6,11 @@ # Read .git/FETCH_HEAD and make a human 
 # by grouping branches and tags together to form a single line.
 
 BEGIN { unshift @INC, '@@INSTLIBDIR@@'; }
+use lib '@@INSTLIBDIR@@';
 use strict;
 use Git;
 use Error qw(:try);
+print STDERR "\@INC is @INC\n";
 
 my $repo = Git->repository();
 
It spits this out: 

@INC is /home/junio/git-pu/lib/perl/5.8.8 /opt/git/git.git/t/../perl/blib/lib /opt/git/git.git/t/../perl/blib/arch/auto/Git /etc/perl /usr/local/lib/perl/5.8.8 /usr/local/share/perl/5.8.8 /usr/lib/perl5 /usr/share/perl5 /usr/lib/perl/5.8 /usr/share/perl/5.8 /usr/local/lib/site_perl .

So "BEGIN { unshift }" is JUST AS WRONG as "use lib".

I thought we killed this showstopper and was hoping now the
series is mergeable to "next" but apparently not yet X-<.

Sigh....
