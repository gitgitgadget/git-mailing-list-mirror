From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] Convert ce_path_match() to use struct pathspec
Date: Mon, 20 Sep 2010 09:29:59 +1000
Message-ID: <1284939000-16907-5-git-send-email-pclouds@gmail.com>
References: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 01:30:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTLD-0001WE-8a
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab0ISXaf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:30:35 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42215 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab0ISXae (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:30:34 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1011131pvg.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=QBnKMBUa17b7A/2+quykMcRgzGH/7b0xLDubJfn7PeU=;
        b=WpBboTXrRFHzsUsFVrl7nvQ7dZkIJBsVrnXEzCn+Ga6gFJOAaxsRItlKpR0EuZhd2I
         zXSICSa8v4gI4lw8QX/HM4fTc73DoI5tLVx1tGlbvRZIZbug4dRpl7uDcF6azUD5Prmb
         BbmgoiEvBC5tpAocaaGdftmm1oqCJYdLg2iSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Hvcj/uAB7c2tX4W3L91Tj1JQtt5E2Htil0VhyUZQ2k8z7ckLRNaQXNGlSJWaKbDIKv
         8KhZSaRU8ohf2s3dr+zFzqfSZB/aS6mfA+cZMWFVoy9Mi9aHuVfgDgAYkGM3yWZ/kGRG
         nw9m/3VM9DfLVDUT8Mfxc846A6nZPFLZJZX+Q=
Received: by 10.114.132.18 with SMTP id f18mr9076576wad.30.1284939034505;
        Sun, 19 Sep 2010 16:30:34 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id s5sm12276524wak.12.2010.09.19.16.30.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:30:33 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:30:28 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156534>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c |    8 ++++++--
 cache.h                |    2 +-
 diff-lib.c             |   10 ++++++++--
 preload-index.c        |    5 ++++-
 read-cache.c           |    8 +++++---
 revision.c             |    5 ++++-
 wt-status.c            |    5 ++++-
 7 files changed, 32 insertions(+), 11 deletions(-)

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
index dc54d16..bf50603 100644
--- a/cache.h
+++ b/cache.h
@@ -505,7 +505,7 @@ struct pathspec {
=20
 extern int init_pathspec(struct pathspec *,const char **);
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
index 3b809f2..63db7f4 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -89,9 +89,11 @@ int run_diff_files(struct rev_info *revs, unsigned i=
nt option)
 	int silent_on_removed =3D option & DIFF_SILENT_ON_REMOVED;
 	unsigned ce_option =3D ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
+	struct pathspec pathspec;
=20
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
=20
+	init_pathspec(&pathspec, revs->prune_data);
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage =3D 2;
 	entries =3D active_nr;
@@ -106,7 +108,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
 			break;
=20
-		if (!ce_path_match(ce, revs->prune_data))
+		if (!ce_path_match(ce, &pathspec))
 			continue;
=20
 		if (ce_stage(ce)) {
@@ -218,6 +220,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 			    ce->name, 0, dirty_submodule);
=20
 	}
+	free_pathspec(&pathspec);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	return 0;
@@ -417,6 +420,7 @@ static int oneway_diff(struct cache_entry **src, st=
ruct unpack_trees_options *o)
 	struct cache_entry *idx =3D src[0];
 	struct cache_entry *tree =3D src[1];
 	struct rev_info *revs =3D o->unpack_data;
+	struct pathspec pathspec;
=20
 	/*
 	 * Unpack-trees generates a DF/conflict entry if
@@ -427,8 +431,10 @@ static int oneway_diff(struct cache_entry **src, s=
truct unpack_trees_options *o)
 	if (tree =3D=3D o->df_conflict_entry)
 		tree =3D NULL;
=20
-	if (ce_path_match(idx ? idx : tree, revs->prune_data))
+	init_pathspec(&pathspec, revs->prune_data);
+	if (ce_path_match(idx ? idx : tree, &pathspec))
 		do_oneway_diff(o, idx, tree);
+	free_pathspec(&pathspec);
=20
 	return 0;
 }
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
index 1f42473..918a90c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -683,17 +683,19 @@ int ce_same_name(struct cache_entry *a, struct ca=
che_entry *b)
 	return ce_namelen(b) =3D=3D len && !memcmp(a->name, b->name, len);
 }
=20
-int ce_path_match(const struct cache_entry *ce, const char **pathspec)
+int ce_path_match(const struct cache_entry *ce, const struct pathspec =
*pathspec)
 {
 	const char *match, *name;
+	const char **p;
 	int len;
=20
-	if (!pathspec)
+	if (!pathspec || !pathspec->nr)
 		return 1;
=20
 	len =3D ce_namelen(ce);
 	name =3D ce->name;
-	while ((match =3D *pathspec++) !=3D NULL) {
+	p =3D pathspec->raw;
+	while ((match =3D *p++) !=3D NULL) {
 		int matchlen =3D strlen(match);
 		if (matchlen > len)
 			continue;
diff --git a/revision.c b/revision.c
index b2a5867..e77184a 100644
--- a/revision.c
+++ b/revision.c
@@ -951,6 +951,7 @@ static void prepare_show_merge(struct rev_info *rev=
s)
 	unsigned char sha1[20];
 	const char **prune =3D NULL;
 	int i, prune_num =3D 1; /* counting terminating NULL */
+	struct pathspec pathspec;
=20
 	if (get_sha1("HEAD", sha1) || !(head =3D lookup_commit(sha1)))
 		die("--merge without HEAD?");
@@ -965,11 +966,12 @@ static void prepare_show_merge(struct rev_info *r=
evs)
=20
 	if (!active_nr)
 		read_cache();
+	init_pathspec(&pathspec, revs->prune_data);
 	for (i =3D 0; i < active_nr; i++) {
 		struct cache_entry *ce =3D active_cache[i];
 		if (!ce_stage(ce))
 			continue;
-		if (ce_path_match(ce, revs->prune_data)) {
+		if (ce_path_match(ce, &pathspec)) {
 			prune_num++;
 			prune =3D xrealloc(prune, sizeof(*prune) * prune_num);
 			prune[prune_num-2] =3D ce->name;
@@ -979,6 +981,7 @@ static void prepare_show_merge(struct rev_info *rev=
s)
 		       ce_same_name(ce, active_cache[i+1]))
 			i++;
 	}
+	free_pathspec(&pathspec);
 	revs->prune_data =3D prune;
 	revs->limited =3D 1;
 }
diff --git a/wt-status.c b/wt-status.c
index 54b6b03..70bd378 100644
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
1.7.1.rc1.70.g788ca
