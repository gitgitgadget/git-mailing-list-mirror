From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cg-fetch: handle tags with funny chars, retrieve missing commits
Date: Tue, 25 Oct 2005 09:49:23 +1300
Message-ID: <1130186963916-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Oct 24 22:47:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU9Cr-0001Om-Uq
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 22:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVJXUqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 16:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVJXUqG
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 16:46:06 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:22178 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751277AbVJXUqF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 16:46:05 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1EU9Cm-0001ix-Dx; Tue, 25 Oct 2005 09:46:04 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1EU9Fz-0002dW-00; Tue, 25 Oct 2005 09:49:23 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10559>

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

Resend: added signoff as requested.

---

 cg-fetch |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

applies-to: e6fab694ece986de77f6e17c16df9f17276c6666
e2cf1ab9b594d3d12655dd93377dfea03247379e
diff --git a/cg-fetch b/cg-fetch
index b004ab3..f0c11aa 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -377,7 +377,8 @@ $get -i -s -u -d "$uri/refs/tags" "$_git
 	for tag in *; do
 		[ "$tag" = "*" ] && break
 		tagid="$(cat "$tag")"
-		GIT_DIR=../.. git-cat-file -t "$tagid" >/dev/null 2>&1 && continue
+		GIT_DIR=../.. git-rev-parse --verify "$tag"^0 2>/dev/null >> /dev/null && continue
+		GIT_DIR=../.. git-cat-file blob `git-rev-parse --verify "$tag"^{blob} 2>/dev/null` 2>/dev/null >> /dev/null && continue
 		echo -n "Missing object of tag $tag... "
 		if [ "$fetch" != "fetch_rsync" ] && GIT_DIR=../.. $fetch "$tagid" "$uri" 2>/dev/null >&2; then
 			echo "retrieved"
---
0.99.8.GIT
