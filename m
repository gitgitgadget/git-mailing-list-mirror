From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Tue, 1 Feb 2011 05:14:29 -0600
Message-ID: <20110201111429.GA10165@elie>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <20110201014807.GA2722@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101312238170.8580@xanadu.home>
 <201102011342.06910.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 01 21:14:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkMbv-0001dv-9r
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 21:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab1BAUNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 15:13:54 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46591 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab1BAUNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 15:13:53 -0500
Received: by qyk12 with SMTP id 12so7902721qyk.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 12:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WAUVyCQW+60dotOoPDWRWJBJ9nEhvBIkwayc1GhWma4=;
        b=mltZGJW9DNaUoTT1EYdIpry/WUOeOoyBccIbAW+rF2XPl9Gu6WXhEaOGNizWgFPaEE
         HU4u2Q2Iz9VK2TWRPoABTy/ULlDdokobp6/0prYwU41/zED6HVtDRvFINAtLxznq7jHU
         PQMxT/ovnEyo7BAhG9DLaoJlfyxzlQU4l3xrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Gmmegn/WeSAwcAO65FTGinNumS6QJOZxFx3VUfUY6V3MYALY2NqOW59KY7mrPEvSaB
         pdVPH40sZfdtsQ2iisCOJmdCNF0Nd+GPYgS3ELRJxRT7DGdBrZVWQknOOHGGCyf2R2A9
         sny0pA4Mdnk118x4jNWC8BP+oLBWkfUvE3+UQ=
Received: by 10.224.76.85 with SMTP id b21mr7795512qak.340.1296591232258;
        Tue, 01 Feb 2011 12:13:52 -0800 (PST)
