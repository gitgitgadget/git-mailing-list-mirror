From: benoit.person@ensimag.fr
Subject: [PATCH V3 3/4] git-mw: Adding git-mw command
Date: Sun, 16 Jun 2013 04:31:32 +0200
Message-ID: <1371349893-7789-4-git-send-email-benoit.person@ensimag.fr>
References: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 04:32:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo2lk-0007eC-1T
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 04:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab3FPCcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 22:32:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48204 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836Ab3FPCcS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 22:32:18 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5G2WHuV015988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Jun 2013 04:32:17 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5G2WHpJ013557;
	Sun, 16 Jun 2013 04:32:17 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5G2W1eL020162;
	Sun, 16 Jun 2013 04:32:16 +0200
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 16 Jun 2013 04:32:17 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227984>

From: Benoit Person <benoit.person@ensimag.fr>

Add the new git-mw command, with its 'help' subcommand as an example. Argument
parsing and subcommand choice is based on git-svn.perl.
Update Makefile to build, install and clean both scripts now (git-mw.perl and
git-remote-mediawiki.perl).

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

---

changes from V2:
  - Perlcritic changes: 
    - Update for loops style to a more perlish one.
    - All 'print's specify their output streams.

 contrib/mw-to-git/Makefile    |  7 ++++---
 contrib/mw-to-git/git-mw.perl | 46 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 3 deletions(-)
 create mode 100644 contrib/mw-to-git/git-mw.perl

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index b0c7cf2..fe02c7e 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -6,6 +6,7 @@
 
 GIT_MEDIAWIKI_PM=GitMediawiki.pm
 SCRIPT_PERL=git-remote-mediawiki.perl
+SCRIPT_PERL+=git-mw.perl
 GIT_ROOT_DIR=../..
 HERE=contrib/mw-to-git/
 
@@ -22,15 +23,15 @@ install_pm:
 	cp $(GIT_MEDIAWIKI_PM) $(INSTLIBDIR)
 
 build: copy_pm
-	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL="$(SCRIPT_PERL_FULL)" \
                 build-perl-script
 
 install: install_pm
-	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL="$(SCRIPT_PERL_FULL)" \
                 install-perl-script
 
 clean:
-	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL="$(SCRIPT_PERL_FULL)" \
                 clean-perl-script
 	rm $(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM) \
        $(GIT_ROOT_DIR)/perl/blib/lib/$(GIT_MEDIAWIKI_PM)
diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.perl
new file mode 100644
index 0000000..320c00e
--- /dev/null
+++ b/contrib/mw-to-git/git-mw.perl
@@ -0,0 +1,46 @@
+#!/usr/bin/perl
+
+# Copyright (C) 2013
+#     Benoit Person <benoit.person@ensimag.imag.fr>
+#     Celestin Matte <celestin.matte@ensimag.imag.fr>
+# License: GPL v2 or later
+
+# Set of tools for git repo with a mediawiki remote.
+# Documentation & bugtracker: https://github.com/moy/Git-Mediawiki/
+
+use strict;
+use warnings;
+
+use Getopt::Long;
+
+my %commands = (
+	'help' =>
+		[\&help, {}, \&help]
+);
+
+# Search for sub-command
+my $cmd = $commands{'help'};
+for (0..@ARGV) {
+	if (defined $commands{$ARGV[$_]}) {
+		$cmd = $commands{$ARGV[$_]};
+		splice @ARGV, $_, 1;
+		last;
+	}
+};
+GetOptions( %{$cmd->[1]},
+	'help|h' => \&{$cmd->[2]});
+
+# Launch command
+&{$cmd->[0]};
+
+############################## Help Functions ##################################
+
+sub help {
+	print {*STDOUT} <<'END';
+usage: git mw <command> <args>
+
+git mw commands are:
+    help        Display help information about git mw
+END
+	exit;
+}
\ No newline at end of file
-- 
1.8.3.GIT
