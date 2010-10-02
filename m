From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [RFC PATCH] git-svn: fix performance importing tagged subdirectories
Date: Sat,  2 Oct 2010 06:01:12 -0700
Message-ID: <1286024472-2255-1-git-send-email-ddkilzer@kilzer.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	"David D. Kilzer" <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 02 15:17:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P21xV-0001oq-RD
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 15:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092Ab0JBNLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 09:11:04 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:56911 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab0JBNLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 09:11:03 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Oct 2010 09:11:03 EDT
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 4B346B349D56;
	Sat,  2 Oct 2010 06:01:32 -0700 (PDT)
X-AuditID: 1180711d-b7b8eae0000035ac-45-4ca72d2cff32
Received: from ddkilzer.apple.com (ddkilzer.apple.com [17.202.32.26])
	by relay13.apple.com (Apple SCV relay) with SMTP id 1B.11.13740.C2D27AC4; Sat,  2 Oct 2010 06:01:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.158.gbd3a97
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157805>

NOTE: This is an RFC patch because I'm pretty sure I should be
using Git::SVN::Ra::can_do_switch() somewhere, and because I am
very likely abusing git-svn internal methods in a way that will
produce incorrect results in some cases.

Dave
--

When an svn repository has multiple related projects checked in
as individual directories under trunk:

    trunk/project1/
    trunk/project2/
    trunk/project3/

and each project subdirectory is tagged instead of tagging
trunk:

    [...]
    tags/project1-204
    tags/project1-205
    [...]
    tags/project2-395
    tags/project2-396
    [...]
    tags/project3-77
    tags/project3-78
    [...]

then git-svn currently imports the entire history of each new
tag beginning with r1.  This happens because git-svn uses the
name of the branch or tag when attempting to fast-forward svn
history.  For large svn repositories, the time required to
import each additional tag grows exponentially.

A better approach is to search through all known refs for a
ref that has the same repository URL, but with a smaller max
revision.  This ref could then be used to seed a new ref for
the tag being imported, thus bypassing the majority of the
work.

This approach is implemented by changing find_by_url() to take
an additional parameter ($rev) that tells it to return a ref
that represents the closest match to the desired repo url while
having a revision less than or equal to $rev.  When a brand new
ref is created in other_gs(), the new find_by_url() behavior is
used to find the closest matching ref and use it as a seed.
---
 git-svn.perl                          |   45 +++++++++++++++++++++---
 t/t9157-git-svn-subdir-import-perf.sh |   59 +++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 6 deletions(-)
 create mode 100755 t/t9157-git-svn-subdir-import-perf.sh

diff --git a/git-svn.perl b/git-svn.perl
index 9b046b6..af46f5f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1967,8 +1967,12 @@ sub init_remote_config {
 	$self->{url} = $url;
 }
 
