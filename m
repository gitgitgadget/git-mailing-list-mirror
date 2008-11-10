From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 4/4] git send-email: ask less questions when --compose is used.
Date: Tue, 11 Nov 2008 00:54:02 +0100
Message-ID: <1226361242-2516-5-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1226361242-2516-1-git-send-email-madcoder@debian.org>
 <1226361242-2516-2-git-send-email-madcoder@debian.org>
 <1226361242-2516-3-git-send-email-madcoder@debian.org>
 <1226361242-2516-4-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 00:55:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzgba-0003dS-UH
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbYKJXyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbYKJXyS
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:54:18 -0500
Received: from pan.madism.org ([88.191.52.104]:37654 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbYKJXyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:54:09 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 435FC3CD88;
	Tue, 11 Nov 2008 00:54:06 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0E9142A254; Tue, 11 Nov 2008 00:54:03 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4.862.g3e9be
In-Reply-To: <1226361242-2516-4-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100598>

When --compose is used, we can grab the From/Subject/In-Reply-To from the
edited summary, let it be so and don't ask the user silly questions.

The summary templates gets quite revamped, and includes the list of
patches subjects that are going to be sent with this batch.

When having a body full of empty lines, the summary isn't sent. Document
that in the git-send-email manpage fully.

Note: It doesn't deal with To/Cc/Bcc yet.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/git-send-email.txt |    9 ++
 git-send-email.perl              |  187 +++++++++++++++++++++++---------------
 2 files changed, 123 insertions(+), 73 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 66d5f4c..acf8bf4 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -45,6 +45,15 @@ The --cc option must be repeated for each user you want on the cc list.
 --compose::
 	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
 	introductory message for the patch series.
++
+When compose is in used, git send-email gets less interactive will use the
+values of the headers you set there. If the body of the email (what you type
+after the headers and a blank line) only contains blank (or GIT: prefixed)
+lines, the summary won't be sent, but git-send-email will still use the
+Headers values if you don't removed them.
++
+If it wasn't able to see a header in the summary it will ask you about it
+interactively after quitting your editor.
 
 --from::
 	Specify the sender of the emails.  This will default to
diff --git a/git-send-email.perl b/git-send-email.perl
index ccb3b18..9039cfd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -162,9 +162,17 @@ my $multiedit;
 my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
 sub do_edit {
 	if (defined($multiedit) && !$multiedit) {
-		map { system('sh', '-c', $editor.' "$@"', $editor, $_); } @_;
+		map {
+			system('sh', '-c', $editor.' "$@"', $editor, $_);
+			if (($? & 127) || ($? >> 8)) {
+				die("the editor exited uncleanly, aborting everything");
+			}
+		} @_;
 	} else {
 		system('sh', '-c', $editor.' "$@"', $editor, @_);
+		if (($? & 127) || ($? >> 8)) {
+			die("the editor exited uncleanly, aborting everything");
+		}
 	}
 }
 
@@ -450,6 +458,108 @@ if (@files) {
 	usage();
 }
 
+sub get_patch_subject($) {
+	my $fn = shift;
+	open (my $fh, '<', $fn);
+	while (my $line = <$fh>) {
+		next unless ($line =~ /^Subject: (.*)$/);
+		close $fh;
+		return "GIT: $1\n";
+	}
+	close $fh;
+	die "No subject line in $fn ?";
+}
+
+if ($compose) {
+	# Note that this does not need to be secure, but we will make a small
+	# effort to have it be unique
+	open(C,">",$compose_filename)
+		or die "Failed to open for writing $compose_filename: $!";
+
+
+	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
+	my $tpl_subject = $initial_subject || '';
+	my $tpl_reply_to = $initial_reply_to || '';
+
+	print C <<EOT;
+From $tpl_sender # This line is ignored.
+GIT: Lines beginning in "GIT: " will be removed.
+GIT: Consider including an overall diffstat or table of contents
+GIT: for the patch you are writing.
+GIT:
+GIT: Clear the body content if you don't wish to send a summary.
+From: $tpl_sender
+Subject: $tpl_subject
+In-Reply-To: $tpl_reply_to
+
+EOT
+	for my $f (@files) {
+		print C get_patch_subject($f);
+	}
+	close(C);
+
+	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+
+	if ($annotate) {
+		do_edit($compose_filename, @files);
+	} else {
+		do_edit($compose_filename);
+	}
+
+	open(C2,">",$compose_filename . ".final")
+		or die "Failed to open $compose_filename.final : " . $!;
+
+	open(C,"<",$compose_filename)
+		or die "Failed to open $compose_filename : " . $!;
+
+	my $need_8bit_cte = file_has_nonascii($compose_filename);
+	my $in_body = 0;
+	my $summary_empty = 1;
+	while(<C>) {
+		next if m/^GIT: /;
+		if ($in_body) {
+			$summary_empty = 0 unless (/^\n$/);
+		} elsif (/^\n$/) {
+			$in_body = 1;
+			if ($need_8bit_cte) {
+				print C2 "MIME-Version: 1.0\n",
+					 "Content-Type: text/plain; ",
+					   "charset=utf-8\n",
+					 "Content-Transfer-Encoding: 8bit\n";
+			}
+		} elsif (/^MIME-Version:/i) {
+			$need_8bit_cte = 0;
+		} elsif (/^Subject:\s*(.+)\s*$/i) {
+			$initial_subject = $1;
+			my $subject = $initial_subject;
+			$_ = "Subject: " .
+				($subject =~ /[^[:ascii:]]/ ?
+				 quote_rfc2047($subject) :
+				 $subject) .
+				"\n";
+		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
+			$initial_reply_to = $1;
+			next;
+		} elsif (/^From:\s*(.+)\s*$/i) {
+			$sender = $1;
+			next;
+		} elsif (/^(?:To|Cc|Bcc):/i) {
+			print "To/Cc/Bcc fields are not interpreted yet, they have been ignored\n";
+			next;
+		}
+		print C2 $_;
+	}
+	close(C);
+	close(C2);
+
+	if ($summary_empty) {
+		print "Summary email is empty, skipping it\n";
+		$compose = -1;
+	}
+} elsif ($annotate) {
+	do_edit(@files);
+}
+
 my $prompting = 0;
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter || '';
@@ -494,17 +604,6 @@ sub expand_aliases {
 @initial_cc = expand_aliases(@initial_cc);
 @bcclist = expand_aliases(@bcclist);
 
-if (!defined $initial_subject && $compose) {
-	while (1) {
-		$_ = $term->readline("What subject should the initial email start with? ", $initial_subject);
-		last if defined $_;
-		print "\n";
-	}
-
-	$initial_subject = $_;
-	$prompting++;
-}
-
 if ($thread && !defined $initial_reply_to && $prompting) {
 	while (1) {
 		$_= $term->readline("Message-ID to be used as In-Reply-To for the first email? ", $initial_reply_to);
@@ -531,64 +630,6 @@ if (!defined $smtp_server) {
 }
 
 if ($compose) {
-	# Note that this does not need to be secure, but we will make a small
-	# effort to have it be unique
-	open(C,">",$compose_filename)
-		or die "Failed to open for writing $compose_filename: $!";
-	print C "From $sender # This line is ignored.\n";
-	printf C "Subject: %s\n\n", $initial_subject;
-	printf C <<EOT;
-GIT: Please enter your email below.
-GIT: Lines beginning in "GIT: " will be removed.
-GIT: Consider including an overall diffstat or table of contents
-GIT: for the patch you are writing.
-
-EOT
-	close(C);
-
-	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
-
-	if ($annotate) {
-		do_edit($compose_filename, @files);
-	} else {
-		do_edit($compose_filename);
-	}
-
-	open(C2,">",$compose_filename . ".final")
-		or die "Failed to open $compose_filename.final : " . $!;
-
-	open(C,"<",$compose_filename)
-		or die "Failed to open $compose_filename : " . $!;
-
-	my $need_8bit_cte = file_has_nonascii($compose_filename);
-	my $in_body = 0;
-	while(<C>) {
-		next if m/^GIT: /;
-		if (!$in_body && /^\n$/) {
-			$in_body = 1;
-			if ($need_8bit_cte) {
-				print C2 "MIME-Version: 1.0\n",
-					 "Content-Type: text/plain; ",
-					   "charset=utf-8\n",
-					 "Content-Transfer-Encoding: 8bit\n";
-			}
-		}
-		if (!$in_body && /^MIME-Version:/i) {
-			$need_8bit_cte = 0;
-		}
-		if (!$in_body && /^Subject: ?(.*)/i) {
-			my $subject = $1;
-			$_ = "Subject: " .
-				($subject =~ /[^[:ascii:]]/ ?
-				 quote_rfc2047($subject) :
-				 $subject) .
-				"\n";
-		}
-		print C2 $_;
-	}
-	close(C);
-	close(C2);
-
 	while (1) {
 		$_ = $term->readline("Send this email? (y|n) ");
 		last if defined $_;
@@ -600,9 +641,9 @@ EOT
 		exit(0);
 	}
 
-	@files = ($compose_filename . ".final", @files);
-} elsif ($annotate) {
-	do_edit(@files);
+	if ($compose > 0) {
+		@files = ($compose_filename . ".final", @files);
+	}
 }
 
 # Variables we set as part of the loop over files
-- 
1.6.0.4.859.g7ecd.dirty
