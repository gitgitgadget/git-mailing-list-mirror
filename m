From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 1/2] sendemail: teach git-send-email to dump alias names
Date: Tue, 17 Nov 2015 03:45:49 -0800
Message-ID: <1447760750-21287-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 12:48:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zyejf-0006SH-RQ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 12:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbbKQLrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 06:47:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:57964 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331AbbKQLpx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 06:45:53 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 17 Nov 2015 03:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,307,1444719600"; 
   d="scan'208";a="852657508"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by orsmga002.jf.intel.com with ESMTP; 17 Nov 2015 03:45:52 -0800
X-Mailer: git-send-email 2.6.3.491.g3e3f6ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281402>

From: Jacob Keller <jacob.keller@gmail.com>

Add an option "--dump-aliases" which changes the default behavior of
git-send-email. This mode will simply read the alias files configured by
sendemail.aliasesfile and sendemail.aliasfiletype and dump a list of all
configured aliases, one per line. The intended use case for this option
is the bash-completion script which will use it to autocomplete aliases
on the options which take addresses.

Add some tests for the new option using various alias file formats.

A possible future extension to the alias dump format could be done by
extending the --dump-aliases to take an optional argument defining the
format to display. This has not been done in this patch as no user of
this information has been identified.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

I also noticed a possible issue with the gnus format for mail addresses,
in that the expansion of the alias does not allow spaces in its regular
expression, but I am not sure how best to resolve this or even if it's
an issue. Anyone know?

Notes:
    - v2
    * Add command --list-aliases to git-send-email
    
    - v3
    * Add test
    * change option to --dump-aliases
    * dump both the alias and its expansion
    
    - v4
    * Rework and extend tests
    * Only print alias names for now, punt full format for when a use case is
      identified
    * Ensure no other options are used with --dump-aliases

 Documentation/git-send-email.txt | 11 ++++++
 git-send-email.perl              | 15 ++++++++
 t/t9001-send-email.sh            | 82 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index b9134d234f53..771a7b5b0915 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git send-email' [options] <file|directory|rev-list options>...
+'git send-email' --dump-aliases
 
 
 DESCRIPTION
@@ -387,6 +388,16 @@ default to '--validate'.
 	Send emails even if safety checks would prevent it.
 
 
+Information
+~~~~~~~~~~~
+
+--dump-aliases::
+	Instead of the normal operation, dump the shorthand alias names from
+	the configured alias file(s), one per line in alphabetical order. Note,
+	this only includes the alias name and not its expanded email addresses.
+	See 'sendemail.aliasesfile' for more information about aliases.
+
+
 CONFIGURATION
 -------------
 
diff --git a/git-send-email.perl b/git-send-email.perl
index e907e0eacf31..a475b0d75370 100755
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
@@ -291,6 +296,11 @@ $SIG{INT}  = \&signal_handler;
 
 my $help;
 my $rc = GetOptions("h" => \$help,
+                    "dump-aliases" => \$dump_aliases);
+usage() unless $rc;
+die "--dump-aliases incompatible with other options\n"
+    if !$help and $dump_aliases and @ARGV;
+$rc = GetOptions(
 		    "sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_reply_to,
 		    "subject=s" => \$initial_subject,
@@ -551,6 +561,11 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 	}
 }
 
+if ($dump_aliases) {
+    print "$_\n" for (sort keys %aliases);
+    exit(0);
+}
+
 # is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if
 # $f is a revision list specification to be passed to format-patch.
 sub is_format_patch_arg {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 5b4a5ce06b94..3c49536e0e8d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1555,6 +1555,88 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 	grep "^!someone@example\.org!$" commandline1
 '
 
+test_dump_aliases () {
+	msg="$1" && shift &&
+	filetype="$1" && shift &&
+	printf '%s\n' "$@" >expect &&
+	cat >.tmp-email-aliases &&
+
+	test_expect_success $PREREQ "$msg" '
+		clean_fake_sendmail && rm -fr outdir &&
+		git config --replace-all sendemail.aliasesfile \
+			"$(pwd)/.tmp-email-aliases" &&
+		git config sendemail.aliasfiletype "$filetype" &&
+		git send-email --dump-aliases 2>errors >actual &&
+		test_cmp expect actual
+	'
+}
+
+test_dump_aliases '--dump-aliases sendmail format' \
+	'sendmail' \
+	'abgroup' \
+	'alice' \
+	'bcgrp' \
+	'bob' \
+	'chloe' <<-\EOF
+	alice: Alice W Land <awol@example.com>
+	bob: Robert Bobbyton <bob@example.com>
+	chloe: chloe@example.com
+	abgroup: alice, bob
+	bcgrp: bob, chloe, Other <o@example.com>
+	EOF
+
+test_dump_aliases '--dump-aliases mutt format' \
+	'mutt' \
+	'alice' \
+	'bob' \
+	'chloe' \
+	'donald' <<-\EOF
+	alias alice Alice W Land <awol@example.com>
+	alias donald Donald C Carlton <donc@example.com>
+	alias bob Robert Bobbyton <bob@example.com>
+	alias chloe chloe@example.com
+	EOF
+
+test_dump_aliases '--dump-aliases mailrc format' \
+	'mailrc' \
+	'alice' \
+	'bob' \
+	'chloe' \
+	'eve' <<-\EOF
+	alias alice   Alice W Land <awol@example.com>
+	alias eve     Eve <eve@example.com>
+	alias bob     Robert Bobbyton <bob@example.com>
+	alias chloe   chloe@example.com
+	EOF
+
+test_dump_aliases '--dump-aliases pine format' \
+	'pine' \
+	'alice' \
+	'bob' \
+	'chloe' \
+	'eve' <<-\EOF
+	alice	Alice W Land	<awol@example.com>
+	eve	Eve	<eve@example.com>
+	bob	Robert	Bobbyton <bob@example.com>
+	chloe		chloe@example.com
+	EOF
+
+test_dump_aliases '--dump-aliases gnus format' \
+	'gnus' \
+	'alice' \
+	'bob' \
+	'chloe' \
+	'eve' <<-\EOF
+	(define-mail-alias "alice" "awol@example.com")
+	(define-mail-alias "eve" "eve@example.com")
+	(define-mail-alias "bob" "bob@example.com")
+	(define-mail-alias "chloe" "chloe@example.com")
+	EOF
+
+test_expect_success '--dump-aliases must be used alone' '
+	test_must_fail git send-email --dump-aliases --to=janice@example.com -1 refs/heads/accounting
+'
+
 test_sendmail_aliases () {
 	msg="$1" && shift &&
 	expect="$@" &&
-- 
2.6.3.491.g3e3f6ce
