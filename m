From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH 2/2] Run garbage collection with loose object pruning after svn dcommit
Date: Thu, 4 Oct 2007 17:15:28 -0700
Message-ID: <20071005001528.GA13029@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 02:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idaqw-0004Gq-8K
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 02:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760263AbXJEAPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 20:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760197AbXJEAP3
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 20:15:29 -0400
Received: from tater.midwinter.com ([216.32.86.90]:58102 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759553AbXJEAP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 20:15:29 -0400
Received: (qmail 13210 invoked by uid 1001); 5 Oct 2007 00:15:28 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60022>

git-svn dcommit, by virtue of rewriting history to insert svn revision IDs,
leaves old commits dangling.  Since dcommit is already unsafe to run
concurrently with other git commands, no additional risk is introduced
by making it prune those old objects as needed.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

This is in response to a colleague who complained that, after I
installed the latest git release, he was getting lots of "too many
unreachable loose objects" errors from the new "git gc --auto" run.
Those objects turned out to be dangling commits from a year's worth of
git-svn usage, since every git-svn commit will abandon at least one
existing commit in order to rewrite it with the svn version data.

 git-svn.perl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 777e436..be62ee1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -441,6 +441,12 @@ sub cmd_dcommit {
 			}
 			command_noisy(@finish, $gs->refname);
 			$last_rev = $cmt_rev;
+
+			# rebase will have made the just-committed revisions
+			# unreachable; over time that can build up lots of
+			# loose objects in the repo. prune is unsafe to run
+			# concurrently but so is dcommit.
+			command_noisy(qw/gc --auto --prune/);
 		}
 	}
 }
-- 
1.5.3.4.203.gcc61a
