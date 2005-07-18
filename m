From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH] cg-commit chokes when given a very large list of files
Date: Sun, 17 Jul 2005 23:18:13 -0400
Message-ID: <20050718031808.20247.43698.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 05:19:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuM9U-0001Sw-6r
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 05:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVGRDSh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 23:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVGRDSh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 23:18:37 -0400
Received: from smtp110.mail.sc5.yahoo.com ([66.163.170.8]:43342 "HELO
	smtp110.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261508AbVGRDSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 23:18:13 -0400
Received: (qmail 12979 invoked from network); 18 Jul 2005 03:18:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=BQHtfabd7Ccoqx1nPDlEvgDHvUlY8gVBjSgaHJ8rWeiWW+/9XqKuQfiFSm/YLnqWK354QNR4PgtUpCXS97g4V54yU7w4MxroDszCdA0mKwf+WUcEOQ9x2368g7Qr/43LsqSad5A/6JObGE3RgWtwWoXbV5I/212TpOrIhoCMucA=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp110.mail.sc5.yahoo.com with SMTP; 18 Jul 2005 03:18:12 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

cg-commit currently chokes when passed a very large list of files.
Fix it.

This patch depends on your filenames not containing line feeds.  No
big deal, other parts of cogito break on filenames containing line
feeds.

Resent because previous send appears to have been dropped.  This patch
is cleaner.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-commit |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -289,9 +289,9 @@ precommit_update () {
 		eval "queue$op[\${#queue$op[@]}]=\"\$fname\""
 	done
 	# XXX: Do we even need to do the --add and --remove update-caches?
-	[ "$queueN" ] && { git-update-cache --add ${infoonly} -- "${queueN[@]}" || return 1; }
-	[ "$queueD" ] && { git-update-cache --force-remove -- "${queueD[@]}" || return 1; }
-	[ "$queueM" ] && { git-update-cache ${infoonly} -- "${queueM[@]}" || return 1; }
+	[ "$queueN" ] && { ( echo "${queueN[*]}" | tr \\n \\0 | IFS=$'\n' xargs -0 git-update-cache --add ${infoonly} -- ) || return 1; }
+	[ "$queueD" ] && { ( echo "${queueD[*]}" | tr \\n \\0 | IFS=$'\n' xargs -0 git-update-cache --force-remove -- ) || return 1;  }
+	[ "$queueM" ] && { ( echo "${queueM[*]}" | tr \\n \\0 | IFS=$'\n' xargs -0 git-update-cache ${infoonly} -- ) || return 1; }
 	return 0
 }
 
