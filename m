From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Fri, 29 Sep 2006 00:34:51 -0700
Message-ID: <7vhcyrnn1g.fsf@assigned-by-dhcp.cox.net>
References: <7vodt0zbhc.fsf@assigned-by-dhcp.cox.net>
	<20060928093623.GJ20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 09:35:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTCtd-00057G-N0
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 09:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161475AbWI2Hey (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 03:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161476AbWI2Hey
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 03:34:54 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30370 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1161475AbWI2Hew (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 03:34:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929073452.FMMH6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Sep 2006 03:34:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U7an1V00o1kojtg0000000
	Fri, 29 Sep 2006 03:34:48 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060928093623.GJ20017@pasky.or.cz> (Petr Baudis's message of
	"Thu, 28 Sep 2006 11:36:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28100>

Petr Baudis <pasky@suse.cz> writes:

> FWIW, I'd say kill it all (perhaps except BASIC_*, I don't know about
> that one) - we indeed can easily resurrect this, and that was the
> presumption with which I've killed the rest of Git.xs. There's no point
> in keeping legacy cruft around when we can take it back from the
> history.

I came up with this to apply on top of "next".  Extra sets of
eyeballs very much appreciated.

-- >8 --
Remove -fPIC which was only needed for Git.xs

The distinction between BASIC_ vs ALL_ is still kept, since it
is not Git.xs specific -- we could face the same issue when we
do other language bindings (e.g. Python). 

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 INSTALL       |   13 -------------
 Makefile      |   13 -------------
 config.mak.in |    1 -
 configure.ac  |    7 -------
 4 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/INSTALL b/INSTALL
index 0d432d7..fa9bf74 100644
--- a/INSTALL
+++ b/INSTALL
@@ -38,19 +38,6 @@ Issues of note:
    has been actively developed since 1997, and people have moved over to
    graphical file managers.
 
- - You can use git after building but without installing if you
-   wanted to.  Various git commands need to find other git
-   commands and scripts to do their work, so you would need to
-   arrange a few environment variables to tell them that their
-   friends will be found in your built source area instead of at
-   their standard installation area.  Something like this works
-   for me:
-
-	GIT_EXEC_PATH=`pwd`
-	PATH=`pwd`:$PATH
-	GITPERLLIB=`pwd`/perl/blib/lib:`pwd`/perl/blib/arch/auto/Git
-	export GIT_EXEC_PATH PATH GITPERLLIB
-
  - Git is reasonably self-sufficient, but does depend on a few external
    programs and libraries:
 
diff --git a/Makefile b/Makefile
index 8a7f29b..1875965 100644
--- a/Makefile
+++ b/Makefile
@@ -60,9 +60,6 @@ # a bundled SHA1 routine coming from Moz
 # on non-x86 architectures (e.g. PowerPC), while the OpenSSL version (default
 # choice) has very fast version optimized for i586.
 #
-# Define USE_PIC if you need the main git objects to be built with -fPIC
-# in order to build and link perl/Git.so.  x86-64 seems to need this.
-#
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
@@ -112,7 +109,6 @@ uname_P := $(shell sh -c 'uname -p 2>/de
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
-PIC_FLAG = -fPIC
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -402,12 +398,6 @@ endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 endif
-ifeq ($(uname_M),sun4u)
-	USE_PIC = YesPlease
-endif
-ifeq ($(uname_M),x86_64)
-	USE_PIC = YesPlease
-endif
 
 -include config.mak.autogen
 -include config.mak
@@ -546,9 +536,6 @@ else
 endif
 endif
 endif
-ifdef USE_PIC
-	ALL_CFLAGS += $(PIC_FLAG)
-endif
 ifdef NO_ACCURATE_DIFF
 	BASIC_CFLAGS += -DNO_ACCURATE_DIFF
 endif
diff --git a/config.mak.in b/config.mak.in
index addda4f..fecae80 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -3,7 +3,6 @@ # @configure_input@
 
 CC = @CC@
 CFLAGS = @CFLAGS@
-PIC_FLAG = @PIC_FLAG@
 AR = @AR@
 TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
diff --git a/configure.ac b/configure.ac
index 0f93f6f..8192826 100644
--- a/configure.ac
+++ b/configure.ac
@@ -96,13 +96,6 @@ ## Checks for programs.
 AC_MSG_NOTICE([CHECKS for programs])
 #
 AC_PROG_CC([cc gcc])
-if test -n "$GCC"; then
-	PIC_FLAG="-fPIC"
-else
-	AC_CHECK_DECL(__SUNPRO_C, [CFLAGS="$CFLAGS -xO3"; PIC_FLAG="-KPIC"])
-fi
-AC_SUBST(PIC_FLAG)
-
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOL(AR, ar, :)
 AC_CHECK_PROGS(TAR, [gtar tar])
