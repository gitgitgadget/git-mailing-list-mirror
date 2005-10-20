From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cg-fetch: handle tags with funny chars, retrieve missing commits
Date: Thu, 20 Oct 2005 17:45:24 +1300
Message-ID: <11297835242417-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Oct 20 06:45:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESSGQ-0008W0-6t
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 06:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbVJTEmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 00:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbVJTEmg
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 00:42:36 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:32392 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751738AbVJTEmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 00:42:35 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1ESSGA-0007Ko-3p; Thu, 20 Oct 2005 17:42:34 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1ESSIu-0007qa-00; Thu, 20 Oct 2005 17:45:24 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10345>

 + handles tags with funny chars a bit better
 + will check tagrefs, trying to ensure it actually has the relevant
   commits. If the commits are missing, it'll go out and fetch them.

This isn't a complete solution for cg-fetch -- git-fetch is actually
much smarter now, and cg-fetch should perhaps be a thin wrapper
around it, dropping all the duplicate code.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 cg-fetch |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

applies-to: 38ed7981343a8e2bb734d64e019186a8a482dbef
21a91d74a6807677f8e59c737fee3692d0f392e8
diff --git a/cg-fetch b/cg-fetch
index 7694584..625444c 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -416,8 +416,9 @@ $get -i -s -u -d "$uri/refs/tags" "$_git
 	cd $_git/refs/tags
 	for tag in *; do
 		[ "$tag" = "*" ] && break
-		tagid=$(cat $tag)
-		GIT_DIR=../.. git-cat-file -t "$tagid" >/dev/null 2>&1 && continue
+		tagid=$(cat "$tag")
+		GIT_DIR=../.. git-cat-file commit `git-rev-parse --verify "$tag"^{commit} 2>/dev/null` 2>/dev/null >> /dev/null && continue
+		GIT_DIR=../.. git-cat-file blob `git-rev-parse --verify "$tag"^{blob} 2>/dev/null` 2>/dev/null >> /dev/null && continue
 		echo -n "Missing object of tag $tag... "
 		if [ "$fetch" != "fetch_rsync" ] && GIT_DIR=../.. $fetch "$tagid" "$uri" 2>/dev/null >&2; then
 			echo "retrieved"
---
0.99.8.GIT
