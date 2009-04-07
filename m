From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 4/6] send-email: --compose takes optional argument to existing file
Date: Tue,  7 Apr 2009 16:25:20 -0500
Message-ID: <1239139522-24118-4-git-send-email-mfwitten@gmail.com>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-3-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 23:28:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrIpw-0002qz-6N
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 23:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759583AbZDGV0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759429AbZDGV0O
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 17:26:14 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:61365 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbZDGV0N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 17:26:13 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2931737rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 14:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ME8QFe1QIwgTNbshvXQZ9BT1Os4mslAZrbmE+w8jYbQ=;
        b=BYBWUxjL2AdH78UJDIbXCK96C9KhE0x8K5dKg6+yBv7g/0vN6V0EPt0HtMhP068Qxr
         mtxAcbDqMf41YY2fnddXQ8qLwe8xLWirsptX2q/XEUTHMmlfz5NF484oEf2QToPvkSrY
         57iAUbGAB8cdUvDJczILXNmPFWic0HFgfCLRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=twxkp8lQjfAHxVdJyQKDfHOpA6MCf9JMJOu89JQnxvIb/l2hUudB1oJ0UDLXWgYrhe
         syMEp5NgfEPAwUcbMNflfWPCRBL8K3vi9cC6DJ3WeNtjjQ/p4XkJz3TcP5h0BNmOZ2Wt
         RaWD1jHD10zpm1q9ZAeGtL8XR1NDo5zUH9/Ss=
Received: by 10.114.137.16 with SMTP id k16mr287926wad.189.1239139572598;
        Tue, 07 Apr 2009 14:26:12 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-21.mpls.qwest.net [97.116.125.21])
        by mx.google.com with ESMTPS id j39sm7381340waf.28.2009.04.07.14.26.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 14:26:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.448.g61445.dirty
In-Reply-To: <1239139522-24118-3-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115989>

Now, a user may specify an existing (in-progress) file to use as
the introductory/summary email.

The file is opened for any additional editing as usual.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |    7 ++-
 git-send-email.perl              |  112 ++++++++++++++++++++++----------------
 2 files changed, 71 insertions(+), 48 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 4b656ca..bc9ff13 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -57,8 +57,11 @@ The --cc option must be repeated for each user you want on the cc list.
 	or one for all of them at once.
 
 --compose::
-	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
-	introductory message for the patch series.
+	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR, or vi to edit an
+	introductory message for the patch series. An existing file may be
+	specified as the basis for the introductory email; it will be opened
+	for editing directly. Otherwise, a new temporary file is created with
+	some default contents.
 +
 When '--compose' is used, git send-email will use the From, Subject, and
 In-Reply-To headers specified in the message. If the body of the message
diff --git a/git-send-email.perl b/git-send-email.perl
index 098c620..481bf36 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -53,7 +53,7 @@ git send-email [options] <file | directory | rev-list options >
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
     --annotate                     * Review each patch that will be sent in an editor.
-    --compose                      * Open an editor for introduction.
+    --compose           opt <str>  * Open an editor for introduction.
 
   Sending:
     --delay                 <int>  * Delay (seconds) between sending emails.
@@ -62,7 +62,7 @@ git send-email [options] <file | directory | rev-list options >
                                      is optional. Default 'localhost'.
     --smtp-server-port      <int>  * Outgoing SMTP server port.
     --smtp-user             <str>  * Username for SMTP-AUTH.
-    --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
+    --smtp-pass         opt <str>  * Password for SMTP-AUTH; not necessary.
     --smtp-encryption       <str>  * tls or ssl; anything else disables.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
 
