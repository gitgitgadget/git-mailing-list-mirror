From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: disable _rev_list memoization
Date: Mon, 27 Oct 2014 01:40:33 +0000
Message-ID: <20141027014033.GA4189@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lin zuojian <manjian2006@gmail.com>,
	Hin-Tak Leung <htl10@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 02:40:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiZIU-00050q-IT
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 02:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbaJ0Bke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 21:40:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42703 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbaJ0Bkd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 21:40:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361E41F624;
	Mon, 27 Oct 2014 01:40:33 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This memoization appears unneeded as the check_cherry_pick2 cache is
in front of it does enough.

With this change applied, importing from local svn+ssh and http copies
of the R repo[1] takes only 2:00 (2 hours) on my system and the git-svn
process never uses more than 60MB RSS on my x86-64 GNU/Linux system[2].
This 60M measurement is only for the git-svn Perl process itself and
does not include memory used by git subprocesses accessing large packs
(subprocess memory usage _is_ measured by my time(1) tool).

Before this change, an import took longer (2:20) on svn+ssh:// but
git-svn used around 240MB during the imports.  Worse yet, git-svn
ballooned to over 400M when writing out the cache to the filesystem.

I also tried removing memoization for `has_no_changes', too, but a
local copy of the R repository(*) was not close to finishing within
10 hours on my system.

[1] http://svn.r-project.org/R
[2] file:// repos causes libsvn to use more memory internally

Signed-off-by: Eric Wong <normalperson@yhbt.net>
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>
---
  This patch is in my "less-memo" branch of bogomips.org/git-svn.git
  Info here:

  (not intended as a pull request for Junio, yet)

  The following changes since commit fbecd99861ea5795aeba46faf2ac7a8c1b70d485:

    Update draft release notes to 2.2 (2014-10-24 15:02:17 -0700)

  are available in the git repository at:

    git://bogomips.org/git-svn.git less-memo

  for you to fetch changes up to 7676aff70973e617c3f58a8633db6d0e3ee99e45:

    git-svn: disable _rev_list memoization (2014-10-27 01:39:39 +0000)

  ----------------------------------------------------------------
  Eric Wong (7):
        git-svn: reduce check_cherry_pick cache overhead
        git-svn: cache only mergeinfo revisions
        git-svn: remove mergeinfo rev caching
        git-svn: reload RA every log-window-size
        git-svn: remove unnecessary DESTROY override
        git-svn: save a little memory as fetch progresses
        git-svn: disable _rev_list memoization

  Jakob Stoklund Olesen (2):
        git-svn: only look at the new parts of svn:mergeinfo
        git-svn: only look at the root path for svn:mergeinfo

  Sveinung Kvilhaugsvik (1):
        git-svn.txt: advertise pushurl with dcommit

   Documentation/git-svn.txt |   4 ++
   perl/Git/SVN.pm           | 121 +++++++++++++++++++++++++++++-----------------
   perl/Git/SVN/Ra.pm        |  27 ++++++-----
   3 files changed, 94 insertions(+), 58 deletions(-)

 perl/Git/SVN.pm | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 4364506..5f9d469 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1600,7 +1600,6 @@ sub tie_for_persistent_memoization {
 		my %lookup_svn_merge_cache;
 		my %check_cherry_pick2_cache;
 		my %has_no_changes_cache;
-		my %_rev_list_cache;
 
 		tie_for_persistent_memoization(\%lookup_svn_merge_cache,
 		    "$cache_path/lookup_svn_merge");
@@ -1622,14 +1621,6 @@ sub tie_for_persistent_memoization {
 			SCALAR_CACHE => ['HASH' => \%has_no_changes_cache],
 			LIST_CACHE => 'FAULT',
 		;
-
-		tie_for_persistent_memoization(\%_rev_list_cache,
-		    "$cache_path/_rev_list");
-		memoize '_rev_list',
-			SCALAR_CACHE => 'FAULT',
-			LIST_CACHE => ['HASH' => \%_rev_list_cache],
-		;
-
 	}
 
 	sub unmemoize_svn_mergeinfo_functions {
@@ -1639,7 +1630,6 @@ sub tie_for_persistent_memoization {
 		Memoize::unmemoize 'lookup_svn_merge';
 		Memoize::unmemoize 'check_cherry_pick2';
 		Memoize::unmemoize 'has_no_changes';
-		Memoize::unmemoize '_rev_list';
 	}
 
 	sub clear_memoized_mergeinfo_caches {
-- 
EW
