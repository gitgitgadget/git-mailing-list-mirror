From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] Fix unconditional early exit in cg-fetch v2
Date: Tue, 20 Dec 2005 16:24:58 +0100
Message-ID: <20051220152458.1302.84228.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 20 19:35:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EomHv-0004Ba-73
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 19:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVLTScg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 13:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbVLTScg
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 13:32:36 -0500
Received: from host234-100.pool8255.interbusiness.it ([82.55.100.234]:62393
	"EHLO zion.home.lan") by vger.kernel.org with ESMTP
	id S1750886AbVLTScf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 13:32:35 -0500
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 6134C22170;
	Tue, 20 Dec 2005 16:24:59 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13850>


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When invoking cg-fetch, after fetching tags it exits here, for an overlooked
error handling. Replace the exit with an early return.

This means, for instance, we exit without reporting the tag updates and without
removing the "fetch in progress" marker - leading to unconditional "Recovering
from interrupted fetch" at the very beginning with rsync transport. Indeed, this
is fixed by this patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 cg-fetch |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/cg-fetch b/cg-fetch
index a2865ae..074aa14 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -189,9 +189,10 @@ fetch_tags()
 	[ -d "$_git/refs/tags" ] || mkdir -p "$_git/refs/tags"
 
 	if [ "$get" = "get_rsync" ]; then
-		$get -i -s -u -d "$uri/refs/tags" "$_git/refs/tags" ||
+		if ! $get -i -s -u -d "$uri/refs/tags" "$_git/refs/tags"; then
 			echo "unable to get tags list (non-fatal)" >&2
-		exit $?
+			return $?
+		fi
 	fi
 
 	git-ls-remote --tags "$uri" |
