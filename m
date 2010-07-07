From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Wed,  7 Jul 2010 11:57:56 +0200
Message-ID: <1278496676-26575-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 11:58:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWROU-0004Cm-80
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 11:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab0GGJ6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 05:58:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65095 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab0GGJ6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 05:58:07 -0400
Received: by fxm14 with SMTP id 14so5414771fxm.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 02:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=mYj7/Rx0v3I3wKxmgCCqo84hjDS2J8qYwUboW9+Tn6U=;
        b=ikZZvMT/OI4FAqxJVPkjdCBG3pM14Q/e+OxJYiRFegeSWyBlmMWFgvlsaT26/EQv3Q
         9FPuKqw1KNrFNNlouUupDNyKYdQnVHlVAl4BMUwbI6xNkOYf6P1ZYIVISvntHF0Toagv
         42Hl/Im38FBLu6P1RqBmaWK+HwAy8EJkTP3uU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DxsnQ2kxUZ9Oby9s+cyKB/4lP3QhaqPuWfq3RDt4B8DJ+4jJkmlKMzcg04LffEw8T5
         dgFKXa52TvA5M4Kp5ZAHFQ4J6c2XRVdec6NPMr09iCUYU/cMJ7XHRm0B53VtB1byabsW
         1s80Kg4Ek/rCz9erh6oIEICmJAla4bP836CkU=
Received: by 10.223.121.4 with SMTP id f4mr5409391far.1.1278496685917;
        Wed, 07 Jul 2010 02:58:05 -0700 (PDT)
Received: from localhost.localdomain (abvr9.neoplus.adsl.tpnet.pl [83.8.215.9])
        by mx.google.com with ESMTPS id h3sm14120342faj.44.2010.07.07.02.58.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 02:58:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150463>

Prepare gitweb for having been split into modules that are to be
installed alongside gitweb in 'lib/' subdirectory, by adding

  use lib __DIR__.'/lib';

to gitweb.perl (to main gitweb script), and preparing for putting
modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

This version uses shell 'for' loop, instead of make's $(foreach)
function, to avoid possible problem with generating a command line
that exceeded the maximum argument list length.  This solution has
also advantage of being more readable than original $(foreach ...)
version, with its overly long lines.

This idea is based on discussion surrounding Brandon Casey's patch.
In particular Bruce Stephens's suggestion was implemented to solve
issue of empty $(GITWEB_MODULES) variable (which is in this patch),
as implemented in
  [PATCH 2/2 v2] Makefile: work around ksh's failure to handle missing list argument to for loop
  http://thread.gmane.org/gmane.comp.version-control.git/147796/focus=150413

This version also moves installing modules to separate install-modules
target, as compared to previous version.

It also contains improvement from Pavan Kumar Sunkara, namely that
target is a directory, rather than destibation filename.  This might
be not necessary (and not much of an improvement).

 gitweb/Makefile    |   14 +++++++++++++-
 gitweb/gitweb.perl |    9 +++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 2fb7c2d..84a1d71 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -55,6 +55,7 @@ PERL_PATH  ?= /usr/bin/perl
 bindir_SQ = $(subst ','\'',$(bindir))#'
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
 gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
+gitweblibdir_SQ = $(subst ','\'',$(gitwebdir)/lib)#'
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
 PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
 DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
@@ -145,12 +146,23 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
 
 ### Installation rules
 
-install: all
+install: all install-modules
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 
+install-modules:
+	install_dirs=$(sort $(dir $(GITWEB_MODULES))) && \
+	for dir in $$install_dirs; do \
+		test -d '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$dir' || \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$dir'; \
+	done
+	gitweb_modules=$(GITWEB_MODULES) && \
+	for mod in $$gitweb_modules; do \
+		$(INSTALL) -m 644 $$mod '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$(dirname $$mod)'; \
+	done
+
 ### Cleaning rules
 
 clean:
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1f611d2..bf1485c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -9,6 +9,14 @@
 
 use strict;
 use warnings;
+
+use File::Spec;
+# __DIR__ is taken from Dir::Self __DIR__ fragment
+sub __DIR__ () {
+	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
+}
+use lib __DIR__ . '/lib';
+
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
@@ -16,6 +24,7 @@ use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
+
 binmode STDOUT, ':utf8';
 
 our $t0;
-- 
1.7.0.1
