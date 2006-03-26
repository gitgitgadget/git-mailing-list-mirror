From: Petr Baudis <pasky@suse.cz>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 01:26:49 +0200
Message-ID: <20060326232649.GV18185@pasky.or.cz>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <20060326100717.GD18185@pasky.or.cz> <Pine.LNX.4.64.0603260829550.15714@g5.osdl.org> <20060326191445.GQ18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 01:26:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNedB-0004vU-D2
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 01:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWCZX0n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 18:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWCZX0m
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 18:26:42 -0500
Received: from w241.dkm.cz ([62.24.88.241]:2205 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932199AbWCZX0m (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 18:26:42 -0500
Received: (qmail 20973 invoked by uid 2001); 27 Mar 2006 01:26:49 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20060326191445.GQ18185@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18068>

Dear diary, on Sun, Mar 26, 2006 at 09:14:45PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> Dear diary, on Sun, Mar 26, 2006 at 06:33:13PM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...
> > If you do
> > 
> > 	git-rev-list --parents --remove-empty $REV -- $filename
> > 
> > then you'll get the whole history for that filename. When it ends, you 
> > know the file went away, and then you do basically _one_ "where the hell 
> > did it go" thing.
> > 
> > And yes, it's not git-ls-tree (unless you only want to follow pure 
> > renames), it's actually one "git-diff-tree -M $lastrev". Then you just 
> > continue with the new filename (and do another "git-rev-list" until you 
> > hit the next rename).
> 
> I wrote a long rant but then it all suddenly fit together and I have now
> an idea how to implement it reasonably elegantly.

So, this is what I have. Testing (I've gave it very little of that) and
thoughts welcome. It is probably pretty efficient, at least in terms of
fork()s it does only 2*N of them where N is the number of commits
containing interesting renames.  Actually, this should be even possible
to reduce to N+1 if you do a single git-diff-tree call and multiplex
different git-rev-lists to it, but I'm too tired to do the trickery now.

It has 'cg' in the name but depends on no Cogito stuff; it should be in
fact possible to trivially put it to git-whatchanged in place of the
final pipeline (not that I'd be suggesting this to be done universally,
but perhaps git-whatchanged -f ...?). There are three downsides in this
regard:

(i) No -c support. I need the separate deltas coming out from
git-diff-tree but I think I can join them together pretty easily on my
own, except that I have problems with -c (see
<20060326102100.GF18185@pasky.or.cz>) so I'm not sure how exactly is it
supposed to behave.

(ii) Only --pretty=raw output. It shouldn't be hard to add the
reformatting code, but I'm personally not going to use it and kind of
lazy, so I'll let someone else do that, I guess. :-)

(iii) Raw deltas required. -p parsing support would be certainly useful
and possible, but see (ii).


To quickly see what it does, you can try it e.g. on the git-log.sh file
in the Git repository.

Thoughts? Opinions? Bugs? Patches?


Signed-off-by: Petr Baudis <pasky@suse.cz>


diff --git a/cg-Xfollowrenames b/cg-Xfollowrenames
new file mode 100755
index 0000000..fa5c552
--- /dev/null
+++ b/cg-Xfollowrenames
@@ -0,0 +1,246 @@
+#!/usr/bin/env perl
+#
+# git-rev-list | git-diff-tree --stdin following renames
+# Copyright (c) Petr Baudis, 2006
+# Uses bits of git-annotate.perl by Ryan Anderson.
+#
+# This script will efficiently show output as of the
+#
+#	git-rev-list --remove-empty ARGS -- FILE... |
+#	git-diff-tree -M -r -m --stdin --pretty=raw ARGS
+#
+# pipeline, except that it follows renames of individual files listed
+# in the FILE... set.
+#
+# Usage:
+#
+#	cg-Xfollowrenames revlistargs -- difftreeargs -- revs -- files
+
+# TODO: Does not work on multiple files properly yet - most probably
+# (I didn't test it!). We want git-rev-list to stop traversing the history
+# when _any_ file disappears while now it probably stops traversing when
+# _all_ files disappear.
+
+use warnings;
+use strict;
+
+$| = 1;
+
+our (@revlist_args, @difftree_args, @revs, @files);
+
+{ # Load arguments
+	my @argp = (\@revlist_args, \@difftree_args, \@revs, \@files);
+	my $argi = 0;
+	for my $arg (@ARGV) {
+		if ($arg eq '--' and $argi < $#argp) {
+			$argi++;
+			next;
+		}
+		push(@{$argp[$argi]}, $arg);
+	}
+}
+
+
+# The heads we watch (sorted by commit time)
+our @heads;
+# Each head is: {
+#	# Persistent for the whole line of development:
+#	pipe => $pipe,
+#	files => \@files, # to watch for
+#
+#	id => $sha1, # useful actually only for debugging
+#	time => $timestamp,
+#	str => $prettyoutput,
+#	parents => \@sha1s,
+#
+#	# When the commit is processed, spawn these extra heads:
+#	recurse => {$sha1id => \@files, ...},
+# }
+
+# To avoid printing duplicate commits
+# FIXME: Currently, we will not handle merge commits properly since
+# we hit them multiple times.
+our %commits;
+
+
+sub open_pipe($@) {
+	my ($stdin, @execlist) = @_;
+
+	my $pid = open my $kid, "-|";
+	defined $pid or die "Cannot fork: $!";
+
+	unless ($pid) {
+		if (defined $stdin) {
+			open STDIN, "<&", $stdin or die "Cannot dup(): $!";
+		}
+		exec @execlist;
+		die "Cannot exec @execlist: $!";
+	}
+
+	return $kid;
+}
+
+sub revlist($@) {
+	my ($rev, @files) = @_;
+	open_pipe(undef, "git-rev-list", "--remove-empty",
+	                 @revlist_args, $rev, "--", @files)
+		or die "Failed to exec git-rev-list: $!";
+}
+
+sub difftree($) {
+	my ($revlist) = @_;
+	open_pipe($revlist, "git-diff-tree", "-r", "-m", "--stdin", "-M",
+	                    "--pretty=raw", @difftree_args)
+		or die "Failed to exec git-diff-tree: $!";
+}
+
+sub revdiffpipe($@) {
+	my ($rev, @files) = @_;
+	my $pipe = difftree(revlist($rev, @files));
+}
+
+
+sub read_commit($$) {
+	my ($head, $tolerant) = @_;
+	my $pipe = $head->{'pipe'};
+	my $against;
+	my @oldset = @{$head->{'files'}};
+	my @newset;
+	my $rename;
+
+	# Load header
+	while (my $line = <$pipe>) {
+		$head->{'str'} .= $line;
+		chomp $line;
+		$line eq '' and goto header_loaded;
+
+		if ($line =~ /^diff-tree (\S+) \(from (root|\S+)\)/) {
+			$head->{'id'} = $1;
+			if (not $tolerant and $commits{$1}++) {
+				close $pipe;
+				return undef;
+			}
+			# The 'root' case is harmless since there'll be no renames.
+			$against = $2;
+		} elsif ($line =~ /^parent (\S+)/) {
+			push (@{$head->{'parents'}}, $1);
+		} elsif ($line =~ /^committer .*?> (\d+)/) {
+			$head->{'time'} = $1;
+		}
+	}
+	return undef;
+header_loaded:
+
+	# Load message
+	while (my $line = <$pipe>) {
+		$head->{'str'} .= $line;
+		chomp $line;
+		$line eq '' and goto message_loaded;
+	}
+	return undef;
+message_loaded:
+
+	# Load delta
+	while (my $line = <$pipe>) {
+		$head->{'str'} .= $line;
+		chomp $line;
+		$line eq '' and goto delta_loaded;
+
+		$line =~ /^:/ or return undef;
+		my ($info, $newfile, $oldfile) = split("\t", $line);
+		if ($info =~ /[RC]\d*$/) {
+			# Behold, a rename!
+			# (Or a copy, it's all the same for us.)
+			my $i;
+			for ($i = 0; $i <= $#oldset; $i++) {
+				$oldfile eq $oldset[$i] or next;
+				$rename = 1;
+				splice(@oldset, $i, 1);
+				push(@newset, $newfile);
+				last;
+			}
+			# In case of multiple candidates, follow
+			# all of them:
+			# (TODO: This might be a policy decision
+			# best left on the user.)
+			if ($i > $#oldset and grep { $oldfile eq $_ } @newset) {
+				$rename = 1;
+				push(@newset, $newfile);
+			}
+		} elsif ($info =~ /D$/) {
+			# Not weeding out deleted files might cause bizarre
+			# results when following multiple files since
+			# git-rev-list weeds them out too (probably?).
+			@oldset = grep { $newfile ne $_ } @oldset;
+			@{$head->{'files'}} = grep { $newfile ne $_ } @{$head->{'files'}};
+		}
+	}
+	$head->{'str'} .= "\n";
+delta_loaded:
+
+	if ($rename) {
+		$head->{'recurse'}->{$against} = [@newset, @oldset];
+	}
+	return 1;
+}
+
+sub load_commit($) {
+	my ($head) = @_;
+	$head->{'time'} = undef;
+	$head->{'str'} = '';
+	$head->{'parents'} = ();
+
+	read_commit($head, 0) or return undef;
+
+	# In case there was a merge, the commit will be multiple times
+	# here, each time with a different delta section. Read them all.
+	for (1 .. $#{$head->{'parents'}}) { # stupid vim syntax highlighting
+		read_commit($head, 1) or return undef;
+	}
+
+	return 1;
+}
+
+
+# Add head at the proper position
+sub add_head($) {
+	my ($head) = @_;
+	my $i;
+	for ($i = 0; $i <= $#heads; $i++) {
+		last if ($head->{'time'} > $heads[$i]->{'time'})
+	}
+	splice(@heads, $i, 0, $head);
+}
+
+# Create new head
+sub init_head($@) {
+	my ($rev, @files) = @_;
+	my $head = { files => \@files, 'pipe' => revdiffpipe($rev, @files) };
+	load_commit($head) or return;
+	add_head($head);
+}
+
+
+
+{ # Seed the heads list
+	for my $rev (@revs) {
+		init_head($rev, @files);
+	}
+}
+
+# Process the heads
+{
+	while (@heads) {
+		my $head = splice(@heads, 0, 1);
+
+		print $head->{'str'};
+
+		foreach my $parent (keys %{$head->{'recurse'}}) {
+			init_head($parent, @{$head->{'recurse'}->{$parent}});
+		}
+		$head->{'recurse'} = undef;
+
+		load_commit($head) or next;
+		add_head($head);
+	}
+}


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