Received: from elie (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id q12sm15913938qcu.30.2011.02.01.12.13.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 12:13:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201102011342.06910.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165850>

Thomas Rast wrote:

> In particular a prospective git hacker would not care whether
> something is a source file or a script (you seem to imply the
> opposite).  He would instead expect to find git-foo implemented in
> something named of that sort, so we could probably help him by mapping
> 
>   git-foo.sh      ->   git-foo.sh
>   builtin/bar.c   ->   git-bar.c
>   baz.c           ->   lib/baz.c

I agree.  This sets off my "time to resist change" alarms much
less than "git mv *.c *.sh src/", for what it's worth.

>   baz.o           ->   build/baz.o (or whatever, just elsewhere)
>   baz.gcov        ->   build/baz.gcov (ditto)

Maybe something like this to start?

-- 8< --
Subject: Makefile: basic support for separate build dir

 - python and perl machinery haven't been tweaked yet
 - requires good VPATH support
 - relies on COMPUTE_HEADER_DIRECTORIES to make the object file
   directories
 - does not support paths with spaces

Usage:

	mkdir output
	cd output
	echo COMPUTE_HEADER_DIRECTORIES=1 >config.mak
	make -f ../Makefile GIT_SRC=$(pwd)/../ -j2

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile            |   41 ++++++++++++++++++++++++++---------------
 generate-cmdlist.sh |    4 ++--
 perl/Makefile       |    2 +-
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 775ee83..b258a24 100644
--- a/Makefile
+++ b/Makefile
@@ -243,8 +243,18 @@ all::
 #
 # Define NATIVE_CRLF if your platform uses CRLF for line endings.
 
+# Absolute path to the toplevel of the git sources, with trailing /.
+# Leave empty for an in-place build.
+GIT_SRC =
+ifdef GIT_SRC
+	NO_PYTHON = YesPlease
+	NO_PERL_MAKEMAKER = YesPlease
+endif
+
+VPATH := $(if $(GIT_SRC),$(GIT_SRC),$(CURDIR))
+
 GIT-VERSION-FILE: FORCE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@$(SHELL_PATH) $(GIT_SRC)/GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
@@ -305,6 +315,7 @@ lib = lib
 pathsep = :
 
 export prefix bindir sharedir sysconfdir gitwebdir
+export GIT_SRC
 
 CC = gcc
 AR = ar
@@ -333,7 +344,7 @@ SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
 # Those must not be GNU-specific; they are shared with perl/ which may
 # be built by a different compiler. (Note that this is an artifact now
 # but it still might be nice to keep that distinction.)
-BASIC_CFLAGS = -I.
+BASIC_CFLAGS = -I$(GIT_SRC). -I.
 BASIC_LDFLAGS =
 
 # Guard against environment variables
@@ -1562,7 +1573,7 @@ ifeq ($(PYTHON_PATH),)
 NO_PYTHON=NoThanks
 endif
 
-QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
+QUIET_SUBDIR0  = +$(MAKE) -C $(GIT_SRC)# no space before subdir
 QUIET_SUBDIR1  =
 
 ifneq ($(findstring $(MAKEFLAGS),w),w)
@@ -1582,7 +1593,7 @@ ifndef V
 	QUIET_GCOV     = @echo '   ' GCOV $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
-			 $(MAKE) $(PRINT_DIR) -C $$subdir
+			 $(MAKE) $(PRINT_DIR) -C $(GIT_SRC)$$subdir
 	export V
 	export QUIET_GEN
 	export QUIET_BUILT_IN
@@ -1696,10 +1707,10 @@ $(BUILT_INS): git$X
 	ln -s git$X $@ 2>/dev/null || \
 	cp git$X $@
 
-common-cmds.h: ./generate-cmdlist.sh command-list.txt
+common-cmds.h: generate-cmdlist.sh command-list.txt
 
 common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
+	$(QUIET_GEN)$(GIT_SRC)./generate-cmdlist.sh > $@+ && mv $@+ $@
 
 define cmd_munge_script
 $(RM) $@ $@+ && \
@@ -1709,7 +1720,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e $(BROKEN_PATH_FIX) \
-    $@.sh >$@+
+    $(GIT_SRC)$@.sh >$@+
 endef
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
@@ -1729,7 +1740,7 @@ perl/perl.mak: GIT-CFLAGS perl/Makefile perl/Makefile.PL
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C $(GIT_SRC)perl -s --no-print-directory instlibdir` && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e '	h' \
@@ -1738,7 +1749,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	    -e '	x' \
 	    -e '}' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.perl >$@+ && \
+	    $(GIT_SRC)$@.perl >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
@@ -1780,7 +1791,7 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
-	    $@.sh > $@+ && \
+	    $(GIT_SRC)$@.sh > $@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
@@ -1788,7 +1799,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
-	    unimplemented.sh >$@+ && \
+	    $(GIT_SRC)unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 endif # NO_PERL
@@ -1803,7 +1814,7 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    -e 's|\(os\.getenv("GITPYTHONLIB"\)[^)]*)|\1,"@@INSTLIBDIR@@")|' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
-	    $@.py >$@+ && \
+	    $(GIT_SRC)$@.py >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PYTHON
@@ -1811,7 +1822,7 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
-	    unimplemented.sh >$@+ && \
+	    $(GIT_SRC)unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 endif # NO_PYTHON
@@ -2142,7 +2153,7 @@ test-%$X: test-%.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: test-sha1$X
-	./test-sha1.sh
+	$(GIT_SRC)./test-sha1.sh
 
 check: common-cmds.h
 	if sparse; \
@@ -2229,7 +2240,7 @@ endif
 		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
 	done && \
-	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
+	$(GIT_SRC)./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-gitweb:
 	$(MAKE) -C gitweb install
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 75c68d9..f718633 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -9,7 +9,7 @@ struct cmdname_help
 
 static struct cmdname_help common_cmds[] = {"
 
-sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
+sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' "$GIT_SRC"command-list.txt |
 sort |
 while read cmd
 do
@@ -19,6 +19,6 @@ do
             x
             s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
 	    p
-     }' "Documentation/git-$cmd.txt"
+     }' "${GIT_SRC}Documentation/git-$cmd.txt"
 done
 echo "};"
diff --git a/perl/Makefile b/perl/Makefile
index a2ffb64..7c3a82a 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -44,4 +44,4 @@ endif
 # this is just added comfort for calling make directly in perl dir
 # (even though GIT-CFLAGS aren't used yet. If ever)
 ../GIT-CFLAGS:
-	$(MAKE) -C .. GIT-CFLAGS
+	$(MAKE) -C $(GIT_SRC).. GIT-CFLAGS
-- 
1.7.2.3
