From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.3 1/4 (bugfix)] gitweb: Prepare for splitting gitweb
Date: Thu, 2 Dec 2010 11:17:14 +0100
Message-ID: <201012021117.16183.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <201011130035.50229.jnareb@gmail.com> <201011130041.22918.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 11:17:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO6EN-0003Op-0B
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 11:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156Ab0LBKRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 05:17:32 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48564 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab0LBKRb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 05:17:31 -0500
Received: by bwz15 with SMTP id 15so7074730bwz.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 02:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=V4wA3RDzzvP3PdFf8Y6iOHnTg+bMKWj98HJv5UAzAIE=;
        b=ZEukrvfekpgKJ9GC1Bt0w7Il0WO8RoCBQkqeUCzVLhPnK5XlZxi6+vznMmPZbrMLTh
         Cvv+Bxc06Tf/DmLoLt063c6COsfbo3S91HzID02RXa4h7ZiwkBiwGehBRlGlACcI/0d6
         pXEgtrdjCMiENBoM4ARTT0CLbyYFpyp4X0Yhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Bs5atn1xRLzLDoemQeX8PBrg0h8WItbAvi2oht4hNb2yVDr/6tE5zwguSELbzKRNne
         WJ41tGt0i3iTHdDJUzy1KQqu4RTZH8zneXfB6n98p3gkNXYvWjQzVGTEJmtgJVwSt8/j
         /5LY3XjQ5E8nhPf0HyCcStvzjhG9PUGkVQjqU=
Received: by 10.204.57.10 with SMTP id a10mr311965bkh.66.1291285049901;
        Thu, 02 Dec 2010 02:17:29 -0800 (PST)
Received: from [192.168.1.13] (abwq166.neoplus.adsl.tpnet.pl [83.8.240.166])
        by mx.google.com with ESMTPS id p34sm168945bkf.3.2010.12.02.02.17.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 02:17:25 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201011130041.22918.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162690>

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
BUGFIX: shell variables should not be in single quotes

I am very sorry about this bug...

 gitweb/Makefile    |   18 +++++++++++++++---
 gitweb/gitweb.perl |    8 ++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 0a6ac00..ad5a282 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -57,6 +57,7 @@ PERL_PATH  ?= /usr/bin/perl
 bindir_SQ = $(subst ','\'',$(bindir))#'
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
 gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
+gitweblibdir_SQ = $(subst ','\'',$(gitwebdir)/lib)#'
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
 PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
 DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
@@ -153,20 +154,31 @@ test:
 
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
-
+.PHONY: all clean install install-modules test test-installed .FORCE-GIT-VERSION-FILE FORCE
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 679f2da..cfa511c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -10,6 +10,14 @@
 use 5.008;
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
