From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 3/3] unpack-trees: remove redundant path search in verify_absent
Date: Thu,  1 Jan 2009 21:54:33 +0100
Message-ID: <1230843273-11056-4-git-send-email-drizzd@aon.at>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at>
 <1230843273-11056-2-git-send-email-drizzd@aon.at>
 <1230843273-11056-3-git-send-email-drizzd@aon.at>
Cc: gitster@pobox.com, Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 01 22:28:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIV5L-0003x8-Mb
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 22:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbZAAV0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 16:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZAAV0q
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 16:26:46 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:14659 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbZAAV0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 16:26:46 -0500
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Jan 2009 22:26:43 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LIUYr-0002wO-PA; Thu, 01 Jan 2009 21:54:33 +0100
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1230843273-11056-3-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 01 Jan 2009 21:26:43.0141 (UTC) FILETIME=[A44FAF50:01C96C57]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104329>

Since the only caller, verify_absent, relies on the fact that o->pos
points to the next index entry anyways, there is no need to recompute
its position.

Furthermore, if a nondirectory entry were found, this would return too
early, because there could still be an untracked directory in the way.
This is currently not a problem, because verify_absent is only called
if the index does not have this entry.
---
 unpack-trees.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index f8e2484..c4dc6dc 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -495,7 +495,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	 * anything in the existing directory there.
 	 */
 	int namelen;
-	int pos, i;
+	int i;
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
@@ -516,11 +516,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	 * in that directory.
 	 */
 	namelen = strlen(ce->name);
-	pos = index_name_pos(o->src_index, ce->name, namelen);
-	if (0 <= pos)
-		return 0; /* we have it as nondirectory */
-	pos = -pos - 1;
-	for (i = pos; i < o->src_index->cache_nr; i++) {
+	for (i = o->pos; i < o->src_index->cache_nr; i++) {
 		struct cache_entry *ce2 = o->src_index->cache[i];
 		int len = ce_namelen(ce2);
 		if (len < namelen ||
-- 
1.6.1
