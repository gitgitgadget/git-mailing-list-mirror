From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] Support multithread in traverse_commit_list and rev-list
Date: Tue, 10 Apr 2012 21:39:31 +0700
Message-ID: <1334068771-32725-6-git-send-email-pclouds@gmail.com>
References: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 16:43:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHcI1-0007Q6-4f
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 16:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758928Ab2DJOnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 10:43:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52722 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab2DJOnT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 10:43:19 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so45834pbc.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Yj1Fi9FV+mMnkvsoGDcSl29SEdbC7/eqpmAhp7BUK1M=;
        b=YpgrNvj5bK9rc6kwCAA3Apc3m+UDQnhFjs5NwScTktPj2lI6ON3rr4xLJgvL8xT3im
         03ITMMn/q7h8ek6R/VZz407bK3r3LUgQUPJaFgT4aNuVb1G741QSNlnVx1PlLlCq858R
         XGRuI+gz/xiSEWYtWmfwq0ICFXULdiZJQU2R2jmEViRdlOJTYSEMXKwgHvRDzk932c0l
         QSi93zhKZPEl9bKJYvYz5yenBUCBaNnvs28Uvx+QR8M9yQqjbys+eFPiLoo1uzPMj68I
         QNDYrwI0phhGKI3q+IuumXFgfoV+i4d7VPoSg33s4b1n7bkdQsqS/NnBk2eE/WtF3b6a
         ne2g==
Received: by 10.68.189.231 with SMTP id gl7mr29298683pbc.151.1334068998162;
        Tue, 10 Apr 2012 07:43:18 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.33.136])
        by mx.google.com with ESMTPS id d6sm59879pbi.23.2012.04.10.07.43.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 07:43:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Apr 2012 21:40:17 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195090>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rev-list.c |    3 +-
 list-objects.c     |  153 ++++++++++++++++++++++++++++++++++++++++++++=
+++++--
 revision.c         |   16 ++++++
 revision.h         |    2 +
 4 files changed, 167 insertions(+), 7 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index e720561..e07ba40 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -395,7 +395,8 @@ int cmd_rev_list(int argc, const char **argv, const=
 char *prefix)
 			return show_bisect_vars(&info, reaches, all);
 	}
=20
-	traverse_commit_list(&revs, show_commit, show_object, &info, 0);
+	traverse_commit_list(&revs, show_commit, show_object, &info,
+			     getenv("REV_LIST") ? 2 : 0);
=20
 	if (revs.count) {
 		if (revs.left_right && revs.cherry_mark)
diff --git a/list-objects.c b/list-objects.c
index 4f365e8..59a7c33 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -7,6 +7,29 @@
 #include "tree-walk.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "semaphore.h"
+
+struct thread_data {
+	pthread_t thread;
+	pthread_mutex_t mutex;
+	sem_t sem;
+
+	struct rev_info *revs;
+	struct tree *tree;
+	show_object_fn show;
+	struct name_path *path;
+	struct strbuf base;
+	const char *name;
+	void *cb_data;
+};
+
+static struct thread_data *threads;
+static int nr_threads;
+static pthread_mutex_t obj_lock;
+static int done;
+
+#define LOCK_OBJ() { if (nr_threads) pthread_mutex_lock(&obj_lock); }
+#define UNLOCK_OBJ() { if (nr_threads) pthread_mutex_unlock(&obj_lock)=
; }
=20
 static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
@@ -21,10 +44,14 @@ static void process_blob(struct rev_info *revs,
 		return;
 	if (!obj)
 		die("bad blob object");
-	if (obj->flags & (UNINTERESTING | SEEN))
+	LOCK_OBJ();
+	if (obj->flags & (UNINTERESTING | SEEN)) {
+		UNLOCK_OBJ();
 		return;
+	}
 	obj->flags |=3D SEEN;
 	show(obj, path, name, cb_data);
+	UNLOCK_OBJ();
 }
