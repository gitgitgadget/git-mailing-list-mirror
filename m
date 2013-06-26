From: benoit.person@ensimag.fr
Subject: [PATCH v5 4/5] git-remote-mediawiki: Adding git-mw command
Date: Wed, 26 Jun 2013 21:12:49 +0200
Message-ID: <1372273970-9084-5-git-send-email-benoit.person@ensimag.fr>
References: <1372273970-9084-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 26 21:14:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrvAD-0005tn-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 21:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab3FZTNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 15:13:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35492 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954Ab3FZTNo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 15:13:44 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5QJDYn6010022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Jun 2013 21:13:34 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5QJDbKx019180;
	Wed, 26 Jun 2013 21:13:37 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5QJDNHx023434;
	Wed, 26 Jun 2013 21:13:36 +0200
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1372273970-9084-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 26 Jun 2013 21:13:34 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229057>

From: Benoit Person <benoit.person@ensimag.fr>

For now, git-remote-mediawiki is only a remote-helper. This patch adds a new
toolset script in which we will be able to build new tools for
git-remote-mediawiki.

This toolset uses a subcommand-mechanism to launch the proper action. For now
only the 'help' subcommand is implemented. It also provides some generic code
for the verbose and help command line options.

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

---
 contrib/mw-to-git/Makefile    |  7 ++---
 contrib/mw-to-git/git-mw.perl | 60 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 3 deletions(-)
 create mode 100755 contrib/mw-to-git/git-mw.perl

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index 2a80d56..37afbbf 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -14,6 +14,7 @@
 
 GIT_MEDIAWIKI_PM=Git/Mediawiki.pm
 SCRIPT_PERL=git-remote-mediawiki.perl
+SCRIPT_PERL+=git-mw.perl
 GIT_ROOT_DIR=../..
 HERE=contrib/mw-to-git/
 
@@ -27,15 +28,15 @@ install_pm:
 	install $(GIT_MEDIAWIKI_PM) $(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
 
 build:
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
 	rm $(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
 
diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.perl
new file mode 100755
index 0000000..4a3e4a9
--- /dev/null
+++ b/contrib/mw-to-git/git-mw.perl
@@ -0,0 +1,60 @@
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
+# By default, use UTF-8 to communicate with Git and the user
+binmode STDERR, ':encoding(UTF-8)';
+binmode STDOUT, ':encoding(UTF-8)';
+
+# Global parameters
+my $verbose = 0;
+sub v_print {
+	if ($verbose) {
+		return print {*STDERR} @_;
+	}
+	return;
+}
+
+my %commands = (
+	'help' =>
+		[\&help, {}, \&help]
+);
+
+# Search for sub-command
+my $cmd = $commands{'help'};
+for (0..@ARGV-1) {
+	if (defined $commands{$ARGV[$_]}) {
+		$cmd = $commands{$ARGV[$_]};
+		splice @ARGV, $_, 1;
+		last;
+	}
+};
+GetOptions( %{$cmd->[1]},
+	'help|h' => \&{$cmd->[2]},
+	'verbose|v'  => \$verbose);
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
-- 
1.8.3.GIT
