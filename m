From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 07/22] teach fsck-objects.c to use cache iterators
Date: Mon, 12 Sep 2005 10:55:58 -0400
Message-ID: <20050912145558.28120.91494.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:04:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEplr-0001hk-Ec
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVILO4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVILO4s
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:48 -0400
Received: from citi.umich.edu ([141.211.133.111]:8526 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751293AbVILOz7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:55:59 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id A5DBC1BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:55:58 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8404>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 fsck-objects.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fsck-objects.c b/fsck-objects.c
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -412,6 +412,20 @@ static int fsck_head_link(void)
 	return 0;
 }
 
+static int mark_one_blob_reachable(struct cache_cursor *cc, struct cache_entry *ce)
+{
+	struct blob *blob = lookup_blob(ce->sha1);
+
+	if (blob) {
+		struct object *obj = &blob->object;
+		obj->used = 1;
+		mark_reachable(obj, REACHABLE);
+	}
+
+	next_cc(cc);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int i, heads;
@@ -519,17 +533,8 @@ int main(int argc, char **argv)
 	}
 
 	if (keep_cache_objects) {
-		int i;
-		read_cache();
-		for (i = 0; i < active_nr; i++) {
-			struct blob *blob = lookup_blob(active_cache[i]->sha1);
-			struct object *obj;
-			if (!blob)
-				continue;
-			obj = &blob->object;
-			obj->used = 1;
-			mark_reachable(obj, REACHABLE);
-		}
+		if (read_cache() > 0)
+			walk_cache(mark_one_blob_reachable);
 	}
 
 	check_connectivity();
