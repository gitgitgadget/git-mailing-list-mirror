From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 1/8] gitweb: Add parse_commits, used to bulk load commit objects.
Date: Sun, 24 Dec 2006 14:31:42 +0000
Message-ID: <11669707092427-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Dec 24 15:31:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyUO3-0005SR-3w
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 15:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWLXObg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 09:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWLXObg
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 09:31:36 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:32840 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbWLXObf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 09:31:35 -0500
Received: from [212.2.174.82] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GyUNp-0002uQ-T8; Sun, 24 Dec 2006 14:31:26 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.ge655-dirty
In-Reply-To: 20061224143041.GF11474@localhost
References: 20061224143041.GF11474@localhost
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=1, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00, RCVD_IN_NJABL_DUL 3.00)
X-blacknight-igraine-MailScanner-SpamScore: s
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35360>

Add a new method parse_commits which is able to parse multiple commit
objects at once.  Reworked parse_commit to share the commit object
parsing logic.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |   91 ++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d01d689..6bd57a4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1270,25 +1270,13 @@ sub parse_tag {
 	return %tag
 }
 
-sub parse_commit {
-	my $commit_id = shift;
-	my $commit_text = shift;
-
-	my @commit_lines;
+sub parse_commit_text {
+	my ($commit_text) = @_;
+	my @commit_lines = split '\n', $commit_text;
 	my %co;
 
-	if (defined $commit_text) {
-		@commit_lines = @$commit_text;
-	} else {
-		local $/ = "\0";
-		open my $fd, "-|", git_cmd(), "rev-list",
-			"--header", "--parents", "--max-count=1",
-			$commit_id, "--"
-			or return;
-		@commit_lines = split '\n', <$fd>;
-		close $fd or return;
-		pop @commit_lines;
-	}
+	pop @commit_lines; # Remove '\0'
+
 	my $header = shift @commit_lines;
 	if (!($header =~ m/^[0-9a-fA-F]{40}/)) {
 		return;
@@ -1375,6 +1363,75 @@ sub parse_commit {
 	return %co;
 }
 
+sub parse_commit {
+	my ($commit_id) = @_;
+	my %co;
+
+	local $/ = "\0";
+
+	open my $fd, "-|", git_cmd(), "rev-list",
+		"--header",
+		"--parents",
+		"--max-count=1",
+		$commit_id,
+		"--",
+		or die_error(undef, "Open git-rev-list failed");
+	%co = parse_commit_text(<$fd>);
+	close $fd;
+
+	return %co;
+}
+
+sub parse_commits {
+	my ($commit_id, $maxcount, $skip, $arg, $filename) = @_;
+	my @cos;
+
+	$maxcount ||= 1;
+	$skip ||= 0;
+
+	# Delete once rev-list supports the --skip option
+	if ($skip > 0) {
+		open my $fd, "-|", git_cmd(), "rev-list",
+			($arg ? ($arg) : ()),
+			("--max-count=" . ($maxcount + $skip)),
+			$commit_id,
+			"--",
+			($filename ? ($filename) : ())
+			or die_error(undef, "Open git-rev-list failed");
+		while (my $line = <$fd>) {
+			if ($skip-- <= 0) {
+				chomp $line;
+				my %co = parse_commit($line);
+				push @cos, \%co;
+			}
+		}
+		close $fd;
+
+		return wantarray ? @cos : \@cos;
+	}
+
+	local $/ = "\0";
+
+	open my $fd, "-|", git_cmd(), "rev-list",
+		"--header",
+		"--parents",
+		($arg ? ($arg) : ()),
+		("--max-count=" . $maxcount),
+		# Add once rev-list supports the --skip option
+		# ("--skip=" . $skip),
+		$commit_id,
+		"--",
+		($filename ? ($filename) : ())
+		or die_error(undef, "Open git-rev-list failed");
+	while (my $line = <$fd>) {
+		my %co = parse_commit_text($line);
+		push @cos, \%co;
+	}
+	close $fd;
+
+	return wantarray ? @cos : \@cos;
+}
+
 # parse ref from ref_file, given by ref_id, with given type
 sub parse_ref {
 	my $ref_file = shift;
-- 
1.4.4.3.ge655-dirty
