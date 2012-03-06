From: Jakub Narebski <jnareb@gmail.com>
Subject: =?UTF-8?q?=5BRFC/PATCHv3=201/2=5D=20gitweb=3A=20Prepare=20for=20splitting=20gitweb?=
Date: Tue,  6 Mar 2012 23:41:41 +0100
Message-ID: <1331073702-9071-2-git-send-email-jnareb@gmail.com>
References: <1331073702-9071-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 23:42:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S534z-0007Up-Pp
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 23:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759339Ab2CFWl4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 17:41:56 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52136 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759081Ab2CFWlz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 17:41:55 -0500
Received: by mail-ey0-f174.google.com with SMTP id q12so2014017eaa.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 14:41:55 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.100.142 as permitted sender) client-ip=10.14.100.142;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.100.142 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.100.142])
        by 10.14.100.142 with SMTP id z14mr14548789eef.58.1331073715327 (num_hops = 1);
        Tue, 06 Mar 2012 14:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vXa5B78DQvEmpITIwdxtC9FEjcpRoVFOnud6a9Ra6RE=;
        b=QCPmCtMZhfo61M0DoQfHA2a0K9NYSybfWYL0KTRC5aOBs03x+K9V7i6n73wSpoZNjG
         bb0CPBwB5u0yN3GX4UxeUdNNUjhzOdpmOY+EDAi2Zc1BJG0+TArU/9+X1rekxtIjtXYv
         sliJU5dfhBmyrUSGDHnTN2eQvRBxANs4C15U0RZYyeAoMJf5J9BoN/NKEd/iJQpPPOvE
         mfeWeSFzcbh/jlRNca0KbaaUfaAM/L/FYRRmY0K/2SXD5Xv6XJqGJFilCMcebqTg/1LA
         VuUTtHSlrL1RWDKwWdcAgo4weaOAED5JoZ05GvEUtTesF/fewmng8vpJ8gqfj42zuZ4K
         77ng==
Received: by 10.14.100.142 with SMTP id z14mr11041128eef.58.1331073715264;
        Tue, 06 Mar 2012 14:41:55 -0800 (PST)
Received: from localhost.localdomain (abwo250.neoplus.adsl.tpnet.pl. [83.8.238.250])
        by mx.google.com with ESMTPS id o49sm79596627eeb.7.2012.03.06.14.41.52
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 14:41:53 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1331073702-9071-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192409>

Prepare gitweb for being split into modules that would be installed
in gitweblibdir, by default alongside gitweb in 'lib/' subdirectory.

Gitweb would search first in 'lib/' subdirectory from where it is
installed, via

  use lib __DIR__.'/lib';

(This allow for tests to work with source version of gitweb without
changes.)  Then it searches in $(gitweblibdir) directory (set during
build time), by default "$(gitwebdir)/lib", via

  use lib "++GITWEBLIBDIR++";

which is set to requested dir during building of gitweb.cgi.  Note
that 'use lib' assures no trailing duplicate entries in @INC.


This preparatory work allows to add new module to gitweb by simply
adding

  GITWEB_MODULES +=3D <module>

to gitweb/Makefile (assuming that the module is in 'gitweb/lib/'
directory).


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


While at it pass GITWEBLIBDIR environment variable in addition to
GITWEB_TEST_INSTALLED down to $(MAKE) invocation in 'test-installed'
target.  This is to allow testing installed version of gitweb and
installed version of modules, for future tests which would check
individual gitweb (sub)modules.

Helped-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Helped-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes to v2:
* Lost update to gitweb/INSTALL about possibility of installing
  optional Perl modules for gitweb in 'lib/', alongside future
  gitweb modules.

 gitweb/Makefile    |   20 ++++++++++++++++++--
 gitweb/gitweb.perl |   11 +++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index cd194d0..5f0a785 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -13,6 +13,7 @@ all::
 prefix ?=3D $(HOME)
 bindir ?=3D $(prefix)/bin
 gitwebdir ?=3D /var/www/cgi-bin
+gitweblibdir ?=3D $(gitwebdir)/lib
=20
 RM ?=3D rm -f
 INSTALL ?=3D install
@@ -59,6 +60,7 @@ PERL_PATH  ?=3D /usr/bin/perl
 bindir_SQ =3D $(subst ','\'',$(bindir))#'
 gitwebdir_SQ =3D $(subst ','\'',$(gitwebdir))#'
 gitwebstaticdir_SQ =3D $(subst ','\'',$(gitwebdir)/static)#'
+gitweblibdir_SQ =3D $(subst ','\'',$(gitweblibdir))#'
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))#'
 PERL_PATH_SQ  =3D $(subst ','\'',$(PERL_PATH))#'
 DESTDIR_SQ    =3D $(subst ','\'',$(DESTDIR))#'
@@ -129,6 +131,7 @@ GITWEB_JSLIB_FILES +=3D static/js/blame_incremental=
=2Ejs
 GITWEB_REPLACE =3D \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
+	-e 's|++GITWEBLIBDIR++|$(gitweblibdir)|g' \
 	-e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
 	-e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
 	-e 's|++GITWEB_CONFIG_COMMON++|$(GITWEB_CONFIG_COMMON)|g' \
@@ -174,16 +177,29 @@ test:
=20
 test-installed:
 	GITWEB_TEST_INSTALLED=3D'$(DESTDIR_SQ)$(gitwebdir_SQ)' \
+	GITWEBLIBDIR=3D'$(DESTDIR_SQ)$(gitweblibdir_SQ)' \
 		$(MAKE) -C ../t gitweb-test
=20
 ### Installation rules
=20
-install: all
+install: all install-modules
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)=
'
=20
+install-modules:
+	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)/li=
b'
+	install_dirs=3D"$(sort $(dir $(GITWEB_MODULES)))" && \
+	for dir in $$install_dirs; do \
+		test -d '$(DESTDIR_SQ)$(gitweblibdir_SQ)'/"$$dir" || \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitweblibdir_SQ)'/"$$dir"; \
+	done
+	gitweb_modules=3D"$(GITWEB_MODULES)" && \
+	for mod in $$gitweb_modules; do \
+		$(INSTALL) -m 644 "lib/$$mod" '$(DESTDIR_SQ)$(gitweblibdir_SQ)'/"$$(=
dirname $$mod)"; \
+	done
+
 ### Cleaning rules
=20
 clean:
@@ -191,5 +207,5 @@ clean:
 		static/gitweb.min.js static/gitweb.min.css \
 		GITWEB-BUILD-OPTIONS
=20
-.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE =
=46ORCE
+.PHONY: all clean install install-modules test test-installed .FORCE-G=
IT-VERSION-FILE FORCE
=20
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e2e6a73..5902212 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -10,6 +10,17 @@
 use 5.008;
 use strict;
 use warnings;
+
+use File::Spec;
+
+# __DIR__ is excerpt from Dir::Self
+sub __DIR__ () {
+	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1])=
;
+}
+use lib "++GITWEBLIBDIR++";
+use lib __DIR__ . '/lib';
+
+
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
--=20
1.7.9
