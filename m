From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/4] Prepare testsuite for a "git clone" that packs refs
Date: Mon, 14 Apr 2008 10:03:39 +0200
Message-ID: <200804141003.39170.johan@herland.net>
References: <200803220210.30957.johan@herland.net>
 <alpine.LNX.1.00.0804140205040.19665@iabervon.org>
 <200804141000.09515.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 10:04:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlJgA-0007Zp-3b
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 10:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbYDNIDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 04:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756695AbYDNIDy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 04:03:54 -0400
Received: from smtp.getmail.no ([84.208.20.33]:43915 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756467AbYDNIDx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 04:03:53 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZB00K172E9TB00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:03:45 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZB007QB2E3Z490@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:03:39 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZB00KVF2E3KY90@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:03:39 +0200 (CEST)
In-reply-to: <200804141000.09515.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79485>

t5515-fetch-merge-logic removes many, but not all, refs between each test.
This is done by removing the corresponding refs/foo/* files in the .git/refs
hierarchy. However, once "git clone" starts producing packed refs, these refs
will no longer be in the .git/refs hierarchy, but rather listed in
.git/packed-refs. This patch therefore teaches t5515-fetch-merge-logic to also
remove the refs in question from the packed-refs file.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t5515-fetch-merge-logic.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 65c3774..8a8c35c 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -145,6 +145,25 @@ do
 			rm -f .git/refs/heads/*
 			rm -f .git/refs/remotes/rem/*
 			rm -f .git/refs/tags/*
+			cat .git/packed-refs | \
+			while read sha1 refname
+			do
+				case "$sha1" in
+				^*) # remove peeled tags
+					;;
+				*)
+					case "$refname" in
+					refs/heads/*|\
+					refs/remotes/rem/*|\
+					refs/tags/*) # remove same as above
+						;;
+					*) # keep everything else
+						echo "$sha1 $refname"
+						;;
+					esac
+				esac
+			done > .git/packed-refs.new
+			mv .git/packed-refs.new .git/packed-refs
 			git fetch "$@" >/dev/null
 			cat .git/FETCH_HEAD
 		} >"$actual_f" &&
-- 
1.5.5.159.g8c84b
