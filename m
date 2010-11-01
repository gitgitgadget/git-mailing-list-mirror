From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.1b 1/4] gitweb: Prepare for splitting gitweb
Date: Mon, 1 Nov 2010 20:50:10 +0200
Message-ID: <201011011950.18730.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <1288607092-31458-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 01 19:50:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCzT2-0007e6-SH
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 19:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab0KASui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 14:50:38 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41112 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab0KASuh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 14:50:37 -0400
Received: by bwz11 with SMTP id 11so4804826bwz.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qm+UxiiI57xZy8Sj3U2/vkfMC23+yYWiHVlAz9bN6cY=;
        b=Doiv4AK6s/SZ8uaHnWlX+yBD+ZtcNFHxIBckEgdOCudmpVhs5vA2WfAJUFe5FWCxz8
         mc5f9hT2r7Qh1fkzajoHXmRO4kQd5nuyZ4S6lhFdIY3DOJ5RPxMi2O3TurHGgcWv5drw
         cQso4ExKAKhHFuVyXuzhI8jizlZZ1MlkX5S8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HZ+xP6giad5cbs7i2dW3xiq7WeH5njbDacsTyHG5Ul7ZK1sQYBkOw49CCj5H1IESJV
         wJSCSVZt9AvvcmQ/QEwdfn035q0yTuzSCo3GP0VzBpidVt7zUWeUqmhjQsDtMrUfsXOF
         poZ+Xj8DjqJ+PzfICYESfMqfQxy8g9pQXx9Q0=
Received: by 10.204.121.131 with SMTP id h3mr6558285bkr.193.1288637435242;
        Mon, 01 Nov 2010 11:50:35 -0700 (PDT)
Received: from [192.168.1.13] (abvk31.neoplus.adsl.tpnet.pl [83.8.208.31])
        by mx.google.com with ESMTPS id v25sm1298606bkt.18.2010.11.01.11.50.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 11:50:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1288607092-31458-2-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160492>

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

While at it pass GITWEBLIBDIR in addition to GITWEB_TEST_INSTALLED
to test instaleed version of gitweb and installed version of modules
(for tests which check individual (sub)modules).


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
This version requires and applies cleanly on top of patch 958a846 
(gitweb/Makefile: Add 'test' and 'test-installed' targets, 2010-09-26)
in 'pu'.

 gitweb/Makefile    |   17 +++++++++++++++--
 gitweb/gitweb.perl |    8 ++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index df908a1..c2d72e4 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -56,6 +56,7 @@ PERL_PATH  ?= /usr/bin/perl
 bindir_SQ = $(subst ','\'',$(bindir))#'
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
 gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
+gitweblibdir_SQ = $(subst ','\'',$(gitwebdir)/lib)#'
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
 PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
 DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
@@ -151,20 +152,32 @@ test:
 
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
+		test -d '$(DESTDIR_SQ)$(gitweblibdir_SQ)/$$dir' || \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitweblibdir_SQ)/$$dir'; \
+	done
+	gitweb_modules="$(GITWEB_MODULES)" && \
+	for mod in $$gitweb_modules; do \
+		$(INSTALL) -m 644 lib/$$mod 
'$(DESTDIR_SQ)$(gitweblibdir_SQ)/$$(dirname $$mod)'; \
+	done
+
 ### Cleaning rules
 
 clean:
 	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css 
GITWEB-BUILD-OPTIONS
 
-.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE 
FORCE
+.PHONY: all clean install install-modules test 
test-installed .FORCE-GIT-VERSION-FILE FORCE
 
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
