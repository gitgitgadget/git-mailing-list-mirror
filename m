From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 4/7] Relaxes error checking in epoch.c to allow duplicate parents
Date: Mon, 20 Jun 2005 12:29:33 +1000
Message-ID: <20050620022933.28599.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Jun 20 04:26:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkByq-0006sb-U7
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 04:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVFTCbX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 22:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVFTCbX
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 22:31:23 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:47491 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261403AbVFTC3f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 22:29:35 -0400
Received: (qmail 28609 invoked by uid 500); 20 Jun 2005 02:29:33 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Given that real trees in the wild include parents with duplicate parents, I have relaxed
over-zealous error checking in epoch.c and dealt with the problem a different way - duplicate
parents are now silently ignored.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -224,17 +224,13 @@ static int find_base_for_list(struct com
 	for (; list; list = list->next) {
 		struct commit *item = list->item;
 
-		if (item->object.util) {
-			die("%s:%d:%s: logic error: this should not have happened - commit %s",
-			    __FILE__, __LINE__, __FUNCTION__,
-			    sha1_to_hex(item->object.sha1));
-		}
-
-		new_mass_counter(list->item, get_one());
-		add(&injected, &injected, get_one());
+		if (!item->object.util) {
+			new_mass_counter(list->item, get_one());
+			add(&injected, &injected, get_one());
 
-		commit_list_insert(list->item, &cleaner);
-		commit_list_insert(list->item, &pending);
+			commit_list_insert(list->item, &cleaner);
+			commit_list_insert(list->item, &pending);
+		}
 	}
 
 	while (!*boundary && pending && !ret) {
------------
