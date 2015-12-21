From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 2/2] do_compare_entry: use already-computed path
Date: Mon, 21 Dec 2015 17:34:20 -0500
Message-ID: <1450737260-15965-3-git-send-email-dturner@twopensource.com>
References: <1450737260-15965-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 23:34:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB92W-0001Q6-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 23:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbbLUWen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 17:34:43 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33615 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbbLUWel (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 17:34:41 -0500
Received: by mail-qg0-f47.google.com with SMTP id k90so119136108qge.0
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 14:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ReaxcuS1JqKdpOjtQmh+RbBtwkVTYxHG8CedxBON+gs=;
        b=A8T33D/3CcbVSQgXDnwmhDx/I8Q5aF4rDs0HbXR4tKBqgCGlYZFAnyBOuc2WV3Ilt+
         N/baq8NTIeZZdv+o/m8VykRWILujbUsi+M/rtBOhMdrsf9IJIVCKOrBaosmdF6XV75w1
         +7vkneyalTbiOyRm8/t53M0VS061tuE0KrgCkoOlHUaO1KK98v99wXh2nc8e5eDlBFNS
         at58Aoifgvkid6PtJIZFA/yeG5mPfiHmH0GwWZm/7ZYU7uWTX4W2rtnP6aJQmhkW+2Mb
         ub+nXv3M9W3a3s2o8QzNUEf5sxkaTL2Y3sjE5MIGD1jz0RueB3zKGdd+tCJun3lcq8vx
         2Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ReaxcuS1JqKdpOjtQmh+RbBtwkVTYxHG8CedxBON+gs=;
        b=Pf44LyxRNtDPljis5sTch5qRCRHydBYgw33MnH9MQ9cHXWahOB2lchoy+k32XOb/p3
         97YGjkvjMADyvTYAhQbPAEM+1PMD+zXfnDld+h6iClCsz/KAuKnMt9NrvLVevxZgq+JE
         4/nRAjKNESl2xGWu0tnTMlaCZbIFNdJsJS/nqGrsexKtYCMW9gLBAGxQi5uQf9/5FJ2O
         Hwcdwjjjg8IeWkwNgpotXJtuJnVRYvs45fUaSQQzOF7FUKDUF6BOKX5Y65B4xGP/o7aG
         /1vrnKi7g9DQnbMY2/6nP6OZWwRQ06qK6A3SE3GH5iwcHsa3O7Hx4pi9lepo9xOMcPn3
         VKyw==
X-Gm-Message-State: ALoCoQlQeMdj383JHXP/N1cYLDpNjm4Fl5b/uvdCKCUyUb9qkMUWR6ZoDofqf0+/mBTymxiP4AD42PzUkXVbF+A0FBYY3WFw1A==
X-Received: by 10.140.240.199 with SMTP id l190mr30012377qhc.69.1450737280208;
        Mon, 21 Dec 2015 14:34:40 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z21sm12643373qge.18.2015.12.21.14.34.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Dec 2015 14:34:39 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1450737260-15965-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282822>

In traverse_trees, we generate the complete traverse path for a
traverse_info.  Later, in do_compare_entry, we used to go do a bunch
of work to compare the traverse_info to a cache_entry's name without
computing that path.  But since we already have that path, we don't
need to do all that work.  Instead, we can just put the generated
path into the traverse_info, and do the comparison more directly.

We copy the path because prune_traversal might mutate `base`. This
doesn't happen in any codepaths where do_compare_entry is called,
but it's better to be safe.

This makes git checkout much faster -- about 25% on Twitter's
monorepo.  Deeper directory trees are likely to benefit more than
shallower ones.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 tree-walk.c    |  7 +++++++
 tree-walk.h    |  1 +
 unpack-trees.c | 41 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 5eee262..7a0419e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -320,6 +320,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 	struct tree_desc_x *tx = xcalloc(n, sizeof(*tx));
 	struct strbuf base = STRBUF_INIT;
 	int interesting = 1;
+	char *traverse_path;
 
 	for (i = 0; i < n; i++)
 		tx[i].d = t[i];
@@ -329,7 +330,11 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 		make_traverse_path(base.buf, info->prev, &info->name);
 		base.buf[info->pathlen-1] = '/';
 		strbuf_setlen(&base, info->pathlen);
+		traverse_path = xstrndup(base.buf, info->pathlen);
+	} else {
+		traverse_path = xstrndup(info->name.path, info->pathlen);
 	}
+	info->traverse_path = traverse_path;
 	for (;;) {
 		int trees_used;
 		unsigned long mask, dirmask;
@@ -411,6 +416,8 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 	for (i = 0; i < n; i++)
 		free_extended_entry(tx + i);
 	free(tx);
+	free(traverse_path);
+	info->traverse_path = NULL;
 	strbuf_release(&base);
 	return error;
 }
diff --git a/tree-walk.h b/tree-walk.h
index f0a457b..a94357a 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -59,6 +59,7 @@ enum follow_symlinks_result {
 enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, struct strbuf *result_path, unsigned *mode);
 
 struct traverse_info {
+	const char *traverse_path;
 	const struct traverse_info *prev;
 	struct name_entry name;
 	int pathlen;
diff --git a/unpack-trees.c b/unpack-trees.c
index d4bedac..37328de 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -498,13 +498,14 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
  * itself - the caller needs to do the final check for the cache
  * entry having more data at the end!
  */
-static int do_compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
+static int do_compare_entry_piecewise(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
 {
 	int len, pathlen, ce_len;
 	const char *ce_name;
 
 	if (info->prev) {
-		int cmp = do_compare_entry(ce, info->prev, &info->name);
+		int cmp = do_compare_entry_piecewise(ce, info->prev,
+						     &info->name);
 		if (cmp)
 			return cmp;
 	}
@@ -522,6 +523,42 @@ static int do_compare_entry(const struct cache_entry *ce, const struct traverse_
 	return df_name_compare(ce_name, ce_len, S_IFREG, n->path, len, n->mode);
 }
 
+static int do_compare_entry(const struct cache_entry *ce,
+			    const struct traverse_info *info,
+			    const struct name_entry *n)
+{
+	int len, pathlen, ce_len;
+	const char *ce_name;
+	int cmp;
+
+	/*
+	 * If we have not precomputed the traverse path, it is quicker
+	 * to avoid doing so.  But if we have precomputed it,
+	 * it is quicker to use the precomputed version.
+	 */
+	if (!info->traverse_path)
+		return do_compare_entry_piecewise(ce, info, n);
+
+	cmp = strncmp(ce->name, info->traverse_path, info->pathlen);
+	if (cmp)
+		return cmp;
+
+	pathlen = info->pathlen;
+	ce_len = ce_namelen(ce);
+
+	if (ce_len < pathlen) {
+		if (do_compare_entry_piecewise(ce, info, n) >= 0)
+			die("pathlen");
+		return -1;
+	}
+
+	ce_len -= pathlen;
+	ce_name = ce->name + pathlen;
+
+	len = tree_entry_len(n);
+	return df_name_compare(ce_name, ce_len, S_IFREG, n->path, len, n->mode);
+}
+
 static int compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
 {
 	int cmp = do_compare_entry(ce, info, n);
-- 
2.4.2.749.g730654d-twtrsrc
