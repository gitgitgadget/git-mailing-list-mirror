From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.1 1/4] gitweb: Prepare for splitting gitweb
Date: Mon,  1 Nov 2010 11:24:49 +0100
Message-ID: <1288607092-31458-2-git-send-email-jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 01 11:25:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCrZx-0005lL-E3
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 11:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757127Ab0KAKZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 06:25:19 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44181 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab0KAKZP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 06:25:15 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so3125206ewy.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DVqB/BKHKvAEgGBePEooIsgRIhgm/rqBSB+stRaUJxs=;
        b=DSXwlxCBduYMuIXWAeiNJqigUj1oerSsN8HKTqGVAVWmbJTh6vLUbIBELU1oRPQK+m
         hSN6oo1d4DbLOEpqlRz9/D0efMAByXiRGbWDopLH8ifzTNE8g624GRQ9I4bjfJkRJsgJ
         j9N7XLnUfE7i44FkbjRQenWP3OU+lglWMAKmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ME+P/bYsIDEl+KiSyAPebwgLP9eifwbTk3J9GCT+vZ8OVXPBj0oLxISbEQJU1tmXH3
         pcRYLLtRrIsEW25jWtNWNAYfP2j33bw4rYf6AshqTXSYniDA/ys14T1BdrLGiO9H1x9S
         EWFUURYcpBlhckHoIFkQHdCCjdWObm4wUsXZw=
Received: by 10.213.33.206 with SMTP id i14mr2026063ebd.89.1288607115129;
        Mon, 01 Nov 2010 03:25:15 -0700 (PDT)
Received: from roke.localdomain (abvk31.neoplus.adsl.tpnet.pl [83.8.208.31])
        by mx.google.com with ESMTPS id x54sm4069255eeh.11.2010.11.01.03.25.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 03:25:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <201010311021.55917.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160474>

Prepare gitweb for having been split into modules that are to be
installed alongside gitweb in 'lib/' subdirectory, by adding

  use lib __DIR__.'/lib';

to gitweb.perl (to main gitweb script), and preparing for putting
modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.

This preparatory work allows to add new module to gitweb by simply
adding

  GITWEB_MODULES += <module>

to gitweb/Makefile (assuming that the module is in 'gitweb/lib/'
directory).

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
This patch would conflict with the patch 958a846 (gitweb/Makefile: Add
'test' and 'test-installed' targets, 2010-09-26), which is in 'pu'.
Resolving those conflicts is easy, though non-trivial.

Please tell me if I should send this series rebased on top of 
'jn/gitweb-test' (which includes 958a846) instead.

This patch introduces infrastructure which would be required later for
splitting gitweb.

 gitweb/Makefile    |   17 ++++++++++++++---
 gitweb/gitweb.perl |    8 ++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 2fb7c2d..6fa7625 100644
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
@@ -145,16 +146,26 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
 
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
+		test -d '$(DESTDIR_SQ)$(gitweblibdir_SQ)/$$dir' || \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitweblibdir_SQ)/$$dir'; \
+	done
+	gitweb_modules="$(GITWEB_MODULES)" && \
+	for mod in $$gitweb_modules; do \
+		$(INSTALL) -m 644 lib/$$mod '$(DESTDIR_SQ)$(gitweblibdir_SQ)/$$(dirname $$mod)'; \
+	done
+
 ### Cleaning rules
 
 clean:
 	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
 
-.PHONY: all clean install .FORCE-GIT-VERSION-FILE FORCE
-
+.PHONY: all clean install install-modules .FORCE-GIT-VERSION-FILE FORCE
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d521b4c..e4c08ba 100755
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
-- 
1.7.3
