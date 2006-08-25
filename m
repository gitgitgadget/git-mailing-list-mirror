From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: establish new connections on commit after fork
Date: Fri, 25 Aug 2006 12:28:18 -0700
Message-ID: <20060825192818.GB8957@localdomain>
References: <m2u040n5e2.fsf@ziti.local> <20060825191516.GA8957@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 21:28:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGhLs-0004Fg-Bt
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 21:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422782AbWHYT2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 15:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWHYT2U
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 15:28:20 -0400
Received: from hand.yhbt.net ([66.150.188.102]:2452 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1422782AbWHYT2U (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 15:28:20 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 44A057DC02E;
	Fri, 25 Aug 2006 12:28:18 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 25 Aug 2006 12:28:18 -0700
To: Seth Falcon <sethfalcon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060825191516.GA8957@localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26009>

SVN seems to have a problem with https:// repositories from
time-to-time when doing multiple, sequential commits.  This
problem is not consistently reproducible without the patch,
but it should go away entirely with this patch...

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 git-svn.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0d58bb9..b311c3d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -500,6 +500,8 @@ sub commit_lib {
 	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
 	my $commit_msg = "$GIT_SVN_DIR/.svn-commit.tmp.$$";
 
+	my $repo;
+	($repo, $SVN_PATH) = repo_path_split($SVN_URL);
 	set_svn_commit_env();
 	foreach my $c (@revs) {
 		my $log_msg = get_commit_message($c, $commit_msg);
@@ -508,6 +510,8 @@ sub commit_lib {
 		# can't track down... (it's probably in the SVN code)
 		defined(my $pid = open my $fh, '-|') or croak $!;
 		if (!$pid) {
+			$SVN_LOG = libsvn_connect($repo);
+			$SVN = libsvn_connect($repo);
 			my $ed = SVN::Git::Editor->new(
 					{	r => $r_last,
 						ra => $SVN,
-- 
1.4.2.g7c9b
