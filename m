From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/32] read-cache: mark updated entries for split index
Date: Mon, 28 Apr 2014 17:55:41 +0700
Message-ID: <1398682553-11634-21-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:56:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejEg-00030A-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbaD1K4Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:56:25 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:54843 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbaD1K4U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:56:20 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so1296462pde.8
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nTn2KuqUim0cVl/hT6US0mgl/VTehICqlATcHenr3mo=;
        b=IGjNRztn9ZuyBpy6AxqD5X8d65xzeBaupgdOvp3bt5jyYEkFZcHpnuRISq/7F92kZ6
         4Wk5YG7GEi1CVZrYoYDFcPboIH5DQa2TQ8EOaBnVxzPtBUN4LwxsmhhS22VBN4aU3FRX
         AVryz2KymAvb7aVanfwoVmi0Zu89J4/Jt7FWV42YH8C36O2bcxO/0vjh5NBXg+T/5h7h
         Rpu2SZeKNqGoouk/40nrXu6o5GQY0O/YxgLfaBGNgtPMOJDxrEG1J1ImylogY3egrUCy
         q3KJ91ttY7D5HpvIRx+osA22RLbir+Dqymd4o3Tm/mP2Aea68rN2L22AUNct1zIA5GYn
         QuWg==
X-Received: by 10.66.219.225 with SMTP id pr1mr24668861pac.83.1398682579723;
        Mon, 28 Apr 2014 03:56:19 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id gn3sm34215901pbc.32.2014.04.28.03.56.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:56:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:57:47 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247284>

The large part of this patch just follows CE_ENTRY_CHANGED
marks. replace_index_entry() is updated to update
split_index->base->cache[] as well so base->cache[] does not reference
to a freed entry.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c |  2 ++
 cache.h                |  2 ++
 entry.c                |  1 +
 read-cache.c           |  5 ++++-
 split-index.c          | 15 +++++++++++++++
 split-index.h          |  3 +++
 unpack-trees.c         |  4 +++-
 7 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index fa3c441..f7a19c4 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -55,6 +55,7 @@ static int mark_ce_flags(const char *path, int flag, =
int mark)
 			active_cache[pos]->ce_flags |=3D flag;
 		else
 			active_cache[pos]->ce_flags &=3D ~flag;
+		active_cache[pos]->ce_flags |=3D CE_UPDATE_IN_BASE;
 		cache_tree_invalidate_path(&the_index, path);
 		active_cache_changed |=3D CE_ENTRY_CHANGED;
 		return 0;
@@ -268,6 +269,7 @@ static void chmod_path(int flip, const char *path)
 		goto fail;
 	}
 	cache_tree_invalidate_path(&the_index, path);
+	ce->ce_flags |=3D CE_UPDATE_IN_BASE;
 	active_cache_changed |=3D CE_ENTRY_CHANGED;
 	report("chmod %cx '%s'", flip, path);
 	return;
diff --git a/cache.h b/cache.h
index 90a5998..127804e 100644
--- a/cache.h
+++ b/cache.h
@@ -169,6 +169,8 @@ struct cache_entry {
 /* used to temporarily mark paths matched by pathspecs */
 #define CE_MATCHED           (1 << 26)
=20
+#define CE_UPDATE_IN_BASE    (1 << 27)
+
 /*
  * Extended on-disk flags
  */
diff --git a/entry.c b/entry.c
index d913c1d..1eda8e9 100644
--- a/entry.c
+++ b/entry.c
@@ -214,6 +214,7 @@ finish:
 		if (!fstat_done)
 			lstat(ce->name, &st);
 		fill_stat_cache_info(ce, &st);
+		ce->ce_flags |=3D CE_UPDATE_IN_BASE;
 		state->istate->cache_changed |=3D CE_ENTRY_CHANGED;
 	}
 	return 0;
diff --git a/read-cache.c b/read-cache.c
index 7cdb171..a717171 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -39,7 +39,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce,
=20
 /* changes that can be kept in $GIT_DIR/index (basically all extension=
s) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
-		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED)
+		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED)
=20
 struct index_state the_index;
 static const char *alternate_index_output;
@@ -54,9 +54,11 @@ static void replace_index_entry(struct index_state *=
istate, int nr, struct cache
 {
 	struct cache_entry *old =3D istate->cache[nr];
=20
+	replace_index_entry_in_base(istate, old, ce);
 	remove_name_hash(istate, old);
 	free(old);
 	set_index_entry(istate, nr, ce);
+	ce->ce_flags |=3D CE_UPDATE_IN_BASE;
 	istate->cache_changed |=3D CE_ENTRY_CHANGED;
 }
=20
@@ -1192,6 +1194,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags,
 				 * means the index is not valid anymore.
 				 */
 				ce->ce_flags &=3D ~CE_VALID;
+				ce->ce_flags |=3D CE_UPDATE_IN_BASE;
 				istate->cache_changed |=3D CE_ENTRY_CHANGED;
 			}
 			if (quiet)
diff --git a/split-index.c b/split-index.c
index 2bb5d55..b36c73b 100644
--- a/split-index.c
+++ b/split-index.c
@@ -100,3 +100,18 @@ void save_or_free_index_entry(struct index_state *=
istate, struct cache_entry *ce
 	else
 		free(ce);
 }
+
+void replace_index_entry_in_base(struct index_state *istate,
+				 struct cache_entry *old,
+				 struct cache_entry *new)
+{
+	if (old->index &&
+	    istate->split_index &&
+	    istate->split_index->base &&
+	    old->index <=3D istate->split_index->base->cache_nr) {
+		new->index =3D old->index;
+		if (old !=3D istate->split_index->base->cache[new->index - 1])
+			free(istate->split_index->base->cache[new->index - 1]);
+		istate->split_index->base->cache[new->index - 1] =3D new;
+	}
+}
diff --git a/split-index.h b/split-index.h
index 5302118..812e510 100644
--- a/split-index.h
+++ b/split-index.h
@@ -13,6 +13,9 @@ struct split_index {
=20
 struct split_index *init_split_index(struct index_state *istate);
 void save_or_free_index_entry(struct index_state *istate, struct cache=
_entry *ce);
+void replace_index_entry_in_base(struct index_state *istate,
+				 struct cache_entry *old,
+				 struct cache_entry *new);
 int read_link_extension(struct index_state *istate,
 			const void *data, unsigned long sz);
 int write_link_extension(struct strbuf *sb,
diff --git a/unpack-trees.c b/unpack-trees.c
index a941f7c..4a9cdf2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -257,8 +257,10 @@ static int apply_sparse_checkout(struct index_stat=
e *istate,
 		ce->ce_flags |=3D CE_SKIP_WORKTREE;
 	else
 		ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
-	if (was_skip_worktree !=3D ce_skip_worktree(ce))
+	if (was_skip_worktree !=3D ce_skip_worktree(ce)) {
+		ce->ce_flags |=3D CE_UPDATE_IN_BASE;
 		istate->cache_changed |=3D CE_ENTRY_CHANGED;
+	}
=20
 	/*
 	 * if (!was_skip_worktree && !ce_skip_worktree()) {
--=20
1.9.1.346.ga2b5940
