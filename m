From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] cvsimport: cleanup commit function
Date: Tue, 23 May 2006 03:00:07 -0400
Message-ID: <20060523070007.GC6180@coredump.intra.peff.net>
References: <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> <44720C66.6040304@gentoo.org> <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com> <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org> <20060522214128.GE16677@kiste.smurf.noris.de> <7v8xotadm3.fsf@assigned-by-dhcp.cox.net> <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com> <20060523065232.GA6180@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 23 09:00:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiQsJ-0007hp-AP
	for gcvg-git@gmane.org; Tue, 23 May 2006 09:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWEWHAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 03:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWEWHAL
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 03:00:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:12252 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932065AbWEWHAJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 03:00:09 -0400
Received: (qmail 12917 invoked from network); 23 May 2006 07:00:07 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 23 May 2006 07:00:07 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2006 03:00:07 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060523065232.GA6180@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20568>

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

I know this patch is quite large. I can try to split it if you want, but
I suspect it's not worth the effort (either you like refactoring or you
don't :) ).

9dc9f05ab5e1cbd8765238e7b1da0addd6f4296a
 git-cvsimport.perl |  150 ++++++++++++++++++++++------------------------------
 1 files changed, 64 insertions(+), 86 deletions(-)

9dc9f05ab5e1cbd8765238e7b1da0addd6f4296a
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 4efb0a5..f8feb52 100755
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
+	return $s =~ /^[a-zA-Z0-9]{40}$/;
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
       	open(my $fh, '|-', qw(git-update-index --index-info))
 		or die "unable to open git-update-index: $!";
 	print $fh 
 		(map { "0 0000000000000000000000000000000000000000\t$_\n" }
-			@old),
+			@$old),
 		(map { '100' . sprintf('%o', $_->[0]) . " $_->[1]\t$_->[2]\n" }
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
1.3.3.gcb64-dirty
