From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 7/7] Convert git-annotate to use Git.pm
Date: Sun, 25 Jun 2006 03:54:34 +0200
Message-ID: <20060625015434.29906.23422.stgit@machine.or.cz>
References: <20060625015421.29906.50002.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 03:54:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJph-0006BB-BD
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWFYByh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWFYByh
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:54:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3498 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964893AbWFYByg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:54:36 -0400
Received: (qmail 30010 invoked from network); 25 Jun 2006 03:54:34 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 25 Jun 2006 03:54:34 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060625015421.29906.50002.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22574>

Together with the other converted scripts, this is probably still pu
material; it appears to work fine for me, though. The speed gain from
get_object() is about 10% (I expected more...).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-annotate.perl |  167 ++++++++++-------------------------------------------
 1 files changed, 31 insertions(+), 136 deletions(-)

diff --git a/git-annotate.perl b/git-annotate.perl
index a6a7a48..d924e87 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -11,6 +11,7 @@ use strict;
 use Getopt::Long;
 use POSIX qw(strftime gmtime);
 use File::Basename qw(basename dirname);
+use Git;
 
 sub usage() {
 	print STDERR "Usage: ${\basename $0} [-s] [-S revs-file] file [ revision ]
@@ -29,7 +30,7 @@ sub usage() {
 	exit(1);
 }
 
-our ($help, $longrev, $rename, $rawtime, $starting_rev, $rev_file) = (0, 0, 1);
+our ($help, $longrev, $rename, $rawtime, $starting_rev, $rev_file, $repo) = (0, 0, 1);
 
 my $rc = GetOptions(	"long|l" => \$longrev,
 			"time|t" => \$rawtime,
@@ -52,6 +53,8 @@ my @stack = (
 	},
 );
 
+$repo = Git->repository();
+
 our @filelines = ();
 
 if (defined $starting_rev) {
@@ -102,15 +105,11 @@ while (my $bound = pop @stack) {
 push @revqueue, $head;
 init_claim( defined $starting_rev ? $head : 'dirty');
 unless (defined $starting_rev) {
-	my $diff = open_pipe("git","diff","-R", "HEAD", "--",$filename)
-		or die "Failed to call git diff to check for dirty state: $!";
-
-	_git_diff_parse($diff, $head, "dirty", (
-				'author' => gitvar_name("GIT_AUTHOR_IDENT"),
-				'author_date' => sprintf("%s +0000",time()),
-				)
-			);
-	close($diff);
+	my %ident;
+	@ident{'author', 'author_email', 'author_date'} = $repo->ident('author');
+	my $diff = $repo->command_output_pipe('diff', '-R', 'HEAD', '--', $filename);
+	_git_diff_parse($diff, $head, "dirty", %ident);
+	$repo->command_close_pipe($diff);
 }
 handle_rev();
 
@@ -181,8 +180,7 @@ sub git_rev_list {
 		open($revlist, '<' . $rev_file)
 		    or die "Failed to open $rev_file : $!";
 	} else {
-		$revlist = open_pipe("git-rev-list","--parents","--remove-empty",$rev,"--",$file)
-			or die "Failed to exec git-rev-list: $!";
+		$revlist = $repo->command_output_pipe('rev-list', '--parents', '--remove-empty', $rev, '--', $file);
 	}
 
 	my @revs;
@@ -191,7 +189,7 @@ sub git_rev_list {
 		my ($rev, @parents) = split /\s+/, $line;
 		push @revs, [ $rev, @parents ];
 	}
-	close($revlist);
+	$repo->command_close_pipe($revlist);
 
 	printf("0 revs found for rev %s (%s)\n", $rev, $file) if (@revs == 0);
 	return @revs;
@@ -200,8 +198,7 @@ sub git_rev_list {
 sub find_parent_renames {
 	my ($rev, $file) = @_;
 
-	my $patch = open_pipe("git-diff-tree", "-M50", "-r","--name-status", "-z","$rev")
-		or die "Failed to exec git-diff: $!";
+	my $patch = $repo->command_output_pipe('diff-tree', '-M50', '-r', '--name-status', '-z', $rev);
 
 	local $/ = "\0";
 	my %bound;
@@ -227,7 +224,7 @@ sub find_parent_renames {
 			}
 		}
 	}
-	close($patch);
+	$repo->command_close_pipe($patch);
 
 	return \%bound;
 }
@@ -236,14 +233,9 @@ sub find_parent_renames {
 sub git_find_parent {
 	my ($rev, $filename) = @_;
 
-	my $revparent = open_pipe("git-rev-list","--remove-empty", "--parents","--max-count=1","$rev","--",$filename)
-		or die "Failed to open git-rev-list to find a single parent: $!";
-
-	my $parentline = <$revparent>;
-	chomp $parentline;
-	my ($revfound,$parent) = split m/\s+/, $parentline;
-
-	close($revparent);
+	my $parentline = $repo->command_oneline('rev-list', '--remove-empty',
+			'--parents', '--max-count=1', $rev, '--', $filename);
+	my ($revfound, $parent) = split m/\s+/, $parentline;
 
 	return $parent;
 }
@@ -254,13 +246,13 @@ # Record the commit information that res
 sub git_diff_parse {
 	my ($parent, $rev, %revinfo) = @_;
 
-	my $diff = open_pipe("git-diff-tree","-M","-p",$rev,$parent,"--",
-			$revs{$rev}{'filename'}, $revs{$parent}{'filename'})
-		or die "Failed to call git-diff for annotation: $!";
+	my $diff = $repo->command_output_pipe('diff-tree', '-M', '-p',
+			$rev, $parent, '--',
+			$revs{$rev}{'filename'}, $revs{$parent}{'filename'});
 
 	_git_diff_parse($diff, $parent, $rev, %revinfo);
 
-	close($diff);
+	$repo->command_close_pipe($diff);
 }
 
 sub _git_diff_parse {
@@ -351,36 +343,25 @@ sub git_cat_file {
 	my $blob = git_ls_tree($rev, $filename);
 	die "Failed to find a blob for $filename in rev $rev\n" if !defined $blob;
 
-	my $catfile = open_pipe("git","cat-file", "blob", $blob)
-		or die "Failed to git-cat-file blob $blob (rev $rev, file $filename): " . $!;
-
-	my @lines;
-	while(<$catfile>) {
-		chomp;
-		push @lines, $_;
-	}
-	close($catfile);
-
+	my @lines = split(/\n/, $repo->get_object('blob', $blob));
+	pop @lines unless $lines[$#lines]; # Trailing newline
 	return @lines;
 }
 
 sub git_ls_tree {
 	my ($rev, $filename) = @_;
 
-	my $lstree = open_pipe("git","ls-tree",$rev,$filename)
-		or die "Failed to call git ls-tree: $!";
-
+	my $lstree = $repo->command_output_pipe('ls-tree', $rev, $filename);
 	my ($mode, $type, $blob, $tfilename);
 	while(<$lstree>) {
 		chomp;
 		($mode, $type, $blob, $tfilename) = split(/\s+/, $_, 4);
 		last if ($tfilename eq $filename);
 	}
-	close($lstree);
+	$repo->command_close_pipe($lstree);
 
 	return $blob if ($tfilename eq $filename);
 	die "git-ls-tree failed to find blob for $filename";
-
 }
 
 
@@ -396,25 +377,17 @@ sub claim_line {
 
 sub git_commit_info {
 	my ($rev) = @_;
-	my $commit = open_pipe("git-cat-file", "commit", $rev)
-		or die "Failed to call git-cat-file: $!";
+	my $commit = $repo->get_object('commit', $rev);
 
 	my %info;
-	while(<$commit>) {
-		chomp;
-		last if (length $_ == 0);
-
-		if (m/^author (.*) <(.*)> (.*)$/) {
-			$info{'author'} = $1;
-			$info{'author_email'} = $2;
-			$info{'author_date'} = $3;
-		} elsif (m/^committer (.*) <(.*)> (.*)$/) {
-			$info{'committer'} = $1;
-			$info{'committer_email'} = $2;
-			$info{'committer_date'} = $3;
+	while ($commit =~ /(.*?)\n/g) {
+		my $line = $1;
+		if ($line =~ s/^author //) {
+			@info{'author', 'author_email', 'author_date'} = $repo->ident($line);
+		} elsif ($line =~ s/^committer//) {
+			@info{'committer', 'committer_email', 'committer_date'} = $repo->ident($line);
 		}
 	}
-	close($commit);
 
 	return %info;
 }
@@ -432,81 +405,3 @@ sub format_date {
 	my $t = $timestamp + $minutes * 60;
 	return strftime("%Y-%m-%d %H:%M:%S " . $timezone, gmtime($t));
 }
-
-# Copied from git-send-email.perl - We need a Git.pm module..
-sub gitvar {
-    my ($var) = @_;
-    my $fh;
-    my $pid = open($fh, '-|');
-    die "$!" unless defined $pid;
-    if (!$pid) {
-	exec('git-var', $var) or die "$!";
-    }
-    my ($val) = <$fh>;
-    close $fh or die "$!";
-    chomp($val);
-    return $val;
-}
-
-sub gitvar_name {
-    my ($name) = @_;
-    my $val = gitvar($name);
-    my @field = split(/\s+/, $val);
-    return join(' ', @field[0...(@field-4)]);
-}
-
-sub open_pipe {
-	if ($^O eq '##INSERT_ACTIVESTATE_STRING_HERE##') {
-		return open_pipe_activestate(@_);
-	} else {
-		return open_pipe_normal(@_);
-	}
-}
-
-sub open_pipe_activestate {
-	tie *fh, "Git::ActiveStatePipe", @_;
-	return *fh;
-}
-
-sub open_pipe_normal {
-	my (@execlist) = @_;
-
-	my $pid = open my $kid, "-|";
-	defined $pid or die "Cannot fork: $!";
-
-	unless ($pid) {
-		exec @execlist;
-		die "Cannot exec @execlist: $!";
-	}
-
-	return $kid;
-}
-
-package Git::ActiveStatePipe;
-use strict;
-
-sub TIEHANDLE {
-	my ($class, @params) = @_;
-	my $cmdline = join " ", @params;
-	my  @data = qx{$cmdline};
-	bless { i => 0, data => \@data }, $class;
-}
-
-sub READLINE {
-	my $self = shift;
-	if ($self->{i} >= scalar @{$self->{data}}) {
-		return undef;
-	}
-	return $self->{'data'}->[ $self->{i}++ ];
-}
-
-sub CLOSE {
-	my $self = shift;
-	delete $self->{data};
-	delete $self->{i};
-}
-
-sub EOF {
-	my $self = shift;
-	return ($self->{i} >= scalar @{$self->{data}});
-}
