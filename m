From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (version C) 1/2] gitweb: Prepare for splitting gitweb
Date: Tue,  1 Feb 2011 17:50:15 +0100
Message-ID: <1296579016-13356-4-git-send-email-jnareb@gmail.com>
References: <1296579016-13356-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 01 17:51:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkJRZ-0007ZV-Eb
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 17:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab1BAQut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 11:50:49 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41376 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab1BAQus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 11:50:48 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so6510232bwz.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 08:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=gzT/meH47opmDXUY39Zd8iCbeZbQWH1WJFTA6yaWMq0=;
        b=B7r+VN9tQ5HN5DrIirQLZkV3SquqGPFNEKxBg9ixSp8m7+vDFIcDzPK6YwSbZmRbCu
         WVMjFtWOGoFod50BUAyPiaIIWIIO+xGNSJgGULpJBJUIXtquEQ97TqFBCDcpxVafAC14
         xSKlhJsYhao3BmujEePOF3KACNHJjyD8zVv/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ubnke2JDBksyhKDpf0+0nOf1EuaEGYmlQwxMOCl+LLtBCKhhLtRGl8JT+J1/K2f0Jn
         281bhje9GR25yx2suVLQFKH1eiF1bW0EL2/k7o4MUVmrv8tpXuIOl9PrANkCeqs9TAZs
         xyC1fWvQponb2ePNlj/4a9g68nsd8GKx8VTX0=
Received: by 10.204.77.196 with SMTP id h4mr6926401bkk.89.1296579047669;
        Tue, 01 Feb 2011 08:50:47 -0800 (PST)
Received: from localhost.localdomain (abuz232.neoplus.adsl.tpnet.pl [83.8.197.232])
        by mx.google.com with ESMTPS id z18sm8881027bkf.20.2011.02.01.08.50.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 08:50:46 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1296579016-13356-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165826>

Prepare gitweb for being split into modules that would be installed
in gitweblibdir, by default alongside gitweb in 'lib/' subdirectory.

Gitweb would search first in 'lib/' subdirectory from where it is
installed, via

  use lib __DIR__.'/lib';

(This allow for tests to work with source version of gitweb without
changes.)  Then it searches in $(gitweblibdir) directory (set during
build time), by default "$(gitwebdir)/lib", via

  use lib "++GITWEBLIBDIR++";

"++GITWEBLIBDIR++" is set to appropriate value during build time
(generating gitweb.cgi).  This allows to select where to install
gitweb modules via 'gitweblibdir' build time configuration variable,
for example

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


Using __DIR__ from Dir::Self module (not in core, that's why currently
gitweb includes excerpt of code from Dir::Self defining __DIR__) was
chosen over using FindBin-based solution (in core since perl 5.00307,
while gitweb itself requires at least perl 5.8.0) because FindBin uses
BEGIN block, which is a problem under mod_perl and other persistent
Perl environments (thought there are workarounds).

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
 gitweb/gitweb.perl |   10 ++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

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
index 1025c2f..ea8ab56 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -10,6 +10,16 @@
 use 5.008;
 use strict;
 use warnings;
+
+use File::Spec;
+
+# __DIR__ is excerpt from Dir::Self
+sub __DIR__ () {
+	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
+}
+use lib __DIR__ . '/lib';
+use lib "++GITWEBLIBDIR++";
+
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
-- 
1.7.3
