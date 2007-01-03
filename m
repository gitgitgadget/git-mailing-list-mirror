From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] git-remote
Date: Wed, 03 Jan 2007 13:40:56 -0800
Message-ID: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 03 22:41:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2Dr3-0006gE-UK
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 22:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbXACVk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 16:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbXACVk6
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 16:40:58 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:49277 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbXACVk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 16:40:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103214057.QRRK16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 3 Jan 2007 16:40:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6lhB1W00D1kojtg0000000; Wed, 03 Jan 2007 16:41:11 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35892>

It might be handy to have a single command that helps you manage
your configuration that relates to downloading from remote
repositories.  This currently does only about 20% of what I want
it to do.

	$ git remote

shows the list of 'remotes' you have defined somewhere, and

	$ git remote origin

shows the details about the named remote (in this case
"origin").  How the branches are tracked, if you have a 
tracking branch that is stale, etc.

	$ git add another git://git.kernel.org/pub/...

defines the default remote.another.url and remote.another.fetch
entries just like a clone does; you can say "git fetch another"
afterwards.

For it to be useful, I think it should be enhanced to:

 - check overlaps of tracking branches and warn;

 - offer to remove stale tracking branches in one go;

 - offer ways to remove or rename remote;

 - give different levels of verbosity in its 'show' command,
   especially if ls-remote is run;

 - offer ways to update an existing remote, perhaps have an
   interactive mode;

Other enhancements might be also possible, but I do not think of
anything that is absolutely necessary other than the above right
now.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Makefile        |    2 +-
 git-remote.perl |  260 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 261 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index fa1a022..ea07634 100644
--- a/Makefile
+++ b/Makefile
@@ -179,7 +179,7 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-add--interactive.perl \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
-	git-cvsserver.perl \
+	git-cvsserver.perl git-remote.perl \
 	git-svnimport.perl git-cvsexportcommit.perl \
 	git-send-email.perl git-svn.perl
 
