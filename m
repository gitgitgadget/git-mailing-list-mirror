From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] git-fsck-objects: Free tree entries after use
Date: Tue, 15 Nov 2005 19:07:15 +0300
Message-ID: <20051115160715.GF24496@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 17:12:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec3Ld-0007Ji-1Q
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 17:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVKOQH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 11:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVKOQH3
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 11:07:29 -0500
Received: from mivlgu.ru ([81.18.140.87]:46746 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S964790AbVKOQH2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 11:07:28 -0500
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id B976918011E; Tue, 15 Nov 2005 19:07:15 +0300 (MSK)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11911>

The Massif tool of Valgrind revealed that parsed tree entries occupy
more than 60% of memory allocated by git-fsck-objects.  These entries
can be freed immediately after use, which significantly decreases
memory consumption.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 fsck-objects.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

applies-to: 4b6dbe856a3e63699b299c76f4f1fc5cb34cbe26
0742a20134cc7f58f2c4cbc982a3eb115c6eaf47
diff --git a/fsck-objects.c b/fsck-objects.c
index 17d0536..c1b279e 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -184,10 +184,17 @@ static int fsck_tree(struct tree *item)
 			default:
 				break;
 			}
+			free(last->name);
+			free(last);
 		}
 
 		last = entry;
 	}
+	if (last) {
+		free(last->name);
+		free(last);
+	}
+	item->entries = NULL;
 
 	retval = 0;
 	if (has_full_path) {
---
0.99.9.GIT
