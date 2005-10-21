From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cg-fetch: retrieve missing commits with a smarter optimization
Date: Fri, 21 Oct 2005 18:31:31 +1300
Message-ID: <11298726913836-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Oct 21 07:29:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESpSM-0000mL-Px
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 07:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVJUF2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 01:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVJUF2h
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 01:28:37 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:65473 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S964873AbVJUF2g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 01:28:36 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1ESpSF-0003da-03; Fri, 21 Oct 2005 18:28:35 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1ESpV5-0006Fg-00; Fri, 21 Oct 2005 18:31:31 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10421>

I've actually rebased this one so Petr doesn't have to deal
with the silly conflicts. It also turns out that my repo got
fsck'd in one of the last updates, and cg-merge was seriously
broken. I guess did an update in the middle of the transition 
between positional parameters and named parameters, and got stuck.

Actual commit message follows.
 
---

 + will check tagrefs, trying to ensure it actually has the relevant
   commits. If the commits are missing, it'll go out and fetch them.
 + if the tagref points to a blob and we have it, it'll skip it

This isn't a complete solution for cg-fetch -- git-fetch is actually
much smarter now, and cg-fetch should perhaps be a thin wrapper
around it, dropping all the duplicate code.

This version uses ^0 instead of ^{commit} which does a more thorough check,
so we don't need to call git-cat-file.

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
