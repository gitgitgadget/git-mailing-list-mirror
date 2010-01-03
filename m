From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2/RFC 4/4 (resent)] gitweb: Makefile improvements
Date: Sun,  3 Jan 2010 17:07:30 +0100
Message-ID: <1262534850-24572-5-git-send-email-jnareb@gmail.com>
References: <1262534850-24572-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 03 17:08:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRT00-0008Jq-3V
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 17:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878Ab0ACQHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 11:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866Ab0ACQHv
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 11:07:51 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:47129 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab0ACQHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 11:07:47 -0500
Received: by fg-out-1718.google.com with SMTP id 19so6099310fgg.1
        for <git@vger.kernel.org>; Sun, 03 Jan 2010 08:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WFTb5sKjWB9lF+6rPeyQEmST+uru/1lpagrdisdKNvA=;
        b=ccWcCziVOo4fXWzvFipNTChEcjTQZqEgAWCrynpEsg9hXh08sYnzYk5ZnjVn2iuzp+
         NmMifqgd5sdPeEgXRNLIffEhtn5xxMw5V3BImSaaIEkvZjO25a23eRQSELGYA7GbZPTX
         P9qP6Tec/ZRRKd8LnxDq9ESWPo1iSDRxaKGLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=B8b0v+n75NDosXW02Tje7R2ppuGdSHpsYMG8Wzas/ZEdrRxLQV2Tt/JgjkESn/H30b
         eeGU236dYqWKTqjvEAPlRMvpyq91Ds612TLuZIV7fldMxOEj+hBrXVUKbolKxTffapHK
         hmRoLaFzkO98LoiDDRoQBvPWWUOes3jGeLz/8=
Received: by 10.103.87.3 with SMTP id p3mr259987mul.76.1262534865735;
        Sun, 03 Jan 2010 08:07:45 -0800 (PST)
Received: from localhost.localdomain (abvk210.neoplus.adsl.tpnet.pl [83.8.208.210])
        by mx.google.com with ESMTPS id g1sm1607328muf.14.2010.01.03.08.07.44
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Jan 2010 08:07:44 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <1262534850-24572-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136076>

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
directories.  The original patch by J.H. did it the opposite way, with
gitweb/Makefile calling main Makefile.

It is marked as RFC because I don't feel that my make-fu is strong enough
to be sure that there are no errors / mistakes.  Very slightly tested.

 Makefile        |   65 +++++----------------------
 gitweb/Makefile |  129 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 53 deletions(-)
 create mode 100644 gitweb/Makefile

diff --git a/Makefile b/Makefile
index c11719c..9c6d2b2 100644
--- a/Makefile
+++ b/Makefile
@@ -282,29 +282,6 @@ pathsep = :
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
@@ -1526,6 +1503,11 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
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
@@ -1533,30 +1515,13 @@ else
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
@@ -1583,12 +1548,6 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
 	mv $@+ $@
 endif # NO_PERL
 
-
-ifdef JSMIN
-gitweb/gitweb.min.js: gitweb/gitweb.js
-	$(QUIET_GEN)$(JSMIN) <$< >$@
-endif # JSMIN
-
 ifndef NO_PYTHON
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
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
