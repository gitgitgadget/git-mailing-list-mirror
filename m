From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix confusing behaviour of update-cache --refresh on
 unmerged paths.
Date: Sun, 17 Apr 2005 23:09:34 -0700
Message-ID: <7v3btovco1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 08:06:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNPOf-0006oi-Eu
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 08:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVDRGJq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 02:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVDRGJq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 02:09:46 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:53442 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261687AbVDRGJg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 02:09:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418060934.TPLT13819.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Apr 2005 02:09:34 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The "update-cache --refresh" command attempts refresh_entry() 
on unmerged path, which results in as many "needs update" messages
as there are unmerged stages for that path.  This does not do
any harm to the working directory, but it is confusing.

    $ ls -al
    total 16
    drwxrwsr-x   3 junio src 4096 Apr 17 23:00 ./
    drwxrwsr-x  10 junio src 4096 Apr 17 22:58 ../
    drwxr-sr-x   3 junio src 4096 Apr 17 22:59 .git/
    -rw-rw-r--   1 junio src  363 Apr 17 23:00 TT
    $ show-files --stage
    100644 e14bafaadce6c34768ba2ff8b3c6419e8839e7d2 1 TT
    100644 99ef1b30fc6d6ea186d6eac62619e1afd65ad64e 2 TT
    100644 033b9385f7a29882a6b4b34f67b20e2304d3489d 3 TT
    $ ../++linus/update-cache --refresh
    TT: needs update
    TT: needs update
    TT: needs update
    $ ../update-cache --refresh
    TT: needs merge

Here is a fix.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 update-cache.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

update-cache.c: 5742c6ca084a7761ad728651d85509736e2ebc7c
--- update-cache.c
+++ update-cache.c	2005-04-17 22:58:06.000000000 -0700
@@ -196,9 +196,18 @@ static void refresh_cache(void)
 	int i;
 
 	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		struct cache_entry *new = refresh_entry(ce);
+		struct cache_entry *ce, *new;
+		ce = active_cache[i];
+		if (ce_stage(ce)) {
+			printf("%s: needs merge\n", ce->name);
+			while ((i < active_nr) &&
+			       ! strcmp(active_cache[i]->name, ce->name))
+				i++;
+			i--;
+			continue;
+		}
 
+		new = refresh_entry(ce);
 		if (!new) {
 			printf("%s: needs update\n", ce->name);
 			continue;

