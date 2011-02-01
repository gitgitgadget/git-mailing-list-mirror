From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (version B) 1/2] gitweb: Prepare for splitting gitweb
Date: Tue,  1 Feb 2011 17:50:14 +0100
Message-ID: <1296579016-13356-3-git-send-email-jnareb@gmail.com>
References: <1296579016-13356-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 01 17:51:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkJRa-0007ZV-RP
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 17:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542Ab1BAQvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 11:51:03 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47466 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab1BAQvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 11:51:01 -0500
Received: by gyb11 with SMTP id 11so2550295gyb.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 08:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=NVQLAKmL7/G9RzLm4w97t8erbhc79ouztVevSpZEMYA=;
        b=KzBDHsTu7w+wrnLbCZnqchw8cWv3J2qPX3wFjc7a+mbiVPla/Rxx//eGgbXWWGweVt
         +R3udgSLZPKSq274G3gaJEosmetZI/oE9YxHSp0At4UFUAb+92WxFojmpieHNV02QiNy
         WwSRGD5+sERKG8b88Ve4bE7HZTweLisJDwLeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x1kWqgAw5tAeVg2DDqMESxp6GdRKy9jhGgDJ4UI9bIHhY5B3NUGqscxHIAFNjmCW7e
         U+N/UgCsONz4TESO3EaOzbSViHHtff2RaOw3m/qdmzrtTqVwAWDf/zx/QikaoFVWRN7H
         eLND4LNA3sNxPz0TR7lS6Wqqmv07ZZ426Irps=
Received: by 10.204.97.132 with SMTP id l4mr7000509bkn.167.1296579045373;
        Tue, 01 Feb 2011 08:50:45 -0800 (PST)
Received: from localhost.localdomain (abuz232.neoplus.adsl.tpnet.pl [83.8.197.232])
        by mx.google.com with ESMTPS id z18sm8881027bkf.20.2011.02.01.08.50.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 08:50:44 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1296579016-13356-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165827>

Prepare gitweb for being split into modules that would be installed
in gitweblibdir, by default alongside gitweb in 'lib/' subdirectory,
by adding

  use lib $ENV{'GITWEBLIBDIR'} || "++GITWEBLIBDIR++";

to gitweb.perl (to main gitweb script).  The first part allow to run
gitweb scripts using source version of gitweb (after small change to
t/gitweb-lib.sh).  The second part is set to appropriate value during
build (generating gitweb.cgi).  This allows to select where to install
gitweb modules via 'gitweblibdir' build time configuration variable,
e.g.

  $ make gitwebdir=/var/www/cgi-bin gitweblibdir=/usr/lib/perl5
    install-gitweb


This preparatory work allows to add new module to gitweb by simply
adding

  GITWEB_MODULES += <module>

to gitweb/Makefile (assuming that the module is in 'gitweb/lib/'
directory).

While at it pass GITWEBLIBDIR in addition to GITWEB_TEST_INSTALLED to
allow testing installed version of gitweb and installed version of
modules (for future tests which would check individual (sub)modules).


At Pavan Kumar Sankara suggestion gitweb/Makefile uses

  install [OPTION]... SOURCE... DIRECTORY

format (2nd format) with single SOURCE rather than

  install [OPTION]... SOURCE DEST

format (1st format) because of security reasons (race conditions).
Modern GNU install has `-T' / `--no-target-directory' option, but we
cannot rely that the $(INSTALL) we are using supports this option.

The install-modules target in gitweb/Makefile uses shell 'for' loop,
instead of make's $(foreach) function, to avoid possible problem with
generating a command line that exceeded the maximum argument list
length.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/Makefile    |   19 +++++++++++++++++--
 gitweb/gitweb.perl |    4 ++++
 t/gitweb-lib.sh    |    2 ++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 0a6ac00..abe9db8 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -13,6 +13,7 @@ all::
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
 gitwebdir ?= /var/www/cgi-bin
+gitweblibdir ?= $(gitwebdir)/lib
 
 RM ?= rm -f
 INSTALL ?= install
@@ -57,6 +58,7 @@ PERL_PATH  ?= /usr/bin/perl
 bindir_SQ = $(subst ','\'',$(bindir))#'
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
 gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
+gitweblibdir_SQ = $(subst ','\'',$(gitweblibdir))#'
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
 PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
 DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
@@ -115,6 +117,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
+	-e 's|++GITWEBLIBDIR++|$(gitweblibdir)|g' \
 	-e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
 	-e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
 	-e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
@@ -153,20 +156,32 @@ test:
 
 test-installed:
 	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
+	GITWEBLIBDIR='$(DESTDIR_SQ)$(gitweblibdir_SQ)' \
 		$(MAKE) -C ../t gitweb-test
 
 ### Installation rules
 
-install: all
+install: all install-modules
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 
+install-modules:
+	install_dirs="$(sort $(dir $(GITWEB_MODULES)))" && \
+	for dir in $$install_dirs; do \
+		test -d '$(DESTDIR_SQ)$(gitweblibdir_SQ)'/"$$dir" || \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitweblibdir_SQ)'/"$$dir"; \
+	done
+	gitweb_modules="$(GITWEB_MODULES)" && \
+	for mod in $$gitweb_modules; do \
+		$(INSTALL) -m 644 "lib/$$mod" '$(DESTDIR_SQ)$(gitweblibdir_SQ)'/"$$(dirname $$mod)"; \
+	done
+
 ### Cleaning rules
 
 clean:
 	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
 
-.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
+.PHONY: all clean install install-modules test test-installed .FORCE-GIT-VERSION-FILE FORCE
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1025c2f..bed1eec 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -10,6 +10,10 @@
 use 5.008;
 use strict;
 use warnings;
+
+use lib $ENV{'GITWEBLIBDIR'} || "++GITWEBLIBDIR++";
+
+use File::Spec;
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index b9bb95f..8b98047 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -48,6 +48,8 @@ EOF
 		say "# Testing $SCRIPT_NAME"
 	else # normal case, use source version of gitweb
 		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
+		GITWEBLIBDIR="$GIT_BUILD_DIR/gitweb/lib"
+		export GITWEBLIBDIR
 	fi
 	export SCRIPT_NAME
 }
-- 
1.6.5.GIT
