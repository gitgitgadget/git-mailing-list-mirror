From: Christian Biesinger <cbiesinger@web.de>
Subject: [PATCH] Ignore commits for which cvsps can't identify a branch
Date: Fri, 10 Feb 2006 22:02:33 +0100
Message-ID: <200602102102.k1AL2Xkd010415@biesi.no-ip.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:02:46 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7fPh-0001xc-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 22:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWBJVCm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 16:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWBJVCl
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 16:02:41 -0500
Received: from 85-124-17-142.dynamic.xdsl-line.inode.at ([85.124.17.142]:31157
	"EHLO biesi.no-ip.org") by vger.kernel.org with ESMTP
	id S932193AbWBJVCk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 16:02:40 -0500
Received: from biesi.no-ip.org (localhost.localdomain [127.0.0.1])
	by biesi.no-ip.org (8.13.4/8.13.4) with ESMTP id k1AL2XcY010416
	for <git@vger.kernel.org>; Fri, 10 Feb 2006 22:02:34 +0100
Received: (from chb@localhost)
	by biesi.no-ip.org (8.13.4/8.13.4/Submit) id k1AL2Xkd010415
	for git@vger.kernel.org; Fri, 10 Feb 2006 22:02:33 +0100
X-Authentication-Warning: biesi.no-ip.org: chb set sender to cbiesinger@web.de using -f
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15882>

cvps sometimes can't identify a branch for a specific revision, it shows
messages like:
  WARNING: revision 1.36.2.2 of file Makefile.in on unnamed branch
and uses #CVSPS_NO_BRANCH as branch name in its output.

This checkin makes it so that git-cvsimport ignores such branches, and when they
appear as ancestor branch, it maps them to HEAD.

Signed-off-by: Christian Biesinger <cbiesinger@web.de>

---

I tried to import the Mozilla CVS Repository into git, just for fun, and it
failed. This is one of the patches that are required for it.

I hope I did this right, I'm not so familiar with git...
Documentation/SubmittingPatches says to mail patches to the maintainer, who is
that? :)

 git-cvsimport.perl |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

ed142593c84ba76580e780ce8f12244214023213
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 00fc3ba..4b8ca95 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -799,7 +799,18 @@ while(<CVS>) {
 			$state = 11;
 			next;
 		}
+                if ($branch eq "#CVSPS_NO_BRANCH") {
+			# skip
+			print "skip patchset $patchset: unknown branch\n" if $opt_v;
+			$state = 11;
+			next;
+		}
 		if($ancestor) {
+			if ($ancestor eq "#CVSPS_NO_BRANCH") {
+				# skip
+				print "In patchset $patchset: ancestor branch unknown, setting to $opt_o" if $opt_v;
+				$ancestor = $opt_o;
+			}
 			if(-f "$git_dir/refs/heads/$branch") {
 				print STDERR "Branch $branch already exists!\n";
 				$state=11;
-- 
1.1.6
