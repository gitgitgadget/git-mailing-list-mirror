From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/4] git send-email: add --annotate option
Date: Tue, 11 Nov 2008 00:54:01 +0100
Message-ID: <1226361242-2516-4-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1226361242-2516-1-git-send-email-madcoder@debian.org>
 <1226361242-2516-2-git-send-email-madcoder@debian.org>
 <1226361242-2516-3-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 00:55:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzgba-0003dS-6k
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbYKJXyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbYKJXyN
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:54:13 -0500
Received: from pan.madism.org ([88.191.52.104]:37657 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbYKJXyI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:54:08 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 4B1AB3CD8A;
	Tue, 11 Nov 2008 00:54:06 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 042232A252; Tue, 11 Nov 2008 00:54:03 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4.862.g3e9be
In-Reply-To: <1226361242-2516-3-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100600>

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
index 0beaad4..66d5f4c 100644
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
@@ -210,6 +215,12 @@ sendemail.aliasfiletype::
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
index 6f5a613..ccb3b18 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -51,6 +51,7 @@ git send-email [options] <file | directory | rev-list options >
     --bcc                   <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
+    --annotate                     * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
 
   Sending:
@@ -132,7 +133,8 @@ sub cleanup_compose_files();
 
 # Variables we fill in automatically, or via prompting:
 my (@to,@cc,@initial_cc,@bcclist,@xh,
-	$initial_reply_to,$initial_subject,@files,$author,$sender,$smtp_authpass,$compose,$time);
+	$initial_reply_to,$initial_subject,@files,
+	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
 
 my $envelope_sender;
 
@@ -155,6 +157,17 @@ my ($quiet, $dry_run) = (0, 0);
 my $format_patch;
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
@@ -184,6 +197,7 @@ my %config_settings = (
     "aliasesfile" => \@alias_files,
     "suppresscc" => \@suppress_cc,
     "envelopesender" => \$envelope_sender,
+    "multiedit" => \$multiedit,
 );
 
 # Handle Uncouth Termination
@@ -226,6 +240,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "identity=s" => \$identity,
+		    "annotate" => \$annotate,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
@@ -532,7 +547,12 @@ EOT
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
@@ -581,6 +601,8 @@ EOT
 	}
 
 	@files = ($compose_filename . ".final", @files);
+} elsif ($annotate) {
+	do_edit(@files);
 }
 
 # Variables we set as part of the loop over files
-- 
1.6.0.4.859.g7ecd.dirty
