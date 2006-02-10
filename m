From: Christian Biesinger <cbiesinger@web.de>
Subject: [PATCH] Handle the case where cvsps claims a branch is an ancestor of itself
Date: Fri, 10 Feb 2006 22:02:37 +0100
Message-ID: <200602102102.k1AL2bG0010419@biesi.no-ip.org>
X-From: git-owner@vger.kernel.org Sat Feb 11 00:20:50 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7fPp-0001y9-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 22:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWBJVCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 16:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWBJVCp
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 16:02:45 -0500
Received: from 85-124-17-142.dynamic.xdsl-line.inode.at ([85.124.17.142]:31669
	"EHLO biesi.no-ip.org") by vger.kernel.org with ESMTP
	id S932189AbWBJVCo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 16:02:44 -0500
Received: from biesi.no-ip.org (localhost.localdomain [127.0.0.1])
	by biesi.no-ip.org (8.13.4/8.13.4) with ESMTP id k1AL2bET010420
	for <git@vger.kernel.org>; Fri, 10 Feb 2006 22:02:37 +0100
Received: (from chb@localhost)
	by biesi.no-ip.org (8.13.4/8.13.4/Submit) id k1AL2bG0010419
	for git@vger.kernel.org; Fri, 10 Feb 2006 22:02:37 +0100
X-Authentication-Warning: biesi.no-ip.org: chb set sender to cbiesinger@web.de using -f
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15897>

cvsps sometimes claims that a branch is an ancestor of itself. That confuses
cvsimport. This checkin makes it change the ancestor to HEAD instead.

Signed-off-by: Christian Biesinger <cbiesinger@web.de>

---

On the mozilla.org CVS repository, cvsps managed to output a branch as an
ancestor of itself... This patch allows cvsimport to handle that, although
I'm not sure if this is a good idea (a better fix might be to make cvsps not
do that. I haven't debugged yet why it does this)

 git-cvsimport.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

71f7fdb5fd6eccf75ca3c9e070391f94f013dd7e
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 4b8ca95..74d6e10 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -811,6 +811,10 @@ while(<CVS>) {
 				print "In patchset $patchset: ancestor branch unknown, setting to $opt_o" if $opt_v;
 				$ancestor = $opt_o;
 			}
+			if ($ancestor eq $branch) {
+				print "CVSPS INCONSISTENCY: Branch is an ancestor of itself. Setting ancestor to $opt_o\n";
+				$ancestor = $opt_o;
+			}
 			if(-f "$git_dir/refs/heads/$branch") {
 				print STDERR "Branch $branch already exists!\n";
 				$state=11;
-- 
1.1.6