-sub find_by_url { # repos_root and, path are optional
-	my ($class, $full_url, $repos_root, $path) = @_;
+# Finds an exact match for a ref based on $full_url, $repos_root and
+# $path.  If no exact match is found and if $rev is specified, the
+# closest match with the same url and a revision <= $rev is returned.
+# Note that $repos_root, $path and $rev are optional.
+sub find_by_url {
+	my ($class, $full_url, $repos_root, $path, $rev) = @_;
 
 	return undef unless defined $full_url;
 	remove_username($full_url);
@@ -1978,6 +1982,7 @@ sub find_by_url { # repos_root and, path are optional
 		$path = $full_url;
 		$path =~ s#^\Q$repos_root\E(?:/|$)##;
 	}
+	my ($closest_gs, $closest_max_rev);
 	foreach my $repo_id (keys %$remotes) {
 		my $u = $remotes->{$repo_id}->{url} or next;
 		remove_username($u);
@@ -2009,11 +2014,22 @@ sub find_by_url { # repos_root and, path are optional
 			$p =~ s#^\Q$z\E(?:/|$)#$prefix# or next;
 		}
 		foreach my $f (keys %$fetch) {
-			next if $f ne $p;
-			return Git::SVN->new($fetch->{$f}, $repo_id, $f);
+			unless ($rev) {
+				next if $f ne $p;
+				return Git::SVN->new($fetch->{$f}, $repo_id, $f);
+			}
+			my $gs = Git::SVN->new($fetch->{$f}, $repo_id, $f);
+			my ($max_rev, $max_commit) = $gs->rev_map_max(1);
+			next if !$max_rev || !$max_commit;
+			my ($url) = ::cmt_metadata($max_commit);
+			next if $url ne $full_url || $max_rev > $rev;
+			if (!$closest_gs || $closest_max_rev < $max_rev) {
+				$closest_gs = $gs;
+				$closest_max_rev = $max_rev;
+			}
 		}
 	}
-	undef;
+	$closest_gs && $rev ? $closest_gs : undef;
 }
 
 sub init {
@@ -2969,18 +2985,35 @@ sub other_gs {
 			$u = $url;
 			$repo_id = $self->{repo_id};
 		}
+		my $max_commit;
 		while (1) {
 			# It is possible to tag two different subdirectories at
 			# the same revision.  If the url for an existing ref
 			# does not match, we must either find a ref with a
 			# matching url or create a new ref by growing a tail.
 			$gs = Git::SVN->init($u, $p, $repo_id, $ref_id, 1);
-			my (undef, $max_commit) = $gs->rev_map_max(1);
+			(undef, $max_commit) = $gs->rev_map_max(1);
 			last if (!$max_commit);
 			my ($url) = ::cmt_metadata($max_commit);
 			last if ($url eq $gs->full_url);
 			$ref_id .= '-';
 		}
+		unless ($max_commit) {
+			# If a brand new ref was created, try to find a matching
+			# ref with the same url and a smaller revision to use as
+			# as a seed.  This avoids reloading the entire history
+			# of the repository when the same subdirectory is tagged
+			# frequently.
+			my $parent_gs = Git::SVN->find_by_url($new_url, $url,
+				$branch_from, $r);
+			if ($parent_gs) {
+				my ($parent_rev, $parent_commit) =
+					$parent_gs->rev_map_max(1);
+				$gs->rev_map_set($parent_rev, $parent_commit);
+				print STDERR "Using " . $parent_gs->{path} .
+					" as seed: $ref_id\n" unless $::_q > 1;
+			}
+		}
 		print STDERR "Initializing parent: $ref_id\n" unless $::_q > 1;
 	}
 	$gs
diff --git a/t/t9157-git-svn-subdir-import-perf.sh b/t/t9157-git-svn-subdir-import-perf.sh
new file mode 100755
index 0000000..d28d0e0
--- /dev/null
+++ b/t/t9157-git-svn-subdir-import-perf.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='git svn import subdirectory performance'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'setup svn repo' '
+	mkdir -p import/trunk/subdir &&
+	mkdir -p import/branches &&
+	mkdir -p import/tags &&
+	echo "base" >import/trunk/subdir/file &&
+	svn_cmd import -m "import for git svn" import "$svnrepo" &&
+	rm -rf import &&
+
+	svn_cmd co "$svnrepo/trunk" svn_project &&
+	j=4 &&
+	(cd svn_project &&
+		i=1 &&
+		while [ $i -le $j ]; do
+			echo "$i" >>subdir/file &&
+			svn_cmd ci -m "trunk change $i" subdir/file &&
+			i=$(($i+1))
+		done
+	) &&
+
+	svn_cmd cp -m "create tag mytag1" "$svnrepo/trunk/subdir" "$svnrepo/tags/mytag1" &&
+
+	(cd svn_project &&
+		i=$(($j+1)) &&
+		echo "$i" >>subdir/file &&
+		svn_cmd ci -m "trunk change $i" subdir/file
+	) &&
+
+	svn_cmd cp -m "create tag mytag2" "$svnrepo/trunk/subdir" "$svnrepo/tags/mytag2"
+
+	(cd svn_project &&
+		i=$(($j+2)) &&
+		echo "$i" >>subdir/file &&
+		svn_cmd ci -m "trunk change $i" subdir/file
+	) &&
+
+	svn_cmd cp -m "create tag mytag3" "$svnrepo/trunk/subdir" "$svnrepo/tags/mytag3"
+'
+
+test_expect_success 'import subdirectory performance' '
+	git svn init --stdlayout "$svnrepo" git_project &&
+	cd git_project &&
+	git svn fetch | tee fetch.txt &&
+
+	grep "refs/remotes/tags/mytag2@7" fetch.txt >actual.txt &&
+	grep "^r7" actual.txt >expected.txt &&
+	diff -u expected.txt actual.txt &&
+
+	git diff --exit-code tags/mytag1..tags/mytag2^^ &&
+	git diff --exit-code tags/mytag1..tags/mytag3^^^ &&
+	git diff --exit-code tags/mytag2..tags/mytag3^^
+'
+
+test_done
-- 
1.7.2.1.158.gbd3a97
