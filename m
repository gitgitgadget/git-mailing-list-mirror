From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] unpack_trees(): add support for sparse checkout
Date: Wed, 29 Jul 2009 16:49:14 +1000
Message-ID: <1248850154-5469-6-git-send-email-pclouds@gmail.com>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
 <1248850154-5469-2-git-send-email-pclouds@gmail.com>
 <1248850154-5469-3-git-send-email-pclouds@gmail.com>
 <1248850154-5469-4-git-send-email-pclouds@gmail.com>
 <1248850154-5469-5-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 08:50:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW2zE-0003xp-SI
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 08:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbZG2Gtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 02:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbZG2Gtv
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 02:49:51 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:57439 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbZG2Gtt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 02:49:49 -0400
Received: by mail-pz0-f204.google.com with SMTP id 42so411469pzk.33
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 23:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0BdlRePm62FSHkzNZW27CtajSu9UTJxRuUbWTBUIk7E=;
        b=A79BkLQlvn/MGFpSnxCkvI30LsCisp5i2lvE5BGFXJk8IyBnfTyCAaOAaUSKAnZz34
         4Y6qGCoj8v8x5t4NLPn42WnKqgstgUQy1yVWSMDwqUWX5TyigAm5/Et5PDrcDB/6mLIA
         toqkyV4n4/GPuRytYP2NkQPYuyctR0CgkHSnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ym0UExRHjUBcyWkf5501+w78aE1c6AiAw00J+InUKO7ECEJUh3HuEYBu5uBhMuE21p
         Hhuo60o2pjlBTWmK76ks4G9YHoTbVM00+TczIE8Zxt5hX6dol5sU07qwfYokjK3QaUPZ
         E6ROtjJ6GHHQoPM+9hxH7cS/lsXEJe6xY64jc=
Received: by 10.114.72.12 with SMTP id u12mr13347713waa.28.1248850190622;
        Tue, 28 Jul 2009 23:49:50 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id n9sm850606wag.58.2009.07.28.23.49.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 23:49:49 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 29 Jul 2009 16:49:44 +1000
X-Mailer: git-send-email 1.6.3.2.448.gdf8b6
In-Reply-To: <1248850154-5469-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124314>

This patch teaches unpack_trees() to checkout/remove entries
on working directories appropriately when sparse checkout area is
changed. A helper "git shape-workdir" is needed to help determine
which entry will be checked out, which will be not.

"git shape-workdir" will receive from stdin in this format

X\tpathname

where X is either
 - '!' current entry is already CE_VALID
 - 'N' current entry is "new" (it has not been in index before)
 - '-' current entry is "normal" entry

"git shape-workdir" is expected to return either "1" or "0"
immediately. "1" means the entry should be in workdir. "0" means
setting CE_VALID and get rid of it from workdir.
---
 cache.h        |    4 ++
 unpack-trees.c |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 unpack-trees.h |    2 +
 3 files changed, 133 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 1a2a3c9..eac3151 100644
--- a/cache.h
+++ b/cache.h
@@ -177,6 +177,10 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
 
+/* Only remove in work directory, not index */
+#define CE_WT_REMOVE (0x400000)
+#define CE_NEW       (0x800000)
+
 /*
  * Extended on-disk flags
  */
diff --git a/unpack-trees.c b/unpack-trees.c
index c67eed8..125a662 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,7 @@
 #include "progress.h"
 #include "refs.h"
 #include "attr.h"
+#include "run-command.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -32,6 +33,12 @@ static struct unpack_trees_error_msgs unpack_plumbing_errors = {
 
 	/* bind_overlap */
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
+
+	/* sparse_not_uptodate_file */
+	"Entry '%s' not uptodate. Cannot update sparse checkout.",
+
+	/* would_lose_orphaned */
+	"Orphaned working tree file '%s' would be %s by sparse checkout update.",
 };
 
 #define ERRORMSG(o,fld) \
@@ -78,7 +85,7 @@ static int check_updates(struct unpack_trees_options *o)
 	if (o->update && o->verbose_update) {
 		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce = index->cache[cnt];
-			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
+			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE | CE_WT_REMOVE))
 				total++;
 		}
 
@@ -92,6 +99,13 @@ static int check_updates(struct unpack_trees_options *o)
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
+		if (ce->ce_flags & CE_WT_REMOVE) {
+			display_progress(progress, ++cnt);
+			if (o->update)
+				unlink_entry(ce);
+			continue;
+		}
+
 		if (ce->ce_flags & CE_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update)
@@ -118,6 +132,81 @@ static int check_updates(struct unpack_trees_options *o)
 	return errs != 0;
 }
 
