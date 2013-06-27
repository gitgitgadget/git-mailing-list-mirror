From: benoit.person@ensimag.fr
Subject: [PATCH v6 1/5] git-remote-mediawiki: Introduction of Git::Mediawiki.pm
Date: Thu, 27 Jun 2013 19:37:28 +0200
Message-ID: <1372354652-4147-2-git-send-email-benoit.person@ensimag.fr>
References: <1372354652-4147-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 27 19:37:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsG8n-0007A7-Pw
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 19:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab3F0Rht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 13:37:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37290 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227Ab3F0Rhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 13:37:48 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5RHbfdq004146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Jun 2013 19:37:41 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5RHbhOq013093;
	Thu, 27 Jun 2013 19:37:43 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5RHbgW1007347;
	Thu, 27 Jun 2013 19:37:43 +0200
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1372354652-4147-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 27 Jun 2013 19:37:41 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229127>

From: Benoit Person <benoit.person@ensimag.fr>

Currently, the mw-to-git project contains only a remote helper
(git-remote-mediawiki.perl). To improve the user experience while
working with mediawiki remotes, new tools, designed for such cases,
should be created. To achieve this goal, the project needs a way to
share code between several scripts (remote helper, commands, ... ).

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
1.8.3.GIT
