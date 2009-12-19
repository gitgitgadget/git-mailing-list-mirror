From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFCv2 4/6] gitweb: Makefile improvements
Date: Sat, 19 Dec 2009 14:32:11 +0100
Message-ID: <200912191432.12280.jnareb@gmail.com>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <4B2271B4.2010301@kernel.org> <200912111741.51760.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 19 14:32:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLzQY-0007Ww-KQ
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 14:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbZLSNcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 08:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbZLSNcX
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 08:32:23 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:62655 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbZLSNcW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 08:32:22 -0500
Received: by fxm21 with SMTP id 21so3557795fxm.21
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 05:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OKZ8faTGg/U1toQIFAokYLtpIaaqnSzO6Xytm3bkEtY=;
        b=VlSwgOj5YSN07igYi5wgyoHS7SCTaFa028g5aJ+vSZs/iHp+9uv5SgdtL43Qh1Mzuc
         /7H5KuKkM0V5YX7g/IzlpdG3OryMyXQvSH3lWWbBiIAH2gZpXOEPGu5V+QIo0a4O8LWU
         GOxB3zmFI1a00VE2XJPZC0ud6bUkvEPab9Jmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=M0EsozwKH2LsBrqu6URiTzzzxgIrlj52fi++sFhVSOTbIY+HP5KJwO52Qhd3rZEszk
         4KooNXo4qs05bG8nkZqjLYvF2FMP+pfYK6ED0/q6jD73ZQpOKaQIlIEe0+B3lB+alpMe
         Ta73VvtwsDMyXFAkwi+86T423OW19lpZLCqI4=
Received: by 10.223.100.8 with SMTP id w8mr6538495fan.81.1261229540525;
        Sat, 19 Dec 2009 05:32:20 -0800 (PST)
Received: from ?192.168.1.13? (abwf124.neoplus.adsl.tpnet.pl [83.8.229.124])
        by mx.google.com with ESMTPS id c28sm6338349fka.19.2009.12.19.05.32.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Dec 2009 05:32:19 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200912111741.51760.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135480>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

This commit adjust the main Makefile so you can simply run

     make gitweb

which in turn calls gitweb/Makefile.  This means that in order to
generate gitweb, you can simply run 'make' from gitweb subdirectory:

     cd gitweb
     make

Targets gitweb/gitweb.cgi and (dependent on JSMIN being defined)
gitweb/gitweb.min.js in main Makefile are preserved for backward
compatibility.

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This implements separate Makefile for gitweb, with main Makefile calling
it, like for gitk-git/, git-gui/, Documentation/, t/, and templates/
directories.

It is marked as RFC because I don't feel that my make-fu is strong enough
to be sure that there are no errors / mistakes.  Very slightly tested.

 Makefile        |   64 +++++----------------------
 gitweb/Makefile |  129 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 52 deletions(-)
 create mode 100644 gitweb/Makefile

diff --git a/Makefile b/Makefile
index 4a1e5bc..50d815e 100644
--- a/Makefile
+++ b/Makefile
@@ -280,29 +280,6 @@ pathsep = :
 # JavaScript minifier invocation that can function as filter
 JSMIN =
 
-# default configuration for gitweb
-GITWEB_CONFIG = gitweb_config.perl
-GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
-GITWEB_HOME_LINK_STR = projects
-GITWEB_SITENAME =
-GITWEB_PROJECTROOT = /pub/git
-GITWEB_PROJECT_MAXDEPTH = 2007
-GITWEB_EXPORT_OK =
-GITWEB_STRICT_EXPORT =
-GITWEB_BASE_URL =
-GITWEB_LIST =
-GITWEB_HOMETEXT = indextext.html
-GITWEB_CSS = gitweb.css
-GITWEB_LOGO = git-logo.png
-GITWEB_FAVICON = git-favicon.png
-ifdef JSMIN
-GITWEB_JS = gitweb.min.js
-else
-GITWEB_JS = gitweb.js
-endif
-GITWEB_SITE_HEADER =
-GITWEB_SITE_FOOTER =
-
 export prefix bindir sharedir sysconfdir
 
 CC = gcc
@@ -1509,6 +1486,11 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	chmod +x $@+ && \
 	mv $@+ $@
 
+
+.PHONY: gitweb
+gitweb:
+	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
+
 ifdef JSMIN
 OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
 gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
@@ -1516,30 +1498,13 @@ else
 OTHER_PROGRAMS += gitweb/gitweb.cgi
 gitweb/gitweb.cgi: gitweb/gitweb.perl
 endif
