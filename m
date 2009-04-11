From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 10/10] send-email: --compose takes optional argument to existing file
Date: Sat, 11 Apr 2009 14:08:28 -0500
Message-ID: <1239476908-25944-10-git-send-email-mfwitten@gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-5-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-6-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-7-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-8-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-9-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 21:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsikh-0003qw-7Y
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758752AbZDKTST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758470AbZDKTSS
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:18:18 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:3460 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758413AbZDKTSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:18:17 -0400
Received: by an-out-0708.google.com with SMTP id d14so1370108and.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=k6PKaeFe35VdSrKfRANTj/o19wGWy0jV1PgvVXZCVyA=;
        b=ATrTmG2mJjaa9eDjcahDeM7NySAa9dUI1H+q93baEfo1L+n/gZgjin6zBw6dBBU1sm
         5WriRs3mGWCw+kZH8qnsrqFsmr5QN7oGOB3iDDSnRhAB+MZnJSaf4EfsEF5e99nPvMJ7
         2ZM5NFpQHT73VoxYq5K8T/gz5qgjWWtR2gig0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Yn7NkH6oE+ClXv1Hn7diOhR4eLiS+oLuvdwfmLuysxlSpIRphZnnMq+3J2ROkgRbEk
         el3y7qJdmNjdXr5NiZoGe3pOgZrY46Q2SpQKUAI5LoadQGI+tgzOqa6Eu+kcavYZyJhA
         WzwLcGxg1Zf1ddgWqmGd12o1/XOxSML0qGo7o=
Received: by 10.100.152.12 with SMTP id z12mr1658354and.141.1239477495467;
        Sat, 11 Apr 2009 12:18:15 -0700 (PDT)
Received: from localhost.localdomain (97-116-109-29.mpls.qwest.net [97.116.109.29])
        by mx.google.com with ESMTPS id 9sm5461438ywf.6.2009.04.11.12.18.14
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 12:18:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239476908-25944-9-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116320>

Now, a user may specify an existing (in-progress) file to use as
the introductory/summary email.

The file is opened for any additional editing as usual, but it
is not deleted upon normal termination.

There are also a number of fixes to how the internals and
temporaries are handled.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   39 ++++++--
 git-send-email.perl              |  190 ++++++++++++++++++++++++--------------
 2 files changed, 151 insertions(+), 78 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 07c831e..a2af3e5 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -60,17 +60,38 @@ The --bcc option must be repeated for each user you want on the bcc list.
 +
 The --cc option must be repeated for each user you want on the cc list.
 
---compose::
-	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
-	introductory message for the patch series.
+--compose[=<path>]::
+	Use `$GIT_EDITOR`, 'core.editor', `$VISUAL`, or `$EDITOR`, or
+	`vi` to edit an introductory message for the patch series. A
+	path for the intermediate composition may be given. If the path
+	doesn't exist, a file with default contents is created at the
+	path and opened for editing. If the path does exist, then the
+	file at that path is opened for editing as-is. If no path is
+	specified, a new temporary file is created with some default
+	contents. Upon the successful completion of send-email, all
+	temporary files are automatically unlinked (deleted). However,
+	if send-email is terminated by a trappable signal, then this
+	temporary file is not unlinked, and the user is informed of its
+	path.
 +
-When '--compose' is used, git send-email will use the From, Subject, and
-In-Reply-To headers specified in the message. If the body of the message
-(what you type after the headers and a blank line) only contains blank
-(or GIT: prefixed) lines the summary won't be sent, but From, Subject,
-and In-Reply-To headers will be used unless they are removed.
+The user actually composes what will become a valid email message;
+therefore, the message must have the following form (as described in
+`RFC 822`):
 +
-Missing From or In-Reply-To headers will be prompted for.
+	<headers>
+	<blank line>
+	<body>
++
+In particular, `<headers>` must contain the "`Subject`" header. Once the
+user saves the message and quits the editor, this intermediate message is
+transformed into the final email message by removing all lines that begin
+with "`GIT:`". If the `<body>` of the final version is empty, then the
+email is not sent, and send-email proceeds as if '--compose' had never been
+used.
++
+The "`From`", "`Subject`", and "`In-Reply-To`" headers are taken directly
+from the message; missing "`From`" or "`In-Reply-To`" headers will be
+prompted for.
 
 --from=<address>::
 	Specify the sender of the emails.  This will default to
diff --git a/git-send-email.perl b/git-send-email.perl
index e771720..877732f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -63,10 +63,9 @@ git send-email [options] <file | directory | rev-list options >
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
     --smtp-server          <host>  * Outgoing SMTP server to use.
