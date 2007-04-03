From: Junio C Hamano <junkio@cox.net>
Subject: git-cvsimport does not like detached HEAD
Date: Tue, 03 Apr 2007 01:23:37 -0700
Message-ID: <7vmz1pzx12.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Apr 03 10:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYeJ4-00023m-5v
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 10:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933092AbXDCIXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 04:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933115AbXDCIXj
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 04:23:39 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:59224 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933092AbXDCIXi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 04:23:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403082338.LVOD24385.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 3 Apr 2007 04:23:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id iYPd1W00g1kojtg0000000; Tue, 03 Apr 2007 04:23:38 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43619>

In my day-job project, I use git-cvsimport with -i option to
treat the central CVS repository as if it is just a branch in a
remote git repository.  Since I hoard many changes in my git
repository and trickle only a few changes at a time to the
central CVS back, I keep shuffling and rebasing my commits on
top of what I obtain from CVS, and many times, my HEAD is
detached and not on a particular branch.

However, it seems git-cvsimport does not like to work when your
HEAD is detached.

Here is a minimum patch that seems to let me going, but I am not
quite sure what the implication is for letting orig_branch (and
last_branch) to default to "master" (I do not use "master"
branch for that project so maybe I am getting lucky).

---
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 1a1ba7b..a64219f 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -563,8 +563,11 @@ unless (-d $git_dir) {
 
 	open(F, "git-symbolic-ref HEAD |") or
 		die "Cannot run git-symbolic-ref: $!\n";
-	chomp ($last_branch = <F>);
-	$last_branch = basename($last_branch);
+	$last_branch = <F>;
+	if (defined $last_branch) {
+		chomp($last_branch);
+		$last_branch = basename($last_branch);
+	}
 	close(F);
 	unless ($last_branch) {
 		warn "Cannot read the last branch name: $! -- assuming 'master'\n";
