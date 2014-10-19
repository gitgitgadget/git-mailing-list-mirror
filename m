From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn's performance issue and strange pauses, and other thing
Date: Sun, 19 Oct 2014 04:12:38 +0000
Message-ID: <20141019041238.GA8944@dcvr.yhbt.net>
References: <1412706046.90413.YahooMailBasic@web172303.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, stoklund@2pi.dk, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Oct 19 06:12:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfhrP-000328-4E
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 06:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbaJSEMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 00:12:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52258 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbaJSEMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 00:12:43 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A7B21F8B3;
	Sun, 19 Oct 2014 04:12:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1412706046.90413.YahooMailBasic@web172303.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> The new clone has:
> 
> <--
> $ ls -ltr .git/svn/.caches/
> total 144788
> -rw-rw-r--. 1 Hin-Tak Hin-Tak  1166138 Oct  7 13:44 lookup_svn_merge.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak 72849741 Oct  7 13:48 check_cherry_pick.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak  1133855 Oct  7 13:49 has_no_changes.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak 73109005 Oct  7 13:53 _rev_list.yaml
> -->
> 
> The old clone has:

<snip>
> -rw-rw-r--. 1 Hin-Tak Hin-Tak  40241189 Oct  5 16:42 lookup_svn_merge.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak 225323456 Oct  5 16:49 check_cherry_pick.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak    242547 Oct  5 16:49 has_no_changes.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak  24120007 Oct  5 16:50 _rev_list.yaml
> -->
> 
> I had to suspend somewhat around r59000 - but it is interesting to see
> that the max memory consumption of the later part is almost double?
> and it also runs at 100% rather than 60% overall; I don't know what
> to make of that - probably just smaller changes versus
> larger ones, or different time of day and network loads (yes,
> I guess it is just bandwidth-limited?, since the bulk of CPU time is in system
> rather than user).

git-svn memory usage is insane, and we need to reduce it.
(on Linux, fork() performance is reduced as memory size of the parent
 grows, and I don't think we can easily call vfork() from Perl)

> I am somwhat worry about the dramatic difference between the two .svn/.caches -
> check_cherry_pick.yaml is 225MB in one and 73MB in the other, and also
> _rev_list.yaml is opposite - 24MB vs 73MB. How do I reconcile that?

Calling patterns changed, and it looks like Jakob's changes avoided some
calls.  The main thing to care about:
	Does the repository history look right?

The check_cherry_pick cache can be made smaller, too:
----------------------- 8< -----------------------------
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: reduce check_cherry_pick cache overhead

We do not need to store entire lists of commits, only the
number of incomplete and the first commit for reference.
This reduces the amount of data we need to store in memory
and on disk stores.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN.pm | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 25dbcd5..b2d37cb 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1537,7 +1537,7 @@ sub _rev_list {
 	@rv;
 }
 
-sub check_cherry_pick {
+sub check_cherry_pick2 {
 	my $base = shift;
 	my $tip = shift;
 	my $parents = shift;
@@ -1552,7 +1552,8 @@ sub check_cherry_pick {
 			delete $commits{$commit};
 		}
 	}
-	return (keys %commits);
+	my @k = (keys %commits);
+	return (scalar @k, $k[0]);
 }
 
 sub has_no_changes {
@@ -1597,7 +1598,7 @@ sub tie_for_persistent_memoization {
 		mkpath([$cache_path]) unless -d $cache_path;
 
 		my %lookup_svn_merge_cache;
-		my %check_cherry_pick_cache;
+		my %check_cherry_pick2_cache;
 		my %has_no_changes_cache;
 		my %_rev_list_cache;
 
@@ -1608,11 +1609,11 @@ sub tie_for_persistent_memoization {
 			LIST_CACHE => ['HASH' => \%lookup_svn_merge_cache],
 		;
 
-		tie_for_persistent_memoization(\%check_cherry_pick_cache,
-		    "$cache_path/check_cherry_pick");
-		memoize 'check_cherry_pick',
+		tie_for_persistent_memoization(\%check_cherry_pick2_cache,
+		    "$cache_path/check_cherry_pick2");
+		memoize 'check_cherry_pick2',
 			SCALAR_CACHE => 'FAULT',
-			LIST_CACHE => ['HASH' => \%check_cherry_pick_cache],
+			LIST_CACHE => ['HASH' => \%check_cherry_pick2_cache],
 		;
 
 		tie_for_persistent_memoization(\%has_no_changes_cache,
@@ -1636,7 +1637,7 @@ sub tie_for_persistent_memoization {
 		$memoized = 0;
 
 		Memoize::unmemoize 'lookup_svn_merge';
-		Memoize::unmemoize 'check_cherry_pick';
+		Memoize::unmemoize 'check_cherry_pick2';
 		Memoize::unmemoize 'has_no_changes';
 		Memoize::unmemoize '_rev_list';
 	}
@@ -1648,7 +1649,8 @@ sub tie_for_persistent_memoization {
 		return unless -d $cache_path;
 
 		for my $cache_file (("$cache_path/lookup_svn_merge",
-				     "$cache_path/check_cherry_pick",
+				     "$cache_path/check_cherry_pick", # old
+				     "$cache_path/check_cherry_pick2",
 				     "$cache_path/has_no_changes")) {
 			for my $suffix (qw(yaml db)) {
 				my $file = "$cache_file.$suffix";
@@ -1817,15 +1819,15 @@ sub find_extra_svn_parents {
 		}
 
 		# double check that there are no missing non-merge commits
-		my (@incomplete) = check_cherry_pick(
+		my ($ninc, $ifirst) = check_cherry_pick2(
 			$merge_base, $merge_tip,
 			$parents,
 			@all_ranges,
 		       );
 
-		if ( @incomplete ) {
-			warn "W:svn cherry-pick ignored ($spec) - missing "
-				.@incomplete." commit(s) (eg $incomplete[0])\n";
+		if ($ninc) {
+			warn "W:svn cherry-pick ignored ($spec) - missing " .
+				"$ninc commit(s) (eg $ifirst)\n";
 		} else {
 			warn
 				"Found merge parent ($spec): ",
-- 
EW
