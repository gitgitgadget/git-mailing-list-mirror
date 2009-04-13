From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 12/13] send-email: --compose takes optional argument to existing file
Date: Mon, 13 Apr 2009 13:23:56 -0500
Message-ID: <1239647037-15381-13-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-10-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-11-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-12-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:40:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtR2x-00050H-MS
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbZDMSgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbZDMSgi
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:36:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:29619 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbZDMSgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:36:37 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2203817rvb.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bMyKs51uI/QEdXkKa4X4JsA8WnWgzbiLgbUH92E2A1M=;
        b=FvL9GaOnomPf7UIyZw9fOvnNfk3n7ur/S+20CxgsEt6UP77kqqoDEvD8VBgW2rWIib
         avZ5xnIfTeG2T94mcA51dh5hmxV7UG0qQ5eS9oW1lRz6q+OlG8pkqp4+hwdP7ZZFpCvH
         QVMB4UkmlFaJ0zsJ+f6ga04pt/qcRFfx4k2rM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UD1Ef7VjCGV6iP1xeezs8MSY1V7rn6p5rXL1oMZXkRwelrlKi73qSCtbdeCJxpaJUa
         lkevhHguvfD8pg/XukLm7fKSzjAoyOBgN3tKhHRTtgUSGkYJom8KmiYooLRUy8swIXMI
         Yy2NR1H9MV4LuiLPttYYqHOMMjbPz8fihntcw=
Received: by 10.114.59.1 with SMTP id h1mr3294378waa.72.1239647796322;
        Mon, 13 Apr 2009 11:36:36 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.36.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:36:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-12-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116473>

Now, a user may specify an existing (in-progress) file to use as
the introductory/summary email.

The file is opened for any additional editing as usual, but it
is not deleted upon normal termination.

There are also a number of fixes to how the internals and
temporaries are handled.

Also, it is no longer possible to pass --compose multiple times
in order to edit the transformed version as well.

Also, send-email now aborts upon discovering an empty message.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   40 +++++++--
 git-send-email.perl              |  182 ++++++++++++++++++++++++--------------
 2 files changed, 145 insertions(+), 77 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 93cfb34..5ef8b12 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -55,17 +55,39 @@ The --bcc option must be repeated for each user you want on the bcc list.
 +
 The --cc option must be repeated for each user you want on the cc list.
 
---compose::
-	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
-	introductory message for the patch series.
+--compose[=<path>]::
+	Create an introductory message for the patch series; the
+	message is opened for editing with (in order of preference)
+	`$GIT_EDITOR`, 'core.editor', `$VISUAL`, `$EDITOR`, or `vi`.
 +
-When '--compose' is used, git send-email will use the From, Subject, and
-In-Reply-To headers specified in the message. If the body of the message
-(what you type after the headers and a blank line) only contains blank
-(or GIT: prefixed) lines the summary won't be sent, but From, Subject,
-and In-Reply-To headers will be used unless they are removed.
+A path for the composition may be given. If the path exists, then
+the file at the path is opened for editing as-is. If the path
+doesn't exist, a file with default content is created at the path
+and opened for editing. If no path is specified, a new temporary
+file with default content is created and opened for editing.
 +
-Missing From or In-Reply-To headers will be prompted for.
+Upon the successful completion of send-email, all temporary files
+are automatically unlinked (deleted). However, if send-email is
+terminated by a trappable signal, then this temporary file is not
+unlinked, and the user is informed of its path.
++
+The user actually composes what will become a valid email message;
+therefore, the message must have the following form (as described in
+`RFC 822`):
++
+	<headers>
+	<blank line>
+	<body>
++
+In particular, `<headers>` must contain the "`Subject`" header. Once
+the user saves the message and quits the editor, this intermediate
+message is transformed into the final email message by removing all
+lines that begin with "`GIT:`". If the `<body>` of the final version
+is empty, then send-email aborts without sending anything.
++
+The "`From`", "`Subject`", and "`In-Reply-To`" headers are taken
+directly from the message; missing "`From`" or "`In-Reply-To`"
+headers will be prompted for.
 +
 See the CONFIGURATION section for 'sendemail.multiedit'.
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 8ce9d3b..2ab76c6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -58,10 +58,9 @@ git send-email [options] <file | directory | rev-list options >
     --bcc               <address>  * Email Bcc:
     --subject            <string>  * Email "Subject:"
     --in-reply-to    <message-id>  * Email "In-Reply-To:"; include '<' and '>'.
+    --compose             [<path>] * Open an editor for introduction.
     --annotate                     * Review each patch that will be sent in
                                      an editor.
