From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 2/2] annotate: Fix bug when parsing merges with differing real and logical parents.
Date: Mon,  7 Aug 2006 05:11:24 -0700
Message-ID: <11549526841904-git-send-email-ryan@michonline.com>
References: <20060807115000.GC15477@h4x0r5.com> <1154952684908-git-send-email-ryan@michonline.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Aug 07 14:14:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA40C-00019M-GC
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 14:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWHGMOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 08:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWHGMOd
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 08:14:33 -0400
Received: from h4x0r5.com ([70.85.31.202]:45833 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932086AbWHGMOd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 08:14:33 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythryan.michonline.com)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GA3xn-0003Y6-Hl; Mon, 07 Aug 2006 05:12:08 -0700
Received: from ryan by mythryan.michonline.com with local (Exim 4.62)
	(envelope-from <ryan@mythryan.michonline.com>)
	id 1GA3x6-0007VY-NG; Mon, 07 Aug 2006 05:11:24 -0700
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2.rc3.g6487-dirty
In-Reply-To: <1154952684908-git-send-email-ryan@michonline.com>
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25010>

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---
 git-annotate.perl |  128 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 122 insertions(+), 6 deletions(-)

diff --git a/git-annotate.perl b/git-annotate.perl
index 505b5cc..215ed26 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -147,7 +147,7 @@ sub init_claim {
 
 
 sub handle_rev {
-	my $i = 0;
+	my $revseen = 0;
 	my %seen;
 	while (my $rev = shift @revqueue) {
 		next if $seen{$rev}++;
@@ -247,22 +247,129 @@ sub git_find_parent {
 	return $parent;
 }
 
+sub git_find_all_parents {
+	my ($rev) = @_;
+
+	my $revparent = open_pipe("git-rev-list","--remove-empty", "--parents","--max-count=1","$rev")
+		or die "Failed to open git-rev-list to find a single parent: $!";
+
+	my $parentline = <$revparent>;
+	chomp $parentline;
+	my ($origrev, @parents) = split m/\s+/, $parentline;
+
+	close($revparent);
+
+	return @parents;
+}
+
+sub git_merge_base {
+	my ($rev1, $rev2) = @_;
+
+	my $mb = open_pipe("git-merge-base", $rev1, $rev2)
+	        or die "Failed to open git-merge-base: $!";
+
+	my $base = <$mb>;
+	chomp $base;
+
+	close($mb);
+
+	return $base;
+}
+
+# Construct a set of pseudo parents that are in the same order,
+# and the same quantity as the real parents,
+# but whose SHA1s are as similar to the logical parents
+# as possible.
+sub get_pseudo_parents {
+	my ($all, $fake) = @_;
+
+	my @all = @$all;
+	my @fake = @$fake;
+
+	my @pseudo;
+
+	my %fake = map {$_ => 1} @fake;
+	my %seenfake;
+
+	my $fakeidx = 0;
+	foreach my $p (@all) {
+		if (exists $fake{$p}) {
+			if ($fake[$fakeidx] ne $p) {
+				die sprintf("parent mismatch: %s != %s\nall:%s\nfake:%s\n",
+					    $fake[$fakeidx], $p,
+					    join(", ", @all),
+					    join(", ", @fake),
+					   );
+			}
+
+			push @pseudo, $p;
+			$fakeidx++;
+			$seenfake{$p}++;
+
+		} else {
+			my $base = git_merge_base($fake[$fakeidx], $p);
+			if ($base ne $fake[$fakeidx]) {
+				die sprintf("Result of merge-base doesn't match fake: %s,%s != %s\n",
+				       $fake[$fakeidx], $p, $base);
+			}
+
+			# The details of how we parse the diffs
+			# mean that we cannot have a duplicate
+			# revision in the list, so if we've already
+			# seen the revision we would normally add, just use
+			# the actual revision.
+			if ($seenfake{$base}) {
+				push @pseudo, $p;
+			} else {
+				push @pseudo, $base;
+				$seenfake{$base}++;
+			}
+		}
+	}
+
+	return @pseudo;
+}
+
 
 # Get a diff between the current revision and a parent.
 # Record the commit information that results.
 sub git_diff_parse {
 	my ($parents, $rev, %revinfo) = @_;
 
+	my @pseudo_parents;
+	my @command = ("git-diff-tree");
+	my $revision_spec;
+
+	if (scalar @$parents == 1) {
+
+		$revision_spec = join("..", $parents->[0], $rev);
+		@pseudo_parents = @$parents;
+	} else {
+		my @all_parents = git_find_all_parents($rev);
+
+		if (@all_parents !=  @$parents) {
+			@pseudo_parents = get_pseudo_parents(\@all_parents, $parents);
+		} else {
+			@pseudo_parents = @$parents;
+		}
+
+		$revision_spec = $rev;
+		push @command, "-c";
+	}
+
 	my @filenames = ( $revs{$rev}{'filename'} );
+
 	foreach my $parent (@$parents) {
 		push @filenames, $revs{$parent}{'filename'};
 	}
 
-	my $diff = open_pipe("git-diff-tree","-M","-p","-c",$rev,"--",
-				@filenames )
+	push @command, "-p", "-M", $revision_spec, "--", @filenames;
+
+
+	my $diff = open_pipe( @command )
 		or die "Failed to call git-diff for annotation: $!";
 
-	_git_diff_parse($diff, $parents, $rev, %revinfo);
+	_git_diff_parse($diff, \@pseudo_parents, $rev, %revinfo);
 
 	close($diff);
 }
@@ -283,6 +390,7 @@ sub _git_diff_parse {
 	$diff_header_regexp .= "@" x @$parents;
 	$diff_header_regexp .= ' -\d+,\d+' x @$parents;
 	$diff_header_regexp .= ' \+(\d+),\d+';
+	$diff_header_regexp .= " " . ("@" x @$parents);
 
 	my %claim_regexps;
 	my $allparentplus = '^' . '\\+' x @$parents . '(.*)$';
@@ -311,6 +419,7 @@ sub _git_diff_parse {
 	DIFF:
 	while(<$diff>) {
 		chomp;
+		#printf("%d:%s:\n", $gotheader, $_);
 		if (m/$diff_header_regexp/) {
 			$remstart = $1 - 1;
 			# (0-based arrays)
@@ -391,10 +500,17 @@ sub _git_diff_parse {
 						printf("parent %s is on line %d\n", $parent, $pi{$parent});
 					}
 
+					my @context;
+					for (my $i = -2; $i < 2; $i++) {
+						push @context, get_line($slines, $ri + $i);
+					}
+					my $context = join("\n", @context);
+
+					my $justline = substr($_, scalar @$parents);
 					die sprintf("Line %d, does not match:\n|%s|\n|%s|\n%s\n",
 						    $ri,
-						substr($_,scalar @$parents),
-						get_line($slines,$ri), $rev);
+						    $justline,
+						    $context);
 				}
 				foreach my $parent (@$parents) {
 					$plines{$parent}[$pi{$parent}++] = $slines->[$ri];
-- 
1.4.2.rc3.g6487-dirty
