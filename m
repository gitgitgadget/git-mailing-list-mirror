From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] Fix unconditional early exit in cg-fetch
Date: Mon, 19 Dec 2005 17:17:36 +0100
Message-ID: <20051219161736.18245.98591.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 17:23:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoNj8-00080a-W9
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 17:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVLSQTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 11:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVLSQTE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 11:19:04 -0500
Received: from host182-39.pool8259.interbusiness.it ([82.59.39.182]:50380 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S964804AbVLSQTC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 11:19:02 -0500
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 83000525D;
	Mon, 19 Dec 2005 17:17:38 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13826>


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When invoking cg-fetch, after fetching tags it exits here, probably for an
overlooked error handling (at least I corrected it this way).

This means, for instance, we exit without reporting the tag updates and without
removing the "fetch in progress" marker - leading to unconditional "Recovering
from interrupted fetch" at the very beginning with rsync transport. Indeed, this
is fixed by this patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 cg-fetch |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cg-fetch b/cg-fetch
index a2865ae..a489834 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -190,8 +190,8 @@ fetch_tags()
 
 	if [ "$get" = "get_rsync" ]; then
 		$get -i -s -u -d "$uri/refs/tags" "$_git/refs/tags" ||
-			echo "unable to get tags list (non-fatal)" >&2
-		exit $?
+			(echo "unable to get tags list (non-fatal)" >&2;
+			exit $?)
 	fi
 
 	git-ls-remote --tags "$uri" |
