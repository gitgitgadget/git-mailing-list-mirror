From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH v2 2/3] stash: Don't overwrite files that have gone from the
 index
Date: Sun, 18 Apr 2010 19:28:05 +0100
Message-ID: <20100418182805.GB29329@hashpling.org>
References: <9eaa7a4672f2010c9e6e3b3f473f1c09abcfcc45.1271614677.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:28:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ZE6-0006w4-QZ
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556Ab0DRS2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:28:10 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:37471 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753063Ab0DRS2H (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Apr 2010 14:28:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEANPryktUXebz/2dsb2JhbACbeXG4a4UQBA
Received: from relay02.plus.net ([84.93.230.243])
  by relay.pcl-ipout02.plus.net with ESMTP; 18 Apr 2010 19:28:06 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by relay02.plus.net with esmtp (Exim) id 1O3ZDy-0004rV-4L; Sun, 18 Apr 2010 19:28:06 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.69)
	(envelope-from <charles@hashpling.org>)
	id 1O3ZDx-0007lP-Un; Sun, 18 Apr 2010 19:28:05 +0100
Content-Disposition: inline
In-Reply-To: <9eaa7a4672f2010c9e6e3b3f473f1c09abcfcc45.1271614677.git.charles@hashpling.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Plusnet-Relay: 834811fbf329ca4d2e8f15f3c01b7497
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145228>

The use of git add -u in create_stash isn't always complete. In
particular, if a file has been removed from the index but changed in the
work tree it will not be added to the stash's saved work tree tree
object. When stash then resets the work tree to match HEAD, any changes
will be lost.

To be complete, any work tree file which differs from HEAD needs to be
saved, regardless of whether it still appears in the index or not.

This is achieved with a combination of a diff against HEAD and a call to
update-index with an explicit list of paths that have changed.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

Since the last version of this patch I've followed Jeff King's advice
and used update-index. This should be much more portable and reliable.

I believe the fix is now complete as it is, although as I noted we
still have an issue when stashing file <-> directory changes.

 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 908aab2..1d95447 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -86,7 +86,7 @@ create_stash () {
 			GIT_INDEX_FILE="$TMP-index" &&
 			export GIT_INDEX_FILE &&
 			git read-tree -m $i_tree &&
-			git add -u &&
+			git diff --name-only -z HEAD | git update-index -z --add --remove --stdin &&
 			git write-tree &&
 			rm -f "$TMP-index"
 		) ) ||
-- 
1.7.1.rc1.241.g4e72f
