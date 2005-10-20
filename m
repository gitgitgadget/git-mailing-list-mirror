From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cg-fetch: handle tags with funny chars, retrieve missing commits
Date: Thu, 20 Oct 2005 18:07:46 +1300
Message-ID: <1129784866457-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Oct 20 07:05:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESSbu-0008HG-1c
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 07:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbVJTFE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 01:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbVJTFE5
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 01:04:57 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:55689 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751748AbVJTFE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 01:04:57 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1ESSbn-0007uy-HJ; Thu, 20 Oct 2005 18:04:55 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1ESSeY-0008VM-00; Thu, 20 Oct 2005 18:07:46 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10348>

 + handles tags with funny chars a bit better
 + will check tagrefs, trying to ensure it actually has the relevant
   commits. If the commits are missing, it'll go out and fetch them.
 + if the tagref points to a blob and we have it, it'll skip it

This isn't a complete solution for cg-fetch -- git-fetch is actually
much smarter now, and cg-fetch should perhaps be a thin wrapper
around it, dropping all the duplicate code.

This version uses ^0 instead of ^{commit} which does a more thorough check,
so we don't need to call git-cat-file.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 cg-fetch |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

applies-to: 38ed7981343a8e2bb734d64e019186a8a482dbef
6adda5a9a938adbc313c6ed40156257d62707757
diff --git a/cg-fetch b/cg-fetch
index 7694584..ec9fff3 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -416,8 +416,9 @@ $get -i -s -u -d "$uri/refs/tags" "$_git
 	cd $_git/refs/tags
 	for tag in *; do
 		[ "$tag" = "*" ] && break
-		tagid=$(cat $tag)
-		GIT_DIR=../.. git-cat-file -t "$tagid" >/dev/null 2>&1 && continue
+		tagid=$(cat "$tag")
+		GIT_DIR=../.. git-rev-parse --verify "$tag"^0 2>/dev/null >> /dev/null && continue
+		GIT_DIR=../.. git-cat-file blob `git-rev-parse --verify "$tag"^{blob} 2>/dev/null` 2>/dev/null >> /dev/null && continue
 		echo -n "Missing object of tag $tag... "
 		if [ "$fetch" != "fetch_rsync" ] && GIT_DIR=../.. $fetch "$tagid" "$uri" 2>/dev/null >&2; then
 			echo "retrieved"
---
0.99.8.GIT
