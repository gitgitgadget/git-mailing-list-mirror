From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/21] Convert ce_path_match() to use struct pathspec
Date: Fri, 17 Dec 2010 19:43:07 +0700
Message-ID: <1292589787-9525-2-git-send-email-pclouds@gmail.com>
References: <AANLkTikKCU==mS5_TdqHstETj=CQ_deHMCJ4xW0r+Sck@mail.gmail.com>
 <1292589787-9525-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 13:44:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTZg0-0002D6-V4
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 13:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082Ab0LQMoX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Dec 2010 07:44:23 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63550 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab0LQMoW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 07:44:22 -0500
Received: by iwn9 with SMTP id 9so681745iwn.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 04:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=V70NYr1i3dpABqfFjNwTphHhTQYCOWO2WgUtrjJfKao=;
        b=b2D7MkfjLK/HirO3MAdeCBmA4vViFztQccfM4PLDeUqlIUV/5EDkzKCq1f90HOS6kO
         TONIU55j9CXvGrK6J7AAKhNMYmj4mG4aqHPmkyes/WtCAd+Dg4NfyjImjtirqtuseRHs
         qCGP2bDioGoNRtXimjuOLQKnvwUrOfIRoNBLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ILaGVvlezKiVdu3Hi5Bq7x4PRLQ2JrQIs3cjZMhElEMBuRqpK3gr0mh5FSAWJi2iUh
         jN1p5WNdvtI4F4m98OD774VAVhK/aO5Cy5Zoj5tRXjPkgJlz84vvjkW+YiSBqOnMGaji
         iXojxiV+qxF//IqAEVDS2TXo9c+XDohrwyJ38=
