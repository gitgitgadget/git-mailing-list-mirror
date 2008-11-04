From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/5] git send-email: add --annotate option
Date: Tue,  4 Nov 2008 17:24:16 +0100
Message-ID: <1225815858-30617-4-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-2-git-send-email-madcoder@debian.org>
 <1225815858-30617-3-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 17:25:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxOiv-0006x8-Mo
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 17:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbYKDQY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 11:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754799AbYKDQY1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 11:24:27 -0500
Received: from pan.madism.org ([88.191.52.104]:54656 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754406AbYKDQYW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 11:24:22 -0500
Received: from madism.org (unknown [213.223.38.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 4DE6C3BFF9;
	Tue,  4 Nov 2008 17:24:21 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 69EB4C256; Tue,  4 Nov 2008 17:24:18 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.844.gcde3
In-Reply-To: <1225815858-30617-3-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100088>

This allows to review every patch (and fix various aspects of them, or
comment them) in an editor just before being sent. Combined to the fact
that git send-email can now process revision lists, this makes git
send-email and efficient way to review and send patches interactively.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/git-send-email.txt |   11 +++++++++++
 git-send-email.perl              |   26 ++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 4654d4f..39d6da9 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -37,6 +37,11 @@ The --bcc option must be repeated for each user you want on the bcc list.
 +
 The --cc option must be repeated for each user you want on the cc list.
 
+--annotate::
+	Review each patch you're about to send in an editor. The setting
+	'sendemail.multiedit' defines if this will spawn one editor per patch
+	or one for all of them at once.
+
 --compose::
 	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
 	introductory message for the patch series.
@@ -204,6 +209,12 @@ sendemail.aliasfiletype::
 	Format of the file(s) specified in sendemail.aliasesfile. Must be
 	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
 
+sendemail.multiedit::
+	If true (default), a single editor instance will be spawned to edit
+	files you have to edit (patches when '--annotate' is used, and the
+	summary when '--compose' is used). If false, files will be edited one
+	after the other, spawning a new editor each time.
+
 
 Author
 ------
diff --git a/git-send-email.perl b/git-send-email.perl
index c29868a..d0c5a41 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -50,6 +50,7 @@ git send-email [options] <file | directory | rev-list options >
     --bcc                   <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
+    --annotate                     * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
 
   Sending:
@@ -129,7 +130,8 @@ sub cleanup_compose_files();
 
 # Variables we fill in automatically, or via prompting:
 my (@to,@cc,@initial_cc,@bcclist,@xh,
-	$initial_reply_to,$initial_subject,@files,$author,$sender,$smtp_authpass,$compose,$time);
+	$initial_reply_to,$initial_subject,@files,
+	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
 
 my $envelope_sender;
 
@@ -151,6 +153,17 @@ if ($@) {
 my ($quiet, $dry_run) = (0, 0);
 my $compose_filename = $repo->repo_path() . "/.gitsendemail.msg.$$";
 
+# Handle interactive edition of files.
+my $multiedit;
+my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+sub do_edit {
+	if (defined($multiedit) && !$multiedit) {
+		map { system('sh', '-c', $editor.' "$@"', $editor, $_); } @_;
+	} else {
+		system('sh', '-c', $editor.' "$@"', $editor, @_);
+	}
+}
+
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
@@ -180,6 +193,7 @@ my %config_settings = (
     "aliasesfile" => \@alias_files,
     "suppresscc" => \@suppress_cc,
     "envelopesender" => \$envelope_sender,
+    "multiedit" => \$multiedit,
 );
 
 # Handle Uncouth Termination
@@ -222,6 +236,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "identity=s" => \$identity,
+		    "annotate" => \$annotate,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
@@ -515,7 +530,12 @@ EOT
 	close(C);
 
 	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
-	system('sh', '-c', $editor.' "$@"', $editor, $compose_filename);
+
+	if ($annotate) {
+		do_edit($compose_filename, @files);
+	} else {
+		do_edit($compose_filename);
+	}
 
 	open(C2,">",$compose_filename . ".final")
 		or die "Failed to open $compose_filename.final : " . $!;
@@ -564,6 +584,8 @@ EOT
 	}
 
 	@files = ($compose_filename . ".final", @files);
+} elsif ($annotate) {
+	do_edit(@files);
 }
 
 # Variables we set as part of the loop over files
-- 
1.5.6.5
