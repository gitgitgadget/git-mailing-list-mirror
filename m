From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Prepare for splitting gitweb
Date: Fri, 11 Jun 2010 12:25:59 +0200
Message-ID: <1276251959-7948-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 11 12:26:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON1RN-00077l-If
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 12:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab0FKK0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 06:26:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46832 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab0FKK0L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 06:26:11 -0400
Received: by fxm8 with SMTP id 8so534163fxm.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 03:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=RXxzeTyg36uQYFhpVe6eQAADGmIDxgZb2/ijHuU38qM=;
        b=lcQLzw1wMB9nJNjaNU4Co0UsSMpo6SZbcu1Y8J70DAVxuiF22H1Rnsks3q/80JqjOa
         pObKAH0kJs3IsBHDyN8o154CvNMpRiDRSUaXGLwiN2aL60sxabYZiGJ/sWFiq12YDYyv
         etKCQ+1s9/+6iMQBOrceRHQllKmx6H5Q025hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PovzG5b5XyjI59UrufcZ0gtYDkVJ6qTbb986047PDvmCTLbLza8U2I2JZELoz32s4L
         Lodrt2EYpXVfP0RmH+tkHMuJf7/fdZPQiOZdrz3cD8BLlZpuLzLcjC4uQcZ2fcP5aleV
         bcWtczZ9aCP/+nLy3lmnKKaF+pQSE+klbplVQ=
Received: by 10.103.122.19 with SMTP id z19mr438439mum.49.1276251969194;
        Fri, 11 Jun 2010 03:26:09 -0700 (PDT)
Received: from localhost.localdomain (abuz71.neoplus.adsl.tpnet.pl [83.8.197.71])
        by mx.google.com with ESMTPS id 25sm1410146mul.24.2010.06.11.03.26.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 03:26:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148936>

Prepare gitweb for having been split into modules that are to be
installed alongside gitweb in 'lib/' subdirectory, by adding

  use lib __DIR__.'/lib';

to gitweb.perl (to main gitweb script), and preparing for putting
modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is based on commit c0cb4ed (git-instaweb: Configure it to
work with new gitweb structure, 2010-05-28), which is top commit of
'ps/gitweb-soc' branch merged into next on 2010-06-03 (as commit
5db4adf).

It is an RFC patch adding infrastructure for splitting gitweb, or
adding new functionality to gitweb via gitweb modules, without adding
any gitweb module.

It is an RFC because:
1. I'm not sure if having such separate preparatory patch is good
   idea.  It would allow me to move gitweb output caching to proper
   modules, without waiting for gitweb splitting part of GSoC 2010
   project to stabilize.

2. I don't know if what I have written in gitweb/Makefile is portable
   enough.  In particular it uses $(sort WORDLIST), which is not used
   otherwise in git Makefiles.

3. Should there be information added to gitweb/INSTALL that one can
   put Perl modules in 'lib/' subdirectory?  This is why 'use lib ...'
   is moved earlier compared to original patch by Pavan..

 gitweb/Makefile    |    3 +++
 gitweb/gitweb.perl |    9 +++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index d2584fe..4694959 100644
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
@@ -150,6 +151,8 @@ install: all
 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
+	$(foreach dir,$(sort $(dir $(GITWEB_MODULES))),test -d '$(DESTDIR_SQ)$(gitwebdir_SQ)/$dir' || $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)/$dir')
+	$(foreach mod,$(GITWEB_MODULES),$(INSTALL) -m 644 $mod '$(DESTDIR_SQ)$(gitwebdir_SQ)/$mod')
 
 ### Cleaning rules
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 934aacb..023698f 100755
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