-	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
-	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
-	    -e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
-	    -e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
-	    -e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
-	    -e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
-	    -e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
-	    -e 's|"++GITWEB_PROJECT_MAXDEPTH++"|$(GITWEB_PROJECT_MAXDEPTH)|g' \
-	    -e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
-	    -e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
-	    -e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
-	    -e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
-	    -e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
-	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
-	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
-	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
-	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
-	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
-	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
-	    $< >$@+ && \
-	chmod +x $@+ && \
-	mv $@+ $@
+	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
+
+ifdef JSMIN
+gitweb/gitweb.min.js: gitweb/gitweb.js
+	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
+endif # JSMIN
+
 
 git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.js
 	$(QUIET_GEN)$(RM) $@ $@+ && \
@@ -1566,11 +1531,6 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
 	mv $@+ $@
 endif # NO_PERL
 
-ifdef JSMIN
-gitweb/gitweb.min.js: gitweb/gitweb.js
-	$(QUIET_GEN)$(JSMIN) <$< >$@
-endif # JSMIN
-
 configure: configure.ac
 	$(QUIET_GEN)$(RM) $@ $<+ && \
 	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
diff --git a/gitweb/Makefile b/gitweb/Makefile
new file mode 100644
index 0000000..c9eb1ee
--- /dev/null
+++ b/gitweb/Makefile
@@ -0,0 +1,129 @@
+# The default target of this Makefile is...
+all::
+
+# Define V=1 to have a more verbose compile.
+#
+# Define JSMIN to point to JavaScript minifier that functions as
+# a filter to have gitweb.js minified.
+#
+
+prefix ?= $(HOME)
+bindir ?= $(prefix)/bin
+RM ?= rm -f
+
+# JavaScript minifier invocation that can function as filter
+JSMIN ?=
+
+# default configuration for gitweb
+GITWEB_CONFIG = gitweb_config.perl
+GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
+GITWEB_HOME_LINK_STR = projects
+GITWEB_SITENAME =
+GITWEB_PROJECTROOT = /pub/git
+GITWEB_PROJECT_MAXDEPTH = 2007
+GITWEB_EXPORT_OK =
+GITWEB_STRICT_EXPORT =
+GITWEB_BASE_URL =
+GITWEB_LIST =
+GITWEB_HOMETEXT = indextext.html
+GITWEB_CSS = gitweb.css
+GITWEB_LOGO = git-logo.png
+GITWEB_FAVICON = git-favicon.png
+ifdef JSMIN
+GITWEB_JS = gitweb.min.js
+else
+GITWEB_JS = gitweb.js
+endif
+GITWEB_SITE_HEADER =
+GITWEB_SITE_FOOTER =
+
+# include user config
+-include ../config.mak.autogen
+-include ../config.mak
+
+# determine version
+../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
+	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
+
+-include ../GIT-VERSION-FILE
+
+### Build rules
+
+SHELL_PATH ?= $(SHELL)
+PERL_PATH  ?= /usr/bin/perl
+
+# Shell quote;
+bindir_SQ = $(subst ','\'',$(bindir))         #'
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH)) #'
+PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))  #'
+
+# Quiet generation (unless V=1)
+QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
+QUIET_SUBDIR1  =
+
+ifneq ($(findstring $(MAKEFLAGS),w),w)
+PRINT_DIR = --no-print-directory
+else # "make -w"
+NO_SUBDIR = :
+endif
+
+ifneq ($(findstring $(MAKEFLAGS),s),s)
+ifndef V
+	QUIET          = @
+	QUIET_GEN      = $(QUIET)echo '   ' GEN $@;
+	QUIET_SUBDIR0  = +@subdir=
+	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
+	                 $(MAKE) $(PRINT_DIR) -C $$subdir
+	export V
+	export QUIET
+	export QUIET_GEN
+	export QUIET_SUBDIR0
+	export QUIET_SUBDIR1
+endif
+endif
+
+all:: gitweb.cgi
+
+ifdef JSMIN
+FILES=gitweb.cgi gitweb.min.js
+gitweb.cgi: gitweb.perl gitweb.min.js
+else # !JSMIN
+FILES=gitweb.cgi
+gitweb.cgi: gitweb.perl
+endif # JSMIN
+
+gitweb.cgi:
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
+	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
+	    -e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
+	    -e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
+	    -e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
+	    -e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
+	    -e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
+	    -e 's|"++GITWEB_PROJECT_MAXDEPTH++"|$(GITWEB_PROJECT_MAXDEPTH)|g' \
+	    -e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
+	    -e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
+	    -e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
+	    -e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
+	    -e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
+	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
+	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
+	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
+	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
+	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
+	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
+	    $< >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
+
+ifdef JSMIN
+gitweb.min.js: gitweb.js
+	$(QUIET_GEN)$(JSMIN) <$< >$@
+endif # JSMIN
+
+clean:
+	$(RM) $(FILES)
+
+.PHONY: all clean .FORCE-GIT-VERSION-FILE
-- 
1.6.5.3
