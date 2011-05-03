From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 1/2 (RFC?)] gitweb: Prepare for splitting gitweb
Date: Tue,  3 May 2011 16:04:09 +0200
Message-ID: <1304431450-23901-2-git-send-email-jnareb@gmail.com>
References: <1304431450-23901-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	"Alejandro R. Sedeno" <asedeno@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 16:04:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHGDa-000530-Uh
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 16:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab1ECOEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 10:04:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39533 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab1ECOEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 10:04:39 -0400
Received: by wwa36 with SMTP id 36so115819wwa.1
        for <git@vger.kernel.org>; Tue, 03 May 2011 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=aUUtZkz2c2J42jYDZW4W1KfPZiS5HfCQk8Ck+Z5df6U=;
        b=GbO+gn5E3u7PLGl9WVVWN29E56OoNebKBcIzKbXXLyt8cabONgCM13+Qln6IbjgYei
         dkDWGvwgoKmNgJ5wCjtcwUBSiViGn5V4Pa85r5S1TUVqPoiI1SxDWxPXAhJspKJtuDBJ
         CNiebZdbPnbAtCZZjSU2kdc1GM+gu8USZxnNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=l0IpHSxatrhG5kjc1HaEIkHfPNFzci4GJlZvi8grxOCrOfQOXsOBaGAaJcW2et4d1q
         oUR1g7csCOChXvtfbjDgfm5AhJajRLaF0exdlqXA1jTDn6W6ueZd3ALIwUxDI4DuyCHL
         btRraumMqKIbCgQ3UnoSQe5rbb65U/IiudoUc=
Received: by 10.216.240.3 with SMTP id d3mr3768035wer.51.1304431477728;
        Tue, 03 May 2011 07:04:37 -0700 (PDT)
Received: from roke.localdomain (abvt77.neoplus.adsl.tpnet.pl [83.8.217.77])
        by mx.google.com with ESMTPS id ed10sm78669wbb.32.2011.05.03.07.04.34
        (version=SSLv3 cipher=OTHER);
        Tue, 03 May 2011 07:04:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1304431450-23901-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172660>

Prepare gitweb for being split into modules that would be installed in
$(gitweblibdir), by default alongside gitweb in 'lib/' subdirectory.

Gitweb would search first in 'lib/' subdirectory from where gitweb.cgi
is installed, via

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

Helped-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Helped-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
This patch is closest to

  [PATCH (version C) 1/2] gitweb: Prepare for splitting gitweb
  http://thread.gmane.org/gmane.comp.version-control.git/165824/focus=3D=
165826

from previous (v1) version of this series.

  Advantages:
  - can run source version of gitweb (gitweb/gitweb.perl) as a script s=
imply
  - supports relocating gitweb modules (to gitweblibdir)
  - allow users to simply install extra modules by hand alongside gitwe=
b

  Disadvantages:
  - most complicated code of all cases

In this version modules from __DIR__."/lib", i.e. installed alongside
gitweb.cgi take preference over common modules installed in
"++GITWEBLIBDIR++", as suggested / requested by Alejandro:

  http://thread.gmane.org/gmane.comp.version-control.git/165824/focus=3D=
165926 =20


This patch is marked as possible RFC because I am not sure if
"$(gitwebdir)/lib" directory to install modules alongside gitweb.cgi
should be created unconditionally; it might be empty if
$(gitweblibdir) is changed from its default version.

This version also include update to gitweb/INSTALL.


Side-note: I have thought about adding sanity check for empty
"++GITWEBLIBDIR++" in the form of

  use if "++GITWEBLIBDIR++", lib =3D> "++GITWEBLIBDIR++";

or

  use lib "++GITWEBLIBDIR++" || '.';

But because default value of "++GITWEBLIBDIR++" is never empty, I
don't think it is worth complicating code protecting against unlikely
user error; Perl would give the following warning:

  Empty compile time value given to use lib

 gitweb/INSTALL     |    7 +++++++
 gitweb/Makefile    |   20 ++++++++++++++++++--
 gitweb/gitweb.perl |   11 +++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 4964a67..7af343a 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -243,6 +243,13 @@ The following optional Perl modules are required f=
or extra features
  - HTML::TagCloud - for fancy tag cloud in project list view
  - HTTP::Date or Time::ParseDate - to support If-Modified-Since for fe=
eds
=20
+Those modules can be installed, in order of search, alongside
+gitweb.cgi in 'lib/' subdirectory, in '$(gitweblibdir)' directory
+(given during build), or in one of directories in which Perl looks for
+library files (PERL5LIB, PERLLIB, standard places, current directory,
+etc.).  Note that the first two places are by default the same
+directory; "$(gitweblibdir)" is "$(gitwebdir)/lib".
+
=20
 Example web server configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 0a6ac00..b353d15 100644
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
@@ -57,6 +58,7 @@ PERL_PATH  ?=3D /usr/bin/perl
 bindir_SQ =3D $(subst ','\'',$(bindir))#'
 gitwebdir_SQ =3D $(subst ','\'',$(gitwebdir))#'
 gitwebstaticdir_SQ =3D $(subst ','\'',$(gitwebdir)/static)#'
+gitweblibdir_SQ =3D $(subst ','\'',$(gitweblibdir))#'
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))#'
 PERL_PATH_SQ  =3D $(subst ','\'',$(PERL_PATH))#'
 DESTDIR_SQ    =3D $(subst ','\'',$(DESTDIR))#'
@@ -115,6 +117,7 @@ GITWEB_FILES +=3D static/git-logo.png static/git-fa=
vicon.png
 GITWEB_REPLACE =3D \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
+	-e 's|++GITWEBLIBDIR++|$(gitweblibdir)|g' \
 	-e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
 	-e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
 	-e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
@@ -153,20 +156,33 @@ test:
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
 	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BU=
ILD-OPTIONS
=20
-.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE =
=46ORCE
+.PHONY: all clean install install-modules test test-installed .FORCE-G=
IT-VERSION-FILE FORCE
=20
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ee69ea6..f094471 100755
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
1.7.3
