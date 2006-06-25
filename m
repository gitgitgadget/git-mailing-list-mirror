From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Git.pm build: Fix quoting and missing GIT-CFLAGS dependency
Date: Sat, 24 Jun 2006 20:03:24 -0700
Message-ID: <7vac82q6mb.fsf@assigned-by-dhcp.cox.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
	<7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	<7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241338370.6483@g5.osdl.org>
	<7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net>
	<20060625010202.GX21864@pasky.or.cz>
	<20060625014009.GA21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 05:03:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuKuX-0006La-RX
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 05:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWFYDD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 23:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWFYDD0
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 23:03:26 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:8183 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751356AbWFYDDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 23:03:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625030325.VYCX18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 23:03:25 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060625014009.GA21864@pasky.or.cz> (Petr Baudis's message of
	"Sun, 25 Jun 2006 03:40:09 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22579>

Petr Baudis <pasky@suse.cz> writes:

>   This one should do a better job; if we quote, let's do it proper. :-)
>
> +PERL_DEFINE = $(ALL_CFLAGS) -DGIT_VERSION='"$(GIT_VERSION)"'
> +PERL_DEFINE_SQ = $(subst ','\'',$(PERL_DEFINE))
> +PERL_LIBS = $(EXTLIBS)
> +PERL_LIBS_SQ = $(subst ','\'',$(PERL_LIBS))
> +perl/Makefile:	perl/Git.pm perl/Makefile.PL GIT-CFLAGS
>  	(cd perl && $(PERL_PATH) Makefile.PL \
> +		PREFIX='$(prefix_SQ)' \
> +		DEFINE='$(PERL_DEFINE_SQ)' \
> +		LIBS='$(PERL_LIBS)')

Yes let's ;-).  You obviously meant PERL_LIBS_SQ on the last line.

During our a handful piecemeal patch exchange back-and-forth on
the list, most of the patches did not apply mechanically, so I
rolled them up and have pushed out the result in "pu" and it
will mirror out shortly.  I am reasonably sure it is in much
better shape than 24 hours ago; could you double check the
result for me please?

And I earlier said...

    Pasky, can we first iron out kinks in the build procedure and
    installation before converting existing programs further?  The
    things I worry about currently are:

     - the SITELIBARCH gotcha I sent you a message about (and you
       responded to it already -- was that an Acked-by?);

     - RPM target -- we probably acquired a new build-dependency in
       which case the .spec file needs to be updated;

     - Make sure Git.xs builds and installed result works fine on
       all platforms we care about, including Cygwin and other
       non-Linux boxes.

    I'd even suggest we revert the changes to git-fmt-merge-msg to
    keep it working for now, until the above worries are resolved.
    Otherwise we cannot have it in "next" safely (and I REALLY _do_
    want to have Git.pm infrastructure in "next" soonish).

    We can start using Git.xs and friends in some _new_ ancillary
    programs, once we solve building and installing problems for
    everybody.  That way it would help us gain portability and
    confidence without disrupting existing users.

I think we have cleared SITELIBARCH, and Git.xs building is in
testable state for wider audience.  The remaining hurdles are to
make sure the RPM target is still sensible, and fix the test
scheme.

Now, I am clueless about RPM, so help is very much appreciated.

About the testsuite, I think with the way git-fmt-merge-msg (and
other Perl scripts that will use Git.pm) is munged on the
initial line "#!/usr/bin/perl -I$(installedpath)", the test
scheme is seriously broken.  To see how yourself, have a good
working version of Git.pm and friends in the path your
git-fmt-merge-msg's first line points at, apply the following
patch to perl/Git.pm in your source tree and run "make test".
It will pass t5700-clone-reference.sh test, which does "git
pull" (and uses git-fmt-merge-msg) without problems X-<.

diff --git a/perl/Git.pm b/perl/Git.pm
index 7bbb5be..c9121f4 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1,3 +1,5 @@
+syntax error
+
 =head1 NAME
 
 Git - Perl interface to the Git version control system

This is (as I said in a separate message earlier) because -I on
the first line (and the command line) seems to take precedence
over PERL5LIB we set up in the test harness, so the test does
not find the broken version you think you are testing.  And
after it tests out OK, you install it and suffer from the
breakage.  This is bad.

I am not sure what the right way to fix it, though.  Obviously,
we could do something like the following:

diff --git a/Makefile b/Makefile
index 3a67578..3350be3 100644
--- a/Makefile
+++ b/Makefile
@@ -517,9 +517,12 @@ common-cmds.h: Documentation/git-*.txt
 	chmod +x $@+
 	mv $@+ $@
 
-$(patsubst %.perl,%,$(SCRIPT_PERL)) : % : %.perl
+$(patsubst %.perl,%,$(SCRIPT_PERL)): perl/Makefile
+$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	rm -f $@ $@+
-	sed -e '1s|#!.*perl\(.*\)|#!$(PERL_PATH_SQ)\1 -I'"$$(make -s -C perl instlibdir)"'|' \
+	INSTLIBDIR=$$(make -s -C perl instlibdir) && \
+	sed -e '1s|#!.*perl\(.*\)|#!$(PERL_PATH_SQ)\1|' \
+	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.perl >$@+
 	chmod +x $@+
diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index f86231e..e8fad02 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -5,6 +5,7 @@ #
 # Read .git/FETCH_HEAD and make a human readable merge message
 # by grouping branches and tags together to form a single line.
 
+unshift @INC, '@@INSTLIBDIR@@';
 use strict;
 use Git;
 use Error qw(:try);

which is in line with what git-merge-recursive does, but it is
not really what usual Perl modules and scripts do.  It is
bending backwards to support testing which does not feel right.

The additional dependency to perl/Makefile is needed regardless
of this tentative fix -- you cannot run make -C perl before
building perl/Makefile.
