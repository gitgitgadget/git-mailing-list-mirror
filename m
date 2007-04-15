From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: respect lower bound of -r/--revision when following parent
Date: Sun, 15 Apr 2007 03:01:29 -0700
Message-ID: <11766312891942-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 12:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd1Y6-000344-P6
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 12:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbXDOKBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 06:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbXDOKBb
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 06:01:31 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53650 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbXDOKBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 06:01:30 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 4A2207DC0A1;
	Sun, 15 Apr 2007 03:01:29 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 15 Apr 2007 03:01:29 -0700
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44493>

When an explicit --revision argument is specified, do not fetch
past the specified range into the beginning of history.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ac44f60..7ebd07b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1682,7 +1682,10 @@ sub find_parent_branch {
 	}
 	my ($r0, $parent) = $gs->find_rev_before($r, 1);
 	if (!defined $r0 || !defined $parent) {
-		$gs->fetch(0, $r);
+		my ($base, $head) = parse_revision_argument(0, $r);
+		if ($base <= $r) {
+			$gs->fetch($base, $r);
+		}
 		($r0, $parent) = $gs->last_rev_commit;
 	}
 	if (defined $r0 && defined $parent) {
-- 
1.5.1.1.98.gedb4f
