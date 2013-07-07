From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 12/22] read-cache: make read_blob_data_from_index use index api
Date: Sun,  7 Jul 2013 10:11:50 +0200
Message-ID: <1373184720-29767-13-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk5x-0006Dl-7b
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057Ab3GGINS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:18 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:42357 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab3GGINM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:13:12 -0400
Received: by mail-ee0-f53.google.com with SMTP id c41so2181591eek.26
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6ps94wk7sC9TzDJQpMbKMUrF65+79qgqb1rQesgZSd4=;
        b=yuYSjWfBSXn78awz6E/slLh7Mb7n5kKxKEihioxVmhAkxokJP+e5VedpriRMjp63sn
         RS47VVcDejdulBtmG5MpzfTuamsop6tQ/hQK+HGhatLTFtm8YF8nskOP67j8qJMdV43B
         kl7zff2t8a9MIZR0mWO7t0DZDmYnl0KzhoOhtAol8JuJgcrkyGDikWh3gn9noqkicoba
         R+XyMtam59g3N1DhljiTpIaPA8k4l0XiznVCkHJb8iRWEmMz2Ghr6yZZgj/FCA4t5iFW
         /szL/R8w+3dbKIfJgKfrzmZ9f3LQD1Y6ht9rFqL1ujxVyMCYaRmKKw4t6g+Iyzk+C4no
         rgag==
X-Received: by 10.14.115.132 with SMTP id e4mr19541689eeh.54.1373184790777;
        Sun, 07 Jul 2013 01:13:10 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id ci50sm30683917eeb.12.2013.07.07.01.13.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:13:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229742>

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 4529fab..c81e643 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1588,29 +1588,27 @@ int index_name_is_other(const struct index_state *istate, const char *name,
 
 void *read_blob_data_from_index(struct index_state *istate, const char *path, unsigned long *size)
 {
-	int pos, len;
+	int ret, len;
 	unsigned long sz;
 	enum object_type type;
 	void *data;
+	struct cache_entry *ce;
 
 	len = strlen(path);
-	pos = index_name_pos(istate, path, len);
-	if (pos < 0) {
+	ret = get_index_entry_by_name(istate, path, len, &ce);
+	if (!ret) {
 		/*
 		 * We might be in the middle of a merge, in which
 		 * case we would read stage #2 (ours).
 		 */
-		int i;
-		for (i = -pos - 1;
-		     (pos < 0 && i < istate->cache_nr &&
-		      !strcmp(istate->cache[i]->name, path));
-		     i++)
-			if (ce_stage(istate->cache[i]) == 2)
-				pos = i;
+		for (; !ret && ce && !strcmp(ce->name, path); ce = next_index_entry(ce))
+			if (ce_stage(ce) == 2)
+				ret = 1;
+
 	}
-	if (pos < 0)
+	if (!ret)
 		return NULL;
-	data = read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
+	data = read_sha1_file(ce->sha1, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
-- 
1.8.3.453.g1dfc63d
