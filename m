From: Christian Engwer <christian.engwer@wwu.de>
Subject: [PATCH] prohibit "svn dcommit" on remote-tracking-branches
Date: Wed, 4 Apr 2012 10:42:34 +0200
Message-ID: <20120404084234.GA17768@mathe-macht-spass.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 11:04:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFM8c-0000K7-OS
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 11:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab2DDJES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 05:04:18 -0400
Received: from marnach.net ([87.230.94.153]:49897 "EHLO
	lvps87-230-94-153.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756110Ab2DDJER (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 05:04:17 -0400
X-Greylist: delayed 1370 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Apr 2012 05:04:17 EDT
Received: from dslb-084-060-028-065.pools.arcor-ip.net ([84.60.28.65] helo=sansibar)
	by lvps87-230-94-153.dedicated.hosteurope.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <christi@mathe-macht-spass.de>)
	id 1SFLmP-0001kt-PR
	for git@vger.kernel.org; Wed, 04 Apr 2012 10:41:25 +0200
Received: from christi by sansibar with local (Exim 4.77)
	(envelope-from <christi@mathe-macht-spass.de>)
	id 1SFLnW-0004cu-HF
	for git@vger.kernel.org; Wed, 04 Apr 2012 10:42:34 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194689>

A branch should either be a local copy of an svn branch, or a remote
tracking branch. After a "git svn dcommit" a remote tracking branch
could not be synced with the git remote due to the rebase that occured
during the dcommit. Thus we check for a remote entry in the git config
for the current branch and prohibit the "dcommit" if such an entry
exists.
---
 git-svn.perl |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4334b95..f9c8440 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -759,6 +759,23 @@ sub cmd_dcommit {
 		'Cannot dcommit with a dirty index.  Commit your changes first, '
 		. "or stash them with `git stash'.\n";
 	$head ||= 'HEAD';
+    my ($branches,$ctx) = eval { command_output_pipe('branch') };
+    my $branch = undef;
+    while (<$branches>) {
+        chomp;
+        if (s/^\* +//)
+        {
+            $branch = $_;
+        }
+    }
+	command_close_pipe($branches, $ctx);
+
+    my $remote = eval { command_oneline('config', '--get',
+                                      "branch.${branch}.remote") };
+	if ($remote) {
+		die "You specified a non-svn remote for branch ${branch}.\n".
+            "To change this setting, modify \"branch.${branch}.remote\" using git config.\n";
+	}
 
 	my $old_head;
 	if ($head ne 'HEAD') {
-- 
1.7.9.1
