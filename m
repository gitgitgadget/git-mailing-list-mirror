From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 09/28] shallow.c: steps 6 and 7 to select new commits for .git/shallow
Date: Thu,  5 Dec 2013 20:02:36 +0700
Message-ID: <1386248575-10206-10-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:59:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYWU-0001mp-Rh
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164Ab3LEM7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:59:14 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:49370 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156Ab3LEM7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:59:12 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so25810381pbc.35
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=y7w66uh3wIBGowQ3lvXODRI9OW9DkBQBj6bKk0Mk30w=;
        b=Ekip04PqpTbj6VZDzypJvG5rkaqBHrcCC19MJJ2W4q3uHmzJPelac8ElNdPk9dsaUx
         yEmlPVqevbRF9aaFfzkoJk0qrHi1iwXyFw5vjR6+Rq8GooZHZjRLks3HaeEUtwmRPdms
         oUERbD/h+Oe+Kz+fumRK94BKbeJfX0K2CzisxV0F3Ud0nf7hnzdnA5FKRGokGiHALBcs
         ODN4TqpKAL3bUTaqtu5/w+ZBtPOgdazwykpzPl7W1pR2EM5S+w9Yluk6E5Rs+JgUVGBw
         9XxD4EBRaCHWtbQuiqS6h0JHZOB1LgouPzLFiQrQOYqVAEWbguDnQhwAnoHxbUTbop+q
         ykYw==
X-Received: by 10.67.30.70 with SMTP id kc6mr87745787pad.32.1386248352365;
        Thu, 05 Dec 2013 04:59:12 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id om6sm54837852pbc.43.2013.12.05.04.59.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:59:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:03:55 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238865>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h  |   3 +
 shallow.c | 295 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 298 insertions(+)

diff --git a/commit.h b/commit.h
index 9ead93b..69bca3e 100644
--- a/commit.h
+++ b/commit.h
@@ -223,6 +223,9 @@ extern void clear_shallow_info(struct shallow_info =
*);
 extern void remove_nonexistent_theirs_shallow(struct shallow_info *);
 extern void remove_nonexistent_ours_in_pack(struct shallow_info *,
 					    struct packed_git *);
+extern void assign_shallow_commits_to_refs(struct shallow_info *info,
+					   uint32_t **used,
+					   int *ref_status);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/shallow.c b/shallow.c
index a6547ca..975d699 100644
--- a/shallow.c
+++ b/shallow.c
@@ -317,3 +317,298 @@ void remove_nonexistent_ours_in_pack(struct shall=
ow_info *info,
 	}
 	info->nr_ours =3D dst;
 }
