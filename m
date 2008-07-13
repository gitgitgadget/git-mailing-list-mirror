From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] bash completion: Fix the . -> .. revision range completion
Date: Sun, 13 Jul 2008 13:19:58 +0200
Message-ID: <20080713111847.29801.8969.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 13:30:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHzmM-0003Fg-SZ
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 13:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbYGML3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 07:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbYGML3L
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 07:29:11 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:53788 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752074AbYGML3K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 07:29:10 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Jul 2008 07:29:09 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id A8BDC2ACC9B;
	Sun, 13 Jul 2008 13:19:58 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88298>

When Git sees a string with trailing dot on a place where revision
range could occur, it will unconditionally append another dot to
it to help complete a revision range. However, filespec can usually
occur at such a place as well. I have been hitting this all the time
lately with

	git log git-submodule.<tab>

and the like.

This patch will make Git perform the . -> .. completion in
__git_complete_revlist only if there is no filename starting with
the entered prefix available.  At few places, filename could not occur
when calling __git_complete_revlist; however, taking this into account
did not seem worth complicating the code further.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 contrib/completion/git-completion.bash |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 61581fe..fe24b8c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -325,7 +325,12 @@ __git_complete_revlist ()
 		__gitcomp "$(__git_refs)" "$pfx" "$cur"
 		;;
 	*.)
-		__gitcomp "$cur."
+		if ls "$cur"* >/dev/null 2>&1; then
+			# This is a file, not revision range
+			__gitcomp "$(__git_refs)"
+		else
+			__gitcomp "$cur."
+		fi
 		;;
 	*)
 		__gitcomp "$(__git_refs)"
