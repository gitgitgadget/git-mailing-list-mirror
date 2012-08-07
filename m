From: Peter Baumann <waste.manager@gmx.de>
Subject: [PATCH] git svn: reset invalidates the memoized mergeinfo caches
Date: Tue, 7 Aug 2012 22:02:07 +0200
Message-ID: <20120807200207.GA10899@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Andrew Myrick <amyrick@apple.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Steven Walter <stevenrwalter@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 22:22:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyqI5-00008F-VE
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 22:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131Ab2HGUWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 16:22:03 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:53954 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755891Ab2HGUWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 16:22:01 -0400
Received: (qmail invoked by alias); 07 Aug 2012 20:21:59 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp033) with SMTP; 07 Aug 2012 22:21:59 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19D/BEsMkdDbINzoRFEb6ZAcnztn4muYTcCRHAybZ
	6j78vcnfoACMhB
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 539B8D6BCC; Tue,  7 Aug 2012 22:02:07 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203043>

Since v1.7.0-rc2~11 (git-svn: persistent memoization, 2010-01-30),
git-svn has maintained some private per-repository caches in
.git/svn/.caches to avoid refetching and recalculating some
mergeinfo-related information with every 'git svn fetch'.

This memoization can cause problems, e.g consider the following case:

SVN repo:

  ... - a - b - c - m  <- trunk
          \        /
            d  -  e    <- branch1

The Git import of the above repo is at commit 'a' and doesn't know about
the branch1. In case of an 'git svn rebase', only the trunk of the
SVN repo is imported. During the creation of the git commit 'm', git svn
uses the svn:mergeinfo property and tries to find the corresponding git
commit 'e' to create 'm' with 'c' and 'e' as parents. But git svn rebase
only imports the current branch so commit 'e' is not imported.
Therefore git svn fails to create commit 'm' as a merge commit, because one
of its parents is not known to git. The imported history looks like this:

  ... - a - b - c - m  <- trunk

A later 'git svn fetch' to import all branches can't rewrite the commit 'm'
to add 'e' as a parent and to make it a real git merge commit, because it
was already imported.

That's why the imported history misses the merge and looks like this:

  ... - a - b - c - m  <- trunk
          \
            d  -  e    <- branch1

Right now the only known workaround for importing 'm' as a merge is to
force reimporting 'm' again from SVN, e.g. via

  $ git svn reset --revision $(git find-rev $c)
  $ git svn fetch

Sadly, this is where the behavior has regressed: git svn reset doesn't
invalidate the old mergeinfo cache, which is no longer valid for the
reimport, which leads to 'm' beeing imprted with only 'c' as parent.

As solution to this problem, this commit invalidates the mergeinfo cache
to force correct recalculation of the parents.

During development of this patch, several ways for invalidating the cache
where considered. One of them is to use Memoize::flush_cache, which will
call the CLEAR method on the underlying Memoize persistency implementation.
Sadly, neither Memoize::Storable nor the newer Memoize::YAML module
introduced in 68f532f4ba888 could optionally be used implement the
CLEAR method, so this is not an option.

Reseting the internal hash used to store the memoized values has the same
problem, because it calls the non-existing CLEAR method of the
underlying persistency layer, too.

Considering this and taking into account the different implementations
of the memoization modules, where Memoize::Storable is not in our control,
implementing the missing CLEAR method is not an option, at least not if
Memoize::Storable is still used.

Therefore the easiest solution to clear the cache is to delete the files
on disk in 'git svn reset'. Normally, deleting the files behind the back
of the memoization module would be problematic, because the in-memory
representation would still exist and contain wrong data. Fortunately, the
memoization is active in memory only for a small portion of the code.
Invalidating the cache by deleting the files on disk if it isn't active
should be safe.

Signed-off-by: Peter Baumann <waste.manager@gmx.de>
---
 perl/Git/SVN.pm                        | 25 ++++++++++-
 t/t9163-git-svn-reset-clears-caches.sh | 79 ++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 2 deletions(-)
 create mode 100755 t/t9163-git-svn-reset-clears-caches.sh

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 0889145..430b366 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1634,6 +1634,22 @@ sub tie_for_persistent_memoization {
 		Memoize::unmemoize 'has_no_changes';
 	}
 
