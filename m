From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/32] read-cache: mark updated entries for split index
Date: Fri, 13 Jun 2014 19:19:39 +0700
Message-ID: <1402661991-14977-21-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:22:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQUj-000482-J1
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbaFMMWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:22:05 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:54000 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbaFMMWD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:22:03 -0400
Received: by mail-pd0-f174.google.com with SMTP id y10so2077086pdj.5
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Q+Gs+1OrhV7XWbs9/SAHFh9RWUe1zW5pO53LZSLa4MM=;
        b=gbpErRkC5l+hvTv0WwEcLlkYaLW2x5UIxPgElj1kVJSKFrXrKZnnYriSBjE0I5yWue
         C7rLIIcV2z/8+jkreShYjaWL313G5bZgDQ/+4oGJ8eNZID5Tfbwk+pOjB9PvedgmBuVh
         XdRic6LCPZ3V5hVRbb2LTGE9DOEl1bGf6q9y/A1l8p0VoIid8+UcWcG62SBNlOL0TE4o
         l9MeioSn2mzIe5D1lqqnane7BoqlO8VE5NwCkEtuuHeH+ogDvw4ezG7JtjdkPIUwF0eZ
         GJ0Y4ILvky3VFA5WxeOvjxZCrMLexsPoiOPJ/WldMERTdPgpdfLdihF/vmp6D9MiYWhD
         6glw==
X-Received: by 10.66.102.39 with SMTP id fl7mr2827122pab.43.1402662122809;
        Fri, 13 Jun 2014 05:22:02 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id gg3sm3402787pbc.34.2014.06.13.05.22.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:22:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:22:02 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251576>

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
index 47fe374..295bf9d 100644
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
index c437585..7966fb7 100644
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