@@ -159,7 +159,7 @@ if ($@) {
 # Behavior modification variables
 my ($quiet, $dry_run) = (0, 0);
 my $format_patch;
-my $compose_filename;
+my ($compose_filename, $compose_final_filename, $compose_final_is_not_empty);
 
 # Handle interactive edition of files.
 my $multiedit;
@@ -224,13 +224,12 @@ sub signal_handler {
 	system "stty echo";
 
 	# tmp files from --compose
-	if (defined $compose_filename) {
-		if (-e $compose_filename) {
-			print "'$compose_filename' contains an intermediate version of the email you were composing.\n";
-		}
-		if (-e ($compose_filename . ".final")) {
-			print "'$compose_filename.final' contains the composed email.\n"
-		}
+	if (defined $compose_filename and -f $compose_filename) {
+		print "'$compose_filename' contains an intermediate version of the email you were composing.\n";
+	}
+
+	if (defined $compose_final_filename and -f $compose_final_filename) {
+		print "'$compose_final_filename' contains the composed email.\n"
 	}
 
 	exit;
@@ -258,7 +257,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "identity=s" => \$identity,
 		    "annotate" => \$annotate,
-		    "compose" => \$compose,
+		    "compose:s" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
@@ -517,21 +516,36 @@ sub get_patch_subject($) {
 	die "'Subject:' line expected in '$patch'";
 }
 
-if ($compose) {
-	# Note that this does not need to be secure, but we will make a small
-	# effort to have it be unique
-	$compose_filename = ($repo ?
-		tempfile(".gitsendemail.msg.XXXXXX", DIR => $repo->repo_path()) :
-		tempfile(".gitsendemail.msg.XXXXXX", DIR => "."))[1];
-	open(C,">",$compose_filename)
-		or die "Failed to open for writing $compose_filename: $!";
+if (defined $compose) {
+
+	my ($tmp_file, $tmp_filename) = tempfile(".gitsendemail.msg.XXXXXX", DIR => ($repo ? $repo->repo_path() : "."));
 
+	my $compose_file;
+	my $compose_final_file;
+
+	if ($compose ne '') {
+
+		$compose_filename = $compose;
+
+		$compose_final_filename = $tmp_filename;
+		$compose_final_file     = $tmp_file
+
+	} else {
 
-	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
-	my $tpl_subject = $initial_subject || '';
-	my $tpl_reply_to = $initial_reply_to || '';
+		$compose_filename = $tmp_filename;
+		$compose_file     = $tmp_file;
 
-	print C <<EOT;
+		$compose_final_filename = "$compose_filename.final";
+		open $compose_final_file, ">", $compose_final_filename
+			or die "Failed to open '$compose_final_filename' for writing: $!";
+
+		# Help the user out with some instruction and initial headers:
+
+		my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
+		my $tpl_subject = $initial_subject || '';
+		my $tpl_reply_to = $initial_reply_to || '';
+
+		print $compose_file <<EOT;
 From $tpl_sender # This line is ignored.
 GIT: Lines beginning in "GIT:" will be removed.
 GIT: Consider including an overall diffstat or table of contents
@@ -543,10 +557,10 @@ Subject: $tpl_subject
 In-Reply-To: $tpl_reply_to
 
 EOT
-	for my $f (@files) {
-		print C "GIT: ", get_patch_subject($f), "\n";
+		for my $f (@files) {
+			print $compose_file "GIT: ", get_patch_subject($f), "\n";
+		}
 	}
-	close(C);
 
 	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
 
@@ -556,23 +570,28 @@ EOT
 		do_edit($compose_filename);
 	}
 
-	open(C2,">",$compose_filename . ".final")
-		or die "Failed to open $compose_filename.final : " . $!;
+	# Now transform the user-edited introduction into something
+	# suitable for sending via email; the user's editor may have
+	# unlinked the original file and replaced it with an entirely
+	# new one. If this be the case, then it wouldn't do just to
+	# seek to the beginning and start reading, because then only
+	# the original content would be retrieved. Consequently, the
+	# file must be reopened to be safe (note, the original
+	# filehandle is closed automatically).
 
-	open(C,"<",$compose_filename)
-		or die "Failed to open $compose_filename : " . $!;
+	open $compose_file, "<", $compose_filename
+		or die "Failed to open '$compose_filename' for reading: $!";
 
 	my $need_8bit_cte = file_has_nonascii($compose_filename);
 	my $in_body = 0;
-	my $summary_empty = 1;
-	while(<C>) {
+	while(<$compose_file>) {
 		next if m/^GIT:/;
-		if ($in_body) {
-			$summary_empty = 0 unless (/^\n$/);
+		if ($in_body && not /^\n$/) {
+			 $compose_final_is_not_empty = 1;
 		} elsif (/^\n$/) {
 			$in_body = 1;
 			if ($need_8bit_cte) {
-				print C2 "MIME-Version: 1.0\n",
+				print $compose_final_file "MIME-Version: 1.0\n",
 					 "Content-Type: text/plain; ",
 					   "charset=utf-8\n",
 					 "Content-Transfer-Encoding: 8bit\n";
@@ -597,15 +616,12 @@ EOT
 			print "To/Cc/Bcc fields are not interpreted yet, they have been ignored\n";
 			next;
 		}
-		print C2 $_;
-	}
-	close(C);
-	close(C2);
 
-	if ($summary_empty) {
-		print "Summary email is empty, skipping it\n";
-		$compose = -1;
+		print $compose_final_file $_;
 	}
+
+	print "Summary email is empty, skipping it\n" unless ($compose_final_is_not_empty);
+
 } elsif ($annotate) {
 	do_edit(@files);
 }
@@ -685,9 +701,7 @@ if (!defined $smtp_server) {
 	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
 }
 
-if ($compose && $compose > 0) {
-	@files = ($compose_filename . ".final", @files);
-}
+unshift(@files, $compose_final_filename) if ($compose_final_is_not_empty);
 
 # Variables we set as part of the loop over files
 our ($message_id, %mail, $subject, $reply_to, $references, $message,
@@ -1153,7 +1167,13 @@ for (my $index = 0; $index < @files; $index++) {
 cleanup_compose_files();
 
 sub cleanup_compose_files() {
-	unlink($compose_filename, $compose_filename . ".final") if $compose;
+	if (defined $compose) {
+		unlink(
+			$compose_final_filename,
+			# Don't delete user-supplied file.
+			$compose ? () : $compose_filename
+		);
+	}
 }
 
 $smtp->quit if $smtp;
-- 
1.6.2.2.448.g61445.dirty
