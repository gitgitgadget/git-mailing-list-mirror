From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/28] shallow.c: add mark_new_shallow_refs()
Date: Mon, 25 Nov 2013 10:55:34 +0700
Message-ID: <1385351754-9954-9-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:52:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknDh-0001mj-FY
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab3KYDwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:52:16 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:48822 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab3KYDwP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:52:15 -0500
Received: by mail-pd0-f174.google.com with SMTP id y13so4584735pdi.5
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=392tj45tMSXqo0CfcUn19W1FPJ/DWLdzxA10F+72CvQ=;
        b=Tkl+kpO3To55MyCkXK7Xsa8t3g3Ai8qmMHu9Q0MaPqzomhkvOBTrr9L82GMDo5gHnp
         IOcDekMrM8e6BJAl+pscj33UtT8nEKJv74ZurC6Slc+CRCWtXKTr784GPbvIE8DHbDih
         WCaSBvWkkkwqyH7fLPK19ZFR5OzrYI0BqIi22D5qa87nuWAuSW4FLtwtCIA1h7ReUbii
         4ixK9leJPZhX2aGqN86A+L+QclfcDwkWOIivz5C9tMBo5qKbK+du4Q1pT93xUm5jbhWD
         1gowsoYF3acM2g9zK9uhGIhAplegwH7GNuwbh6Enibb7Gof5Ravs246MH+AffIh577kh
         hRtA==
X-Received: by 10.68.219.167 with SMTP id pp7mr5625611pbc.125.1385351534649;
        Sun, 24 Nov 2013 19:52:14 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id oj6sm79024478pab.9.2013.11.24.19.52.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:52:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:56:47 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238280>

When we receive a pack and the shallow points from another repository,
we may need to add more shallow points to current repo to make sure no
commits point to nowhere. But usually we don't want to do so because
(in future) new shallow points invalidate pack bitmaps and we need to
rebuild them again, which is not cheap.

So the default way is we allow ref updates that do not introduce new
shallow points and mark the others. If the user is fine with new
shallow point addition, we accept the marked refs.

But even so we do not blindly accept all shallow points provided. Some
of them might not point to any commits in the new pack. Some might
even do, but those might be unreachable object islands. Only shallow
points that are reachable from old and new refs can stay.

The way it's implemented is paint down from each ref, attach a bitmap
to each commit where one bit represents one ref. In order to avoid
allocating new bitmap for every commit, we try to reuse the same
bitmap for parent commits if possible. This reduces allocation and
leaks deliberately because it's hard to keep/time consuming track how
many pointers to the same buffer.

In a typical push or fetch, the new pack should not carry new shallow
roots. If the current repo does not have any commit islands refered by
the sender's shallow roots either, this function is just a few
has_sha1_file(). So quite cheap.

Once the sender diverts from that path (or the receiver detects
shallow roots attached to commit islands from remove_reachable_shallow_=
points),
it'll be a lot more expensive. Pack bitmaps won't help this kind of
commit traversal, but commit cache might.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h  |   4 ++
 shallow.c | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 223 insertions(+)

diff --git a/commit.h b/commit.h
index 98044e6..e1fd587 100644
--- a/commit.h
+++ b/commit.h
@@ -194,6 +194,7 @@ extern struct commit_list *get_octopus_merge_bases(=
struct commit_list *in);
 #define INFINITE_DEPTH 0x7fffffff
=20
 struct extra_have_objects;
+struct ref;
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
@@ -209,6 +210,9 @@ extern char *setup_temporary_shallow(void);
 extern void advertise_shallow_grafts(int);
 extern void remove_reachable_shallow_points(struct extra_have_objects =
*out,
 					    const struct extra_have_objects *in);
+extern int mark_new_shallow_refs(const struct extra_have_objects *ref,
+				 int *ref_status, uint32_t **used,
+				 const struct extra_have_objects *shallow);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/shallow.c b/shallow.c
index a974d2d..c92a1dc 100644
--- a/shallow.c
+++ b/shallow.c
@@ -4,6 +4,8 @@
 #include "pkt-line.h"
 #include "remote.h"
 #include "refs.h"
