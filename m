From: Bryan Jacobs <bjacobs@woti.com>
Subject: [PATCH] git-svn: teach git-svn to populate svn:mergeinfo
Date: Fri, 2 Sep 2011 14:07:02 -0400
Organization: White Oak Technologies
Message-ID: <20110902140702.066a4668@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: Sam Vilain <sam@vilain.net>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 20:07:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzY95-0001bh-NU
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 20:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab1IBSHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 14:07:09 -0400
Received: from mail02.woti.us ([66.92.158.6]:54971 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753632Ab1IBSHG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2011 14:07:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id 53855504D37F1;
	Fri,  2 Sep 2011 14:07:04 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YsUXfrQPKizx; Fri,  2 Sep 2011 14:07:03 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 10F4A504D37F0;
	Fri,  2 Sep 2011 14:07:03 -0400 (EDT)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180626>

>From a74814d4cd91627098e5be0209da30a2bc23904e Mon Sep 17 00:00:00 2001
From: Bryan Jacobs <bjacobs@woti.com>
Date: Thu, 1 Sep 2011 16:53:17 -0400
Subject: [PATCH] git-svn: teach git-svn to populate svn:mergeinfo

Allow git-svn to populate the svn:mergeinfo property automatically in
a narrow range of circumstances. Specifically, when dcommitting a
revision with multiple parents, each of which have been already
committed to SVN.

In this case, the merge info is the union of that given by each of the
parents, plus all changes introduced to the first parent by the other
parents.

In all other cases where a revision has multiple parents, cause "git
svn dcommit" to raise an error rather than completing the commit and
potentially losing history information in the upstream SVN repository.

This behavior is disabled by default, and can be enabled by setting
the svn.pushmergeinfo config option.

Signed-off-by: Bryan Jacobs <bjacobs@woti.com>
---

Per previous discussion re: svn:mergeinfo handling, I am submitting for your consideration a patch which allows git-svn to write mergeinfo as well as read it.

This has several limitations. Specifically, it does not handle any cases concerning fast-forward merges, nor any with cherry-picks. It exclusively deals with --no-ff merges where both parents are already committed to SVN.

For this particular case, it works well: svn:mergeinfo is populated in such a way that the local merge history is recreated when another git-svn user pulls down the repository. This patch thus allows to git users to exchange branching and merging development through a central SVN server without loss of fidelity and without explicitly manipulating the mergeinfo property by hand.

If the user has made commits to two local branches, merges them with --no-ff, and attempts to dcommit the result, the tool will error out with a message stating that all parents must reside in the SVN repository before their merge can be committed.

I was unable to discover a way to clean way to restore the repository state in the case where this happens before reaching the HEAD commit. For example:

r1 --- B --- C -- F
 \               /
  r2 --- E ------

If r1 and r2 already reside in SVN, git-svn will dcommit B and C, then error when it tries to dcommit F (since the SVN revision number for E has not yet been set; the user should dcommit E before dcommitting F). The repository SHOULD be set to the following state after this happens:

r1 -- r3 -- r4 -- F
 \               /
  r2 --- E ------

... but git-svn seems to put all the changes from all objects that it will be dcommitting into the working copy, which means that cherry-picking F atop the state the WC is in fails (due to conflicts with "untracked" objects already added). So in this patch if you try the above, you actually end up in this state:

r1 --- r3 -- r4
 \
  r2 --- E

F is lost and cannot be cherry-picked back onto the WC, as any files created in E are already present but untracked locally.

I would appreciate any help anyone can give with what the proper way to "partially reset" a git-svn commit which gets halfway through is. My attempt is the commented-out code in merge_commit_fail below. So far as I can tell, if *any* multi-revision dcommit of a merge is aborted partway through, it may end with an unclean WC and make reflog recovery necessary (even before my changes).

The other corner case I am unsure about is when two branches are merged, then the merge result is itself merged into a third. Like so:

branch1: r1 ----- r4
                 /  \
branch2:   r2 ---    \
                      \
branch3: r3 --------- r5

This has the effect of branch3's mergeinfo containing r2 as part of both branch1 and branch2 (branch2:2 from the merge history set in r4, and branch1:2 from the changes being introduced by the second parent of r5). I wasn't sure whether the mergeinfo should be "deduplicated" and only contain r2 on branch2. Not sure what the stock SVN client does here.

Finally, this makes NO EFFORT to handle svn:mergeinfo set on subdirectories of the branch root folder. The SVN red book advises against using mergeinfo on anything other than a branch top-level folder, so I think this is acceptable.

All new behavior is disabled by default, and all non-error-handling behavior is tested/demonstrated.

 Documentation/git-svn.txt         |    8 +
 git-svn.perl                      |  230 ++++++++++++++++++++++-
 t/t9160-git-svn-mergeinfo-push.sh |   97 ++++++++++
 t/t9160/branches.dump             |  374 +++++++++++++++++++++++++++++++++++++
 4 files changed, 707 insertions(+), 2 deletions(-)
 create mode 100755 t/t9160-git-svn-mergeinfo-push.sh
 create mode 100644 t/t9160/branches.dump

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ed5eca1..2bf5703 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -213,6 +213,14 @@ discouraged.
 	store this information (as a property), and svn clients starting from
 	version 1.5 can make use of it. 'git svn' currently does not use it
 	and does not set it automatically.
++
+[verse]
+config key: svn.pushmergeinfo
++
+This option will cause git-svn to attempt to automatically populate the
+svn:mergeinfo property in the SVN repository when possible. Currently, this can
+only be done when dcommitting non-fast-forward merges where all parents have
+already been pushed into SVN.
 
 'branch'::
 	Create a branch in the SVN repository.
diff --git a/git-svn.perl b/git-svn.perl
index 89f83fd..80df8a0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -497,6 +497,216 @@ sub cmd_set_tree {
 	unlink $gs->{index};
 }
 
+sub split_merge_info_range {
+	my ($range) = @_;
+	if ($range =~ /(\d+)-(\d+)/o) {
+		return (int($1), int($2));
+	} else {
+		return (int($range), int($range));
+	}
+}
+
+sub combine_ranges {
+	my ($in) = @_;
+
+	my @fnums = ();
+	my @arr = split(/,/o, $in);
+	for my $element (@arr) {
+		my ($start, $end) = split_merge_info_range($element);
+		push @fnums, $start;
+	}
+
+	my @sorted = @arr [ sort {
+		$fnums[$a] <=> $fnums[$b]
+	} 0..$#arr ];
+
+	my @return = ();
+	my $last = -1;
+	my $first = -1;
+	for my $element (@sorted) {
+		my ($start, $end) = split_merge_info_range($element);
+
+		if ($last == -1) {
+			$first = $start;
+			$last = $end;
+			next;
+		}
+		if ($start <= $last+1) {
+			if ($end > $last) {
+				$last = $end;
+			}
+			next;
+		}
+		if ($first == $last) {
+			push @return, "$first";
+		} else {
+			push @return, "$first-$last";
+		}
+		$first = $start;
+		$last = $end;
+	}
+
+	if ($first != -1) {
+		if ($first == $last) {
+			push @return, "$first";
+		} else {
+			push @return, "$first-$last";
+		}
+	}
+
+	return join(',', @return);
+}
+
+sub merge_revs_into_hash {
+	my ($hash, $minfo) = @_;
+	my @lines = split(' ', $minfo);
+
+	for my $line (@lines) {
+		my ($branchpath, $revs) = split(/:/o, $line);
+
+		if (exists($hash->{$branchpath})) {
+			# Merge the two revision sets
+			my $combined = "$hash->{$branchpath},$revs";
+			$hash->{$branchpath} = combine_ranges($combined);
+		} else {
+			# Just do range combining for consolidation
+			$hash->{$branchpath} = combine_ranges($revs);
+		}
+	}
+}
+
+sub merge_merge_info {
+	my ($mergeinfo_one, $mergeinfo_two) = @_;
+	my %result_hash = ();
+
+	merge_revs_into_hash(\%result_hash, $mergeinfo_one);
+	merge_revs_into_hash(\%result_hash, $mergeinfo_two);
+
+	my $result = '';
+	# Sort below is for consistency's sake
+	for my $branchname (sort keys(%result_hash)) {
+		my $revlist = $result_hash{$branchname};
+		$result .= "$branchname:$revlist\n"
+	}
+	return $result;
+}
+
+sub merge_commit_fail {
+	my ($gs, $linear_refs, $d) = @_;
+	#while (1) {
+	#	my $cs = shift @$linear_refs or last;
+	#	command_noisy(qw/cherry-pick/, $cs);
+	#}
+	#command_noisy(qw/cherry-pick -m/, '1', $d);
+	fatal "Aborted after failed dcommit of merge revision";
+}
+
+sub populate_merge_info {
+	my ($d, $gs, $uuid, $linear_refs) = @_;
+
+	my %parentshash;
+	read_commit_parents(\%parentshash, $d);
+	my @parents = @{$parentshash{$d}};
+	if ($#parents > 0) {
+		# Merge commit
+		my $all_parents_ok = 1;
+		my $aggregate_mergeinfo = '';
+		my $rooturl = $gs->repos_root;
+		foreach my $parent (@parents) {
+			my ($branchurl, $svnrev, $paruuid) =
+				cmt_metadata($parent);
+
+			unless (defined $paruuid) {
+				# A parent is missing SVN annotations...
+				# abort the whole operation.
+				print "$parent is merged into revision $d, "
+					 ."but does not have git-svn metadata. "
+					 ."Either dcommit the branch or use a "
+					 ."local cherry-pick, FF merge, or rebase "
+					 ."instead of an explicit merge commit.\n";
+				merge_commit_fail($gs, $linear_refs, $d);
+			}
+
+			unless ($paruuid eq $uuid) {
+				# Parent has SVN metadata from different repository
+				print "merge parent $parent for change $d has "
+					 ."git-svn uuid $paruuid, while current change "
+					 ."has uuid $uuid!\n";
+				merge_commit_fail($gs, $linear_refs, $d);
+			}
+
+			unless ($branchurl =~ /^$rooturl(.*)/) {
+				# This branch is very strange indeed.
+				print "merge parent $parent for $d is on branch "
+					 ."$branchurl, which is not under the "
+					 ."git-svn root $rooturl!\n";
+				merge_commit_fail($gs, $linear_refs, $d);
+			}
+			my $branchpath = $1;
+
+			my $ra = Git::SVN::Ra->new($branchurl);
+			my (undef, undef, $props) =
+				$ra->get_dir(canonicalize_path("."), $svnrev);
+			my $par_mergeinfo = $props->{'svn:mergeinfo'};
+			unless (defined $par_mergeinfo) {
+				$par_mergeinfo = '';
+			}
+			# Merge previous mergeinfo values
+			$aggregate_mergeinfo =
+				merge_merge_info($aggregate_mergeinfo,
+								 $par_mergeinfo, 0);
+
+			next if $parent eq $parents[0]; # Skip first parent
+			# Add new changes being placed in tree by merge
+			my @cmd = (qw/rev-list --reverse/,
+					   $parent, qw/--not/);
+			foreach my $par (@parents) {
+				unless ($par eq $parent) {
+					push @cmd, $par;
+				}
+			}
+			my @revsin = ();
+			my ($revlist, $ctx) = command_output_pipe(@cmd);
+			while (<$revlist>) {
+				my $irev = $_;
+				chomp $irev;
+				my (undef, $csvnrev, undef) =
+					cmt_metadata($irev);
+				unless (defined $csvnrev) {
+					# A child is missing SVN annotations...
+					# this might be OK, or might not be.
+					warn "W:child $irev is merged into revision "
+						 ."$d but does not have git-svn metadata. "
+						 ."This means git-svn cannot determine the "
+						 ."svn revision numbers to place into the "
+						 ."svn:mergeinfo property. You must ensure "
+						 ."a branch is entirely committed to "
+						 ."SVN before merging it in order for "
+						 ."svn:mergeinfo population to function "
+						 ."properly";
+				}
+				push @revsin, $csvnrev;
+			}
+			command_close_pipe($revlist, $ctx);
+
+			last unless $all_parents_ok;
+
+			# We now have a list of all SVN revnos which are
+			# merged by this particular parent. Integrate them.
+			next if $#revsin == -1;
+			my $newmergeinfo = "$branchpath:" . join(',', @revsin);
+			$aggregate_mergeinfo =
+				merge_merge_info($aggregate_mergeinfo,
+								 $newmergeinfo, 1);
+		}
+		if ($all_parents_ok and $aggregate_mergeinfo) {
+			return $aggregate_mergeinfo;
+		}
+	}
+
+	return undef;
+}
+
 sub cmd_dcommit {
 	my $head = shift;
 	command_noisy(qw/update-index --refresh/);
@@ -547,6 +757,14 @@ sub cmd_dcommit {
 		     "without --no-rebase may be required."
 	}
 	my $expect_url = $url;
+
+	my $push_merge_info = eval {
+		command_oneline(qw/config --get svn.pushmergeinfo/) };
+	if ($push_merge_info eq "false" or $push_merge_info eq "no"
+			or $push_merge_info eq "never") {
+		$push_merge_info = 0;
+	}
+
 	Git::SVN::remove_username($expect_url);
 	while (1) {
 		my $d = shift @$linear_refs or last;
@@ -561,6 +779,12 @@ sub cmd_dcommit {
 			print "diff-tree $d~1 $d\n";
 		} else {
 			my $cmt_rev;
+
+
+			unless (defined $_merge_info or not $push_merge_info) {
+				$_merge_info = populate_merge_info($d, $gs, $uuid, $linear_refs);
+			}
+
 			my %ed_opts = ( r => $last_rev,
 			                log => get_commit_entry($d)->{log},
 			                ra => Git::SVN::Ra->new($url),
@@ -3341,8 +3565,10 @@ sub find_extra_svn_parents {
 		       );
 
 		if ( @incomplete ) {
-			warn "W:svn cherry-pick ignored ($spec) - missing "
-				.@incomplete." commit(s) (eg $incomplete[0])\n";
+			warn "W:svn mergeinfo ignored ($spec) - "
+				.@incomplete." commit(s) have not been merged into "
+				."$merge_base (eg $incomplete[0]). This change "
+				."represents a cherry-pick.\n";
 		} else {
 			warn
 				"Found merge parent (svn:mergeinfo prop): ",
diff --git a/t/t9160-git-svn-mergeinfo-push.sh b/t/t9160-git-svn-mergeinfo-push.sh
new file mode 100755
index 0000000..740adef
--- /dev/null
+++ b/t/t9160-git-svn-mergeinfo-push.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+#
+# Copyright (c) 2007, 2009 Sam Vilain
+#
+
+test_description='git-svn svn mergeinfo propagation'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'load svn dump' "
+	svnadmin load -q '$rawsvnrepo' \
+	  < '$TEST_DIRECTORY/t9160/branches.dump' &&
+	git svn init --minimize-url -R svnmerge \
+	  -T trunk -b branches '$svnrepo' &&
+	git svn fetch --all
+	"
+
+test_expect_success 'propagate merge information' '
+	git config svn.pushmergeinfo yes &&
+	git checkout svnb1 &&
+	git merge --no-ff svnb2 &&
+	git svn dcommit
+	'
+
+test_expect_success 'check svn:mergeinfo' '
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1)
+	echo "$mergeinfo"
+	test "$mergeinfo" = "/branches/svnb2:3,8"
+	'
+
+test_expect_success 'merge another branch' '
+	git merge --no-ff svnb3 &&
+	git svn dcommit
+	'
+
+test_expect_success 'check primary parent mergeinfo respected' '
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1)
+	test "$mergeinfo" = "/branches/svnb2:3,8
+/branches/svnb3:4,9"
+	'
+
+test_expect_success 'merge existing merge' '
+	git merge --no-ff svnb4 &&
+	git svn dcommit
+	'
+
+test_expect_success "check both parents' mergeinfo respected" '
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1)
+	test "$mergeinfo" = "/branches/svnb2:3,8
+/branches/svnb3:4,9
+/branches/svnb4:5-6,10-12
+/branches/svnb5:6,11"
+	'
+
+test_expect_success 'make further commits to branch' '
+	git checkout svnb2 &&
+	touch newb2file &&
+	git add newb2file &&
+	git commit -m "later b2 commit" &&
+	touch newb2file-2 &&
+	git add newb2file-2 &&
+	git commit -m "later b2 commit 2" &&
+	git svn dcommit
+	'
+
+test_expect_success 'second forward merge' '
+	git checkout svnb1 &&
+	git merge --no-ff svnb2 &&
+	git svn dcommit
+	'
+
+test_expect_success "check new mergeinfo added" '
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1)
+	echo "$mergeinfo"
+	test "$mergeinfo" = "/branches/svnb2:3,8,16-17
+/branches/svnb3:4,9
+/branches/svnb4:5-6,10-12
+/branches/svnb5:6,11"
+	'
+
+test_expect_success 'reintegration merge' '
+	git checkout svnb4 &&
+	git merge --no-ff svnb1 &&
+	git svn dcommit
+	'
+
+test_expect_success "check reintegration mergeinfo" '
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb4)
+	echo "$mergeinfo"
+	test "$mergeinfo" = "/branches/svnb1:2-4,7-9,13-18
+/branches/svnb2:3,8,16-17
+/branches/svnb3:4,9
+/branches/svnb4:5-6,10-12
+/branches/svnb5:6,11"
+	'
+
+test_done
diff --git a/t/t9160/branches.dump b/t/t9160/branches.dump
new file mode 100644
index 0000000..e61c3e7
--- /dev/null
+++ b/t/t9160/branches.dump
@@ -0,0 +1,374 @@
+SVN-fs-dump-format-version: 2
+
+UUID: 1ef08553-f2d1-45df-b38c-19af6b7c926d
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2011-09-02T16:08:02.941384Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 114
+Content-length: 114
+
+K 7
+svn:log
+V 12
+Base commit
+
+K 10
+svn:author
+V 7
+bjacobs
+K 8
+svn:date
+V 27
+2011-09-02T16:08:27.205062Z
+PROPS-END
+
+Node-path: branches
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: trunk
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 2
+Prop-content-length: 121
+Content-length: 121
+
+K 7
+svn:log
+V 19
+Create branch svnb1
+K 10
+svn:author
+V 7
+bjacobs
+K 8
+svn:date
+V 27
+2011-09-02T16:09:43.628137Z
+PROPS-END
+
+Node-path: branches/svnb1
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: trunk
+
+
+Revision-number: 3
+Prop-content-length: 121
+Content-length: 121
+
+K 7
+svn:log
+V 19
+Create branch svnb2
+K 10
+svn:author
+V 7
+bjacobs
+K 8
+svn:date
+V 27
+2011-09-02T16:09:46.339930Z
+PROPS-END
+
+Node-path: branches/svnb2
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: trunk
+
+
+Revision-number: 4
+Prop-content-length: 121
+Content-length: 121
+
+K 7
+svn:log
+V 19
+Create branch svnb3
+K 10
+svn:author
+V 7
+bjacobs
+K 8
+svn:date
+V 27
+2011-09-02T16:09:49.394515Z
+PROPS-END
+
+Node-path: branches/svnb3
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: trunk
+
+
+Revision-number: 5
+Prop-content-length: 121
+Content-length: 121
+
+K 7
+svn:log
+V 19
+Create branch svnb4
+K 10
+svn:author
+V 7
+bjacobs
+K 8
+svn:date
+V 27
+2011-09-02T16:09:54.114607Z
+PROPS-END
+
+Node-path: branches/svnb4
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: trunk
+
+
+Revision-number: 6
+Prop-content-length: 121
+Content-length: 121
+
+K 7
+svn:log
+V 19
+Create branch svnb5
+K 10
+svn:author
+V 7
+bjacobs
+K 8
+svn:date
+V 27
+2011-09-02T16:09:58.602623Z
+PROPS-END
+
+Node-path: branches/svnb5
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: trunk
+
+
+Revision-number: 7
+Prop-content-length: 110
+Content-length: 110
+
+K 7
+svn:log
+V 9
+b1 commit
+K 10
+svn:author
+V 7
+bjacobs
+K 8
+svn:date
+V 27
+2011-09-02T16:10:20.292369Z
+PROPS-END
+
+Node-path: branches/svnb1/b1file
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 0
+Text-content-md5: d41d8cd98f00b204e9800998ecf8427e
+Text-content-sha1: da39a3ee5e6b4b0d3255bfef95601890afd80709
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 8
+Prop-content-length: 110
+Content-length: 110
+
+K 7
+svn:log
+V 9
+b2 commit
+K 10
+svn:author
+V 7
+bjacobs
+K 8
+svn:date
+V 27
+2011-09-02T16:10:38.429199Z
+PROPS-END
+
+Node-path: branches/svnb2/b2file
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 0
+Text-content-md5: d41d8cd98f00b204e9800998ecf8427e
+Text-content-sha1: da39a3ee5e6b4b0d3255bfef95601890afd80709
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 9
+Prop-content-length: 110
+Content-length: 110
+
+K 7
+svn:log
+V 9
+b3 commit
+K 10
+svn:author
+V 7
+bjacobs
+K 8
+svn:date
+V 27
+2011-09-02T16:10:52.843023Z
+PROPS-END
+
+Node-path: branches/svnb3/b3file
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 0
+Text-content-md5: d41d8cd98f00b204e9800998ecf8427e
+Text-content-sha1: da39a3ee5e6b4b0d3255bfef95601890afd80709
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 10
+Prop-content-length: 110
+Content-length: 110
+
+K 7
+svn:log
+V 9
+b4 commit
+K 10
+svn:author
+V 7
+bjacobs
+K 8
+svn:date
+V 27
+2011-09-02T16:11:17.489870Z
+PROPS-END
+
+Node-path: branches/svnb4/b4file
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 0
+Text-content-md5: d41d8cd98f00b204e9800998ecf8427e
+Text-content-sha1: da39a3ee5e6b4b0d3255bfef95601890afd80709
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 11
+Prop-content-length: 110
+Content-length: 110
+
+K 7
+svn:log
+V 9
+b5 commit
+K 10
+svn:author
+V 7
+bjacobs
+K 8
+svn:date
+V 27
+2011-09-02T16:11:32.277404Z
+PROPS-END
+
+Node-path: branches/svnb5/b5file
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 0
+Text-content-md5: d41d8cd98f00b204e9800998ecf8427e
+Text-content-sha1: da39a3ee5e6b4b0d3255bfef95601890afd80709
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 12
+Prop-content-length: 192
+Content-length: 192
+
+K 7
+svn:log
+V 90
+Merge remote-tracking branch 'svnb5' into HEAD
+
+* svnb5:
+  b5 commit
+  Create branch svnb5
+K 10
+svn:author
+V 7
+bjacobs
+K 8
+svn:date
+V 27
+2011-09-02T16:11:54.274722Z
+PROPS-END
+
+Node-path: branches/svnb4
+Node-kind: dir
+Node-action: change
+Prop-content-length: 56
+Content-length: 56
+
+K 13
+svn:mergeinfo
+V 21
+/branches/svnb5:6,11
+
+PROPS-END
+
+
+Node-path: branches/svnb4/b5file
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 0
+Text-content-md5: d41d8cd98f00b204e9800998ecf8427e
+Text-content-sha1: da39a3ee5e6b4b0d3255bfef95601890afd80709
+Content-length: 10
+
+PROPS-END
+
+
-- 
1.7.7.rc0.73.gc42335.dirty