=20
 /*
@@ -79,12 +106,20 @@ static void process_tree(struct rev_info *revs,
 		return;
 	if (!obj)
 		die("bad tree object");
-	if (obj->flags & (UNINTERESTING | SEEN))
+
+	LOCK_OBJ();
+	if (obj->flags & (UNINTERESTING | SEEN)) {
+		UNLOCK_OBJ();
 		return;
+	}
+	obj->flags |=3D SEEN;
+	UNLOCK_OBJ();
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
-	obj->flags |=3D SEEN;
+	LOCK_OBJ();
 	show(obj, path, name, cb_data);
+	UNLOCK_OBJ();
+
 	me.up =3D path;
 	me.elem =3D name;
 	me.elem_len =3D strlen(name);
@@ -167,6 +202,80 @@ static void add_pending_tree(struct rev_info *revs=
, struct tree *tree)
 	add_pending_object(revs, &tree->object, "");
 }
=20
+static void *woodchipper(void *arg)
+{
+	struct thread_data *data =3D arg;
+	struct tree *tree;
+
+	init_pack_context();
+
+	while (!done) {
+		pthread_mutex_lock(&data->mutex);
+		tree =3D data->tree;
+		pthread_mutex_unlock(&data->mutex);
+		if (!tree) {
+			sem_wait(&data->sem);
+			continue;
+		}
+
+		process_tree(data->revs, tree, data->show, data->path,
+			     &data->base, data->name, data->cb_data);
+		free(data->path);
+		strbuf_reset(&data->base);
+
+		pthread_mutex_lock(&data->mutex);
+		data->tree =3D NULL;
+		pthread_mutex_unlock(&data->mutex);
+
+		sem_wait(&data->sem);
+	}
+	return NULL;
+}
+
+static void distribute_tree(struct rev_info *revs,
+			    struct tree *tree,
+			    show_object_fn show,
+			    struct name_path *path,
+			    struct strbuf *base,
+			    const char *name,
+			    void *cb_data)
+{
+	int i =3D 0;
+
+	while (nr_threads && i < nr_threads) {
+		struct tree *old_tree;
+		struct thread_data *thr =3D threads + i;
+		pthread_mutex_lock(&thr->mutex);
+		old_tree =3D thr->tree;
+		pthread_mutex_unlock(&thr->mutex);
+#if 0
+		if (old_tree) {
+			i =3D (i + 1) % nr_threads;
+			sched_yield();
+			continue;
+		}
+#else
+		if (old_tree) {
+			i++;
+			continue;
+		}
+#endif
+
+		/* the thread must be asleep, or going to sleep by now */
+		thr->revs =3D revs;
+		thr->tree =3D tree;
+		thr->show =3D show;
+		thr->path =3D dup_name_path(path);
+		strbuf_addbuf(&thr->base, base);
+		thr->name =3D name;
+		thr->cb_data =3D cb_data;
+		sem_post(&thr->sem);
+		return;
+	}
+
+	process_tree(revs, tree, show, path, base, name, cb_data);
+}
+
 void traverse_commit_list(struct rev_info *revs,
 			  show_commit_fn show_commit,
 			  show_object_fn show_object,
@@ -186,20 +295,45 @@ void traverse_commit_list(struct rev_info *revs,
 			add_pending_tree(revs, commit->tree);
 		show_commit(commit, data);
 	}
+
+	nr_threads =3D nr_threads_;
+	if (nr_threads) {
+		threads =3D xmalloc((sizeof*threads) * nr_threads);
+		memset(threads, 0, sizeof(*threads) * nr_threads);
+		pthread_mutex_init(&obj_lock, NULL);
+		done =3D 0;
+		for (i =3D 0; i < nr_threads; i++) {
+			threads[i].tree =3D NULL;
+			strbuf_init(&threads[i].base, PATH_MAX);
+			pthread_mutex_init(&threads[i].mutex, NULL);
+			sem_init(&threads[i].sem, 0, 0);
+			pthread_create(&threads[i].thread, NULL, woodchipper, threads + i);
+		}
+
+		pthread_mutex_init(&mtx, NULL);
+		multithread_object_access =3D 1;
+	}
+
 	for (i =3D 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending =3D revs->pending.objects + i;
 		struct object *obj =3D pending->item;
 		const char *name =3D pending->name;
-		if (obj->flags & (UNINTERESTING | SEEN))
+		LOCK_OBJ();
+		if (obj->flags & (UNINTERESTING | SEEN)) {
+			UNLOCK_OBJ();
 			continue;
+		}
+		UNLOCK_OBJ();
 		if (obj->type =3D=3D OBJ_TAG) {
+			LOCK_OBJ();
 			obj->flags |=3D SEEN;
 			show_object(obj, NULL, name, data);
+			UNLOCK_OBJ();
 			continue;
 		}
 		if (obj->type =3D=3D OBJ_TREE) {
-			process_tree(revs, (struct tree *)obj, show_object,
-				     NULL, &base, name, data);
+			distribute_tree(revs, (struct tree *)obj, show_object,
+					NULL, &base, name, data);
 			continue;
 		}
 		if (obj->type =3D=3D OBJ_BLOB) {
@@ -210,6 +344,13 @@ void traverse_commit_list(struct rev_info *revs,
 		die("unknown pending object %s (%s)",
 		    sha1_to_hex(obj->sha1), name);
 	}
+	if (nr_threads) {
+		done =3D 1;
+		for (i =3D 0; i < nr_threads; i++) {
+			sem_post(&threads[i].sem);
+			pthread_join(threads[i].thread, NULL);
+		}
+	}
 	if (revs->pending.nr) {
 		free(revs->pending.objects);
 		revs->pending.nr =3D 0;
diff --git a/revision.c b/revision.c
index b3554ed..40b6e15 100644
--- a/revision.c
+++ b/revision.c
@@ -40,6 +40,22 @@ char *path_name(const struct name_path *path, const =
char *name)
 	return n;
 }
=20
+struct name_path *dup_name_path(const struct name_path *path)
+{
+	const struct name_path *src;
+	struct name_path *dup, *dst;
+	int len;
+	for (len =3D 0, src =3D path; src; src =3D src->up)
+		len++;
+	dup =3D xmalloc(sizeof(*dup) * len);
+	for (src =3D path, dst =3D dup; src; src =3D src->up, dst++) {
+		memcpy(dst, src, sizeof(*src));
+		if (dst > dup)
+			dst[-1].up =3D dst;
+	}
+	return dup;
+}
+
 static int show_path_component_truncated(FILE *out, const char *name, =
int len)
 {
 	int cnt;
diff --git a/revision.h b/revision.h
index b8e9223..0da4636 100644
--- a/revision.h
+++ b/revision.h
@@ -208,6 +208,8 @@ struct name_path {
=20
 char *path_name(const struct name_path *path, const char *name);
=20
+struct name_path *dup_name_path(const struct name_path *);
+
 extern void show_object_with_name(FILE *, struct object *, const struc=
t name_path *, const char *);
=20
 extern void add_object(struct object *obj,
--=20
1.7.8.36.g69ee2
