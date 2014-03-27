From: Victor Kartashov <victor.kartashov@gmail.com>
Subject: [PATCH] gitweb: gpg signature status indication for commits
Date: Thu, 27 Mar 2014 18:56:20 +0400
Message-ID: <1395932180-19454-1-git-send-email-victor.kartashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 15:56:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTBjK-0002wm-V5
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 15:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824AbaC0O41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 10:56:27 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:49341 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbaC0O40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 10:56:26 -0400
Received: by mail-lb0-f169.google.com with SMTP id q8so2708564lbi.14
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=pxFNGg+fwC58XViO709mSYi8sEZFYCxyaUXlKBt4U8g=;
        b=ffaVGTZsaMDKKZ89ejh3rIC/lM19C+Iov0HbXKVjNHQH+TexpuEljI6Th2s0xKtNmS
         S1nKgshoiW8AxsOUa7A30fXsIZS2/yzGzfXUbH7EZsoYv9FsOkB3lUVQKTWe6suTEq7H
         vYvQvjgbuUpSxBTMg2GnDZWrRHAGDnA/jErGrMERYzw9GSZQ+lfCOEtl0tRwADT+AEt3
         5BrrXw4I/kGcOa/ZVLmWcnPtSW2L83eGIWVFAnOsR+DKgiXiOT6PV+C7/b3fKQFGL8q5
         9MhHuraeJ3xm2ojJ8O2Njob4PBUdexYuSYfRg5ubzV7veR+HIeq3m0Sx0aOtPtsR/k0A
         w1iQ==
X-Received: by 10.112.163.69 with SMTP id yg5mr1234525lbb.14.1395932184669;
        Thu, 27 Mar 2014 07:56:24 -0700 (PDT)
Received: from merlin-PC.echelon.lan ([85.202.231.172])
        by mx.google.com with ESMTPSA id tq9sm1581102lbb.10.2014.03.27.07.56.23
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 07:56:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245286>

shows gpg signature (if any) for commit message in gitweb
in case of successfully verifying the signature highlights it with green

Signed-off-by: Victor Kartashov <victor.kartashov@gmail.com>
---
 gitweb/gitweb.perl       | 33 ++++++++++++++++++++++++++-------
 gitweb/static/gitweb.css |  5 +++++
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 79057b7..0b41392 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3430,8 +3430,9 @@ sub parse_commit_text {
 	my ($commit_text, $withparents) = @_;
 	my @commit_lines = split '\n', $commit_text;
 	my %co;
+	my @signature = ();
 
-	pop @commit_lines; # Remove '\0'
+	pop @commit_lines if ($commit_lines[-1] eq "\0"); # Remove '\0'
 
 	if (! @commit_lines) {
 		return;
@@ -3469,6 +3470,10 @@ sub parse_commit_text {
 				$co{'committer_name'} = $co{'committer'};
 			}
 		}
+		elsif ($line =~ /^gpg: /)
+		{
+			push @signature, $line;
+		}
 	}
 	if (!defined $co{'tree'}) {
 		return;
@@ -3508,6 +3513,11 @@ sub parse_commit_text {
 	foreach my $line (@commit_lines) {
 		$line =~ s/^    //;
 	}
+	push(@commit_lines, "") if(scalar(@signature) > 0);
+	foreach my $sig (@signature)
+	{
+		push(@commit_lines, $sig);
+	}
 	$co{'comment'} = \@commit_lines;
 
 	my $age = time - $co{'committer_epoch'};
@@ -3530,13 +3540,15 @@ sub parse_commit {
 
 	local $/ = "\0";
 
-	open my $fd, "-|", git_cmd(), "rev-list",
-		"--parents",
-		"--header",
-		"--max-count=1",
+
+
+	open my $fd, "-|", git_cmd(), "show",
+		"--quiet",
+		"--date=raw",
+		"--pretty=format:%H %P%ntree %T%nparent %P%nauthor %an <%ae> %ad%ncommitter %cn <%ce> %cd%n%GG%n%s%n%n%b",
 		$commit_id,
 		"--",
-		or die_error(500, "Open git-rev-list failed");
+		or die_error(500, "Open git-show failed");
 	%co = parse_commit_text(<$fd>, 1);
 	close $fd;
 
@@ -4571,7 +4583,14 @@ sub git_print_log {
 	# print log
 	my $skip_blank_line = 0;
 	foreach my $line (@$log) {
-		if ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
+		if ($line =~ m/^gpg:(.)+Good(.)+/) {
+			if (! $opts{'-remove_signoff'}) {
+				print "<span class=\"good_sign\">" . esc_html($line) . "</span><br/>\n";
+				$skip_blank_line = 1;
+			}
+			next;
+		}
+		elsif ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
 			if (! $opts{'-remove_signoff'}) {
 				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
 				$skip_blank_line = 1;
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 3212601..0b7479c 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -136,6 +136,11 @@ span.signoff {
 	color: #888888;
 }
 
+span.good_sign {
+	font-weight: bold;
+	background-color: #aaffaa;
+}
+
 div.log_link {
 	padding: 0px 8px;
 	font-size: 70%;
-- 
1.8.3.2