+#include "diff.h"
+#include "revision.h"
=20
 static int is_shallow =3D -1;
 static struct stat shallow_stat;
@@ -280,3 +282,220 @@ void remove_reachable_shallow_points(struct extra=
_have_objects *out,
 	}
 	free(ca.commits);
 }
+
+static int paint_down(const unsigned char *sha1, int id, int nr_bits, =
int quick)
+{
+	int hit_bottom =3D 0;
+	unsigned int i, nr;
+	struct commit_list *head =3D NULL;
+	int bitmap_nr =3D (nr_bits + 31) / 32;
+	int bitmap_size =3D bitmap_nr * sizeof(uint32_t);
+	uint32_t *tmp =3D xmalloc(bitmap_size);
+	uint32_t *bitmap =3D xcalloc(bitmap_size, sizeof(uint32_t));
+	bitmap[id / 32] |=3D (1 << (id % 32));
+	commit_list_insert(lookup_commit(sha1), &head);
+	while (head) {
+		struct commit_list *p;
+		struct commit *c =3D head->item;
+		uint32_t *c_util =3D c->util;
+
+		p =3D head;
+		head =3D head->next;
+		free(p);
+
+		if (c->object.flags & (SEEN | UNINTERESTING))
+			continue;
+		else
+			c->object.flags |=3D SEEN;
+
+		if (c->util =3D=3D NULL)
+			c->util =3D bitmap;
+		else {
+			/*
+			 * Deliberately leak a lot in commit->util
+			 * because there can be many pointers to the
+			 * same bitmap. Probably should allocate in a
+			 * pool and free the whole pool at the end.
+			 */
+			memcpy(tmp, c_util, bitmap_size);
+			for (i =3D 0; i < bitmap_nr; i++)
+				tmp[i] |=3D bitmap[i];
+			if (memcmp(tmp, c_util, bitmap_size)) {
+				c->util =3D xmalloc(bitmap_size);
+				memcpy(c->util, tmp, bitmap_size);
+			}
+		}
+
+		if (c->object.flags & BOTTOM) {
+			hit_bottom =3D 1;
+			if (quick) {
+				free_commit_list(head);
+				break;
+			} else
+				continue;
+		}
+
+		if (parse_commit(c))
+			die("unable to parse commit %s",
+			    sha1_to_hex(c->object.sha1));
+
+		for (p =3D c->parents; p; p =3D p->next) {
+			if (p->item->object.flags & SEEN)
+				continue;
+			if (p->item->util =3D=3D NULL || p->item->util =3D=3D c_util)
+				p->item->util =3D c->util;
+			commit_list_insert(p->item, &head);
+		}
+	}
+
+	nr =3D get_max_object_index();
+	for (i =3D 0; i < nr; i++) {
+		struct object *o =3D get_indexed_object(i);
+		if (o && o->type =3D=3D OBJ_COMMIT) {
+			o->flags &=3D ~SEEN;
+		}
+	}
+
+	free(tmp);
+	return hit_bottom;
+}
+
+static int mark_uninteresting(const char *refname,
+			      const unsigned char *sha1,
+			      int flags, void *cb_data)
+{
+	struct commit *commit =3D lookup_commit(sha1);
+	commit->object.flags |=3D UNINTERESTING;
+	mark_parents_uninteresting(commit);
+	return 0;
+}
+
+struct saved_util {
+	unsigned char sha1[20];
+	void *util;
+};
+
+/*
+ * Given a set of refs and shallow roots, find out what ref can reach
+ * any of the given roots. If so mark that ref "reject_flag". If
+ * "used" is not NULL, mark all reachable roots. Return how many refs
+ * that need new shallow points.
+ */
+int mark_new_shallow_refs(const struct extra_have_objects *ref,
+			  int *ref_status, uint32_t **used,
+			  const struct extra_have_objects *shallow)
+{
+	struct saved_util *util =3D NULL;
+	unsigned int i, nr, ret =3D 0, nr_util =3D 0, alloc_util =3D 0;
+
+	/*
+	 * Quick check to see if we may need to add new shallow
+	 * roots. Go through the list of root candidates and check if
+	 * they exist (either in current repo, or in the new pack, we
+	 * can't distinguish).
+	 *
+	 * 1) If none of the new roots exist, the pack must connect to
+	 *    the main object graph, which is already guarded by
+	 *    current repo's shallow roots and we will not need to
+	 *    consider adding new shallow roots, so we can exit early.
+	 *
+	 * 2) The pack may connect to some existing object islands in
+	 *    current repo then add shallow roots to plug loose ends
+	 *    from those islands. In that case, new shallow roots must
+	 *    also exist in the repo as this stage (old objects plus
+	 *    the new pack).
+	 *
+	 * 3) The last, easiest case, is the pack contains some
+	 *    shallow roots, which may be used to tie up loose ends of
+	 *    some new refs, or redundanty (tying up loose ends of new
+	 *    object islands)
+	 */
+	for (i =3D 0;i < shallow->nr; i++)
+		if (has_sha1_file(shallow->array[i]))
+			break;
+	if (i =3D=3D shallow->nr)
+		/*
+		 * this is the first and also the common case, where
+		 * the new pack does not carry any new shallow
+		 * points. No need to to the expensive commit traverse
+		 * dance below.
+		 */
+		return 0;
+
+	/*
+	 * Prepare the commit graph to track what refs can reach what
+	 * (new) shallow points.
+	 */
+	nr =3D get_max_object_index();
+	for (i =3D 0; i < nr; i++) {
+		struct object *o =3D get_indexed_object(i);
+		struct commit *c =3D (struct commit *)o;
+		if (!o || o->type !=3D OBJ_COMMIT)
+			continue;
+
+		o->flags &=3D ~(UNINTERESTING | BOTTOM | SEEN);
+		/*
+		 * git-fetch makes use of "util" field. Save it and
+		 * restore later. For fetch/clone/push, "nr" should be
+		 * small because rev-list is delayed to pack-objects.
+		 */
+		if (c->util) {
+			ALLOC_GROW(util, nr_util+1, alloc_util);
+			hashcpy(util[nr_util].sha1, o->sha1);
+			util[nr_util].util =3D c->util;
+			nr_util++;
+			c->util =3D NULL;
+		}
+	}
+
+	/*
+	 * "--not --all" to cut short the traversal if new refs
+	 * connect to old refs. If not (e.g. force ref updates) it'll
+	 * have to go down to the current shallow roots.
+	 *
+	 * We could detect that a new commit is connected to an
+	 * existing commit by keeping new objects in a pack (i.e. the
+	 * index-pack code path) then check commit origin. If so stop
+	 * short, so we don't need to get to the bottom. But then it
+	 * will not work for case #2 because we need to go through
+	 * some of our commits before reaching new shallow roots.
+	 */
+	head_ref(mark_uninteresting, NULL);
+	for_each_ref(mark_uninteresting, NULL);
+
+	for (i =3D 0; i < shallow->nr; i++)
+		if (has_sha1_file(shallow->array[i])) {
+			struct commit *c =3D lookup_commit(shallow->array[i]);
+			c->object.flags |=3D BOTTOM;
+		}
+
+	for (i =3D 0; i < ref->nr; i++)
+		if (paint_down(ref->array[i], i, ref->nr, used =3D=3D NULL)) {
+			if (ref_status)
+				ref_status[i] =3D 1;
+			ret++;
+		}
+
+	if (used) {
+		for (i =3D 0; i < shallow->nr; i++) {
+			struct commit *c =3D lookup_commit(shallow->array[i]);
+			used[i] =3D c->util;
+		}
+	}
+
+	if (nr_util) {
+		nr =3D get_max_object_index();
+		for (i =3D 0; i < nr; i++) {
+			struct object *o =3D get_indexed_object(i);
+			if (o && o->type =3D=3D OBJ_COMMIT)
+				((struct commit *)o)->util =3D NULL;
+		}
+		for (i =3D 0; i < nr_util; i++) {
+			struct commit *c =3D lookup_commit(util[i].sha1);
+			c->util =3D util[i].util;
+		}
+		free(util);
+	}
+
+	return ret;
+}
--=20
1.8.2.83.gc99314b
