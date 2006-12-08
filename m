X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: [PATCH] Allow building GIT in a different directory from the source
 directory
Date: Fri, 08 Dec 2006 18:15:25 +0100
Message-ID: <elc6j2$vej$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 17:25:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 266
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33711>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsjTR-0008N4-Ma for gcvg-git@gmane.org; Fri, 08 Dec
 2006 18:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425985AbWLHRZW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 12:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426035AbWLHRZW
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 12:25:22 -0500
Received: from main.gmane.org ([80.91.229.2]:54520 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425985AbWLHRZV
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 12:25:21 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GsjT4-0002aD-Ai for git@vger.kernel.org; Fri, 08 Dec 2006 18:25:02 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Fri, 08 Dec 2006 18:25:02 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006 18:25:02
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


From 105d331aee95c0cf3610ac0d2fd4aa7688bd5211 Mon Sep 17 00:00:00 2001
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Date: Fri, 8 Dec 2006 18:07:56 +0100

GIT can now be built in a separate builddirectory. This is done as
follows:

  mkdir build
  cd build
  $my_git_dir/configure
  make

In this case, configure creates an empty directory tree based on the
source directory, and wraps Makefiles from source directory in the
build directory.  The rest of the functionality is delivered with the
VPATH feature of Make.

To make this work the Makefile should not mention ./ explicitly in
rules, but rather use $< and $^ to automatically look in the source
dir too.

perl/Makefile and perl/Makefile.PL need special massaging because perl
is not VPATH aware.

Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>
---
 Makefile            |   21 ++++++++++++---------
 config.mak.in       |    9 ++++-----
 configure.ac        |   34 ++++++++++++++++++++++++++++++++++
 generate-cmdlist.sh |    2 +-
 perl/Makefile       |    4 ++++
 perl/Makefile.PL    |   16 +++++++++++++---
 6 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index cb9b745..3ed57ec 100644
--- a/Makefile
+++ b/Makefile
@@ -97,7 +97,7 @@ all:
 #
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@$(SHELL_PATH) $(srcdir)/GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
@@ -110,7 +110,7 @@ uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 
 CFLAGS = -g -O2 -Wall
 LDFLAGS =
-ALL_CFLAGS = $(CFLAGS)
+ALL_CFLAGS = $(CFLAGS) -I.
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 
@@ -120,7 +120,10 @@ datadir = $(prefix)/share
 GIT_datadir = $(datadir)/git-core
 gitexecdir = $(bindir)
 template_dir = $(GIT_datadir)/templates/
-# DESTDIR=
+srcdir = .
+
+# this is usually set on the make command line.
+DESTDIR=
 
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
@@ -598,8 +601,8 @@ git-merge-recur$X: git-merge-recursive$X
 $(BUILT_INS): git$X
 	rm -f $@ && ln git$X $@
 
-common-cmds.h: Documentation/git-*.txt
-	./generate-cmdlist.sh > $@+
+common-cmds.h: $(wildcard $(srcdir)/Documentation/git-*.txt)
+	$(srcdir)/generate-cmdlist.sh $(srcdir)/Documentation/ > $@+
 	mv $@+ $@
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
@@ -609,7 +612,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's!@@GIT_datadir@@!$(GIT_datadir)!g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
-	    $@.sh >$@+
+	    $^ >$@+
 	chmod +x $@+
 	mv $@+ $@
 
@@ -630,7 +633,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	    -e '}' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.perl >$@+
+	    $^ >$@+
 	chmod +x $@+
 	mv $@+ $@
 
@@ -674,7 +677,7 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
-	    $@.sh > $@+
+	    $< > $@+
 	chmod +x $@+
 	mv $@+ $@
 
@@ -821,7 +824,7 @@ install: all
 	fi
 	$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(GIT_datadir_SQ)'
-	$(INSTALL) -m755 git-sh-setup.sh '$(DESTDIR_SQ)$(GIT_datadir_SQ)'
+	$(INSTALL) -m755 $(srcdir)/git-sh-setup.sh '$(DESTDIR_SQ)$(GIT_datadir_SQ)'
 
 install-doc:
 	$(MAKE) -C Documentation install
diff --git a/config.mak.in b/config.mak.in
index 9a57840..bfbbf46 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -10,17 +10,16 @@ TAR = @TAR@
 prefix = @prefix@
 exec_prefix = @exec_prefix@
 bindir = @bindir@
-#gitexecdir = @libexecdir@/git-core/
+mandir=@mandir@
+
+## unused, but necessary for some autoconf versions (?)
 datarootdir = @datarootdir@
-template_dir = @datadir@/git-core/templates/
 
-mandir=@mandir@
 
 srcdir = @srcdir@
-VPATH = @srcdir@
 
 export exec_prefix mandir
-export srcdir VPATH
+export srcdir 
 
 NEEDS_SSL_WITH_CRYPTO=@NEEDS_SSL_WITH_CRYPTO@
 NO_OPENSSL=@NO_OPENSSL@
diff --git a/configure.ac b/configure.ac
index 34e3478..403c410 100644
--- a/configure.ac
+++ b/configure.ac
@@ -5,6 +5,7 @@ AC_PREREQ(2.59)
 AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
 
 AC_CONFIG_SRCDIR([git.c])
+srcdir=`cd $srcdir && pwd`
 
 config_file=config.mak.autogen
 config_append=config.mak.append
@@ -334,6 +335,39 @@ GIT_PARSE_WITH(iconv))
 AC_CONFIG_FILES(["${config_file}":"${config_in}":"${config_append}"])
 AC_OUTPUT
 
