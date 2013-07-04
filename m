From: benoit.person@ensimag.fr
Subject: [PATCH v8 1/7] git-remote-mediawiki: Introduction of Git::Mediawiki.pm
Date: Thu,  4 Jul 2013 22:38:54 +0200
Message-ID: <1372970340-6545-2-git-send-email-benoit.person@ensimag.fr>
References: <1372970340-6545-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 22:39:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuqJQ-0007WI-MO
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 22:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933210Ab3GDUja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 16:39:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43248 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933036Ab3GDUjW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 16:39:22 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r64Kd5AO011139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Jul 2013 22:39:05 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r64Kd866020591;
	Thu, 4 Jul 2013 22:39:08 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r64Kd3if025632;
	Thu, 4 Jul 2013 22:39:07 +0200
X-Mailer: git-send-email 1.8.3.1.590.gc07d91b
In-Reply-To: <1372970340-6545-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 04 Jul 2013 22:39:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r64Kd5AO011139
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: benoit.person@ensimag.fr
MailScanner-NULL-Check: 1373575150.08251@HdhnCsHPjvJpGgIVpvGZQA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229616>

From: Benoit Person <benoit.person@ensimag.fr>

We would want to allow the user to preview what he has edited locally
before pushing it out (and thus creating a non-removable revision in
the mediawiki's history).

This patch introduces a new perl package in which we will be able to
share code between that new tool and the remote helper:
git-remote-mediawiki.perl.

A perl package offers the best way to handle such case: Each script
can select what should be imported in its namespace.  The package
namespacing limits the use of side effects in the shared code.

An alternate solution is to concatenate a "toolset" file with each
*.perl when 'make'-ing the project. In that scheme, everything is
imported in the script's namespace. Plus, files should be renamed in
order to chain to Git's toplevel makefile. Hence, this solution is not
acceptable.

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/Git/Mediawiki.pm | 24 ++++++++++++++++++++++++
 contrib/mw-to-git/Makefile         | 24 +++++++++++++++++++++---
 2 files changed, 45 insertions(+), 3 deletions(-)
 create mode 100644 contrib/mw-to-git/Git/Mediawiki.pm

diff --git a/contrib/mw-to-git/Git/Mediawiki.pm b/contrib/mw-to-git/Git/Mediawiki.pm
new file mode 100644
index 0000000..805f42a
--- /dev/null
+++ b/contrib/mw-to-git/Git/Mediawiki.pm
@@ -0,0 +1,24 @@
+package Git::Mediawiki;
+
+use 5.008;
+use strict;
+use Git;
+
+BEGIN {
+
+our ($VERSION, @ISA, @EXPORT, @EXPORT_OK);
+
+# Totally unstable API.
+$VERSION = '0.01';
+
+require Exporter;
+
+@ISA = qw(Exporter);
+
+@EXPORT = ();
+
+# Methods which can be called as standalone functions as well:
+@EXPORT_OK = ();
+}
+
+1; # Famous last words
diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index 1fb2424..a6f8b24 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -2,18 +2,36 @@
 # Copyright (C) 2013
 #     Matthieu Moy <Matthieu.Moy@imag.fr>
 #
-## Build git-remote-mediawiki
+# To install, run Git's toplevel 'make install' then run:
+#
+#   make install
 
+GIT_MEDIAWIKI_PM=Git/Mediawiki.pm
 SCRIPT_PERL=git-remote-mediawiki.perl
 GIT_ROOT_DIR=../..
 HERE=contrib/mw-to-git/
 
 SCRIPT_PERL_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
+INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/perl \
+                -s --no-print-directory instlibdir)
 
 all: build
 
-build install clean:
+install_pm:
+	install $(GIT_MEDIAWIKI_PM) $(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
+
+build:
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
+                build-perl-script
+
+install: install_pm
 	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
-                $@-perl-script
+                install-perl-script
+
+clean:
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
+                clean-perl-script
+	rm $(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
+
 perlcritic:
 	perlcritic -2 *.perl
-- 
1.8.3.1.590.gc07d91b