Received: by 10.42.170.67 with SMTP id e3mr796295icz.264.1292589861202;
        Fri, 17 Dec 2010 04:44:21 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id jv9sm956404icb.13.2010.12.17.04.44.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 04:44:20 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Dec 2010 19:43:24 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292589787-9525-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163875>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The old 14/21. Slightly changed because of rev_info->pathspec change.

 builtin/update-index.c |    8 ++++++--
 cache.h                |    2 +-
 diff-lib.c             |    4 ++--
 preload-index.c        |    5 ++++-
 read-cache.c           |    7 ++++---
 revision.c             |    2 +-
 wt-status.c            |    5 ++++-
 7 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3ab214d..9d1f67e 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -543,7 +543,10 @@ static int do_reupdate(int ac, const char **av,
 	 */
 	int pos;
 	int has_head =3D 1;
-	const char **pathspec =3D get_pathspec(prefix, av + 1);
+	const char **paths =3D get_pathspec(prefix, av + 1);
+	struct pathspec pathspec;
+
+	init_pathspec(&pathspec, paths);
=20
 	if (read_ref("HEAD", head_sha1))
 		/* If there is no HEAD, that means it is an initial
@@ -556,7 +559,7 @@ static int do_reupdate(int ac, const char **av,
 		struct cache_entry *old =3D NULL;
 		int save_nr;
=20
-		if (ce_stage(ce) || !ce_path_match(ce, pathspec))
+		if (ce_stage(ce) || !ce_path_match(ce, &pathspec))
 			continue;
 		if (has_head)
 			old =3D read_one_ent(NULL, head_sha1,
@@ -575,6 +578,7 @@ static int do_reupdate(int ac, const char **av,
 		if (save_nr !=3D active_nr)
 			goto redo;
 	}
+	free_pathspec(&pathspec);
 	return 0;
 }
=20
diff --git a/cache.h b/cache.h
index dc0bfb4..b5cd61c 100644
--- a/cache.h
+++ b/cache.h
@@ -508,7 +508,7 @@ struct pathspec {
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void free_pathspec(struct pathspec *);
-extern int ce_path_match(const struct cache_entry *ce, const char **pa=
thspec);
+extern int ce_path_match(const struct cache_entry *ce, const struct pa=
thspec *pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int =
write_object, enum object_type type, const char *path);
 extern int index_path(unsigned char *sha1, const char *path, struct st=
at *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *=
st);
diff --git a/diff-lib.c b/diff-lib.c
index 2251f3d..1e22992 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -106,7 +106,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
 			break;
=20
-		if (!ce_path_match(ce, revs->prune_data.raw))
+		if (!ce_path_match(ce, &revs->prune_data))
 			continue;
=20
 		if (ce_stage(ce)) {
@@ -427,7 +427,7 @@ static int oneway_diff(struct cache_entry **src, st=
ruct unpack_trees_options *o)
 	if (tree =3D=3D o->df_conflict_entry)
 		tree =3D NULL;
=20
-	if (ce_path_match(idx ? idx : tree, revs->prune_data.raw))
+	if (ce_path_match(idx ? idx : tree, &revs->prune_data))
 		do_oneway_diff(o, idx, tree);
=20
 	return 0;
diff --git a/preload-index.c b/preload-index.c
index e3d0bda..49cb08d 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -35,7 +35,9 @@ static void *preload_thread(void *_data)
 	struct index_state *index =3D p->index;
 	struct cache_entry **cep =3D index->cache + p->offset;
 	struct cache_def cache;
+	struct pathspec pathspec;
=20
+	init_pathspec(&pathspec, p->pathspec);
 	memset(&cache, 0, sizeof(cache));
 	nr =3D p->nr;
 	if (nr + p->offset > index->cache_nr)
@@ -51,7 +53,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ce_uptodate(ce))
 			continue;
-		if (!ce_path_match(ce, p->pathspec))
+		if (!ce_path_match(ce, &pathspec))
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(c=
e)))
 			continue;
@@ -61,6 +63,7 @@ static void *preload_thread(void *_data)
 			continue;
 		ce_mark_uptodate(ce);
 	} while (--nr > 0);
+	free_pathspec(&pathspec);
 	return NULL;
 }
=20
diff --git a/read-cache.c b/read-cache.c
index 1f42473..f1141a3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -683,17 +683,18 @@ int ce_same_name(struct cache_entry *a, struct ca=
che_entry *b)
 	return ce_namelen(b) =3D=3D len && !memcmp(a->name, b->name, len);
 }
=20
-int ce_path_match(const struct cache_entry *ce, const char **pathspec)
+int ce_path_match(const struct cache_entry *ce, const struct pathspec =
*pathspec)
 {
 	const char *match, *name;
+	const char **ps =3D pathspec->raw;
 	int len;
=20
-	if (!pathspec)
+	if (!pathspec->nr)
 		return 1;
=20
 	len =3D ce_namelen(ce);
 	name =3D ce->name;
-	while ((match =3D *pathspec++) !=3D NULL) {
+	while ((match =3D *ps++) !=3D NULL) {
 		int matchlen =3D strlen(match);
 		if (matchlen > len)
 			continue;
diff --git a/revision.c b/revision.c
index 515e2dd..a0d3816 100644
--- a/revision.c
+++ b/revision.c
@@ -969,7 +969,7 @@ static void prepare_show_merge(struct rev_info *rev=
s)
 		struct cache_entry *ce =3D active_cache[i];
 		if (!ce_stage(ce))
 			continue;
-		if (ce_path_match(ce, revs->prune_data.raw)) {
+		if (ce_path_match(ce, &revs->prune_data)) {
 			prune_num++;
 			prune =3D xrealloc(prune, sizeof(*prune) * prune_num);
 			prune[prune_num-2] =3D ce->name;
diff --git a/wt-status.c b/wt-status.c
index 5c6b118..457d265 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -350,14 +350,16 @@ static void wt_status_collect_changes_index(struc=
t wt_status *s)
=20
 static void wt_status_collect_changes_initial(struct wt_status *s)
 {
+	struct pathspec pathspec;
 	int i;
=20
+	init_pathspec(&pathspec, s->pathspec);
 	for (i =3D 0; i < active_nr; i++) {
 		struct string_list_item *it;
 		struct wt_status_change_data *d;
 		struct cache_entry *ce =3D active_cache[i];
=20
-		if (!ce_path_match(ce, s->pathspec))
+		if (!ce_path_match(ce, &pathspec))
 			continue;
 		it =3D string_list_insert(&s->change, ce->name);
 		d =3D it->util;
@@ -372,6 +374,7 @@ static void wt_status_collect_changes_initial(struc=
t wt_status *s)
 		else
 			d->index_status =3D DIFF_STATUS_ADDED;
 	}
+	free_pathspec(&pathspec);
 }
=20
 static void wt_status_collect_untracked(struct wt_status *s)
--=20
1.7.3.3.476.g10a82
