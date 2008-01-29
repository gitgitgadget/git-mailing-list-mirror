From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: improve repository URL matching when following parents
Date: Tue, 29 Jan 2008 01:18:58 -0800
Message-ID: <20080129091858.GA4569@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 10:19:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJmcx-0000uo-8M
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 10:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbYA2JTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 04:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbYA2JTC
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 04:19:02 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60257 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344AbYA2JTA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 04:19:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 460922DC08B;
	Tue, 29 Jan 2008 01:18:59 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71973>

Warning!  This patch isn't heavily-tested against remote
servers, it only helped me limp by on a server I was having
trouble with tonight.  I was barely awake when working on this
and have been living in a different timezone for more than a
week, so don't trust it too much unless you're already having
difficulty with some servers.

This way we can avoid the spawning of a new SVN::Ra session by
reusing the existing one.

The most problematic issue is that some svn servers disallow
too many connections from a single IP, so this will allow
git-svn to fetch from those repositories with a higher success
rate by using fewer connections.

This sometimes showed up as a new (and redundant)
[svn-remote "$parent_refname"] entry in $GIT_DIR/svn/.metadata.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Note: there are still cases where git-svn can open more than
 one connection to the SVN server, which can make some SVN
 setups/administrators unhappy.  Unfortunately, I'm pretty sure
 I won't have time to properly fix all of these in the next few
 days.

 For now, if you get "connection closed unexpectedly" messages
 while fetching (and following parents), just restart git-svn
 and it'll pick up where it left off.

 git-svn.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 75e97cc..7ba8c8f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2226,7 +2226,12 @@ sub find_parent_branch {
 		# just grow a tail if we're not unique enough :x
 		$ref_id .= '-' while find_ref($ref_id);
 		print STDERR "Initializing parent: $ref_id\n";
-		$gs = Git::SVN->init($new_url, '', $ref_id, $ref_id, 1);
+		my ($u, $p) = ($new_url, '');
+		if ($u =~ s#^\Q$url\E(/|$)##) {
+			$p = $u;
+			$u = $url;
+		}
+		$gs = Git::SVN->init($u, $p, $self->{repo_id}, $ref_id, 1);
 	}
 	my ($r0, $parent) = $gs->find_rev_before($r, 1);
 	if (!defined $r0 || !defined $parent) {
-- 
Eric Wong
