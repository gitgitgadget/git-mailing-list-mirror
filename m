From: Victor Kartashov <v.kartashov@npo-echelon.ru>
Subject: Re: [PATCH] gitweb: gpg signature status indication for commits
Date: Fri, 28 Mar 2014 13:48:50 +0400
Message-ID: <1396000130-10322-1-git-send-email-v.kartashov@npo-echelon.ru>
Cc: git@vger.kernel.org, Victor Kartashov <victor.kartashov@gmail.com>
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Mar 28 10:49:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTTPH-00061R-JV
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 10:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbaC1Jsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 05:48:55 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:54398 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbaC1Jsy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 05:48:54 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so3534515lbj.31
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 02:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=vR0RJgub03guJXDRSJVtnRm6kLfQDOe200Sh60bbygU=;
        b=hA/AsdV/yLc2xGwGKfsv+YMglXB85rRh5SJnvGP9NH/geEWKEtIg7SBT1FktfddcUd
         6f98Xl0f4wHI9JOQkXMZpXFLdBHkTmDpUNHFPwcNqZG1PtMn/gD3/1dfsbHrongPfSZu
         EEBsaX2KEZsbnGOdo3Js/xlpb4g1m5FOyLj4EX9n0x6Z0rxsDt2/cqpIQ0sU5psb2v7+
         zFLRCs5A1AWOv2BIiY1GmqNKPY0A3TM413s1SzRICDp1xovYpnqfjxmlW+72r67Mqc0L
         7YIAUGzOm1H0LONVqe7BsBSCECtxwToo5E4BiA3BCZ5zd2K4wFIQUj0CW7Bvd8aCpPeK
         0jqQ==
X-Received: by 10.152.2.131 with SMTP id 3mr4941050lau.20.1396000132593;
        Fri, 28 Mar 2014 02:48:52 -0700 (PDT)
Received: from localhost.localdomain (79-172-117-143.dyn.broadband.iskratelecom.ru. [79.172.117.143])
        by mx.google.com with ESMTPSA id el7sm4609580lac.10.2014.03.28.02.48.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Mar 2014 02:48:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.10.g8974033
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245374>

show gpg signature (if any) for commit message in gitweb
in case of valid signature highlight it with green
in case of invalid signature highlight it with red

Signed-off-by: Victor Kartashov <victor.kartashov@gmail.com>
---
here's new patch
fixed remarks by Eric Sunshine
"pop @commit_lines" in parse_commit_text() leads to a loss of the last line in commit message ('sign-off' line, for example), so I search for '\0' before removing it.

 gitweb/gitweb.perl       | 36 +++++++++++++++++++++++++++++-------
 gitweb/static/gitweb.css | 11 +++++++++++
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 79057b7..ccde90f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3430,8 +3430,9 @@ sub parse_commit_text {
 	my ($commit_text, $withparents) = @_;
 	my @commit_lines = split '\n', $commit_text;
 	my %co;
+	my @signature = ();
 
-	pop @commit_lines; # Remove '\0'
+	pop @commit_lines if ($commit_lines[-1] =~ "\0"); # Remove '\0'
 
 	if (! @commit_lines) {
 		return;
@@ -3469,6 +3470,9 @@ sub parse_commit_text {
 				$co{'committer_name'} = $co{'committer'};
 			}
 		}
+		elsif ($line =~ /^gpg: /) {
+			push @signature, $line;
+		}
 	}
 	if (!defined $co{'tree'}) {
 		return;
@@ -3508,6 +3512,10 @@ sub parse_commit_text {
 	foreach my $line (@commit_lines) {
 		$line =~ s/^    //;
 	}
+	push(@commit_lines, "") if scalar @signature;
+	foreach my $sig (@signature) {
+		push(@commit_lines, $sig);
+	}
 	$co{'comment'} = \@commit_lines;
 
 	my $age = time - $co{'committer_epoch'};
@@ -3530,13 +3538,13 @@ sub parse_commit {
 
 	local $/ = "\0";
 
-	open my $fd, "-|", git_cmd(), "rev-list",
-		"--parents",
-		"--header",
-		"--max-count=1",
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
 
@@ -4571,7 +4579,21 @@ sub git_print_log {
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
+		elsif ($line =~ m/^gpg:(.)+BAD(.)+/) {
+			if (! $opts{'-remove_signoff'}) {
+				print "<span class=\"bad_sign\">" . esc_html($line) . "</span><br/>\n";
+				$skip_blank_line = 1;
+			}
+			next;
+		}
+		elsif ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
 			if (! $opts{'-remove_signoff'}) {
 				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
 				$skip_blank_line = 1;
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 3212601..e99e223 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -136,6 +136,17 @@ span.signoff {
 	color: #888888;
 }
 
+span.good_sign {
+	font-weight: bold;
+	background-color: #aaffaa;
+}
+
+span.bad_sign {
+	font-weight: bold;
+	background-color: #880000;
+	color: #ffffff
+}
+
 div.log_link {
 	padding: 0px 8px;
 	font-size: 70%;
-- 
1.8.3.rc0.10.g8974033