+	sub clear_memoized_mergeinfo_caches {
+		die "Only call this method in non-memoized context" if ($memoized);
+
+		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
+		return unless -d $cache_path;
+
+		for my $cache_file (("$cache_path/lookup_svn_merge",
+				     "$cache_path/check_cherry_pick",
+				     "$cache_path/has_no_changes")) {
+			for my $suffix (qw(yaml db)) {
+				unlink("$cache_file.$suffix");
+			}
+		}
+	}
+
+
 	Memoize::memoize 'Git::SVN::repos_root';
 }
 
@@ -2126,8 +2142,13 @@ sub rev_map_set {
 
 	sysopen(my $fh, $db_lock, O_RDWR | O_CREAT)
 	     or croak "Couldn't open $db_lock: $!\n";
-	$update_ref eq 'reset' ? _rev_map_reset($fh, $rev, $commit) :
-				 _rev_map_set($fh, $rev, $commit);
+	if ($update_ref eq 'reset') {
+		_rev_map_reset($fh, $rev, $commit);
+		clear_memoized_mergeinfo_caches();
+	} else {
+		_rev_map_set($fh, $rev, $commit);
+	}
+
 	if ($sync) {
 		$fh->flush or die "Couldn't flush $db_lock: $!\n";
 		$fh->sync or die "Couldn't sync $db_lock: $!\n";
diff --git a/t/t9163-git-svn-reset-clears-caches.sh b/t/t9163-git-svn-reset-clears-caches.sh
new file mode 100755
index 0000000..d604dfd
--- /dev/null
+++ b/t/t9163-git-svn-reset-clears-caches.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Peter Baumann
+#
+
+test_description='git svn reset clears memoized caches'
+. ./lib-git-svn.sh
+
+svn_ver="$(svn --version --quiet)"
+case $svn_ver in
+0.* | 1.[0-4].*)
+	skip_all="skipping git-svn test - SVN too old ($svn_ver)"
+	test_done
+	;;
+esac
+
+# ... a  -  b - m   <- trunk
+#      \       /
+#       ... c       <- branch1
+#
+# ... = SVN Commits not interesting for this test, e.g. commits creating
+#       the SVN repo layout
+#
+test_expect_success 'initialize source svn repo' '
+	svn_cmd mkdir -m "create trunk" "$svnrepo"/trunk &&
+	svn_cmd mkdir -m "create branches" "$svnrepo/branches" &&
+	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
+	(
+		cd "$SVN_TREE" &&
+		touch foo &&
+		svn add foo &&
+		svn commit -m "a" &&
+		svn cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch1 &&
+		svn switch "$svnrepo"/branches/branch1 &&
+		touch bar &&
+		svn add bar &&
+		svn commit -m b &&
+		svn switch "$svnrepo"/trunk &&
+		touch baz &&
+		svn add baz &&
+		svn commit -m c &&
+		svn up &&
+		svn merge "$svnrepo"/branches/branch1 &&
+		svn commit -m "m"
+	) &&
+	rm -rf "$SVN_TREE"
+'
+
+test_expect_success 'fetch to merge-base (a)' '
+	git svn init -s "$svnrepo" &&
+	git svn fetch --revision BASE:3
+'
+
+# git svn rebase looses the merge commit
+#
+# ... a  -  b - m  <- trunk
+#      \
+#       ... c
+#
+test_expect_success 'rebase looses SVN merge (m)' '
+	git svn rebase &&
+	git svn fetch &&
+	test 1 = $(git cat-file -p master|grep parent|wc -l)
+'
+
+# git svn fetch creates correct history with merge commit
+#
+# ... a  -  b - m  <- trunk
+#      \       /
+#       ... c      <- branch1
+#
+test_expect_success 'reset and fetch gets the SVN merge (m) correctly' '
+	git svn reset -r 3 &&
+	git reset --hard trunk && 
+	git svn fetch &&
+	test 2 = $(git cat-file -p trunk|grep parent|wc -l)
+'
+
+test_done
-- 
1.7.12.rc0.10.g476109f