-    --compose                      * Open an editor for introduction.
-
   Sending:
     --envelope-sender   <address>  * Email envelope sender.
     --smtp-server          <host>  * Outgoing SMTP server.
@@ -168,7 +167,7 @@ if ($@) {
 # Behavior modification variables
 my ($quiet, $dry_run) = (0, 0);
 my $format_patch;
-my $compose_filename;
+my ($compose_path, $compose_final_path);
 
 # Handle interactive edition of files.
 my $multiedit;
@@ -234,16 +233,15 @@ sub signal_handler {
 	system "stty echo";
 
 	# tmp files from --compose
-	if (defined $compose_filename) {
-		if (-e $compose_filename) {
-			print "'$compose_filename' contains an intermediate version of the email you were composing.\n";
-		}
-		if (-e ($compose_filename . ".final")) {
-			print "'$compose_filename.final' contains the composed email.\n"
-		}
+	if (defined $compose_path and -f $compose_path) {
+		print "'$compose_path' contains an intermediate version of the email you were composing.\n";
+	}
+
+	if (defined $compose_final_path) {
+		unlink $compose_final_path if defined $compose_final_path;
 	}
 
-	exit;
+	exit 1;
 };
 
 $SIG{TERM} = \&signal_handler;
@@ -268,8 +266,8 @@ my $rc = GetOptions(
 	"smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 	"smtp-encryption=s" => \$smtp_encryption,
 	"identity=s" => \$identity,
+	"compose:s" => \$compose,
 	"annotate" => \$annotate,
-	"compose" => \$compose,
 	"quiet" => \$quiet,
 	"cc-cmd=s" => \$cc_cmd,
 	"suppress-from!" => \$suppress_from,
@@ -590,60 +588,108 @@ sub get_patch_subject($) {
 	die "No subject line in $fn ?";
 }
 
-if ($compose) {
-	# Note that this does not need to be secure, but we will make a small
-	# effort to have it be unique
-	$compose_filename = ($repo ?
-		tempfile(".gitsendemail.msg.XXXXXX", DIR => $repo->repo_path()) :
-		tempfile(".gitsendemail.msg.XXXXXX", DIR => "."))[1];
-	open(C,">",$compose_filename)
-		or die "Failed to open for writing $compose_filename: $!";
-
-
-	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
-	my $tpl_subject = $initial_subject || '';
-	my $tpl_reply_to = $initial_reply_to || '';
-
-	print C <<EOT;
-From $tpl_sender # This line is ignored.
-GIT: Lines beginning in "GIT:" will be removed.
-GIT: Consider including an overall diffstat or table of contents
-GIT: for the patch you are writing.
-GIT:
-GIT: Clear the body content if you don't wish to send a summary.
-From: $tpl_sender
-Subject: $tpl_subject
-In-Reply-To: $tpl_reply_to
+if (defined $compose) {
 
-EOT
-	for my $f (@files) {
-		print C get_patch_subject($f);
+	# Some parameters for creating temporary files:
+
+	my $template = ".gitsendemail.msg.XXXXXX";
+	my @dir = (DIR => ($repo ? $repo->repo_path() : "."));
+	my @suffix = (SUFFIX => ".final");
+
+	# Figure out the file that the user should be editing:
+
+	my $compose_path_filehandle;
+
+	if ($compose eq '') { # if no path was given
+		($compose_path_filehandle, $compose_path) = tempfile($template, @dir)
+			or die "--compose: Could not create temporary file for the user to edit: $!\n";
+	} else {
+		$compose_path = $compose;
+		unless (-f $compose_path) {
+			open $compose_path_filehandle, ">", $compose_path
+				or die "--compose: Could not open '$compose_path' for writing default content: $!\n";
+		}
 	}
-	close(C);
+
+	# Fill in default content if necessary:
+
+	if ($compose_path_filehandle) {
+
+		# For convenience:
+
+		local *STDOUT = $compose_path_filehandle;
+
+		# Help the user out with some instruction and initial headers:
+
+		my $from = $sender || $repoauthor || $repocommitter || '';
+		my $subject = $initial_subject || '';
+		my $reply_to = $initial_reply_to || '';
+
+		print "From $from # This line is ignored.\n";
+		print "GIT:\n";
+		print "GIT: Lines beginning in 'GIT:' will be removed.\n";
+		print "GIT:\n";
+		print "GIT: Consider including an overall diffstat\n";
+		print "GIT: (git diff --stat) or table of contents\n";
+		print "GIT: (as provide below).\n";
+		print "GIT:\n";
+		print "GIT: Clear the body content if you decide not\n";
+		print "GIT: to send this message.\n";
+		print "GIT:\n";
+		print "GIT: Here are the <headers>:\n";
+		print "From: $from\n";
+		print "Subject: $subject\n";
+		print "In-Reply-To: $reply_to\n";
+		print "\n";
+		print "GIT: This is the first line of the <body>:\n";
+		print "\n";
+
+		for my $f (@files) {
+			print get_patch_subject($f);
+		}
+	}
+
+	# Do the editing:
 
 	if ($annotate) {
-		do_edit($compose_filename, @files);
+		do_edit($compose_path, @files);
 	} else {
-		do_edit($compose_filename);
+		do_edit($compose_path);
 	}
 
-	open(C2,">",$compose_filename . ".final")
-		or die "Failed to open $compose_filename.final : " . $!;
+	# Now transform the user-edited introduction into something
+	# suitable for sending via email; the user's editor may have
+	# unlinked the original file and replaced it with an entirely
+	# new one. If this be the case, then it wouldn't do just to seek
+	# to the beginning and start reading, because then only the
+	# original content would be retrieved. Consequently, the file
+	# must be reopened to be safe (note, the original filehandle is
+	# closed automatically):
+
+	unless (-f $compose_path) {
+		die "--compose: File '$compose_path' doesn't exist; aborting.\n";
+	}
+
+	open $compose_path_filehandle, "<", $compose_path
+		or die "--compose: Failed to open '$compose_path' for reading: $!";
 
-	open(C,"<",$compose_filename)
-		or die "Failed to open $compose_filename : " . $!;
+	# Create the final version:
 
-	my $need_8bit_cte = file_has_nonascii($compose_filename);
+	(my $compose_final_file, $compose_final_path) = tempfile($template, @dir, @suffix)
+		or die "--compose: Could not create temporary file for final version: $!\n";
+
+	my ($subject, $reply_to, $from);
+	my $need_8bit_cte = file_has_nonascii($compose_path);
 	my $in_body = 0;
 	my $summary_empty = 1;
-	while(<C>) {
+	while(<$compose_path_filehandle>) {
 		next if m/^GIT:/;
 		if ($in_body) {
 			$summary_empty = 0 unless (/^\n$/);
 		} elsif (/^\n$/) {
 			$in_body = 1;
 			if ($need_8bit_cte) {
-				print C2
+				print $compose_final_file
 					"MIME-Version: 1.0\n",
 					"Content-Type: text/plain; ",
 					"charset=utf-8\n",
@@ -653,12 +699,7 @@ EOT
 			$need_8bit_cte = 0;
 		} elsif (/^Subject:\s*(.+)\s*$/i) {
 			$initial_subject = $1;
-			my $subject = $initial_subject;
-			$_ = "Subject: " .
-				($subject =~ /[^[:ascii:]]/ ?
-				quote_rfc2047($subject) :
-				$subject) .
-				"\n";
+			next;
 		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
 			$initial_reply_to = $1;
 			next;
@@ -669,15 +710,14 @@ EOT
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
+	$summary_empty and die "Introductory email is empty; aborting.\n";
+
+	unshift(@files, $compose_final_path);
+
 } elsif ($annotate) {
 	do_edit(@files);
 }
@@ -770,10 +810,6 @@ if (defined $smtp_server && $smtp_server ne '') {
 	$smtp_server_is_a_command = 0;
 }
 
-if ($compose && $compose > 0) {
-	@files = ($compose_filename . ".final", @files);
-}
-
 # Variables we set as part of the loop over files
 our ($message_id, %mail, $subject, $reply_to, $references, $message,
 	$needs_confirm, $message_num, $ask_default);
@@ -918,9 +954,12 @@ sub send_message
 	my $sanitized_sender = sanitize_address($sender);
 	make_message_id() unless defined($message_id);
 
+	my $has_non_ascii = ($subject =~ /[^[:ascii:]]/);
+	my $sanitized_subject = $has_non_ascii ? quote_rfc2047($subject) : $subject;
+
 	my $header = "From: $sanitized_sender
 To: $to${ccline}
-Subject: $subject
+Subject: $sanitized_subject
 Date: $date
 Message-Id: $message_id
 X-Mailer: git-send-email $gitversion
@@ -1280,7 +1319,14 @@ for (my $index = 0; $index < @files; $index++) {
 cleanup_compose_files();
 
 sub cleanup_compose_files() {
-	unlink($compose_filename, $compose_filename . ".final") if $compose;
+
+	if (defined $compose_final_path) {
+		unlink $compose_final_path;
+	}
+
+	if (defined $compose_path and not $compose) {
+		unlink $compose_path;
+	}
 }
 
 $smtp->quit if $smtp;
-- 
1.6.2.2.479.g2aec
