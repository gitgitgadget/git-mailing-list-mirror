From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] cvsimport: cleanup commit function
Date: Tue, 23 May 2006 03:27:46 -0400
Message-ID: <22174.0949004472$1148369283@news.gmane.org>
References: <1148369266352-git-send-email-1>
Reply-To: Jeff King <peff@peff.net>
Cc: martin@catalyst.net.nz, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue May 23 09:28:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiRJ7-0004zD-2c
	for gcvg-git@gmane.org; Tue, 23 May 2006 09:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWEWH1u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 03:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWEWH1u
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 03:27:50 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:27095 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932093AbWEWH1t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 03:27:49 -0400
Received: (qmail 14181 invoked from network); 23 May 2006 07:27:47 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 23 May 2006 07:27:47 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2006 03:27:47 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g3408
In-Reply-To: <1148369266352-git-send-email-1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20572>

This change attempts to clean up the commit function to make it a bit
easier to read (or at least the first half of it). It also improves
robustness and performance. Specifically:
  - report get_headref errors on opening ref unless the error is ENOENT
  - use regex to check for sha1 instead of length
  - use lexically scoped filehandles which get cleaned up automagically
  - check for error on both 'print' and 'close' (since output is buffered)
  - avoid "fork, do some perl, then exec" in commit(). It's not necessary,
    and we probably end up COW'ing parts of the perl process. Plus the code
    is much smaller because we can use open2()
  - avoid calling strftime over and over (mainly a readability cleanup)

---

This is a repost with some minor fixups from Junio (and based off of the
fixed 1/2 patch).

3408c8d8364f816a7c4a34a03045f466bf028540
 git-cvsimport.perl |  150 ++++++++++++++++++++++------------------------------
 1 files changed, 64 insertions(+), 86 deletions(-)

3408c8d8364f816a7c4a34a03045f466bf028540
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index a65bea6..219f6dc 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -23,7 +23,7 @@ use File::Basename qw(basename dirname);
 use Time::Local;
 use IO::Socket;
 use IO::Pipe;
-use POSIX qw(strftime dup2);
+use POSIX qw(strftime dup2 :errno_h);
 use IPC::Open2;
 
 $SIG{'PIPE'}="IGNORE";
@@ -429,22 +429,25 @@ sub getwd() {
 	return $pwd;
 }
 
+sub is_sha1 {
+	my $s = shift;
+	return $s =~ /^[a-f0-9]{40}$/;
+}
 
