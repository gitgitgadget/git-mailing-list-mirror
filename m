From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v7 4/9] gitweb: Prepare for splitting gitweb
Date: Thu, 23 Dec 2010 00:56:18 +0100
Message-ID: <20101222235618.7998.17447.stgit@localhost.localdomain>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 00:57:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYYH-0007VQ-GA
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426Ab0LVX4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 18:56:53 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59129 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab0LVX4w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 18:56:52 -0500
Received: by bwz15 with SMTP id 15so7007506bwz.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=yojOHWXyniuhDeOU4MsDE9wXkii7fMNGy5s/3NLdoSk=;
        b=JDBM+QRd5U7I6Ppi4PYUNn33EPLiWZCpWzvYaP0Xb8cdjv+lge2FgMVP/b2YNXjV8g
         S+H5JNClSp8T3i/BeJ7J3ensDWl30j5G3vEf843lUgHyOcB43HIA9CTkAzjqGv5krdoo
         omtxT5VjICqfqZyJUsGk6yOx2qjZtKpWAx4Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=HrWrjKfroQZCErevQ3Fsadv5kNhHp/bMqOX/XBuN1GbOZ+ReQ6kfWJPeb3W3jaRFab
         HVUFwFcmAyTJwxn45x2BItLY0UeWxd6p7ASw4Zvjr1095DBo4CmAPHNRZVwzD//QcYCl
         TLz+ilnBXnlt8BGN2AjCHQq9ju44WzeL8+iPM=
Received: by 10.204.75.142 with SMTP id y14mr6508711bkj.114.1293062210917;
        Wed, 22 Dec 2010 15:56:50 -0800 (PST)
Received: from localhost.localdomain (abvw91.neoplus.adsl.tpnet.pl [83.8.220.91])
        by mx.google.com with ESMTPS id b17sm5197201bku.8.2010.12.22.15.56.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 15:56:49 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBMNuI6A008137;
	Thu, 23 Dec 2010 00:56:28 +0100
In-Reply-To: <20101222234843.7998.87068.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164105>



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

 gitweb/Makefile    |   17 +++++++++++++++--
 gitweb/gitweb.perl |    8 ++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)


diff --git a/gitweb/Makefile b/gitweb/Makefile
index 0a6ac00..e6029e1 100644
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
index e50654b..880fdf2 100755
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
 use CGI::Carp qw(fatalsToBrowser);
