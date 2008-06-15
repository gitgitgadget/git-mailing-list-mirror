From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/4] Prepare testsuite for a "git clone" that packs refs
Date: Sun, 15 Jun 2008 16:05:47 +0200
Message-ID: <200806151605.47214.johan@herland.net>
References: <200806151602.03445.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 15 16:07:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7sss-0000xP-Cz
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 16:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758296AbYFOOF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 10:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757563AbYFOOF7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 10:05:59 -0400
Received: from smtp.getmail.no ([84.208.20.33]:38060 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758238AbYFOOF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 10:05:58 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2I00M2MCHXFS00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 16:05:57 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00HTFCHN3920@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 16:05:47 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I009JUCHNTS30@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 16:05:47 +0200 (CEST)
In-reply-to: <200806151602.03445.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85096>

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
index 3def75e..b3e1b97 100755
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
1.5.6.rc2.128.gf64ae
