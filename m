From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-reset <tree> -- <path> restores absense of <path> in <tree>
Date: Fri, 05 Jan 2007 01:46:02 -0800
Message-ID: <7vmz4xiz6t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Juergen Ruehle <j.ruehle@bmiag.de>
X-From: git-owner@vger.kernel.org Fri Jan 05 10:46:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2leM-0005Jl-Cj
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 10:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbXAEJqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 04:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbXAEJqH
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 04:46:07 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36138 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965142AbXAEJqF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 04:46:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105094603.TCNS7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Fri, 5 Jan 2007 04:46:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7MmH1W00W1kojtg0000000; Fri, 05 Jan 2007 04:46:18 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35987>

When <path> exists in the index (either merged or unmerged), and
<tree> does not have it, git-reset should be usable to restore
the absense of it from the tree.  This implements it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 
 * By the way, I noticed that "git log --diff-filter=A --
   t/t5401-update-hooks.sh" does not find the commit that
   introduced the path.  v1.4.1.1 seems to work but v1.4.2.4
   does not.  I haven't bisected it yet...

 git-reset.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-reset.sh b/git-reset.sh
index a969370..76c8a81 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -44,8 +44,10 @@ if test $# != 0
 then
 	test "$reset_type" == "--mixed" ||
 		die "Cannot do partial $reset_type reset."
-	git ls-tree -r --full-name $rev -- "$@" |
-	git update-index --add --index-info || exit
+
+	git-diff-index --cached $rev -- "$@" |
+	sed -e 's/^:\([0-7][0-7]*\) [0-7][0-7]* \([0-9a-f][0-9a-f]*\) [0-9a-f][0-9a-f]* [A-Z]	\(.*\)$/\1 \2	\3/' |
+	git update-index --add --remove --index-info || exit
 	git update-index --refresh
 	exit
 fi
-- 
1.5.0.rc0.ge0f6
