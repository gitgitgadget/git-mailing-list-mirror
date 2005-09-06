From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Tue, 06 Sep 2005 16:54:01 -0700
Message-ID: <7v1x41g3c6.fsf@assigned-by-dhcp.cox.net>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
	<46a038f90509051713389c62c8@mail.gmail.com>
	<Pine.LNX.4.58.0509060013520.4316@evo.osdl.org>
	<7vll2atz8a.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509060057491.4316@evo.osdl.org>
	<7vwtlusi9t.fsf@assigned-by-dhcp.cox.net>
	<u5tek82bmlb.fsf@fidgit.hq.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 01:55:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECnGR-0005R7-Cr
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 01:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVIFXyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 19:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVIFXyE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 19:54:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:39347 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751118AbVIFXyD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 19:54:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050906235402.FJXH20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Sep 2005 19:54:02 -0400
To: <davidk@lysator.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8158>

> By the way, I'm not sure how the 'git' script is supposed to be used.
> I know that if there is a git-foo-script file in your path, you can
> run it as 'git foo'.  But what about e.g. git-init-db?  You can run
> that as 'git init-db' today.  And 'git read-cache' should work too.
> And 'git ls-files', and 'git rev-parse', and 'git merge-one-file' and
> 'git sh-setup-script' in decreasing order of usefulness...
>
> But running 'git' without arguments only list the -script commands as
> available.

You are correct.  I think 'git' showing only *-script was done
as an attempt to give a list of Porcelainish commands, excluding
the core commands that people are not supposed to be typing from
the command line.  It so happened that all of the Porcelainish
commands were scripts.

But what Linus wants *-script to mean is editability in the
source tree (his "grep" and "em" examples).  The command being
Porcelainish and the command being implemented as a script tend
to have strong correlations, but in principle they are
orthogonal.  As you mention, 'git merge-one-file' is not really
useful standalone, neither is 'git sh-setup'.  On the other
hand, 'git fsck-cache' is.

My proposal to have git-archimport.perl in the source tree and
install it as $(bindir)/git-archimport solves the editability
issues (sorry, Linus, you will have to say "em *.sh *.perl"
instead of "em *-script" if we did this) and simplifies the
first half of the 'git' wrapper (it just needs to attempt
running "git-$1"), but does not help what the latter half of
'git' wrapper does (to give you the list of Porcelainish
commands).

To make 'git' wrapper produce useful 'list of subcommands', we
need to come up with a list of Porcelainish commands, be they
written in C or sh or Perl, and tell 'git' about that list.
Current implementation cheats by assuming everything that ends
with *-script are such, but it does not have to stay that way.

I'd nominate all $(SCRIPTS) in Makefile and tools/Makefile
except *1*, plus *2* as the list of subcommands 'git' wrapper
would show.

List *1*: implemented as script but not Porcelainish.
	git
        git-merge-one-file-script
        git-sh-setup-script

List *2*: implemented in C but Porcelainish.
	git-init-db
        git-fsck-cache
        git-get-tar-commit-id
        git-apply
        git-patch-id
        git-pack-objects
        git-show-branch
