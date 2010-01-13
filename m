From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 3/7] gitweb: Makefile improvements
Date: Wed, 13 Jan 2010 01:34:38 -0800
Message-ID: <1263375282-15508-4-git-send-email-warthog9@eaglescrag.net>
References: <1263375282-15508-1-git-send-email-warthog9@eaglescrag.net>
 <1263375282-15508-2-git-send-email-warthog9@eaglescrag.net>
 <1263375282-15508-3-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 10:35:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUzdO-0004Yv-AD
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 10:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab0AMJeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 04:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284Ab0AMJet
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 04:34:49 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:57267 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269Ab0AMJeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 04:34:46 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0D9Yg1U018510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 01:34:46 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1263375282-15508-3-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 01:34:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136798>

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
 Makefile        |   91 +++++++++++++++++----------------------
 gitweb/Makefile |  129 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+), 51 deletions(-)
 create mode 100644 gitweb/Makefile

diff --git a/Makefile b/Makefile
index 4a1e5bc..ffef979 100644
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
@@ -1566,10 +1531,34 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
 	mv $@+ $@
 endif # NO_PERL
 
-ifdef JSMIN
-gitweb/gitweb.min.js: gitweb/gitweb.js
-	$(QUIET_GEN)$(JSMIN) <$< >$@
-endif # JSMIN
+ifndef NO_PYTHON
+$(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS
+$(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
+		--no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' \
+		instlibdir` && \
+	sed -e '1{' \
+	    -e '	s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
+	    -e '}' \
+	    -e 's|^import sys.*|&; \\\
+	           import os; \\\
+	           sys.path[0] = os.environ.has_key("GITPYTHONLIB") and \\\
+	                         os.environ["GITPYTHONLIB"] or \\\
+	                         "@@INSTLIBDIR@@"|' \
+	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
+	    $@.py >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
+else # NO_PYTHON
+$(patsubst %.py,%,$(SCRIPT_PYTHON)): % : unimplemented.sh
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
+	    unimplemented.sh >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
+endif # NO_PYTHON
 
 configure: configure.ac
 	$(QUIET_GEN)$(RM) $@ $<+ && \
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
1.6.5.2
