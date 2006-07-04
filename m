From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 2/2] annotate: Correct most merge following to annotate correctly.
Date: Mon, 03 Jul 2006 21:30:02 -0400
Message-ID: <11519766031273-git-send-email-ryan@michonline.com>
References: <11519766021208-git-send-email-ryan@michonline.com> <11519766033852-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Tue Jul 04 03:33:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxZmb-0000N0-R8
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 03:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWGDBct (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 21:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWGDBct
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 21:32:49 -0400
Received: from h4x0r5.com ([70.85.31.202]:60164 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751178AbWGDBcs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 21:32:48 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythical)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FxZkI-0004EM-Lk; Mon, 03 Jul 2006 18:30:35 -0700
Received: from ryan by mythical with local (Exim 4.62)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FxZjn-00042j-Aj; Mon, 03 Jul 2006 21:30:03 -0400
To: junkio@cox.net
X-Mailer: git-send-email 1.4.1.g8fced
In-Reply-To: <11519766033852-git-send-email-ryan@michonline.com>
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23232>

There is still a bug involving octopus merges, somewhere, but this gets normal
merges correct, so it's still an improvement over the existing version.

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---
 git-annotate.perl |  197 +++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 139 insertions(+), 58 deletions(-)

diff --git a/git-annotate.perl b/git-annotate.perl
index a6a7a48..9a7b022 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -102,10 +102,10 @@ while (my $bound = pop @stack) {
 push @revqueue, $head;
 init_claim( defined $starting_rev ? $head : 'dirty');
 unless (defined $starting_rev) {
-	my $diff = open_pipe("git","diff","-R", "HEAD", "--",$filename)
+	my $diff = open_pipe("git","diff","HEAD", "--",$filename)
 		or die "Failed to call git diff to check for dirty state: $!";
 
-	_git_diff_parse($diff, $head, "dirty", (
+	_git_diff_parse($diff, [$head], "dirty", (
 				'author' => gitvar_name("GIT_AUTHOR_IDENT"),
 				'author_date' => sprintf("%s +0000",time()),
 				)
@@ -154,14 +154,13 @@ sub handle_rev {
 
 		my %revinfo = git_commit_info($rev);
 
-		foreach my $p (@{$revs{$rev}{'parents'}}) {
-
-			git_diff_parse($p, $rev, %revinfo);
-			push @revqueue, $p;
-		}
+		if (exists $revs{$rev}{parents} &&
+		    scalar @{$revs{$rev}{parents}} != 0) {
 
+			git_diff_parse($revs{$rev}{'parents'}, $rev, %revinfo);
+			push @revqueue, @{$revs{$rev}{'parents'}};
 
-		if (scalar @{$revs{$rev}{parents}} == 0) {
+ 		} else {
 			# We must be at the initial rev here, so claim everything that is left.
 			for (my $i = 0; $i < @{$revs{$rev}{lines}}; $i++) {
 				if (ref ${$revs{$rev}{lines}}[$i] eq '' || ${$revs{$rev}{lines}}[$i][1] eq '') {
@@ -252,89 +251,171 @@ sub git_find_parent {
 # Get a diff between the current revision and a parent.
 # Record the commit information that results.
 sub git_diff_parse {
-	my ($parent, $rev, %revinfo) = @_;
+	my ($parents, $rev, %revinfo) = @_;
+
+	my @filenames = ( $revs{$rev}{'filename'} );
+	foreach my $parent (@$parents) {
+		push @filenames, $revs{$parent}{'filename'};
+	}
 
-	my $diff = open_pipe("git-diff-tree","-M","-p",$rev,$parent,"--",
-			$revs{$rev}{'filename'}, $revs{$parent}{'filename'})
+	my $diff = open_pipe("git-diff-tree","-M","-p","-c",$rev,"--",
+				@filenames )
 		or die "Failed to call git-diff for annotation: $!";
 
-	_git_diff_parse($diff, $parent, $rev, %revinfo);
+	_git_diff_parse($diff, $parents, $rev, %revinfo);
 
 	close($diff);
 }
 
 sub _git_diff_parse {
-	my ($diff, $parent, $rev, %revinfo) = @_;
+	my ($diff, $parents, $rev, %revinfo) = @_;
+
+	my $ri = 0;
 
-	my ($ri, $pi) = (0,0);
 	my $slines = $revs{$rev}{'lines'};
-	my @plines;
+	my (%plines, %pi);
 
 	my $gotheader = 0;
 	my ($remstart);
-	my ($hunk_start, $hunk_index);
+	my $parent_count = @$parents;
+
+	my $diff_header_regexp = "^@";
+	$diff_header_regexp .= "@" x @$parents;
+	$diff_header_regexp .= ' -\d+,\d+' x @$parents;
+	$diff_header_regexp .= ' \+(\d+),\d+';
+
+	my %claim_regexps;
+	my $allparentplus = '^' . '\\+' x @$parents . '(.*)$';
+
+	{
+		my $i = 0;
+		foreach my $parent (@$parents) {
+
+			$pi{$parent} = 0;
+			my $r = '^' . '.' x @$parents . '(.*)$';
+			my $p = $r;		     
+			substr($p,$i+1, 1) = '\\+';
+
+			my $m = $r;
+			substr($m,$i+1, 1) = '-';
+
+			$claim_regexps{$parent}{plus} = $p;
+			$claim_regexps{$parent}{minus} = $m;
+
+			$plines{$parent} = [];
+
+			$i++;
+		}
+	}
+
+	DIFF:
 	while(<$diff>) {
 		chomp;
-		if (m/^@@ -(\d+),(\d+) \+(\d+),(\d+)/) {
-			$remstart = $1;
-			# Adjust for 0-based arrays
-			$remstart--;
-			# Reinit hunk tracking.
-			$hunk_start = $remstart;
-			$hunk_index = 0;
+		if (m/$diff_header_regexp/) {
+			$remstart = $1 - 1;
+			# (0-based arrays)
+
 			$gotheader = 1;
 
-			for (my $i = $ri; $i < $remstart; $i++) {
-				$plines[$pi++] = $slines->[$i];
-				$ri++;
+			printf("Copying from %d to %d\n", $ri, $remstart);
+			foreach my $parent (@$parents) {
+				for (my $i = $ri; $i < $remstart; $i++) {
+					$plines{$parent}[$pi{$parent}++] = $slines->[$i];
+				}
 			}
-			next;
-		} elsif (!$gotheader) {
-			next;
-		}
+			$ri = $remstart;
 
-		if (m/^\+(.*)$/) {
-			my $line = $1;
-			$plines[$pi++] = [ $line, '', '', '', 0 ];
-			next;
+			next DIFF;
 
-		} elsif (m/^-(.*)$/) {
-			my $line = $1;
-			if (get_line($slines, $ri) eq $line) {
-				# Found a match, claim
-				claim_line($ri, $rev, $slines, %revinfo);
-			} else {
-				die sprintf("Sync error: %d/%d\n|%s\n|%s\n%s => %s\n",
-						$ri, $hunk_start + $hunk_index,
-						$line,
-						get_line($slines, $ri),
-						$rev, $parent);
-			}
-			$ri++;
+		} elsif (!$gotheader) {
+			# Skip over the leadin.
+			next DIFF;
+		}
 
-		} elsif (m/^\\/) {
+		if (m/^\\/) {
 			;
 			# Skip \No newline at end of file.
 			# But this can be internationalized, so only look
 			# for an initial \
 
 		} else {
-			if (substr($_,1) ne get_line($slines,$ri) ) {
-				die sprintf("Line %d (%d) does not match:\n|%s\n|%s\n%s => %s\n",
-						$hunk_start + $hunk_index, $ri,
-						substr($_,1),
-						get_line($slines,$ri),
-						$rev, $parent);
+			my %claims = ();
+			my $negclaim = 0;
+			my $allclaimed = 0;
+			my $line;
+
+			if (m/$allparentplus/) {
+				claim_line($ri, $rev, $slines, %revinfo);
+				$allclaimed = 1;
+
+			}
+
+			PARENT:
+			foreach my $parent (keys %claim_regexps) {
+				my $m = $claim_regexps{$parent}{minus};
+				my $p = $claim_regexps{$parent}{plus};
+
+				if (m/$m/) {
+					$line = $1;
+					$plines{$parent}[$pi{$parent}++] = [ $line, '', '', '', 0 ];
+					$negclaim++;
+
+				} elsif (m/$p/) {
+					$line = $1;
+					if (get_line($slines, $ri) eq $line) {
+						# Found a match, claim
+					       	$claims{$parent}++;
+
+					} else {
+						die sprintf("Sync error: %d\n|%s\n|%s\n%s => %s\n",
+								$ri, $line,
+								get_line($slines, $ri),
+								$rev, $parent);
+					}
+				}
+			}
+
+			if (%claims) {
+				foreach my $parent (@$parents) {
+					next if $claims{$parent} || $allclaimed;
+					$plines{$parent}[$pi{$parent}++] = $slines->[$ri];
+					    #[ $line, '', '', '', 0 ];
+				}
+				$ri++;
+
+			} elsif ($negclaim) {
+				next DIFF;
+
+			} else {
+				if (substr($_,scalar @$parents) ne get_line($slines,$ri) ) {
+				        foreach my $parent (@$parents) {
+						printf("parent %s is on line %d\n", $parent, $pi{$parent});
+					}
+
+					die sprintf("Line %d, does not match:\n|%s|\n|%s|\n%s\n",
+						    $ri,
+						substr($_,scalar @$parents),
+						get_line($slines,$ri), $rev);
+				}
+				foreach my $parent (@$parents) {
+					$plines{$parent}[$pi{$parent}++] = $slines->[$ri];
+				}
+				$ri++;
 			}
-			$plines[$pi++] = $slines->[$ri++];
 		}
-		$hunk_index++;
 	}
+
 	for (my $i = $ri; $i < @{$slines} ; $i++) {
-		push @plines, $slines->[$ri++];
+		foreach my $parent (@$parents) {
+			push @{$plines{$parent}}, $slines->[$ri];
+		}
+		$ri++;
+	}
+
+	foreach my $parent (@$parents) {
+		$revs{$parent}{lines} = $plines{$parent};
 	}
 
-	$revs{$parent}{lines} = \@plines;
 	return;
 }
 
-- 
1.4.1.g8fced
