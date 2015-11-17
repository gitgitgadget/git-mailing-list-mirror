From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 1/2] sendemail: teach git-send-email to dump alias names
Date: Mon, 16 Nov 2015 16:29:25 -0800
Message-ID: <1447720166-9941-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 01:29:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyU9W-0002Kd-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 01:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbbKQA32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 19:29:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:20202 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbbKQA31 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 19:29:27 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 16 Nov 2015 16:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,305,1444719600"; 
   d="scan'208";a="840117987"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2015 16:29:27 -0800
X-Mailer: git-send-email 2.6.3.491.g3e3f6ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281373>

From: Jacob Keller <jacob.keller@gmail.com>

Add an option "dump-aliases" which changes the default behavior of
git-send-email. This mode will simply read the alias files configured by
sendemail.aliasesfile and sendemail.aliasfiletype and dump a list of all
configured aliases, one per line. The intended use case for this option
is the bash-completion script which will use it to autocomplete aliases
on the options which take addresses.

Add some tests for the new option.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

Notes:
    - v2
    * Add command --list-aliases to git-send-email
    
    - v3
    * Add test
    * change option to --dump-aliases
    * dump both the alias and its expansion

 Documentation/git-send-email.txt | 10 ++++++++++
 git-send-email.perl              | 11 +++++++++++
 t/t9001-send-email.sh            | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index b9134d234f53..02f48e2258a6 100644
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
+--dump-aliases::
+	Instead of the standard operation, dump all aliases found in the
+	configured alias file(s), followed by its expansion. See
+	'sendemail.aliasesfile' for more information about aliases.
+
+
 CONFIGURATION
 -------------
 
diff --git a/git-send-email.perl b/git-send-email.perl
index e907e0eacf31..95ac9cf11155 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -46,6 +46,7 @@ package main;
 sub usage {
 	print <<EOT;
 git send-email [options] <file | directory | rev-list options >
+git send-email --dump-aliases
 
   Composing:
     --from                  <str>  * Email From:
@@ -101,6 +102,9 @@ git send-email [options] <file | directory | rev-list options >
                                      `git format-patch` ones.
     --force                        * Send even if safety checks would prevent it.
 
+  Information:
+    --dump-aliases                 * Dump configured aliases and exit.
+
 EOT
 	exit(1);
 }
@@ -180,6 +184,7 @@ my ($quiet, $dry_run) = (0, 0);
 my $format_patch;
 my $compose_filename;
 my $force = 0;
+my $dump_aliases = 0;
 
 # Handle interactive edition of files.
 my $multiedit;
@@ -344,6 +349,7 @@ my $rc = GetOptions("h" => \$help,
 		    "force" => \$force,
 		    "xmailer!" => \$use_xmailer,
 		    "no-xmailer" => sub {$use_xmailer = 0},
+                    "dump-aliases" => \$dump_aliases,
 	 );
 
 usage() if $help;
@@ -551,6 +557,11 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 	}
 }
 
+if ($dump_aliases) {
+    print "$_ @{$aliases{$_}}\n" for (keys %aliases);
+    exit(0);
+}
+
 # is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if
 # $f is a revision list specification to be passed to format-patch.
 sub is_format_patch_arg {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 5b4a5ce06b94..bb537bb50b2b 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1579,6 +1579,24 @@ test_sendmail_aliases () {
 	'
 }
 
+test_sendmail_dump_aliases () {
+	msg="$1" && shift &&
+	expect="$@" &&
+	cat >.tmp-email-aliases &&
+
+	test_expect_success $PREREQ "$msg" '
+		clean_fake_sendmail && rm -fr outdir &&
+		git config --replace-all sendemail.aliasesfile \
+			"$(pwd)/.tmp-email-aliases" &&
+		git config sendemail.aliasfiletype sendmail &&
+		git send-email --dump-aliases 2>errors >out &&
+		for i in $expect
+		do
+			grep "$i" out || return 1
+		done
+	'
+}
+
 test_sendmail_aliases 'sendemail.aliasfiletype=sendmail' \
 	'awol@example\.com' \
 	'bob@example\.com' \
@@ -1593,6 +1611,21 @@ test_sendmail_aliases 'sendemail.aliasfiletype=sendmail' \
 	bcgrp: bob, chloe, Other <o@example.com>
 	EOF
 
+test_sendmail_dump_aliases '--dump-alias-names sendemail.aliasfiletype=sendmail' \
+	'alice' \
+	'bob' \
+	'chloe' \
+	'abgroup' \
+	'bcgrp' <<-\EOF
+	alice: Alice W Land <awol@example.com>
+	bob: Robert Bobbyton <bob@example.com>
+	# this is a comment
+	   # this is also a comment
+	chloe: chloe@example.com
+	abgroup: alice, bob
+	bcgrp: bob, chloe, Other <o@example.com>
+	EOF
+
 test_sendmail_aliases 'sendmail aliases line folding' \
 	alice1 \
 	bob1 bob2 \
-- 
2.6.3.491.g3e3f6ce
