From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: ignore CVSPS_NO_BRANCH and impossible branches
Date: Sun, 11 Jun 2006 20:12:09 +1200
Message-ID: <11500135293734-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Jun 11 10:12:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpL3Z-00008V-6u
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 10:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWFKIMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 04:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWFKIMN
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 04:12:13 -0400
Received: from 203-79-116-174.cable.paradise.net.nz ([203.79.116.174]:17113
	"EHLO 203-79-116-174.cable.paradise.net.nz") by vger.kernel.org
	with ESMTP id S1750778AbWFKIMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 04:12:13 -0400
Received: by 203-79-116-174.cable.paradise.net.nz (Postfix, from userid 501)
	id B64E4466FE5; Sun, 11 Jun 2006 20:12:10 +1200 (NZST)
To: junkio@cox.net, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0.gcda2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21641>

cvsps output often contains references to CVSPS_NO_BRANCH, commits that it
could not trace to a branch. Ignore that branch.

Additionally, cvsps will sometimes draw circular relationships between
branches -- where two branches are recorded as opening from the other.
In those cases, and where the ancestor branch hasn't been seen, ignore
it.
Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
 git-cvsimport.perl |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 76f6246..07b3203 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -595,7 +595,11 @@ sub write_tree () {
 }
 
 my($patchset,$date,$author_name,$author_email,$branch,$ancestor,$tag,$logmsg);
-my(@old,@new,@skipped);
+my(@old,@new,@skipped,%ignorebranch);
+
+# commits that cvsps cannot place anywhere...
+$ignorebranch{'#CVSPS_NO_BRANCH'} = 1; 
+
 sub commit {
 	update_index(@old, @new);
 	@old = @new = ();
@@ -751,7 +755,16 @@ while(<CVS>) {
 			$state = 11;
 			next;
 		}
+		if (exists $ignorebranch{$branch}) {
+			print STDERR "Skipping $branch\n";
+			$state = 11;
+			next;
+		}
 		if($ancestor) {
+			if($ancestor eq $branch) {
+				print STDERR "Branch $branch erroneously stems from itself -- changed ancestor to $opt_o\n";
+				$ancestor = $opt_o;
+			}
 			if(-f "$git_dir/refs/heads/$branch") {
 				print STDERR "Branch $branch already exists!\n";
 				$state=11;
@@ -759,6 +772,7 @@ while(<CVS>) {
 			}
 			unless(open(H,"$git_dir/refs/heads/$ancestor")) {
 				print STDERR "Branch $ancestor does not exist!\n";
+				$ignorebranch{$branch} = 1;
 				$state=11;
 				next;
 			}
@@ -766,6 +780,7 @@ while(<CVS>) {
 			close(H);
 			unless(open(H,"> $git_dir/refs/heads/$branch")) {
 				print STDERR "Could not create branch $branch: $!\n";
+				$ignorebranch{$branch} = 1;
 				$state=11;
 				next;
 			}
-- 
1.4.0.gcda2