+static int verify_uptodate_sparse(struct cache_entry *ce, struct unpack_trees_options *o);
+static int verify_absent_sparse(struct cache_entry *ce, const char *action, struct unpack_trees_options *o);
+static int apply_narrow_spec(struct unpack_trees_options *o)
+{
+	struct index_state *index = &o->result;
+	struct child_process cp;
+	const char *argv[] = { "shape-workdir", NULL };
+	int i, ret;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.in = -1;
+	cp.out = -1;
+	cp.git_cmd = 1;
+	cp.argv = argv;
+
+	ret = start_command(&cp);
+	if (ret)
+		return -1;
+
+	for (i = 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce = index->cache[i];
+		int was_checkout = !(ce->ce_flags & CE_VALID);
+		char buf[PATH_MAX+3];
+		char result[2];
+
+		if (ce_stage(ce))
+			continue;
+
+		/*
+		 * We only care about files getting into the checkout area
+		 * If merge strategies want to remove some, go ahead
+		 */
+		if (ce->ce_flags & CE_REMOVE)
+			continue;
+
+		snprintf(buf, PATH_MAX+3, "%c\t%s\n",
+			 (ce->ce_flags & CE_NEW) ? 'N' : (was_checkout ? '!' : '-'),
+			 ce->name);
+		xwrite(cp.in, buf, strlen(buf));
+		xread(cp.out, result, 2);
+
+		if (result[0] == '1')
+			ce->ce_flags &= ~CE_VALID;
+		else
+			ce->ce_flags |= CE_VALID;
+
+		/* Update worktree, add/remove entries if needed */
+
+		if (was_checkout && ce->ce_flags & CE_VALID) {
+			/*
+			 * If CE_UPDATE is set, verify_uptodate() must be called already
+			 * also stat info may have lost after merged_entry() so calling
+			 * verify_uptodate() again may fail
+			 */
+			if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
+				return -1;
+			ce->ce_flags |= CE_WT_REMOVE;
+		}
+		if (!was_checkout && !(ce->ce_flags & CE_VALID)) {
+			if (verify_absent_sparse(ce, "overwritten", o))
+				return -1;
+			ce->ce_flags |= CE_UPDATE;
+		}
+
+		/* merge strategies may set CE_UPDATE outside checkout area */
+		if (ce->ce_flags & CE_VALID)
+			ce->ce_flags &= ~CE_UPDATE;
+
+	}
+	close(cp.in);
+	finish_command(&cp);
+	close(cp.out);
+	return 0;
+}
+
 static inline int call_unpack_fn(struct cache_entry **src, struct unpack_trees_options *o)
 {
 	int ret = o->fn(src, o);
@@ -423,6 +512,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->trivial_merges_only && o->nontrivial_merge)
 		return unpack_failed(o, "Merge requires file-level merging");
 
+	if (apply_narrow_spec(o))
+		return unpack_failed(o, NULL);
+
 	o->src_index = NULL;
 	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
@@ -452,8 +544,9 @@ static int same(struct cache_entry *a, struct cache_entry *b)
  * When a CE gets turned into an unmerged entry, we
  * want it to be up-to-date
  */
-static int verify_uptodate(struct cache_entry *ce,
-		struct unpack_trees_options *o)
+static int verify_uptodate_generic(struct cache_entry *ce,
+				   struct unpack_trees_options *o,
+				   const char *error_msg)
 {
 	struct stat st;
 
@@ -478,7 +571,18 @@ static int verify_uptodate(struct cache_entry *ce,
 	if (errno == ENOENT)
 		return 0;
 	return o->gently ? -1 :
-		error(ERRORMSG(o, not_uptodate_file), ce->name);
+		error(error_msg, ce->name);
+}
+
+static int verify_uptodate(struct cache_entry *ce,
+			   struct unpack_trees_options *o)
+{
+	return verify_uptodate_generic(ce, o, ERRORMSG(o, not_uptodate_file));
+}
+static int verify_uptodate_sparse(struct cache_entry *ce,
+				  struct unpack_trees_options *o)
+{
+	return verify_uptodate_generic(ce, o, ERRORMSG(o, sparse_not_uptodate_file));
 }
 
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_trees_options *o)
@@ -586,8 +690,9 @@ static int icase_exists(struct unpack_trees_options *o, struct cache_entry *dst,
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
-static int verify_absent(struct cache_entry *ce, const char *action,
-			 struct unpack_trees_options *o)
+static int verify_absent_generic(struct cache_entry *ce, const char *action,
+				 struct unpack_trees_options *o,
+				 const char *error_msg)
 {
 	struct stat st;
 
@@ -667,6 +772,16 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 	}
 	return 0;
 }
+static int verify_absent(struct cache_entry *ce, const char *action,
+			 struct unpack_trees_options *o)
+{
+	return verify_absent_generic(ce, action, o, ERRORMSG(o, would_lose_untracked));
+}
+static int verify_absent_sparse(struct cache_entry *ce, const char *action,
+			 struct unpack_trees_options *o)
+{
+	return verify_absent_generic(ce, action, o, ERRORMSG(o, would_lose_orphaned));
+}
 
 static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		struct unpack_trees_options *o)
@@ -689,10 +804,14 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 				return -1;
 			invalidate_ce_path(old, o);
 		}
+		if (old->ce_flags & CE_VALID)
+			update |= CE_VALID;
 	}
 	else {
 		if (verify_absent(merge, "overwritten", o))
 			return -1;
+		if (!o->has_unmerged)
+			update |= CE_NEW;
 		invalidate_ce_path(merge, o);
 	}
 
@@ -1017,6 +1136,8 @@ int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID))
 				update |= CE_UPDATE;
 		}
+		if (old->ce_flags & CE_VALID)
+			update |= CE_VALID;
 		add_entry(o, old, update, 0);
 		return 0;
 	}
diff --git a/unpack-trees.h b/unpack-trees.h
index aa3ac17..8838517 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -14,6 +14,8 @@ struct unpack_trees_error_msgs {
 	const char *not_uptodate_dir;
 	const char *would_lose_untracked;
 	const char *bind_overlap;
+	const char *sparse_not_uptodate_file;
+	const char *would_lose_orphaned;
 };
 
 struct unpack_trees_options {
-- 
1.6.3.2.448.gdf8b6
