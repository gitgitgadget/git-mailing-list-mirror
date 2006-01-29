From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFC] git-rerere: reuse recorded resolve.
Date: Sun, 29 Jan 2006 01:10:52 -0800
Message-ID: <7v4q3no0v7.fsf@assigned-by-dhcp.cox.net>
References: <7v4q3ssbr6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 29 10:11:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F38aX-0004BP-Q3
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 10:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWA2JLA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 04:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWA2JLA
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 04:11:00 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:16856 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750754AbWA2JK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 04:10:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129090754.COBS20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 Jan 2006 04:07:54 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15207>

In a workflow that employs relatively long lived topic branches,
the developer sometimes needs to resolve the same conflict over
and over again until the topic branches are done (either merged
to the "release" branch, or sent out and accepted upstream).

This commit introduces a new command, "git rerere", to help this
process by recording the conflicted automerge results and
corresponding hand-resolve results on the initial manual merge,
and later by noticing the same conflicted automerge and applying
the previously recorded hand resolution using three-way merge.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * With my admittedly limited tests, this seems to work rather
   well.  I do a lot of "same" merges, because I rebuild "pu"
   every time I have something new in the "master" branch, and
   often what conflict are the things in my own topic branches,
   none of which has been advanced meanwhile.

   The feature is not enabled until you manually create
   $GIT_DIR/rr-cache directory, at least for now.

 Documentation/git-rerere.txt |  177 +++++++++++++++++++++++++++++++++
 Documentation/git.txt        |    3 +
 Makefile                     |    2 
 git-am.sh                    |    1 
 git-commit.sh                |    1 
 git-merge.sh                 |    1 
 git-rerere.perl              |  223 ++++++++++++++++++++++++++++++++++++++++++
 git-reset.sh                 |    2 
 8 files changed, 408 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/git-rerere.txt
 create mode 100755 git-rerere.perl