@@ -173,7 +172,7 @@ if ($@) {
 # Behavior modification variables
 my ($quiet, $dry_run) = (0, 0);
 my $format_patch;
-my $compose_filename;
+my ($compose_filename, $compose_final_filename);
 
 # Handle interactive edition of files.
 my $multiedit;
@@ -239,16 +238,15 @@ sub signal_handler {
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
+	if (defined $compose_final_filename) {
+		unlink $compose_final_filename if defined $compose_final_filename;
 	}
 
-	exit;
+	exit 1;
 };
 
 $SIG{TERM} = \&signal_handler;
@@ -273,8 +271,8 @@ my $rc = GetOptions(
 	"smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 	"smtp-encryption=s" => \$smtp_encryption,
 	"identity=s" => \$identity,
+	"compose:s" => \$compose,
 	"annotate" => \$annotate,
-	"compose" => \$compose,
 	"quiet" => \$quiet,
 	"cc-cmd=s" => \$cc_cmd,
 	"suppress-from!" => \$suppress_from,
@@ -596,36 +594,69 @@ sub get_patch_subject($) {
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
+if (defined $compose) {{
 
-EOT
-	for my $f (@files) {
-		print C "GIT: ", get_patch_subject($f), "\n";
+	# Some parameters for creating temporary files:
+
+	my $template = ".gitsendemail.msg.XXXXXX";
+	my @dir = (DIR => ($repo ? $repo->repo_path() : "."));
+	my @suffix = (SUFFIX => ".final");
+
+	# Figure out the file that the user should be editing:
+
+	my $compose_file;
+	my $needs_default_contents;
+
+	if ($compose eq '') { # if no path was given
+		$needs_default_contents = 1;
+		($compose_file, $compose_filename) = tempfile($template, @dir)
+			or die "--compose: Could not create temporary file for the user to edit: $!\n";
+	} else {
+		$compose_filename = $compose;
+		$needs_default_contents = not -f $compose_filename;
 	}
-	close(C);
+
+	# Fill in default contents if necessary:
+
+	if ($needs_default_contents) {
+
+		open $compose_file, ">", $compose_filename;
+
+		# For convenience:
+
+		local *STDOUT = $compose_file;
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
+			print "GIT: ", get_patch_subject($f), "\n";
+		}
+	}
+
+	# Do the editing:
 
 	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
 
@@ -635,23 +666,40 @@ EOT
 		do_edit($compose_filename);
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
+	unless (-f $compose_filename) {
+		print "--compose: File '$compose_filename' doesn't exist; not sending.\n";
+		last;
+	}
+
+	open $compose_file, "<", $compose_filename
+		or die "--compose: Failed to open '$compose_filename' for reading: $!";
 
-	open(C,"<",$compose_filename)
-		or die "Failed to open $compose_filename : " . $!;
+	# Create the final version:
 
+	(my $compose_final_file, $compose_final_filename) = tempfile($template, @dir, @suffix)
+		or die "--compose: Could not create temporary file for final version: $!\n";
+
+	my ($subject, $reply_to, $from);
 	my $need_8bit_cte = file_has_nonascii($compose_filename);
 	my $in_body = 0;
 	my $summary_empty = 1;
-	while(<C>) {
+	while(<$compose_file>) {
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
@@ -660,33 +708,31 @@ EOT
 		} elsif (/^MIME-Version:/i) {
 			$need_8bit_cte = 0;
 		} elsif (/^Subject:\s*(.+)\s*$/i) {
-			$initial_subject = $1;
-			my $subject = $initial_subject;
-			$_ = "Subject: " .
-				($subject =~ /[^[:ascii:]]/ ?
-				quote_rfc2047($subject) :
-				$subject) .
-				"\n";
+			$subject = $1;
+			next;
 		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
-			$initial_reply_to = $1;
+			$reply_to = $1;
 			next;
 		} elsif (/^From:\s*(.+)\s*$/i) {
-			$sender = $1;
+			$from = $1;
 			next;
 		} elsif (/^(?:To|Cc|Bcc):/i) {
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
-} elsif ($annotate) {
+
+	print("Summary email is empty, skipping it.\n"), last if ($summary_empty);
+
+	$initial_subject = $subject;
+	$initial_reply_to = $reply_to;
+	$sender = $from;
+
+	unshift(@files, $compose_final_filename);
+
+}} elsif ($annotate) {
 	do_edit(@files);
 }
 
@@ -776,10 +822,6 @@ if (defined $smtp_server and $smtp_server ne '') {
 	$smtp_server ||= '127.0.0.1';
 }
 
-if ($compose && $compose > 0) {
-	@files = ($compose_filename . ".final", @files);
-}
-
 # Variables we set as part of the loop over files
 our ($message_id, %mail, $subject, $reply_to, $references, $message,
 	$needs_confirm, $message_num, $ask_default);
@@ -924,9 +966,12 @@ sub send_message
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
@@ -1286,7 +1331,14 @@ for (my $index = 0; $index < @files; $index++) {
 cleanup_compose_files();
 
 sub cleanup_compose_files() {
-	unlink($compose_filename, $compose_filename . ".final") if $compose;
+
+	if (defined $compose_final_filename) {
+		unlink $compose_final_filename;
+	}
+
+	if (defined $compose_filename and not $compose) {
+		unlink $compose_filename;
+	}
 }
 
 $smtp->quit if $smtp;
-- 
1.6.2.2.479.g2aec
