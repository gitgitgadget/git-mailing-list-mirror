From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Revert "Also use 'track_object_refs = 0' in update-server-info."
Date: Thu, 13 Oct 2005 10:20:34 -0700
Message-ID: <7v1x2p49lp.fsf@assigned-by-dhcp.cox.net>
References: <20051013161010.GC12092@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Thu Oct 13 19:25:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ6lB-0007qk-GG
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 19:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVJMRUh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 13:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVJMRUh
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 13:20:37 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33956 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932112AbVJMRUg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 13:20:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051013172024.QNBQ9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Oct 2005 13:20:24 -0400
To: git@vger.kernel.org
In-Reply-To: <20051013161010.GC12092@master.mivlgu.local> (Sergey Vlasov's
	message of "Thu, 13 Oct 2005 20:10:10 +0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10082>

Sergey spotted a grave bug, already in "master", which shows my
lack of testing.  I just pushed out his fix, which is to revert
d119e3de13ea1493107bd57381d0ce9c9dd90976.  It should propagate
to the mirrors soon.

If you used git-update-server-info with the bug on your
repository, you will find a huge objects/info/packs file.
Usually it should list just a handful edge tags and commits, but
with the bug it practically lists everything.

After rebuilding the fixed git-update-server-info, please run
'git-update-server-info -f' there to fix this problem.

Sorry for the stupid bug, and many thanks to Sergey.

 ------------

This reverts d119e3de13ea1493107bd57381d0ce9c9dd90976 commit.

Object references are used in server-info.c:find_pack_info_one() to
find out which objects in the pack are heads, therefore tracking of
references cannot be disabled.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Looks like this bug has caused objects/info/packs in the linux-2.4
 repository to grow huge and hit the limit, which I then needed to remove
 in the previous patch.


 update-server-info.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

applies-to: 1970e5869a42fd4095917d861654dc84d60f02b7
985738719bfb5284911871f15180a2aee6512d53
diff --git a/update-server-info.c b/update-server-info.c
index b708563..e824f62 100644
--- a/update-server-info.c
+++ b/update-server-info.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "object.h"
 
 static const char update_server_info_usage[] =
 "git-update-server-info [--force]";
@@ -8,8 +7,6 @@ int main(int ac, char **av)
 {
 	int i;
 	int force = 0;
-	track_object_refs = 0;
-
 	for (i = 1; i < ac; i++) {
 		if (av[i][0] == '-') {
 			if (!strcmp("--force", av[i]) ||
---
0.99.8.GIT