+
+define_commit_slab(ref_bitmap, uint32_t *);
+
+struct paint_info {
+	struct ref_bitmap ref_bitmap;
+	unsigned nr_bits;
+	char **slab;
+	char *free, *end;
+	unsigned slab_count;
+};
+
+static uint32_t *paint_alloc(struct paint_info *info)
+{
+	unsigned nr =3D (info->nr_bits + 31) / 32;
+	unsigned size =3D nr * sizeof(uint32_t);
+	void *p;
+	if (!info->slab_count || info->free + size > info->end) {
+		info->slab_count++;
+		info->slab =3D xrealloc(info->slab,
+				      info->slab_count * sizeof(*info->slab));
+		info->free =3D xmalloc(COMMIT_SLAB_SIZE);
+		info->slab[info->slab_count - 1] =3D info->free;
+		info->end =3D info->free + COMMIT_SLAB_SIZE;
+	}
+	p =3D info->free;
+	info->free +=3D size;
+	return p;
+}
+
+/*
+ * Given a commit SHA-1, walk down to parents until either SEEN,
+ * UNINTERESTING or BOTTOM is hit. Set the id-th bit in ref_bitmap for
+ * all walked commits.
+ */
+static void paint_down(struct paint_info *info, const unsigned char *s=
ha1,
+		       int id)
+{
+	unsigned int i, nr;
+	struct commit_list *head =3D NULL;
+	int bitmap_nr =3D (info->nr_bits + 31) / 32;
+	int bitmap_size =3D bitmap_nr * sizeof(uint32_t);
+	uint32_t *tmp =3D xmalloc(bitmap_size); /* to be freed before return =
*/
+	uint32_t *bitmap =3D paint_alloc(info);
+	struct commit *c =3D lookup_commit_reference_gently(sha1, 1);
+	if (!c)
+		return;
+	memset(bitmap, 0, bitmap_size);
+	bitmap[id / 32] |=3D (1 << (id % 32));
+	commit_list_insert(c, &head);
+	while (head) {
+		struct commit_list *p;
+		struct commit *c =3D head->item;
+		uint32_t **refs =3D ref_bitmap_at(&info->ref_bitmap, c);
+
+		p =3D head;
+		head =3D head->next;
+		free(p);
+
+		/* XXX check "UNINTERESTING" from pack bitmaps if available */
+		if (c->object.flags & (SEEN | UNINTERESTING))
+			continue;
+		else
+			c->object.flags |=3D SEEN;
+
+		if (*refs =3D=3D NULL)
+			*refs =3D bitmap;
+		else {
+			memcpy(tmp, *refs, bitmap_size);
+			for (i =3D 0; i < bitmap_nr; i++)
+				tmp[i] |=3D bitmap[i];
+			if (memcmp(tmp, *refs, bitmap_size)) {
+				*refs =3D paint_alloc(info);
+				memcpy(*refs, tmp, bitmap_size);
+			}
+		}
+
+		if (c->object.flags & BOTTOM)
+			continue;
+
+		if (parse_commit(c))
+			die("unable to parse commit %s",
+			    sha1_to_hex(c->object.sha1));
+
+		for (p =3D c->parents; p; p =3D p->next) {
+			uint32_t **p_refs =3D ref_bitmap_at(&info->ref_bitmap,
+							  p->item);
+			if (p->item->object.flags & SEEN)
+				continue;
+			if (*p_refs =3D=3D NULL || *p_refs =3D=3D *refs)
+				*p_refs =3D *refs;
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
+}
+
+static int mark_uninteresting(const char *refname,
+			      const unsigned char *sha1,
+			      int flags, void *cb_data)
+{
+	struct commit *commit =3D lookup_commit_reference_gently(sha1, 1);
+	if (!commit)
+		return 0;
+	commit->object.flags |=3D UNINTERESTING;
+	mark_parents_uninteresting(commit);
+	return 0;
+}
+
+static void post_assign_shallow(struct shallow_info *info,
+				struct ref_bitmap *ref_bitmap,
+				int *ref_status);
+/*
+ * Step 6(+7), associate shallow commits with new refs
+ *
+ * info->ref must be initialized before calling this function.
+ *
+ * If used is not NULL, it's an array of info->shallow->nr
+ * bitmaps. The n-th bit set in the m-th bitmap if ref[n] needs the
+ * m-th shallow commit from info->shallow.
+ *
+ * If used is NULL, "ours" and "theirs" are updated. And if ref_status
+ * is not NULL it's an array of ref->nr ints. ref_status[i] is true if
+ * the ref needs some shallow commits from either info->ours or
+ * info->theirs.
+ */
+void assign_shallow_commits_to_refs(struct shallow_info *info,
+				    uint32_t **used, int *ref_status)
+{
+	unsigned char (*sha1)[20] =3D info->shallow->sha1;
+	struct sha1_array *ref =3D info->ref;
+	unsigned int i, nr;
+	int *shallow, nr_shallow =3D 0;
+	struct paint_info pi;
+
+	trace_printf_key(TRACE_KEY, "shallow: assign_shallow_commits_to_refs\=
n");
+	shallow =3D xmalloc(sizeof(*shallow) * (info->nr_ours + info->nr_thei=
rs));
+	for (i =3D 0; i < info->nr_ours; i++)
+		shallow[nr_shallow++] =3D info->ours[i];
+	for (i =3D 0; i < info->nr_theirs; i++)
+		shallow[nr_shallow++] =3D info->theirs[i];
+
+	/*
+	 * Prepare the commit graph to track what refs can reach what
+	 * (new) shallow commits.
+	 */
+	nr =3D get_max_object_index();
+	for (i =3D 0; i < nr; i++) {
+		struct object *o =3D get_indexed_object(i);
+		if (!o || o->type !=3D OBJ_COMMIT)
+			continue;
+
+		o->flags &=3D ~(UNINTERESTING | BOTTOM | SEEN);
+	}
+
+	memset(&pi, 0, sizeof(pi));
+	init_ref_bitmap(&pi.ref_bitmap);
+	pi.nr_bits =3D ref->nr;
+
+	/*
+	 * "--not --all" to cut short the traversal if new refs
+	 * connect to old refs. If not (e.g. force ref updates) it'll
+	 * have to go down to the current shallow commits.
+	 */
+	head_ref(mark_uninteresting, NULL);
+	for_each_ref(mark_uninteresting, NULL);
+
+	/* Mark potential bottoms so we won't go out of bound */
+	for (i =3D 0; i < nr_shallow; i++) {
+		struct commit *c =3D lookup_commit(sha1[shallow[i]]);
+		c->object.flags |=3D BOTTOM;
+	}
+
+	for (i =3D 0; i < ref->nr; i++)
+		paint_down(&pi, ref->sha1[i], i);
+
+	if (used) {
+		int bitmap_size =3D ((pi.nr_bits + 31) / 32) * sizeof(uint32_t);
+		memset(used, 0, sizeof(*used) * info->shallow->nr);
+		for (i =3D 0; i < nr_shallow; i++) {
+			const struct commit *c =3D lookup_commit(sha1[shallow[i]]);
+			uint32_t **map =3D ref_bitmap_at(&pi.ref_bitmap, c);
+			if (*map)
+				used[shallow[i]] =3D xmemdupz(*map, bitmap_size);
+		}
+		/*
+		 * unreachable shallow commits are not removed from
+		 * "ours" and "theirs". The user is supposed to run
+		 * step 7 on every ref separately and not trust "ours"
+		 * and "theirs" any more.
+		 */
+	} else
+		post_assign_shallow(info, &pi.ref_bitmap, ref_status);
+
+	clear_ref_bitmap(&pi.ref_bitmap);
+	for (i =3D 0; i < pi.slab_count; i++)
+		free(pi.slab[i]);
+	free(pi.slab);
+	free(shallow);
+}
+
+struct commit_array {
+	struct commit **commits;
+	int nr, alloc;
+};
+
+static int add_ref(const char *refname,
+		   const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct commit_array *ca =3D cb_data;
+	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
+	ca->commits[ca->nr] =3D lookup_commit_reference_gently(sha1, 1);
+	if (ca->commits[ca->nr])
+		ca->nr++;
+	return 0;
+}
+
+static void update_refstatus(int *ref_status, int nr, uint32_t *bitmap=
)
+{
+	int i;
+	if (!ref_status)
+		return;
+	for (i =3D 0; i < nr; i++)
+		if (bitmap[i / 32] & (1 << (i % 32)))
+			ref_status[i]++;
+}
+
+/*
+ * Step 7, reachability test on "ours" at commit level
+ */
+static void post_assign_shallow(struct shallow_info *info,
+				struct ref_bitmap *ref_bitmap,
+				int *ref_status)
+{
+	unsigned char (*sha1)[20] =3D info->shallow->sha1;
+	struct commit *c;
+	uint32_t **bitmap;
+	int dst, i, j;
+	int bitmap_nr =3D (info->ref->nr + 31) / 32;
+	struct commit_array ca;
+
+	trace_printf_key(TRACE_KEY, "shallow: post_assign_shallow\n");
+	if (ref_status)
+		memset(ref_status, 0, sizeof(*ref_status) * info->ref->nr);
+
+	/* Remove unreachable shallow commits from "theirs" */
+	for (i =3D dst =3D 0; i < info->nr_theirs; i++) {
+		if (i !=3D dst)
+			info->theirs[dst] =3D info->theirs[i];
+		c =3D lookup_commit(sha1[info->theirs[i]]);
+		bitmap =3D ref_bitmap_at(ref_bitmap, c);
+		if (!*bitmap)
+			continue;
+		for (j =3D 0; j < bitmap_nr; j++)
+			if (bitmap[0][j]) {
+				update_refstatus(ref_status, info->ref->nr, *bitmap);
+				dst++;
+				break;
+			}
+	}
+	info->nr_theirs =3D dst;
+
+	memset(&ca, 0, sizeof(ca));
+	head_ref(add_ref, &ca);
+	for_each_ref(add_ref, &ca);
+
+	/* Remove unreachable shallow commits from "ours" */
+	for (i =3D dst =3D 0; i < info->nr_ours; i++) {
+		if (i !=3D dst)
+			info->ours[dst] =3D info->ours[i];
+		c =3D lookup_commit(sha1[info->ours[i]]);
+		bitmap =3D ref_bitmap_at(ref_bitmap, c);
+		if (!*bitmap)
+			continue;
+		for (j =3D 0; j < bitmap_nr; j++)
+			if (bitmap[0][j] &&
+			    /* Step 7, reachability test at commit level */
+			    !in_merge_bases_many(c, ca.nr, ca.commits)) {
+				update_refstatus(ref_status, info->ref->nr, *bitmap);
+				dst++;
+				break;
+			}
+	}
+	info->nr_ours =3D dst;
+
+	free(ca.commits);
+}
--=20
1.8.5.1.25.g8667982
