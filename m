From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 01/12] Introduce Git.pm (v4)
Date: Sat, 24 Jun 2006 04:57:31 -0700
Message-ID: <7vac82wytw.fsf@assigned-by-dhcp.cox.net>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
	<7vr71f5kzs.fsf@assigned-by-dhcp.cox.net>
	<7vu06bymtr.fsf@assigned-by-dhcp.cox.net>
	<20060624111657.GR21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 13:57:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu6lc-0006qn-0d
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 13:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWFXL5d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 07:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWFXL5d
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 07:57:33 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7617 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964786AbWFXL5c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 07:57:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624115732.SAQR1341.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 07:57:32 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060624111657.GR21864@pasky.or.cz> (Petr Baudis's message of
	"Sat, 24 Jun 2006 13:16:57 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22510>

Petr Baudis <pasky@suse.cz> writes:

> (This is also why I was a bit confused by your make test patch - it does
> not "fix" anything per se since no tests directly use Git.pm.)

You are right.

You do not want to be testing installed version, but the one
freshly built, so the patch does not have any effect, except for
one case: testing before installing Git.pm for the first time
anywhere yet.  -I prepends the directory to the search path, so
we are not testing the freshly built copy at all.

Is there a way from the environment to override this behaviour,
so that we can run the tests properly?  I think PERL5LIB and
PERLLIB are defeated by having -I there (that's why I said I
liked what Fredrik did with his Python script, which appends the
final installed location to the search path).  I think unshift
into @INC by hand (i.e. without even using use lib "$path")
would do what we want, but I feel that is a bit too ugly just 
for the testing X-<.

I suspect we would need to think this a bit more... sigh.

> ...because well, they do:
>
> $(patsubst %.perl,%,$(SCRIPT_PERL)) : % : %.perl
> 	rm -f $@ $@+
> 	sed -e '1s|#!.*perl\(.*\)|#!$(PERL_PATH_SQ)\1 -I'"$$(make -s -C perl instlibdir)"'|' \
> 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
> 	    $@.perl >$@+
> 	chmod +x $@+
> 	mv $@+ $@

I'll need to look at why it fails for me, but the above seems to
be doing the right thing, from a superficial look at least.

git-fmt-merge-msg substituted like the above begins with:

	#!/usr/bin/perl -w -I/home/junio/git-pu/share/perl/5.8.8

because my $(prefix) is /home/junio/git-pu/ when building from "pu"
branch.  Then it goes on to create ~/git-pu/{lib,share}/perl/5.8.8
and does this:

make -C perl install
make[1]: Entering directory `/opt/git/git.git/perl'
Installing /home/junio/git-pu/lib/perl/5.8.8/auto/Git/Git.so
Installing /home/junio/git-pu/lib/perl/5.8.8/auto/Git/Git.bs
Files found in blib/arch: installing files in blib/lib into architecture dependent library tree
Installing /home/junio/git-pu/lib/perl/5.8.8/Git.pm
Installing /home/junio/git-pu/lib/perl/5.8.8/Error.pm
Installing /home/junio/git-pu/man/man3/Error.3pm
Installing /home/junio/git-pu/man/man3/Git.3pm
Writing /home/junio/git-pu/lib/perl/5.8.8/auto/Git/.packlist
Appending installation info to /home/junio/git-pu/lib/perl/5.8.8/perllocal.pod

It appears that this is needed perhaps?

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 54e8b20..92c140d 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -3,7 +3,7 @@ use ExtUtils::MakeMaker;
 sub MY::postamble {
 	return <<'MAKE_FRAG';
 instlibdir:
-	@echo $(INSTALLSITELIB)
+	@echo $(INSTALLSITEARCH)
 
 MAKE_FRAG
 }
