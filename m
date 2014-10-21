From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: clear global SVN pool between get_log invocations
Date: Tue, 21 Oct 2014 03:39:12 +0000
Message-ID: <20141021033912.GA27462@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 05:39:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgQI2-0007UC-DV
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 05:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbaJUDjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 23:39:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45506 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbaJUDjN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 23:39:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F091F8B5;
	Tue, 21 Oct 2014 03:39:12 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During long fetches with many revisions, some SVN functions are not
always using local pools and some gets into the global pool.  Ensure
we free that memory occasionally between SVN::RA::get_log calls to
reduce memory growth.

This reduces memory usage over the course of fetching 10K revisions
using a test repository created with the script at the end of this
commit message.

As reported by time(1) on my x86-64 system:

	before: 54024k
	 after: 47344k

-----------------------------8<------------------------------
set -e
tmp=$(mktemp -d svntestrepo-XXXXXXXX)
svnadmin create "$tmp"
repo=file://"$(cd $tmp && pwd)"
svn co "$repo" "$tmp/wd"
cd "$tmp/wd"
if ! test -f a
then
	> a
	svn add a
	svn commit -m 'A'
fi

nr=10000
while test $nr -gt 0
do
	echo $nr > a
	svn commit -q -m A
	nr=$((nr - 1))
done
echo "repository created in $repo"
-----------------------------8<------------------------------

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Pushed to master of git://bogomips.org/git-svn

 However, memory usage still seems to grow infinitely even in this simple
 fetch case, so are other memory leaks.

 perl/Git/SVN/Ra.pm | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index a7b0119..3df4591 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -237,10 +237,6 @@ sub trees_match {
 	my $ctx = SVN::Client->new(auth => _auth_providers);
 	my $out = IO::File->new_tmpfile;
 
-	# older SVN (1.1.x) doesn't take $pool as the last parameter for
-	# $ctx->diff(), so we'll create a default one
-	my $pool = SVN::Pool->new_default_sub;
-
 	$ra_invalid = 1; # this will open a new SVN::Ra connection to $url1
 	$ctx->diff([], $url1, $rev1, $url2, $rev2, 1, 1, 0, $out, $out);
 	$out->flush;
@@ -453,6 +449,7 @@ sub gs_fetch_loop_common {
 				$_[0] = undef;
 				$self = undef;
 				$RA = undef;
+				SVN::Core->gpool->clear;
 				$self = Git::SVN::Ra->new($ra_url);
 				$ra_invalid = undef;
 			}
@@ -468,6 +465,7 @@ sub gs_fetch_loop_common {
 			my $k = "svn-remote.$g->{remote}.$g->{t}-maxRev";
 			Git::SVN::tmp_config($k, $max);
 		}
+		SVN::Core->gpool->clear;
 		last if $max >= $head;
 		$min = $max + 1;
 		$max += $inc;
-- 
EW


-- 
EW