diff --git a/git-remote.perl b/git-remote.perl
new file mode 100755
index 0000000..b0ec838
--- /dev/null
+++ b/git-remote.perl
@@ -0,0 +1,260 @@
+#!/usr/bin/perl -w
+
+use Git;
+my $git = Git->repository();
+
+sub add_remote_config {
+	my ($hash, $name, $what, $value) = @_;
+	if ($what eq 'url') {
+		if (exists $hash->{$name}{'URL'}) {
+			print STDERR "Warning: more than one remote.$name.url\n";
+		}
+		$hash->{$name}{'URL'} = $value;
+	}
+	elsif ($what eq 'fetch') {
+		$hash->{$name}{'FETCH'} ||= [];
+		push @{$hash->{$name}{'FETCH'}}, $value;
+	}
+	if (!exists $hash->{$name}{'SOURCE'}) {
+		$hash->{$name}{'SOURCE'} = 'config';
+	}
+}
+
+sub add_remote_remotes {
+	my ($hash, $file, $name) = @_;
+
+	if (exists $hash->{$name}) {
+		$hash->{$name}{'WARNING'} = 'ignored due to config';
+		return;
+	}
+
+	my $fh;
+	if (!open($fh, '<', $file)) {
+		print STDERR "Warning: cannot open $file\n";
+		return;
+	}
+	my $it = { 'SOURCE' => 'remotes' };
+	$hash->{$name} = $it;
+	while (<$fh>) {
+		chomp;
+		if (/^URL:\s*(.*)$/) {
+			# Having more than one is Ok -- it is used for push.
+			if (! exists $it->{'URL'}) {
+				$it->{'URL'} = $1;
+			}
+		}
+		elsif (/^Push:\s*(.*)$/) {
+			; # later
+		}
+		elsif (/^Pull:\s*(.*)$/) {
+			$it->{'FETCH'} ||= [];
+			push @{$it->{'FETCH'}}, $1;
+		}
+		elsif (/^\#/) {
+			; # ignore
+		}
+		else {
+			print STDERR "Warning: funny line in $file: $_\n";
+		}
+	}
+	close($fh);
+}
+
+sub list_remote {
+	my ($git) = @_;
+	my %seen = ();
+
+	for ($git->command(qw(repo-config --get-regexp), '^remote\.')) {
+		if (/^remote\.([^.]*)\.(\S*)\s+(.*)$/) {
+			add_remote_config(\%seen, $1, $2, $3);
+		}
+	}
+
+	my $dir = $git->repo_path() . "/remotes";
+	if (opendir(my $dh, $dir)) {
+		local $_;
+		while ($_ = readdir($dh)) {
+			chomp;
+			next if (! -f "$dir/$_" || ! -r _);
+			add_remote_remotes(\%seen, "$dir/$_", $_);
+		}
+	}
+
+	return \%seen;
+}
+
+sub add_branch_config {
+	my ($hash, $name, $what, $value) = @_;
+	if ($what eq 'remote') {
+		if (exists $hash->{$name}{'REMOTE'}) {
+			print STDERR "Warning: more than one branch.$name.remote\n";
+		}
+		$hash->{$name}{'REMOTE'} = $value;
+	}
+	elsif ($what eq 'merge') {
+		$hash->{$name}{'MERGE'} ||= [];
+		push @{$hash->{$name}{'MERGE'}}, $value;
+	}
+}
+
+sub list_branch {
+	my ($git) = @_;
+	my %seen = ();
+	for ($git->command(qw(repo-config --get-regexp), '^branch\.')) {
+		if (/^branch\.([^.]*)\.(\S*)\s+(.*)$/) {
+			add_branch_config(\%seen, $1, $2, $3);
+		}
+	}
+
+	return \%seen;
+}
+
+my $remote = list_remote($git);
+my $branch = list_branch($git);
+
+sub update_ls_remote {
+	my ($harder, $info) = @_;
+
+	return if (($harder == 0) ||
+		   (($harder == 1) && exists $info->{'LS_REMOTE'}));
+
+	my @ref = map {
+		s|^[0-9a-f]{40}\s+refs/heads/||;
+		$_;
+	} $git->command(qw(ls-remote --heads), $info->{'URL'});
+	$info->{'LS_REMOTE'} = \@ref;
+}
+
+sub show_wildcard_mapping {
+	my ($forced, $ours, $ls) = @_;
+	my %refs;
+	for (@$ls) {
+		$refs{$_} = 01; # bit #0 to say "they have"
+	}
+	for ($git->command('for-each-ref', "refs/remotes/$ours")) {
+		chomp;
+		next unless (s|^[0-9a-f]{40}\s[a-z]+\srefs/remotes/$ours/||);
+		next if ($_ eq 'HEAD');
+		$refs{$_} ||= 0;
+		$refs{$_} |= 02; # bit #1 to say "we have"
+	}
+	my (@new, @stale, @tracked);
+	for (sort keys %refs) {
+		my $have = $refs{$_};
+		if ($have == 1) {
+			push @new, $_;
+		}
+		elsif ($have == 2) {
+			push @stale, $_;
+		}
+		elsif ($have == 3) {
+			push @tracked, $_;
+		}
+	}
+	if (@new) {
+		print "  New remote branches (next fetch will store in remotes/$ours)\n";
+		print "    @new\n";
+	}
+	if (@stale) {
+		print "  Stale tracking branches in remotes/$ours (you'd better remove them)\n";
+		print "    @stale\n";
+	}
+	if (@tracked) {
+		print "  Tracked remote branches\n";
+		print "    @tracked\n";
+	}
+}
+
+sub show_mapping {
+	my ($name, $info) = @_;
+	my $fetch = $info->{'FETCH'};
+	my $ls = $info->{'LS_REMOTE'};
+	my (@stale, @tracked);
+
+	for (@$fetch) {
+		next unless (/(\+)?([^:]+):(.*)/);
+		my ($forced, $theirs, $ours) = ($1, $2, $3);
+		if ($theirs eq 'refs/heads/*' &&
+		    $ours =~ /^refs\/remotes\/(.*)\/\*$/) {
+			# wildcard mapping
+			show_wildcard_mapping($forced, $1, $ls);
+		}
+		elsif ($theirs =~ /\*/ || $ours =~ /\*/) {
+			print STDERR "Warning: unrecognized mapping in remotes.$name.fetch: $_\n";
+		}
+		elsif ($theirs =~ s|^refs/heads/||) {
+			if (!grep { $_ eq $theirs } @$ls) {
+				push @stale, $theirs;
+			}
+			elsif ($ours ne '') {
+				push @tracked, $theirs;
+			}
+		}
+	}
+	if (@stale) {
+		print "  Stale tracking branches in remotes/$name (you'd better remove them)\n";
+		print "    @stale\n";
+	}
+	if (@tracked) {
+		print "  Tracked remote branches\n";
+		print "    @tracked\n";
+	}
+}
+
+sub show_remote {
+	my ($name, $ls_remote) = @_;
+	if (!exists $remote->{$name}) {
+		print STDERR "No such remote $name\n";
+		return;
+	}
+	my $info = $remote->{$name};
+	update_ls_remote($ls_remote, $info);
+
+	print "* remote $name\n";
+	print "  URL: $info->{'URL'}\n";
+	for my $branchname (sort keys %$branch) {
+		next if ($branch->{$branchname}{'REMOTE'} ne $name);
+		my @merged = map {
+			s|^refs/heads/||;
+			$_;
+		} split(' ',"@{$branch->{$branchname}{'MERGE'}}");
+		next unless (@merged);
+		print "  Remote branch(es) merged with 'git pull' while on branch $branchname\n";
+		print "    @merged\n";
+	}
+	if ($info->{'LS_REMOTE'}) {
+		show_mapping($name, $info);
+	}
+}
+
+sub add_remote {
+	my ($name, $url) = @_;
+	if (exists $remote->{$name}) {
+		print STDERR "remote $name already exists.\n";
+		exit(1);
+	}
+	$git->command('repo-config', "remote.$name.url", $url);
+	$git->command('repo-config', "remote.$name.fetch",
+		      "+refs/heads/*:refs/remotes/$name/*");
+}
+
+if (!@ARGV) {
+	for (sort keys %$remote) {
+		print "$_\n";
+	}
+}
+elsif ($ARGV[0] eq 'show') {
+	if (@ARGV != 2) {
+		print STDERR "Usage: git remote show <remote>\n";
+		exit(1);
+	}
+	show_remote($ARGV[1], 1);
+}
+elsif ($ARGV[0] eq 'add') {
+	if (@ARGV != 3) {
+		print STDERR "Usage: git remote show <name> <url>\n";
+		exit(1);
+	}
+	add_remote($ARGV[1], $ARGV[2]);
+}
+
-- 
1.5.0.rc0.gcc26
