From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 6/6] Remove bareword filehandles in git-send-email.perl
Date: Wed, 29 Apr 2009 09:12:23 -0400
Message-ID: <1241010743-7020-7-git-send-email-wfp5p@virginia.edu>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-2-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-3-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-4-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-5-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-6-git-send-email-wfp5p@virginia.edu>
Cc: gitster@pobox.com, Bill Pemberton <wfp5p@virginia.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 15:16:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz9ed-0003wt-Bx
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 15:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760234AbZD2NMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 09:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760209AbZD2NMd
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 09:12:33 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:37685 "EHLO
	viridian.itc.Virginia.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760091AbZD2NM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 09:12:28 -0400
Received: by viridian.itc.Virginia.EDU (Postfix, from userid 1249)
	id 350AC57191; Wed, 29 Apr 2009 09:12:24 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1241010743-7020-6-git-send-email-wfp5p@virginia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117886>

The script was using bareword filehandles.  This is considered a bad
practice so they have been changed to indirect filehandles.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 git-send-email.perl |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5e7295d..7068041 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -527,7 +527,7 @@ if ($compose) {
 	$compose_filename = ($repo ?
 		tempfile(".gitsendemail.msg.XXXXXX", DIR => $repo->repo_path()) :
 		tempfile(".gitsendemail.msg.XXXXXX", DIR => "."))[1];
-	open(C,">",$compose_filename)
+	open my $C,'>',$compose_filename
 		or die "Failed to open for writing $compose_filename: $!";
 
 
@@ -535,7 +535,7 @@ if ($compose) {
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_reply_to = $initial_reply_to || '';
 
-	print C <<EOT;
+	print {$C} <<EOT;
 From $tpl_sender # This line is ignored.
 GIT: Lines beginning in "GIT: " will be removed.
 GIT: Consider including an overall diffstat or table of contents
@@ -548,9 +548,9 @@ In-Reply-To: $tpl_reply_to
 
 EOT
 	for my $f (@files) {
-		print C get_patch_subject($f);
+		print {$C} get_patch_subject($f);
 	}
-	close(C);
+	close($C);
 
 	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
 
@@ -560,23 +560,23 @@ EOT
 		do_edit($compose_filename);
 	}
 
-	open(C2,">",$compose_filename . ".final")
+	open my $C2,'>',$compose_filename . ".final"
 		or die "Failed to open $compose_filename.final : " . $!;
 
-	open(C,"<",$compose_filename)
+	open $C, '<',$compose_filename
 		or die "Failed to open $compose_filename : " . $!;
 
 	my $need_8bit_cte = file_has_nonascii($compose_filename);
 	my $in_body = 0;
 	my $summary_empty = 1;
-	while(<C>) {
+	while(<$C>) {
 		next if m/^GIT: /;
 		if ($in_body) {
 			$summary_empty = 0 unless (/^\n$/);
 		} elsif (/^\n$/) {
 			$in_body = 1;
 			if ($need_8bit_cte) {
-				print C2 "MIME-Version: 1.0\n",
+				print {$C2} "MIME-Version: 1.0\n",
 					 "Content-Type: text/plain; ",
 					   "charset=utf-8\n",
 					 "Content-Transfer-Encoding: 8bit\n";
@@ -601,10 +601,10 @@ EOT
 			print "To/Cc/Bcc fields are not interpreted yet, they have been ignored\n";
 			next;
 		}
-		print C2 $_;
+		print {$C2} $_;
 	}
-	close(C);
-	close(C2);
+	close($C);
+	close($C2);
 
 	if ($summary_empty) {
 		print "Summary email is empty, skipping it\n";
@@ -984,7 +984,7 @@ $subject = $initial_subject;
 $message_num = 0;
 
 foreach my $t (@files) {
-	open(F,"<",$t) or die "can't open file $t";
+	open my $F,'<',$t or die "can't open file $t";
 
 	my $author = undef;
 	my $author_encoding;
@@ -997,7 +997,7 @@ foreach my $t (@files) {
 	$message = "";
 	$message_num++;
 	# First unfold multiline header fields
-	while(<F>) {
+	while(<$F>) {
 		last if /^\s*$/;
 		if (/^\s+\S/ and @header) {
 			chomp($header[$#header]);
@@ -1073,7 +1073,7 @@ foreach my $t (@files) {
 		}
 	}
 	# Now parse the message body
-	while(<F>) {
+	while(<$F>) {
 		$message .=  $_;
 		if (/^(Signed-off-by|Cc): (.*)$/i) {
 			chomp;
@@ -1090,12 +1090,12 @@ foreach my $t (@files) {
 				$c, $_) unless $quiet;
 		}
 	}
-	close F;
+	close $F;
 
 	if (defined $cc_cmd && !$suppress_cc{'cccmd'}) {
-		open(F, "$cc_cmd $t |")
+		open my $F, '-|', "$cc_cmd $t"
 			or die "(cc-cmd) Could not execute '$cc_cmd'";
-		while(<F>) {
+		while(<$F>) {
 			my $c = $_;
 			$c =~ s/^\s*//g;
 			$c =~ s/\n$//g;
@@ -1104,7 +1104,7 @@ foreach my $t (@files) {
 			printf("(cc-cmd) Adding cc: %s from: '%s'\n",
 				$c, $cc_cmd) unless $quiet;
 		}
-		close F
+		close $F
 			or die "(cc-cmd) failed to close pipe to '$cc_cmd'";
 	}
 
-- 
1.6.0.6