9843f047463a7b0b993c4bd80d34934618d5d622
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
new file mode 100644
index 0000000..8b6b651
--- /dev/null
+++ b/Documentation/git-rerere.txt
@@ -0,0 +1,177 @@
+git-rerere(1)
+=============
+
+NAME
+----
+git-rerere - Reuse recorded resolve
+
+SYNOPSIS
+--------
+'git-rerere'
+
+
+DESCRIPTION
+-----------
+
+In a workflow that employs relatively long lived topic branches,
+the developer sometimes needs to resolve the same conflict over
+and over again until the topic branches are done (either merged
+to the "release" branch, or sent out and accepted upstream).
+
+This command helps this process by recording conflicted
+automerge results and corresponding hand-resolve results on the
+initial manual merge, and later by noticing the same automerge
+results and applying the previously recorded hand resolution.
+
+[NOTE]
+You need to create `$GIT_DIR/rr-cache` directory to enable this
+command.
+
+DISCUSSION
+----------
+
+When your topic branch modifies overlapping area that your
+master branch (or upstream) touched since your topic branch
+forked from it, you may want to test it with the latest master,
+even before your topic branch is ready to be pushed upstream:
+
+------------
+              o---*---o topic
+             /
+    o---o---o---*---o---o master
+------------
+
+For such a test, you need to merge master and topic somehow.
+One way to do it is to pull master into the topic branch:
+
+------------
+	$ git checkout topic
+	$ git pull . master
+
+              o---*---o---+ topic
+             /           /
+    o---o---o---*---o---o master
+------------
+
+The commits marked with `*` touch the same area in the same
+file; you need to resolve the conflicts when creating the commit
+marked with `+`.  Then you can test the result to make sure your
+work-in-progress still works with what is in the latest master.
+
+After this test merge, there are two ways to continue your work
+on the topic.  The easiest is to build on top of the test merge
+commit `+`, and when your work in the topic branch is finally
+ready, pull the topic branch into master, and/or ask the
+upstream to pull from you.  By that time, however, the master or
+the upstream might have been advanced since the test merge `+`,
+in which case the final commit graph would look like this:
+
+------------
+	$ git checkout topic
+	$ git pull . master
+	$ ... work on both topic and master branches
+	$ git checkout master
+	$ git pull . topic
+
+              o---*---o---+---o---o topic
+             /           /         \
+    o---o---o---*---o---o---o---o---+ master
+------------
+
+When your topic branch is long-lived, however, your topic branch
+would end up having many such "Merge from master" commits on it,
+which would unnecessarily clutter the development history.
+Readers of the Linux kernel mailing list may remember that Linus
+complained about such too frequent test merges when a subsystem
+maintainer asked to pull from a branch full of "useless merges".
+
+As an alternative, to keep the topic branch clean of test
+merges, you could blow away the test merge, and keep building on
+top of the tip before the test merge:
+
+------------
+	$ git checkout topic
+	$ git pull . master
+	$ git reset --hard HEAD^ ;# rewind the test merge
+	$ ... work on both topic and master branches
+	$ git checkout master
+	$ git pull . topic
+
+              o---*---o-------o---o topic
+             /                     \
+    o---o---o---*---o---o---o---o---+ master
+------------
+
+This would leave only one merge commit when your topic branch is
+finally ready and merged into the master branch.  This merge
+would require you to resolve the conflict, introduced by the
+commits marked with `*`.  However, often this conflict is the
+same conflict you resolved when you created the test merge you
+blew away.  `git-rerere` command helps you to resolve this final
+conflicted merge using the information from your earlier hand
+resolve.
+
+Running `git-rerere` command immediately after a conflicted
+automerge records the conflicted working tree files, with the
+usual conflict markers `<<<<<<<`, `=======`, and `>>>>>>>` in
+them.  Later, after you are done resolving the conflicts,
+running `git-rerere` again records the resolved state of these
+files.  Suppose you did this when you created the test merge of
+master into the topic branch.
+
+Next time, running `git-rerere` after seeing a conflicted
+automerge, if the conflict is the same as the earlier one
+recorded, it is noticed and a three-way merge between the
+earlier conflicted automerge, the earlier manual resolution, and
+the current conflicted automerge is performed by the command.
+If this three-way merge resolves cleanly, the result is written
+out to your working tree file, so you would not have to manually
+resolve it.  Note that `git-rerere` leaves the index file alone,
+so you still need to do the final sanity checks with `git diff`
+(or `git diff -c`) and `git update-index` when you are
+satisfied.
+
+As a convenience measure, `git-merge` automatically invokes
+`git-rerere` when it exits with a failed automerge, which
+records it if it is a new conflict, or reuses the earlier hand
+resolve when it is not.  `git-commit` also invokes `git-rerere`
+when recording a merge result.  What this means is that you do
+not have to do anything special yourself (Note: you still have
+to create `$GIT_DIR/rr-cache` directory to enable this command).
+
+In our example, when you did the test merge, the manual
+resolution is recorded, and it will be reused when you do the
+actual merge later with updated master and topic branch, as long
+as the earlier resolution is still applicable.
+
+The information `git-rerere` records is also used when running
+`git-rebase`.  After blowing away the test merge and continuing
+development on the topic branch:
+
+------------
+              o---*---o-------o---o topic
+             /
+    o---o---o---*---o---o---o---o   master
+
+	$ git rebase master topic
+
+				  o---*---o-------o---o topic
+				 /
+    o---o---o---*---o---o---o---o   master
+------------
+
+you could run `git rebase master topic`, to keep yourself
+up-to-date even before your topic is ready to be sent upstream.
+This would result in falling back to three-way merge, and it
+would conflict the same way the test merge you resolved earlier.
+`git-rerere` is run by `git rebase` to help you resolve this
+conflict.
+
+
+Author
+------
+Written by Junio C Hamano <junkio@cox.net>
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
index e8ef3ef..2d0ca9d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -313,6 +313,9 @@ gitlink:git-rebase[1]::
 gitlink:git-repack[1]::
 	Pack unpacked objects in a repository.
 
+gitlink:git-rerere[1]::
+	Reuse recorded resolution of conflicted merges.
+
 gitlink:git-reset[1]::
 	Reset current HEAD to the specified state.
 
diff --git a/Makefile b/Makefile
index 2aa2385..a566951 100644
--- a/Makefile
+++ b/Makefile
@@ -116,7 +116,7 @@ SCRIPT_SH = \
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
-	git-shortlog.perl git-fmt-merge-msg.perl \
+	git-shortlog.perl git-fmt-merge-msg.perl git-rerere.perl \
 	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl
 
 SCRIPT_PYTHON = \
