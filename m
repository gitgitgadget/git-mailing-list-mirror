From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 08/22] tree.c: use index api
Date: Sun,  7 Jul 2013 10:11:46 +0200
Message-ID: <1373184720-29767-9-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk5r-0006Au-Ny
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab3GGINE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:04 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:34067 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab3GGIMv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:12:51 -0400
Received: by mail-ee0-f42.google.com with SMTP id c4so2229762eek.1
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SdD4g0Kild6Er6aKs29+T1pf9fqW4jiqBrQsZmkJkHA=;
        b=rhL1t9C0wuga0YVI2AqGgfGspNO3ohhm/WOxj5f5EF/BfZDJD/KXk5HmI98uErcdkA
         wYufJsFsycEMN1cowdeFNLdkMiORcT21iV0pc377lSYyUBQRLiCgRPxVlsjOVIH0vdsu
         FxKGCXqB5+CkW+pqnWDdH+HJeF3q+JpKCxC3Ufj9TPx8rIWvIYMLPrki3TYbqlH/rXrA
         c2X/cxUXdfFpWUNoUY66Y8h5umFG+egPotGOKyZ8w7kgjfO2EstSlmF7T8l3N6E1zvS0
         rxugBQvKl12eKWMRhzlJVewYh9Cv6itnOL0Jp0SEqEPPK5z1o4ULcJUB+DnN/MnjOWr6
         PBfw==
X-Received: by 10.14.182.132 with SMTP id o4mr19379205eem.94.1373184769965;
        Sun, 07 Jul 2013 01:12:49 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id l42sm30656891eeo.14.2013.07.07.01.12.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:12:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229739>

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 tree.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/tree.c b/tree.c
index 62fed63..5cd43f4 100644
--- a/tree.c
+++ b/tree.c
@@ -128,20 +128,28 @@ int read_tree_recursive(struct tree *tree,
 	return ret;
 }
 
-static int cmp_cache_name_compare(const void *a_, const void *b_)
+
+struct read_tree_data {
+	read_tree_fn_t fn;
+	int stage;
+};
+
+int get_read_tree_fn(struct cache_entry *ce, void *cb_data)
 {
-	const struct cache_entry *ce1, *ce2;
+	struct read_tree_data *data = cb_data;
 
-	ce1 = *((const struct cache_entry **)a_);
-	ce2 = *((const struct cache_entry **)b_);
-	return cache_name_stage_compare(ce1->name, ce1->ce_namelen, ce_stage(ce1),
-				  ce2->name, ce2->ce_namelen, ce_stage(ce2));
+	if (ce_stage(ce) == data->stage) {
+		data->fn = read_one_entry;
+		return 0;
+	}
+	return 1;
 }
 
 int read_tree(struct tree *tree, int stage, struct pathspec *match)
 {
 	read_tree_fn_t fn = NULL;
-	int i, err;
+	int err;
+	struct read_tree_data rtd;
 
 	/*
 	 * Currently the only existing callers of this function all
@@ -158,11 +166,10 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match)
 	 * do it the original slow way, otherwise, append and then
 	 * sort at the end.
 	 */
-	for (i = 0; !fn && i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (ce_stage(ce) == stage)
-			fn = read_one_entry;
-	}
+	rtd.fn = fn;
+	rtd.stage = stage;
+	for_each_cache_entry(get_read_tree_fn, &rtd);
+	fn = rtd.fn;
 
 	if (!fn)
 		fn = read_one_entry_quick;
@@ -170,12 +177,7 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match)
 	if (fn == read_one_entry || err)
 		return err;
 
-	/*
-	 * Sort the cache entry -- we need to nuke the cache tree, though.
-	 */
-	cache_tree_free(&active_cache_tree);
-	qsort(active_cache, active_nr, sizeof(active_cache[0]),
-	      cmp_cache_name_compare);
+	sort_cache();
 	return 0;
 }
 
-- 
1.8.3.453.g1dfc63d
