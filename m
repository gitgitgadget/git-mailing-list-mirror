From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Date: Sun, 15 Nov 2015 12:22:19 -0800
Message-ID: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 21:22:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zy3oj-00086L-0O
	for gcvg-git-2@plane.gmane.org; Sun, 15 Nov 2015 21:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbbKOUWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 15:22:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:62631 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbbKOUWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2015 15:22:23 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 15 Nov 2015 12:22:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,298,1444719600"; 
   d="scan'208";a="851279889"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2015 12:22:23 -0800
X-Mailer: git-send-email 2.6.3.491.g3e3f6ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281322>

From: Jacob Keller <jacob.keller@gmail.com>

Add an option "list-aliases" which changes the default behavior of
git-send-email. This mode will simply read the alias files configured by
sendemail.aliasesfile and sendemail.aliasfiletype and print a list of
all known aliases. The intended usecase for this option is the
bash-completion script which will use it to autocomplete aliases on the
options which take addresses.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-send-email.txt | 10 ++++++++++
 git-send-email.perl              | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index b9134d234f53..481770d72e13 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git send-email' [options] <file|directory|rev-list options>...
+'git send-email' --list-aliases
 
 
 DESCRIPTION
@@ -387,6 +388,15 @@ default to '--validate'.
 	Send emails even if safety checks would prevent it.
 
 
+Information
+~~~~~~~~~~~
+
+--list-aliases::
+	Instead of the standard operation, list all aliases found in the
+	configured alias file(s), and then exit. See 'sendemail.aliasesfile'
+	for more information about aliases.
+
+
 CONFIGURATION
 -------------
 
diff --git a/git-send-email.perl b/git-send-email.perl
index e907e0eacf31..ee14894b172b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -46,6 +46,7 @@ package main;
 sub usage {
 	print <<EOT;
 git send-email [options] <file | directory | rev-list options >
+git send-email --list-aliases
 
   Composing:
     --from                  <str>  * Email From:
@@ -101,6 +102,9 @@ git send-email [options] <file | directory | rev-list options >
                                      `git format-patch` ones.
     --force                        * Send even if safety checks would prevent it.
 
+  Information:
+    --list-aliases                 * read the aliases from configured alias files
+
 EOT
 	exit(1);
 }
@@ -180,6 +184,7 @@ my ($quiet, $dry_run) = (0, 0);
 my $format_patch;
 my $compose_filename;
 my $force = 0;
+my $list_aliases = 0;
 
 # Handle interactive edition of files.
 my $multiedit;
@@ -344,6 +349,7 @@ my $rc = GetOptions("h" => \$help,
 		    "force" => \$force,
 		    "xmailer!" => \$use_xmailer,
 		    "no-xmailer" => sub {$use_xmailer = 0},
+                    "list-aliases" => \$list_aliases,
 	 );
 
 usage() if $help;
@@ -551,6 +557,11 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 	}
 }
 
+if ($list_aliases) {
+    print $_,"\n" for (keys %aliases);
+    exit(0);
+}
+
 # is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if
 # $f is a revision list specification to be passed to format-patch.
 sub is_format_patch_arg {
-- 
2.6.3.491.g3e3f6ce
