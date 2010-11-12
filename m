From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.2 1/4] gitweb: Prepare for splitting gitweb
Date: Sat, 13 Nov 2010 00:41:22 +0100
Message-ID: <201011130041.22918.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <1288607092-31458-1-git-send-email-jnareb@gmail.com> <201011130035.50229.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 13 00:41:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH3FR-0004ph-4x
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 00:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757579Ab0KLXlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 18:41:32 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41308 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab0KLXlb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 18:41:31 -0500
Received: by bwz15 with SMTP id 15so3572453bwz.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 15:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SZ3X4uH9OItHmnypH5JWcu4ySFK9yAgs8v4oEp5gxZA=;
        b=KH926ePS2hCn77R0IekiHNq1hmQUr4Ka6TzN9Y6xDXs+cj5U2fihmfFeWE2MuRMG2w
         3WscWcTTMnQ6AN4x5xHIXz8zzqN7FZZXbZuuA9csS9uceKwgIevFhNL/LE8l814rfhel
         FLFK+zCUd4l2Ug+zvznzq8a/b8izNvELRw7IM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AQEB0ePxN9b+qOmCgmHiXXb33IUJbJM4gYvlaftrg/F97uJkY3g54MDEnOi4eMHpKv
         oy5K2u4tlmB9CHWkEsTKhQ8/9yyMygfd80sqZh5u9pfgt6qOQx3DwDkR6WdQjH+tgrxX
         4MjcAJ3Zjt+eulyeO1EV0vMuB39f4Bvko7SY4=
Received: by 10.204.80.97 with SMTP id s33mr3448809bkk.182.1289605289631;
        Fri, 12 Nov 2010 15:41:29 -0800 (PST)
Received: from [192.168.1.13] (abwe118.neoplus.adsl.tpnet.pl [83.8.228.118])
        by mx.google.com with ESMTPS id v25sm1775216bkt.18.2010.11.12.15.41.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 15:41:27 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201011130035.50229.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161369>

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
This version is rebased on top of 'next', which means that it takes
'jn/gitweb-test' into account, in particular 958a846 (gitweb/Makefile:
Add 'test' and 'test-installed' targets, 2010-09-26).

That means adding GITWEBLIBDIR for future testing of individual
modules (it was not present in v7.1).

 gitweb/Makefile    |   17 +++++++++++++++--
 gitweb/gitweb.perl |    8 ++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 0a6ac00..f9e32eb 100644
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
@@ -153,20 +154,32 @@ test:
 
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
+		$(INSTALL) -m 644 lib/$$mod '$(DESTDIR_SQ)$(gitweblibdir_SQ)/$$(dirname $$mod)'; \
+	done
+
 ### Cleaning rules
 
 clean:
 	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
 
-.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
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
