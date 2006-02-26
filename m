From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] annotate: Convert all -| calls to use a helper open_pipe().
Date: Sat, 25 Feb 2006 22:02:05 -0500
Message-ID: <1140922925166-git-send-email-ryan@michonline.com>
References: <11409185133616-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 04:02:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDCB2-0002Ai-EN
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 04:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWBZDCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 22:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWBZDCP
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 22:02:15 -0500
Received: from mail.autoweb.net ([198.172.237.26]:38883 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751192AbWBZDCP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 22:02:15 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FDCAm-00009l-Ul; Sat, 25 Feb 2006 22:02:14 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FDCAf-0007tK-Ib; Sat, 25 Feb 2006 22:02:05 -0500
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan.michonline.com with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FDCAf-00050B-8S; Sat, 25 Feb 2006 22:02:05 -0500
In-Reply-To: <11409185133616-git-send-email-ryan@michonline.com>
X-Mailer: git-send-email
To: junkio@cox.net
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16767>

When we settle on a solution for ActiveState's forking issues, all
compatibility checks can be handled inside this one function.

Also, fixed an abuse of global variables in the process of cleaning this up.

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

 I should have done this before I sent the other patch out, sorry about
 that.  This one will also be in my annotate-upstream branch, but I'm a
 bit less sure where we stand on this kind of fixup at the moment.  Even
 if this is the wrong place to start, this at least flags all the spots
 that need fixing in a nice way.

 git-annotate.perl |   73 ++++++++++++++++++++++++++++++++---------------------
 1 files changed, 44 insertions(+), 29 deletions(-)

3e72e9de7ece2b9c2c9447e761ee721bdd94a33f
diff --git a/git-annotate.perl b/git-annotate.perl
index 91da6d5..ee8ff15 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -98,15 +98,15 @@ while (my $bound = pop @stack) {
 push @revqueue, $head;
 init_claim( defined $starting_rev ? $starting_rev : 'dirty');
 unless (defined $starting_rev) {
-	open(DIFF,"-|","git","diff","-R", "HEAD", "--",$filename)
+	my $diff = open_pipe("git","diff","-R", "HEAD", "--",$filename)
 		or die "Failed to call git diff to check for dirty state: $!";
 
-	_git_diff_parse(*DIFF, $head, "dirty", (
+	_git_diff_parse($diff, $head, "dirty", (
 				'author' => gitvar_name("GIT_AUTHOR_IDENT"),
 				'author_date' => sprintf("%s +0000",time()),
 				)
 			);
-	close(DIFF);
+	close($diff);
 }
 handle_rev();
 
@@ -172,20 +172,21 @@ sub handle_rev {
 sub git_rev_list {
 	my ($rev, $file) = @_;
 
+	my $revlist;
 	if ($rev_file) {
-		open(P, '<' . $rev_file);
+		open($revlist, '<' . $rev_file);
 	} else {
-		open(P,"-|","git-rev-list","--parents","--remove-empty",$rev,"--",$file)
+		$revlist = open_pipe("git-rev-list","--parents","--remove-empty",$rev,"--",$file)
 			or die "Failed to exec git-rev-list: $!";
 	}
 
 	my @revs;
-	while(my $line = <P>) {
+	while(my $line = <$revlist>) {
 		chomp $line;
 		my ($rev, @parents) = split /\s+/, $line;
 		push @revs, [ $rev, @parents ];
 	}
-	close(P);
+	close($revlist);
 
 	printf("0 revs found for rev %s (%s)\n", $rev, $file) if (@revs == 0);
 	return @revs;
@@ -194,22 +195,22 @@ sub git_rev_list {
 sub find_parent_renames {
 	my ($rev, $file) = @_;
 
-	open(P,"-|","git-diff-tree", "-M50", "-r","--name-status", "-z","$rev")
+	my $patch = open_pipe("git-diff-tree", "-M50", "-r","--name-status", "-z","$rev")
 		or die "Failed to exec git-diff: $!";
 
 	local $/ = "\0";
 	my %bound;
-	my $junk = <P>;
-	while (my $change = <P>) {
+	my $junk = <$patch>;
+	while (my $change = <$patch>) {
 		chomp $change;
-		my $filename = <P>;
+		my $filename = <$patch>;
 		chomp $filename;
 
 		if ($change =~ m/^[AMD]$/ ) {
 			next;
 		} elsif ($change =~ m/^R/ ) {
 			my $oldfilename = $filename;
-			$filename = <P>;
+			$filename = <$patch>;
 			chomp $filename;
 			if ( $file eq $filename ) {
 				my $parent = git_find_parent($rev, $oldfilename);
@@ -218,7 +219,7 @@ sub find_parent_renames {
 			}
 		}
 	}
-	close(P);
+	close($patch);
 
 	return \%bound;
 }
@@ -227,14 +228,14 @@ sub find_parent_renames {
 sub git_find_parent {
 	my ($rev, $filename) = @_;
 
-	open(REVPARENT,"-|","git-rev-list","--remove-empty", "--parents","--max-count=1","$rev","--",$filename)
+	my $revparent = open_pipe("git-rev-list","--remove-empty", "--parents","--max-count=1","$rev","--",$filename)
 		or die "Failed to open git-rev-list to find a single parent: $!";
 
-	my $parentline = <REVPARENT>;
+	my $parentline = <$revparent>;
 	chomp $parentline;
 	my ($revfound,$parent) = split m/\s+/, $parentline;
 
-	close(REVPARENT);
+	close($revparent);
 
 	return $parent;
 }
@@ -245,13 +246,13 @@ sub git_find_parent {
 sub git_diff_parse {
 	my ($parent, $rev, %revinfo) = @_;
 
-	open(DIFF,"-|","git-diff-tree","-M","-p",$rev,$parent,"--",
+	my $diff = open_pipe("git-diff-tree","-M","-p",$rev,$parent,"--",
 			$revs{$rev}{'filename'}, $revs{$parent}{'filename'})
 		or die "Failed to call git-diff for annotation: $!";
 
-	_git_diff_parse(*DIFF, $parent, $rev, %revinfo);
+	_git_diff_parse($diff, $parent, $rev, %revinfo);
 
-	close(DIFF);
+	close($diff);
 }
 
 sub _git_diff_parse {
@@ -264,7 +265,7 @@ sub _git_diff_parse {
 	my $gotheader = 0;
 	my ($remstart);
 	my ($hunk_start, $hunk_index);
-	while(<DIFF>) {
+	while(<$diff>) {
 		chomp;
 		if (m/^@@ -(\d+),(\d+) \+(\d+),(\d+)/) {
 			$remstart = $1;
@@ -335,15 +336,15 @@ sub git_cat_file {
 
 	my $blob = git_ls_tree($rev, $filename);
 
-	open(C,"-|","git","cat-file", "blob", $blob)
+	my $catfile = open_pipe("git","cat-file", "blob", $blob)
 		or die "Failed to git-cat-file blob $blob (rev $rev, file $filename): " . $!;
 
 	my @lines;
-	while(<C>) {
+	while(<$catfile>) {
 		chomp;
 		push @lines, $_;
 	}
-	close(C);
+	close($catfile);
 
 	return @lines;
 }
@@ -351,15 +352,15 @@ sub git_cat_file {
 sub git_ls_tree {
 	my ($rev, $filename) = @_;
 
-	open(T,"-|","git","ls-tree",$rev,$filename)
+	my $lstree = open_pipe("git","ls-tree",$rev,$filename)
 		or die "Failed to call git ls-tree: $!";
 
 	my ($mode, $type, $blob, $tfilename);
-	while(<T>) {
+	while(<$lstree>) {
 		($mode, $type, $blob, $tfilename) = split(/\s+/, $_, 4);
 		last if ($tfilename eq $filename);
 	}
-	close(T);
+	close($lstree);
 
 	return $blob if $filename eq $filename;
 	die "git-ls-tree failed to find blob for $filename";
@@ -379,11 +380,11 @@ sub claim_line {
 
 sub git_commit_info {
 	my ($rev) = @_;
-	open(COMMIT, "-|","git-cat-file", "commit", $rev)
+	my $commit = open_pipe("git-cat-file", "commit", $rev)
 		or die "Failed to call git-cat-file: $!";
 
 	my %info;
-	while(<COMMIT>) {
+	while(<$commit>) {
 		chomp;
 		last if (length $_ == 0);
 
@@ -397,7 +398,7 @@ sub git_commit_info {
 			$info{'committer_date'} = $3;
 		}
 	}
-	close(COMMIT);
+	close($commit);
 
 	return %info;
 }
@@ -430,3 +431,17 @@ sub gitvar_name {
     return join(' ', @field[0...(@field-4)]);
 }
 
+
+sub open_pipe {
+	my (@execlist) = @_;
+
+	my $pid = open my $kid, "-|";
+	defined $pid or die "Cannot fork: $!";
+
+	unless ($pid) {
+		exec @execlist;
+		die "Cannot exec @execlist: $!";
+	}
+
+	return $kid;
+}
-- 
1.2.3.g9ca3
