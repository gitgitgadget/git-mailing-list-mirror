From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 02/17] gitweb: Prepare for splitting gitweb
Date: Thu,  7 Oct 2010 00:01:47 +0200
Message-ID: <1286402526-13143-3-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:02:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c4M-0001X4-VR
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989Ab0JFWCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:02:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53578 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab0JFWCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:02:31 -0400
Received: by bwz11 with SMTP id 11so49472bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vf21we2R0wQqSjM12Or0mAAdj7EOTmv3rTtlrh02sJQ=;
        b=cRhgoe7fReXqfGE/njIcSzcvn4iJjputfUhan/E0i+/6gJLhR28sk05oyZDNixclXe
         lUzr5lMeNHQmuz23IHJ1y0TQDakFqvXa8CG0OD0e7BW9rN83n5qvRMrLkEdpRtUP9W6k
         6TDMItRkn3VUdkBENEG8+x1bkCUGFYa8+ckBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZGr1ocUv5+KJJ71CahMPMHyFPYJfPFirJqS1kKk/zhZvVkwK29uOQAtZKusR9ay3HE
         KGwAA44DHqAc4p5BuCfqJHdUxqxr7kWw5WmE8ZBMZfT33IIcF82wQOhemrMNos9PavoU
         fWwC8Hh8/+ubhGp+z7pvWoDFJZjyb3Bkcs+fU=
Received: by 10.204.126.92 with SMTP id b28mr10323662bks.47.1286402549662;
        Wed, 06 Oct 2010 15:02:29 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158311>

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
This patch can serve as a way to introduce infrastructure required for
splitting gitweb into modules for better maintability.  This issue was
to be first part (first milestone) for "Integrated web client for git"
GSoC2010 project by Pavan Kumar Sankara (with Christian Couder as
mentor, and Petr 'Pasky' Baudis as co-mentor)... which unfortunately
failed middterm evaluations.

As you can see later in series it makes it very easy to add new gitweb
modules which are to be installed.  Just add

  GITWEB_MODULES += Module/Foo.pm

to gitweb/Makefile for Module::Foo (present in gitweb/lib/Module/Foo.pm)
and 'install-gitweb' target would automatically install it along with
gitweb.

Differences from v4:
* The 'install-modules' target in gitweb/Makefile uses shell 'for' loop,
  instead of make's $(foreach) function; see commit message

* Modules in GITWEB_MODULES would not include the 'lib/' prefix, so
  for module in gitweb/lib/Module/Foo.pm it would be
    GITWEB_MODULES += Module/Foo.pm
  and not
    GITWEB_MODULES += lib/Module/Foo.pm

* Installing modules is left for separate 'install-modules' target,
  which is prerequisite for 'install' target

* Includes hunk about 'test-installed' target, making it possible to
  test installed modules and not only installed gitweb.

* 'install' and 'install-modules' targets are marked as .PHONY

* Does not contain spurious vertical whitespace change (adding empty
  line before 'binmode' invocation).

* Commit message is much longer and more detailed.


Differences from relevant parts of J.H. patch (probably apply also to
the gitweb version running git.kernel.org):
* It uses standard Perl way of naming and installing modules; the main
  caching module is named GitwebCache::CacheOutput and it is in the
  gitweb/lib/GitwebCache/CacheOutput.pm and is loaded using 'require'
  and found thanks to 'use lib', rather than being in gitweb/cache.pm
  and loaded using "do 'cache.pm'", and found by path.

  This has the advantage of automatically detecting errors in the
  caching module.  (Note that this patch series up to and including v2
  also used 'do $cache_pm', but implemented error handling, while v3
  used 'require $cache_pm' i.e. also finding cache module by path.)

* Instead of one 'cache.pm' file, there are separate Perl modules for
  handling different parts of work: file-based cache, capturing gitweb
  output, and caching captured output are all in separate modules.

  The code of those modules are made generic and disentangled from
  gitweb.perl code, which makes it possible to test those modules in
  isolation.

* 'make install-gitweb' is newer than original patch by J.H.; this
  patch series makes it possible to install gitweb, its dependencies
  (static files) _and modules_, using this one simple command.

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
+		$(INSTALL) -m 644 lib/$$mod '$(DESTDIR_SQ)$(gitweblibdir_SQ)/$$(dirname $$mod)'; \
+	done
+
 ### Cleaning rules
 
 clean:
 	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
 
-.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
+.PHONY: all clean install install-modules test test-installed .FORCE-GIT-VERSION-FILE FORCE
 
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