diff --git a/git-am.sh b/git-am.sh
index 731ab1f..ee6886f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -88,6 +88,7 @@ fall_back_3way () {
     # saying that we reverted all those changes.
 
     git-merge-resolve $orig_tree -- HEAD $his_tree || {
+	    git-rerere
 	    echo Failed to merge in the changes.
 	    exit 1
     }
diff --git a/git-commit.sh b/git-commit.sh
index 193feeb..bfcb0f2 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -237,6 +237,7 @@ else
 fi
 ret="$?"
 rm -f "$GIT_DIR/COMMIT_MSG" "$GIT_DIR/COMMIT_EDITMSG"
+git-rerere
 
 if test -x "$GIT_DIR"/hooks/post-commit && test "$ret" = 0
 then
diff --git a/git-merge.sh b/git-merge.sh
index 92e5a65..586ac08 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -309,5 +309,6 @@ Conflicts:
 		sed -e 's/^[^	]*	/	/' |
 		uniq
 	} >>"$GIT_DIR/MERGE_MSG"
+	git rerere
 	die "Automatic merge failed; fix up by hand"
 fi
diff --git a/git-rerere.perl b/git-rerere.perl
new file mode 100755
index 0000000..df11951
--- /dev/null
+++ b/git-rerere.perl
@@ -0,0 +1,223 @@
+#!/usr/bin/perl
+#
+# REuse REcorded REsolve.  This tool records a conflicted automerge
+# result and its hand resolution, and helps to resolve future
+# automerge that results in the same conflict.
+#
+# To enable this feature, create a directory 'rr-cache' under your
+# .git/ directory.
+
+use Digest;
+use File::Path;
+use File::Copy;
+
+my $git_dir = $::ENV{GIT_DIR} || ".git";
+my $rr_dir = "$git_dir/rr-cache";
+my $merge_rr = "$git_dir/rr-cache/MERGE_RR";
+
+my %merge_rr = ();
+
+sub read_rr {
+	if (!-f $merge_rr) {
+		%merge_rr = ();
+		return;
+	}
+	my $in;
+	local $/ = "\0";
+	open $in, "<$merge_rr" or die "$!: $merge_rr";
+	while (<$in>) {
+		chomp;
+		my ($name, $path) = /^([0-9a-f]{40})\t(.*)$/s;
+		$merge_rr{$path} = $name;
+	}
+	close $in;
+}
+
+sub write_rr {
+	my $out;
+	open $out, ">$merge_rr" or die "$!: $merge_rr";
+	for my $path (sort keys %merge_rr) {
+		my $name = $merge_rr{$path};
+		print $out "$name\t$path\0";
+	}
+	close $out;
+}
+
+sub compute_conflict_name {
+	my ($path) = @_;
+	my @side = ();
+	my $in;
+	open $in, "<$path"  or die "$!: $path";
+
+	my $sha1 = Digest->new("SHA-1");
+	my $hunk = 0;
+	while (<$in>) {
+		if (/^<<<<<<< .*/) {
+			$hunk++;
+			@side = ([], undef);
+		}
+		elsif (/^=======$/) {
+			$side[1] = [];
+		}
+		elsif (/^>>>>>>> .*/) {
+			my ($one, $two);
+			$one = join('', @{$side[0]});
+			$two = join('', @{$side[1]});
+			if ($two le $one) {
+				($one, $two) = ($two, $one);
+			}
+			$sha1->add($one);
+			$sha1->add("\0");
+			$sha1->add($two);
+			$sha1->add("\0");
+			@side = ();
+		}
+		elsif (@side == 0) {
+			next;
+		}
+		elsif (defined $side[1]) {
+			push @{$side[1]}, $_;
+		}
+		else {
+			push @{$side[0]}, $_;
+		}
+	}
+	close $in;
+	return ($sha1->hexdigest, $hunk);
+}
+
+sub record_preimage {
+	my ($path, $name) = @_;
+	my @side = ();
+	my ($in, $out);
+	open $in, "<$path"  or die "$!: $path";
+	open $out, ">$name" or die "$!: $name";
+
+	while (<$in>) {
+		if (/^<<<<<<< .*/) {
+			@side = ([], undef);
+		}
+		elsif (/^=======$/) {
+			$side[1] = [];
+		}
+		elsif (/^>>>>>>> .*/) {
+			my ($one, $two);
+			$one = join('', @{$side[0]});
+			$two = join('', @{$side[1]});
+			if ($two le $one) {
+				($one, $two) = ($two, $one);
+			}
+			print $out "<<<<<<<\n";
+			print $out $one;
+			print $out "=======\n";
+			print $out $two;
+			print $out ">>>>>>>\n";
+			@side = ();
+		}
+		elsif (@side == 0) {
+			print $out $_;
+		}
+		elsif (defined $side[1]) {
+			push @{$side[1]}, $_;
+		}
+		else {
+			push @{$side[0]}, $_;
+		}
+	}
+	close $out;
+	close $in;
+}
+
+sub find_conflict {
+	my $in;
+	local $/ = "\0";
+	open $in, '-|', qw(git ls-files -z -u) or die "$!: ls-files";
+	my %path = ();
+	my @path = ();
+	while (<$in>) {
+		chomp;
+		my ($mode, $sha1, $stage, $path) =
+		    /^([0-7]+) ([0-9a-f]{40}) ([123])\t(.*)$/s;
+		$path{$path} |= (1 << $stage);
+	}
+	close $in;
+	while (my ($path, $status) = each %path) {
+		if ($status == 14) { push @path, $path; }
+	}
+	return @path;
+}
+
+sub merge {
+	my ($name, $path) = @_;
+	record_preimage($path, "$rr_dir/$name/thisimage");
+	unless (system('merge', map { "$rr_dir/$name/${_}image" }
+		       qw(this pre post))) {
+		my $in;
+		open $in, "<$rr_dir/$name/thisimage" or
+		    die "$!: $name/thisimage";
+		my $out;
+		open $out, ">$path" or die "$!: $path";
+		while (<$in>) { print $out $_; }
+		close $in;
+		close $out;
+		return 1;
+	}
+	return 0;
+}
+
+-d "$rr_dir" || exit(0);
+
+read_rr();
+my %conflict = map { $_ => 1 } find_conflict();
+
+# MERGE_RR records paths with conflicts immediately after merge
+# failed.  Some of the conflicted paths might have been hand resolved
+# in the working tree since then, but the initial run would catch all
+# and register their preimages.
+
+for my $path (keys %conflict) {
+	# This path has conflict.  If it is not recorded yet,
+	# record the pre-image.
+	if (!exists $merge_rr{$path}) {
+		my ($name, $hunk) = compute_conflict_name($path);
+		next unless ($hunk);
+		$merge_rr{$path} = $name;
+		if (! -d "$rr_dir/$name") {
+			mkpath("$rr_dir/$name", 0, 0777);
+			print STDERR "Recorded preimage for '$path'\n";
+			record_preimage($path, "$rr_dir/$name/preimage");
+		}
+	}
+}
+
+# Now some of the paths that had conflicts earlier might have been
+# hand resolved.  Others may be similar to a conflict already that
+# was resolved before.
+
+for my $path (keys %merge_rr) {
+	my $name = $merge_rr{$path};
+
+	# We could resolve this automatically if we have images.
+	if (-f "$rr_dir/$name/preimage" &&
+	    -f "$rr_dir/$name/postimage") {
+		if (merge($name, $path)) {
+			print STDERR "Resolved '$path' using previous resolution.\n";
+			# Then we do not have to worry about this path
+			# anymore.
+			delete $merge_rr{$path};
+			next;
+		}
+	}
+
+	# Let's see if we have resolved it.
+	(undef, my $hunk) = compute_conflict_name($path);
+	next if ($hunk);
+
+	print STDERR "Recorded resolution for '$path'.\n";
+	copy($path, "$rr_dir/$name/postimage");
+	# And we do not have to worry about this path anymore.
+	delete $merge_rr{$path};
+}
+
+# Write out the rest.
+write_rr();
diff --git a/git-reset.sh b/git-reset.sh
index 6c9e58a..fe53fc8 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -100,4 +100,4 @@ case "$reset_type" in
 	;;
 esac
 
-rm -f "$GIT_DIR/MERGE_HEAD"
+rm -f "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/rr-cache/MERGE_RR"
-- 
1.1.5.g3480-dirty
