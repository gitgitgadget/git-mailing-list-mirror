From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH] git-svn: fix fetch with deleted tag
Date: Sat, 14 Aug 2010 07:07:11 -0700
Message-ID: <1281794831-33347-1-git-send-email-ddkilzer@kilzer.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	"David D. Kilzer" <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 16:07:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkHOc-0004rb-Cg
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 16:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602Ab0HNOHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 10:07:18 -0400
Received: from mail-out.apple.com ([17.254.13.23]:56968 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404Ab0HNOHR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 10:07:17 -0400
Received: from relay15.apple.com (relay15.apple.com [17.128.113.54])
	by mail-out4.apple.com (Postfix) with ESMTP id B3ACAA929B07;
	Sat, 14 Aug 2010 07:07:16 -0700 (PDT)
X-AuditID: 11807136-b7cc9ae000004162-91-4c66a31411a8
Received: from pwmerge.apple.com (pwmerge.apple.com [17.202.36.35])
	by relay15.apple.com (Apple SCV relay) with SMTP id E4.EA.16738.413A66C4; Sat, 14 Aug 2010 07:07:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.49.g98551
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153560>

Currently git-svn assumes that two tags created from the same
revision will have the same repo url, so it uses a ref to the
tag without checking that its url matches the current url.

This causes issues when fetching an svn repo where a tag was
created, deleted, and then recreated under the following
circumstances:

- Both tags were copied from the same revision.
- Both tags had the same name.
- Both tags had different repository paths.
- [Optional] Both tags have a file with the same name but
  different content.

When all four conditions are met, a checksum mismatch error
occurs because the content of two files with the same path
differ (see t/t9155--git-svn-fetch-deleted-tag.sh):

    Checksum mismatch: ChangeLog 065854....
    expected: ce771b....
         got: 9563fd....

When only the first three conditions are met, no error occurs
but the tag in git matches the first (deleted) tag instead of
the last (most recent) tag (see
t/t9156-git-svn-fetch-deleted-tag-2.sh).

The fix is to verify that the repo url for the ref matches the
current url.  If the urls do not match, then a "tail" is grown
on the tag name by appending a dash and rechecking the new ref's
repo url until either a matching repo url is found or a new tag
is created.

Also fix a regular expression used to remove the revision from
the end of a tag or branch name.  The regex did not account for
any "tail" (dashes) that may have been added to the end of the
tag name (which first appeared in a00439ac).  If not fixed, tags
with names like "tags/mytag@5--@2" may be created.
---
Originally reported in: [BUG/TEST] git-svn: fetch fails with deleted tag
<http://marc.info/?t=128115948900001&r=1&w=2>
<http://thread.gmane.org/gmane.comp.version-control.git/152844>
<message://%3c1281159415-60900-1-git-send-email-ddkilzer@kilzer.net%3e>

 git-svn.perl                           |   16 +++++++++--
 t/t9155-git-svn-fetch-deleted-tag.sh   |   43 ++++++++++++++++++++++++++++++
 t/t9156-git-svn-fetch-deleted-tag-2.sh |   45 ++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 3 deletions(-)
 create mode 100755 t/t9155-git-svn-fetch-deleted-tag.sh
 create mode 100755 t/t9156-git-svn-fetch-deleted-tag-2.sh

diff --git a/git-svn.perl b/git-svn.perl
index 8d2ef3d..c06d9d0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2957,18 +2957,28 @@ sub other_gs {
 	my $gs = Git::SVN->find_by_url($new_url, $url, $branch_from);
 	unless ($gs) {
 		my $ref_id = $old_ref_id;
-		$ref_id =~ s/\@\d+$//;
+		$ref_id =~ s/\@\d+-*$//;
 		$ref_id .= "\@$r";
 		# just grow a tail if we're not unique enough :x
 		$ref_id .= '-' while find_ref($ref_id);
-		print STDERR "Initializing parent: $ref_id\n" unless $::_q > 1;
 		my ($u, $p, $repo_id) = ($new_url, '', $ref_id);
 		if ($u =~ s#^\Q$url\E(/|$)##) {
 			$p = $u;
 			$u = $url;
 			$repo_id = $self->{repo_id};
 		}
-		$gs = Git::SVN->init($u, $p, $repo_id, $ref_id, 1);
+		while (1) {
+			# It is possible to tag two different subdirectories
+			# at the same revision.  If the url for an existing
+			# ref does not match, we must create a new ref.
+			$gs = Git::SVN->init($u, $p, $repo_id, $ref_id, 1);
+			my (undef, $max_commit) = $gs->rev_map_max(1);
+			last if (!$max_commit);
+			my ($url, undef, undef) = ::cmt_metadata($max_commit);
+			last if ($url eq $gs->full_url);
+			$ref_id .= '-';
+		}
+		print STDERR "Initializing parent: $ref_id\n" unless $::_q > 1;
 	}
 	$gs
 }
diff --git a/t/t9155-git-svn-fetch-deleted-tag.sh b/t/t9155-git-svn-fetch-deleted-tag.sh
new file mode 100755
index 0000000..4b50d7f
--- /dev/null
+++ b/t/t9155-git-svn-fetch-deleted-tag.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='git svn fetch deleted tag'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'setup svn repo' '
+	mkdir -p import/trunk/subdir &&
+	mkdir -p import/branches &&
+	mkdir -p import/tags &&
+	echo "base" > import/trunk/subdir/file &&
+	svn_cmd import -m "import for git svn" import "$svnrepo" &&
+	rm -rf import &&
+
+	svn_cmd mkdir --parents -m "create mybranch directory" "$svnrepo/branches/mybranch" &&
+	svn_cmd cp -m "create branch mybranch" "$svnrepo/trunk" "$svnrepo/branches/mybranch/trunk" &&
+
+	svn_cmd co "$svnrepo/trunk" svn_project &&
+	cd svn_project &&
+
+	echo "trunk change" >> subdir/file &&
+	svn_cmd ci -m "trunk change" subdir/file &&
+
+	svn_cmd switch "$svnrepo/branches/mybranch/trunk" &&
+	echo "branch change" >> subdir/file &&
+	svn_cmd ci -m "branch change" subdir/file &&
+
+	cd .. &&
+	svn_cmd cp -m "create mytag attempt 1" -r5 "$svnrepo/trunk/subdir" "$svnrepo/tags/mytag" &&
+	svn_cmd rm -m "delete mytag attempt 1" "$svnrepo/tags/mytag" &&
+	svn_cmd cp -m "create mytag attempt 2" -r5 "$svnrepo/branches/mybranch/trunk/subdir" "$svnrepo/tags/mytag"
+'
+
+test_expect_success 'fetch deleted tags from same revision with checksum error' '
+	git svn init --stdlayout "$svnrepo" git_project &&
+	cd git_project &&
+	git svn fetch &&
+
+	git diff --exit-code mybranch:trunk/subdir/file tags/mytag:file &&
+	git diff --exit-code master:subdir/file tags/mytag^:file
+'
+
+test_done
diff --git a/t/t9156-git-svn-fetch-deleted-tag-2.sh b/t/t9156-git-svn-fetch-deleted-tag-2.sh
new file mode 100755
index 0000000..ad8589c
--- /dev/null
+++ b/t/t9156-git-svn-fetch-deleted-tag-2.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='git svn fetch deleted tag 2'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'setup svn repo' '
+	mkdir -p import/branches &&
+	mkdir -p import/tags &&
+	mkdir -p import/trunk/subdir1 &&
+	mkdir -p import/trunk/subdir2 &&
+	mkdir -p import/trunk/subdir3 &&
+	echo "file1" > import/trunk/subdir1/file &&
+	echo "file2" > import/trunk/subdir2/file &&
+	echo "file3" > import/trunk/subdir3/file &&
+	svn_cmd import -m "import for git svn" import "$svnrepo" &&
+	rm -rf import &&
+
+	svn_cmd co "$svnrepo/trunk" svn_project &&
+	cd svn_project &&
+
+	echo "change1" >> subdir1/file &&
+	echo "change2" >> subdir2/file &&
+	echo "change3" >> subdir3/file &&
+	svn_cmd ci -m "change" . &&
+
+	cd .. &&
+	svn_cmd cp -m "create mytag 1" -r2 "$svnrepo/trunk/subdir1" "$svnrepo/tags/mytag" &&
+	svn_cmd rm -m "delete mytag 1" "$svnrepo/tags/mytag" &&
+	svn_cmd cp -m "create mytag 2" -r2 "$svnrepo/trunk/subdir2" "$svnrepo/tags/mytag" &&
+	svn_cmd rm -m "delete mytag 2" "$svnrepo/tags/mytag" &&
+	svn_cmd cp -m "create mytag 3" -r2 "$svnrepo/trunk/subdir3" "$svnrepo/tags/mytag"
+'
+
+test_expect_success 'fetch deleted tags from same revision with no checksum error' '
+	git svn init --stdlayout "$svnrepo" git_project &&
+	cd git_project &&
+	git svn fetch &&
+
+	git diff --exit-code master:subdir3/file tags/mytag:file &&
+	git diff --exit-code master:subdir2/file tags/mytag^:file &&
+	git diff --exit-code master:subdir1/file tags/mytag^^:file
+'
+
+test_done
-- 
1.7.2.1.49.g98551