-sub get_headref($$) {
+sub get_headref ($$) {
     my $name    = shift;
     my $git_dir = shift; 
-    my $sha;
     
-    if (open(C,"$git_dir/refs/heads/$name")) {
-	chomp($sha = <C>);
-	close(C);
-	length($sha) == 40
-	    or die "Cannot get head id for $name ($sha): $!\n";
+    my $f = "$git_dir/refs/heads/$name";
+    if(open(my $fh, $f)) {
+      	    chomp(my $r = <$fh>);
+	    is_sha1($r) or die "Cannot get head id for $name ($r): $!";
+	    return $r;
     }
-    return $sha;
+    die "unable to open $f: $!" unless $! == POSIX::ENOENT;
+    return undef;
 }
 
-
 -d $git_tree
 	or mkdir($git_tree,0777)
 	or die "Could not create $git_tree: $!";
@@ -561,90 +564,67 @@ #---------------------
 
 my $state = 0;
 
-my($patchset,$date,$author_name,$author_email,$branch,$ancestor,$tag,$logmsg);
-my(@old,@new,@skipped);
-sub commit {
-	my $pid;
-
+sub update_index (\@\@) {
+	my $old = shift;
+	my $new = shift;
 	open(my $fh, '|-', qw(git-update-index -z --index-info))
 		or die "unable to open git-update-index: $!";
 	print $fh 
 		(map { "0 0000000000000000000000000000000000000000\t$_\0" }
-			@old),
+			@$old),
 		(map { '100' . sprintf('%o', $_->[0]) . " $_->[1]\t$_->[2]\0" }
-			@new)
+			@$new)
 		or die "unable to write to git-update-index: $!";
 	close $fh
 		or die "unable to write to git-update-index: $!";
 	$? and die "git-update-index reported error: $?";
-	@old = @new = ();
+}
 
-	$pid = open(C,"-|");
-	die "Cannot fork: $!" unless defined $pid;
-	unless($pid) {
-		exec("git-write-tree");
-		die "Cannot exec git-write-tree: $!\n";
-	}
-	chomp(my $tree = <C>);
-	length($tree) == 40
-		or die "Cannot get tree id ($tree): $!\n";
-	close(C)
+sub write_tree () {
+	open(my $fh, '-|', qw(git-write-tree))
+		or die "unable to open git-write-tree: $!";
+	chomp(my $tree = <$fh>);
+	is_sha1($tree)
+		or die "Cannot get tree id ($tree): $!";
+	close($fh)
 		or die "Error running git-write-tree: $?\n";
 	print "Tree ID $tree\n" if $opt_v;
+	return $tree;
+}
 
-	my $parent = "";
-	if(open(C,"$git_dir/refs/heads/$last_branch")) {
-		chomp($parent = <C>);
-		close(C);
-		length($parent) == 40
-			or die "Cannot get parent id ($parent): $!\n";
-		print "Parent ID $parent\n" if $opt_v;
-	}
-
-	my $pr = IO::Pipe->new() or die "Cannot open pipe: $!\n";
-	my $pw = IO::Pipe->new() or die "Cannot open pipe: $!\n";
-	$pid = fork();
-	die "Fork: $!\n" unless defined $pid;
-	unless($pid) {
-		$pr->writer();
-		$pw->reader();
-		open(OUT,">&STDOUT");
-		dup2($pw->fileno(),0);
-		dup2($pr->fileno(),1);
-		$pr->close();
-		$pw->close();
-
-		my @par = ();
-		@par = ("-p",$parent) if $parent;
-
-		# loose detection of merges
-		# based on the commit msg
-		foreach my $rx (@mergerx) {
-			if ($logmsg =~ $rx) {
-				my $mparent = $1;
-				if ($mparent eq 'HEAD') { $mparent = $opt_o };
-				if ( -e "$git_dir/refs/heads/$mparent") {
-					$mparent = get_headref($mparent, $git_dir);
-					push @par, '-p', $mparent;
-					print OUT "Merge parent branch: $mparent\n" if $opt_v;
-				}
-			}
+my($patchset,$date,$author_name,$author_email,$branch,$ancestor,$tag,$logmsg);
+my(@old,@new,@skipped);
+sub commit {
+	update_index(@old, @new);
+	@old = @new = ();
+	my $tree = write_tree();
+	my $parent = get_headref($last_branch, $git_dir);
+	print "Parent ID " . ($parent ? $parent : "(empty)") . "\n" if $opt_v;
+
+	my @commit_args;
+	push @commit_args, ("-p", $parent) if $parent;
+
+	# loose detection of merges
+	# based on the commit msg
+	foreach my $rx (@mergerx) {
+		next unless $logmsg =~ $rx && $1;
+		my $mparent = $1 eq 'HEAD' ? $opt_o : $1;
+		if(my $sha1 = get_headref($mparent, $git_dir)) {
+			push @commit_args, '-p', $mparent;
+			print "Merge parent branch: $mparent\n" if $opt_v;
 		}
-
-		exec("env",
-			"GIT_AUTHOR_NAME=$author_name",
-			"GIT_AUTHOR_EMAIL=$author_email",
-			"GIT_AUTHOR_DATE=".strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date)),
-			"GIT_COMMITTER_NAME=$author_name",
-			"GIT_COMMITTER_EMAIL=$author_email",
-			"GIT_COMMITTER_DATE=".strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date)),
-			"git-commit-tree", $tree,@par);
-		die "Cannot exec git-commit-tree: $!\n";
-
-		close OUT;
 	}
-	$pw->writer();
-	$pr->reader();
+
+	my $commit_date = strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date));
+	my $pid = open2(my $commit_read, my $commit_write,
+		'env',
+		"GIT_AUTHOR_NAME=$author_name",
+		"GIT_AUTHOR_EMAIL=$author_email",
+		"GIT_AUTHOR_DATE=$commit_date",
+		"GIT_COMMITTER_NAME=$author_name",
+		"GIT_COMMITTER_EMAIL=$author_email",
+		"GIT_COMMITTER_DATE=$commit_date",
+		'git-commit-tree', $tree, @commit_args);
 
 	# compatibility with git2cvs
 	substr($logmsg,32767) = "" if length($logmsg) > 32767;
@@ -656,16 +636,14 @@ sub commit {
 	    @skipped = ();
 	}
 
-	print $pw "$logmsg\n"
+	print($commit_write "$logmsg\n") && close($commit_write)
 		or die "Error writing to git-commit-tree: $!\n";
-	$pw->close();
 
-	print "Committed patch $patchset ($branch ".strftime("%Y-%m-%d %H:%M:%S",gmtime($date)).")\n" if $opt_v;
-	chomp(my $cid = <$pr>);
-	length($cid) == 40
-		or die "Cannot get commit id ($cid): $!\n";
+	print "Committed patch $patchset ($branch $commit_date)\n" if $opt_v;
+	chomp(my $cid = <$commit_read>);
+	is_sha1($cid) or die "Cannot get commit id ($cid): $!\n";
 	print "Commit ID $cid\n" if $opt_v;
-	$pr->close();
+	close($commit_read);
 
 	waitpid($pid,0);
 	die "Error running git-commit-tree: $?\n" if $?;
-- 
1.3.3.g3408
