X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Wed, 06 Dec 2006 15:16:43 +0100
Message-ID: <4576D0CB.7090408@xs4all.nl>
References: <el6c6o$oa7$1@sea.gmane.org> <Pine.LNX.4.63.0612061322140.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576B8BC.8040107@xs4all.nl> <el6eh6$vg7$2@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 14:17:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 223
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <el6eh6$vg7$2@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33458>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrxZt-0008Rt-2c for gcvg-git@gmane.org; Wed, 06 Dec
 2006 15:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760633AbWLFOQu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 09:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760634AbWLFOQu
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 09:16:50 -0500
Received: from main.gmane.org ([80.91.229.2]:37169 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760633AbWLFOQt
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 09:16:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrxZf-0006HG-B1 for git@vger.kernel.org; Wed, 06 Dec 2006 15:16:39 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Wed, 06 Dec 2006 15:16:39 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006 15:16:39
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski escreveu:
> Han-Wen Nienhuys wrote:
> 
>> Subject: [PATCH] Install git-sh-setup.sh into $(prefix)/share/git-core. Call with explicit path.
> 
> I like it... but could you check if you don't need to change
> config.mak.in accordingly for ./configure script to generate proper
> config.mak.autogen?

I couldn't see anything, but while I was looking at it, I also added
support for non-srcdir builds. Can someone with a perl clue look over
the braindamaged messing-around with perl/perl.mak  and figure out why
perl insists

make -C perl PERL_PATH='/usr/bin/perl' prefix='/tmp/test' perl.mak
make[1]: Entering directory `/home/lilydev/vc/go2/perl'
'/usr/bin/perl' -I/home/lilydev/vc/g2/perl /home/lilydev/vc/g2/perl/Makefile.PL FIRST_MAKEFILE='perl.mak' PREFIX='/tmp/test'
Could not open 'Git.pm': No such file or directory at /usr/lib/perl5/5.8.8/ExtUtils/MM_Unix.pm line 2649.


despite the -I option?


From 7bbd698891d9102fa26ae53848c9812f6d1b665e Mon Sep 17 00:00:00 2001
From: Han-Wen Nienhuys <hanwen@lilypond.org>
Date: Wed, 6 Dec 2006 15:14:08 +0100
Subject: [PATCH] Allow non-srcdir builds using cd $builddir && $srcdir/configure


Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>
---
 Makefile            |   19 +++++++++++--------
 config.mak.in       |    5 +----
 configure.ac        |   31 ++++++++++++++++++++++++++++++-
 generate-cmdlist.sh |    2 +-
 perl/Makefile       |    2 +-
 5 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index cb9b745..d64a5bd 100644
--- a/Makefile
+++ b/Makefile
@@ -97,7 +97,7 @@ all:
 #
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@$(SHELL_PATH) $(srcdir)/GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
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
index 9a57840..902a392 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -2,7 +2,7 @@
 # @configure_input@
 
 CC = @CC@
-CFLAGS = @CFLAGS@
+CFLAGS = @CFLAGS@ -I.
 AR = @AR@
 TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
@@ -10,9 +10,6 @@ TAR = @TAR@
 prefix = @prefix@
 exec_prefix = @exec_prefix@
 bindir = @bindir@
-#gitexecdir = @libexecdir@/git-core/
-datarootdir = @datarootdir@
-template_dir = @datadir@/git-core/templates/
 
 mandir=@mandir@
 
diff --git a/configure.ac b/configure.ac
index 34e3478..ccf9374 100644
--- a/configure.ac
+++ b/configure.ac
@@ -5,11 +5,13 @@ AC_PREREQ(2.59)
 AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
 
 AC_CONFIG_SRCDIR([git.c])
-
+srcdir=`cd $srcdir && pwd`
 config_file=config.mak.autogen
 config_append=config.mak.append
 config_in=config.mak.in
 
+
+	
 echo "# ${config_append}.  Generated by configure." > "${config_append}"
 
 
@@ -330,10 +332,37 @@ GIT_PARSE_WITH(iconv))
 # change being considered an inode change from the update-cache perspective.
 
 
+    
+  
+
 ## Output files
 AC_CONFIG_FILES(["${config_file}":"${config_in}":"${config_append}"])
 AC_OUTPUT
 
+	
+## generate subdirectories and sub Makefiles. 
+for d in `cd $srcdir &&  find . -type d -print | grep -v '\.git'` ;
+do
+  if test ! -d  $d ; then
+    echo creating $d 
+    mkdir $d
+  fi
+  
+  if test -f $srcdir/$d/Makefile ; then
+    
+    dnl [[]] is to keep m4 happy
+    depth=`echo $d/ | sed -e 's!^\./!!g' -e 's![[^/]]*/!../!g'`
+    echo creating $d/Makefile
+    cat << EOF > $d/Makefile
+include ${depth}config.mak.autogen
+here-srcdir=\$(srcdir)/$d/
+VPATH=\$(here-srcdir)
+include \$(here-srcdir)/Makefile
+EOF
+
+  fi 
+done
+exit 1
 
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
index bd483b0..5706095 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -29,7 +29,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo '	echo $(instdir_SQ)' >> $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
-	'$(PERL_PATH_SQ)' $< FIRST_MAKEFILE='$@' PREFIX='$(prefix_SQ)'
+	'$(PERL_PATH_SQ)' -I$(srcdir)/perl $< FIRST_MAKEFILE='$@' PREFIX='$(prefix_SQ)'
 endif
 
 # this is just added comfort for calling make directly in perl dir
-- 
1.4.4.1.gc9922-dirty

 


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
