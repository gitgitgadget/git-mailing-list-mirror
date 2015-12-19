From: David Turner <dturner@twopensource.com>
Subject: [PATCH] do_compare_entry: use already-computed path
Date: Fri, 18 Dec 2015 20:40:27 -0500
Message-ID: <1450489227-4771-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 02:41:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA6WJ-0000bu-PF
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 02:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbbLSBkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 20:40:45 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34443 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbbLSBko (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 20:40:44 -0500
Received: by mail-qk0-f171.google.com with SMTP id p187so118209089qkd.1
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 17:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2TFk/xiNKRzAFrmLdtftiNkI0nOvO173xq5StJEk9JE=;
        b=F7hFMuUEOqApRxx2Vr1BtEZtFvgnff4geWdXj+DB4medrj2/K+gIDJv+pMnIz4UJjM
         rRfqnQF/pysE/QW8S4EMqRPeFAAZOlnNENRHHvQEPBM0jixmnUQzMnpP0hD/lIUWQQs4
         SxW+WFZ+eFcUdQCyp9RBiEHF0nejGnnVgLAFCP6ZA1HkR2hirhqwSxXLoxb4qG4LD1ZB
         PGhbwD+j1t5GdLVKFXalOH8m4ju7V6YVW7FXRaY+CY5DKfxNYkUAs2ek1fqwkylMV5fW
         33jAHZLcI5aeaMIJBw1aHfkMk1wjgqBQsB3gz85eTP7a/uzSXSzkW4ivFJUcCgcMBa7C
         TOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2TFk/xiNKRzAFrmLdtftiNkI0nOvO173xq5StJEk9JE=;
        b=ks4dsW0/Ra98gIAw2KXEkuoyPtOdKNixcEKqBzdowpVIxOzmJpCxAsfl13Ur722r7u
         QStNgBBUTfCrPdgkkLcx1ZN4kVvP4Wd7WOxpGeXEM8AxBaC58sW8vX1Jw9nzFPQgBcAa
         0ES6k8czvtBS7P/c729EDA4duriBDla0JjcNqNuQMP76kTNRIwJCxxlGagkI/GzrS+wA
         W+H2gZ7a05Jb9/kbZTlXS2BhwGOS3MbyUBC3ZIYboEa+qK/BCgPK7LMJHZVKwdGSxEmW
         86KpuTSoVn3kSDYoYOVRDbe1+fA7zinoCdmuAjc1C6j/RWpt18GY7kood7vXRkrSx6lP
         SAaw==
X-Gm-Message-State: ALoCoQnN25ygJM6hEn3vT27tXf8+2lAxsmHWbL2tevk1hMsvd/dDgzcJyNXBNz/MWySPYPKfYTFCwae2dZetVHoY/AHm9Cw4lw==
X-Received: by 10.55.73.133 with SMTP id w127mr9467488qka.53.1450489243194;
        Fri, 18 Dec 2015 17:40:43 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id r83sm7950727qhc.8.2015.12.18.17.40.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Dec 2015 17:40:42 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282726>

In traverse_trees, we generate the complete traverse path for a
traverse_info.  Later, in do_compare_entry, we used to go do a bunch
of work to compare the traverse_info to a cache_entry's name without
computing that path.  But since we already have that path, we don't
need to do all that work.  Instead, we can just stuff the generated
path into the traverse_info, and do the comparison more directly.
This makes git checkout much faster -- about 25% on Twitter's
monorepo.  Deeper directory trees are likely to benefit more than
shallower ones.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 tree-walk.c    |  4 ++++
 tree-walk.h    |  1 +
 unpack-trees.c | 41 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 6dccd2d..4cab3e1 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -329,6 +329,9 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 		make_traverse_path(base.buf, info->prev, &info->name);
 		base.buf[info->pathlen-1] = '/';
 		strbuf_setlen(&base, info->pathlen);
+		info->traverse_path = base.buf;
+	} else {
+		info->traverse_path = info->name.path;
 	}
 	for (;;) {
 		int trees_used;
@@ -411,6 +414,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 	for (i = 0; i < n; i++)
 		free_extended_entry(tx + i);
 	free(tx);
+	info->traverse_path = NULL;
 	strbuf_release(&base);
 	return error;
 }
diff --git a/tree-walk.h b/tree-walk.h
index 3b2f7bf..174eb61 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -59,6 +59,7 @@ enum follow_symlinks_result {
 enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, struct strbuf *result_path, unsigned *mode);
 
 struct traverse_info {
+	const char *traverse_path;
 	struct traverse_info *prev;
 	struct name_entry name;
 	int pathlen;
diff --git a/unpack-trees.c b/unpack-trees.c
index 8e2032f..127dd4d 100644
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