+if test "$srcdir" != "."; then
+
+  ## if we're building in another directory
+  ## we need to set it up like the sourcedir
+  for d in `cd $srcdir &&  find . -type d -print | grep -v '\.git'` ;
+  do
+    if test ! -d  $d ; then
+      echo creating $d 
+      mkdir $d
+    fi
+
+    if test -f $srcdir/$d/Makefile ; then
+
+      dnl [[]] is to keep m4 happy
+      depth=`echo $d/ | sed -e 's!^\./!!g' -e 's![[^/]]*/!../!g'`
+      echo creating $d/Makefile
+
+      if test "$depth"  = "";  then
+        INCLUDE_AUTOGEN="include config.mak.autogen" ;
+      else
+        INCLUDE_AUTOGEN="srcdir=$srcdir" 
+      fi
+ 
+      cat << EOF > $d/Makefile
+$INCLUDE_AUTOGEN
+VPATH = $srcdir/$d
+export VPATH
+include $srcdir/$d/Makefile
+EOF
+
+    fi 
+  done
+fi
 
 ## Cleanup
 rm -f "${config_append}"
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 5450918..e744fbb 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -47,6 +47,6 @@ do
             x
             s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
 	    p
-     }' "Documentation/git-$cmd.txt"
+     }' "$1/git-$cmd.txt"
 done
 echo "};"
diff --git a/perl/Makefile b/perl/Makefile
index bd483b0..e912191 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -28,6 +28,10 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo instlibdir: >> $@
 	echo '	echo $(instdir_SQ)' >> $@
 else
+
+PERL_SRCDIR=$(srcdir)/perl
+export PERL_SRCDIR
+
 $(makfile): Makefile.PL ../GIT-CFLAGS
 	'$(PERL_PATH_SQ)' $< FIRST_MAKEFILE='$@' PREFIX='$(prefix_SQ)'
 endif
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index de73235..8a1251d 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -8,21 +8,31 @@ instlibdir:
 MAKE_FRAG
 }
 
-my %pm = ('Git.pm' => '$(INST_LIBDIR)/Git.pm');
+
+$src_prefix = '';
+if (!($ENV{'PERL_SRCDIR'} eq "")) {
+    $src_prefix = $ENV{'PERL_SRCDIR'} . "/"
+}
+
+
+my %pm = ("$src_prefix/Git.pm" => '$(INST_LIBDIR)/Git.pm');
+
+
 
 # We come with our own bundled Error.pm. It's not in the set of default
 # Perl modules so install it if it's not available on the system yet.
 eval { require Error };
 if ($@) {
-	$pm{'private-Error.pm'} = '$(INST_LIBDIR)/Error.pm';
+	$pm{"$src_prefix/private-Error.pm"} = '$(INST_LIBDIR)/Error.pm';
 }
 
 my %extra;
 $extra{DESTDIR} = $ENV{DESTDIR} if $ENV{DESTDIR};
 
+
 WriteMakefile(
 	NAME            => 'Git',
-	VERSION_FROM    => 'Git.pm',
+	VERSION_FROM    => "$src_prefix/Git.pm",
 	PM		=> \%pm,
 	%extra
 );
-- 
1.4.4.1.gc9922-dirty


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
