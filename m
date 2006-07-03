From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Use $GITPERLLIB instead of $RUNNING_GIT_TESTS and centralize @INC munging
Date: Mon, 03 Jul 2006 23:16:32 +0200
Message-ID: <20060703211632.1662.46767.stgit@machine.or.cz>
References: <20060703202925.GN29115@pasky.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 03 23:16:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxVma-0004hQ-7w
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 23:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWGCVQf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 17:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWGCVQe
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 17:16:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62126 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932120AbWGCVQe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 17:16:34 -0400
Received: (qmail 1673 invoked from network); 3 Jul 2006 23:16:32 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 3 Jul 2006 23:16:32 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060703202925.GN29115@pasky.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23213>

This makes the Git perl scripts check $GITPERLLIB instead of
$RUNNING_GIT_TESTS, which makes more sense if you are setting up your shell
environment to use a non-installed Git instance.

It also weeds out the @INC munging from the individual scripts and makes
Makefile add it during the .perl files processing, so that we can change
just a single place when we modify this shared logic. It looks ugly in the
scripts, too. ;-)

And instead of doing arcane things with the @INC array, we just do 'use lib'
instead, which is essentialy the same thing anyway.

I first want to do three separate patches but it turned out that it's quite
a lot neater when bundled together, so I hope it's ok.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 INSTALL                |    4 ++--
 Makefile               |    4 +++-
 git-fmt-merge-msg.perl |    5 -----
 git-mv.perl            |    5 -----
 t/test-lib.sh          |    5 ++---
 5 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/INSTALL b/INSTALL
index ed502de..4e8f883 100644
--- a/INSTALL
+++ b/INSTALL
@@ -39,8 +39,8 @@ Issues of note:
 
 	GIT_EXEC_PATH=`pwd`
 	PATH=`pwd`:$PATH
-	PERL5LIB=`pwd`/perl/blib/lib:`pwd`/perl/blib/arch/auto/Git
-	export GIT_EXEC_PATH PATH PERL5LIB
+	GITPERLLIB=`pwd`/perl/blib/lib:`pwd`/perl/blib/arch/auto/Git
+	export GIT_EXEC_PATH PATH GITPERLLIB
 
  - Git is reasonably self-sufficient, but does depend on a few external
    programs and libraries:
diff --git a/Makefile b/Makefile
index a62e8a3..bae95c2 100644
--- a/Makefile
+++ b/Makefile
@@ -552,7 +552,9 @@ common-cmds.h: Documentation/git-*.txt
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	rm -f $@ $@+
 	INSTLIBDIR=`$(MAKE) -C perl -s --no-print-directory instlibdir` && \
-	sed -e '1s|#!.*perl\(.*\)|#!$(PERL_PATH_SQ)\1|' \
+	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|1' \
+	    -e '2i\
+	        use lib (split(/:/, $$ENV{GITPERLLIB} || '\'"$$INSTLIBDIR"\''));' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.perl >$@+
diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index a9805dd..f86231e 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -5,11 +5,6 @@ #
 # Read .git/FETCH_HEAD and make a human readable merge message
 # by grouping branches and tags together to form a single line.
 
-BEGIN {
-	unless (exists $ENV{'RUNNING_GIT_TESTS'}) {
-		unshift @INC, '@@INSTLIBDIR@@';
-	}
-}
 use strict;
 use Git;
 use Error qw(:try);
diff --git a/git-mv.perl b/git-mv.perl
index 5134b80..322b9fd 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -6,11 +6,6 @@ #
 # This file is licensed under the GPL v2, or a later version
 # at the discretion of Linus Torvalds.
 
-BEGIN {
-	unless (exists $ENV{'RUNNING_GIT_TESTS'}) {
-		unshift @INC, '@@INSTLIBDIR@@';
-	}
-}
 use warnings;
 use strict;
 use Getopt::Std;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 298c6ca..ad9796e 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -206,9 +206,8 @@ PYTHON=`sed -e '1{
 	PYTHONPATH=$(pwd)/../compat
 	export PYTHONPATH
 }
-RUNNING_GIT_TESTS=YesWeAre
-PERL5LIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
-export PERL5LIB RUNNING_GIT_TESTS
+GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
+export GITPERLLIB
 test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
