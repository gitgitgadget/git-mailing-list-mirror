From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] Add parse_commit_for_rev() to take advantage of sha1-cache
Date: Tue,  3 Apr 2012 13:55:09 +0700
Message-ID: <1333436109-16526-4-git-send-email-pclouds@gmail.com>
References: <53707c0a-3782-47a4-8a35-da7136ff4822@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 08:56:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SExfO-0004Rk-OU
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 08:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab2DCG4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Apr 2012 02:56:30 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:61507 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab2DCG42 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 02:56:28 -0400
Received: by dake40 with SMTP id e40so3342147dak.11
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=X5Jr2yxHRu8A5l2a5rvwSpSs8/3lnU1hKr5ynWq0On0=;
        b=vWUQOnYQM/RLQ1TL5WNinYV3CiVCIl/JGg4EoI+bybMDCbfnIduIKv6pb0CE/6qC+S
         /lHK35BY0cXgUZUD7H6GgdUUm+paqxOFfyGIKAAfAB6EcMWgiJH25RgCD7hj0OynlDiN
         cOwb+PS3DEb7pYVNZ9q0uloUFE/ttQGQ9z9cew8yiRJyy2UBSivk1b3hV2vEw7Ise7D7
         wRQhCmcK4k4cs0Tr+bAjU1NYluWSEdMWyerFHc/gfRmpEiutfNnxN4CYViTVTSq/B52r
         pntAKWwp9gSvNiAtg01aeiXM8gG6wcvTVDJGPePcAUEiklUPyG7N+TA8wh2EfQDHHiAu
         ZI8w==
Received: by 10.68.218.134 with SMTP id pg6mr26881191pbc.111.1333436188128;
        Mon, 02 Apr 2012 23:56:28 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id z1sm15684470pbc.38.2012.04.02.23.56.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 Apr 2012 23:56:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 03 Apr 2012 13:55:44 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <53707c0a-3782-47a4-8a35-da7136ff4822@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194599>

This function tries to lookup sha1-cache. If it's found, struct commit
is filled, no actual commit parsing is done. Otherwise parse_commit() i=
s
called.

Because sha1-cache only has information enough for rev machinery (tree,
parent and date), this function is hardly suitable for general use.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/reflog.c |    2 +-
 commit.c         |   36 +++++++++++++++++++++++++++++++-----
 commit.h         |    1 +
 log-tree.c       |    2 +-
 revision.c       |   10 +++++-----
 upload-pack.c    |    2 +-
 walker.c         |    2 +-
 7 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 062d7da..b15ff98 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -240,7 +240,7 @@ static void mark_reachable(struct expire_reflog_cb =
*cb)
 		free(entry);
 		if (commit->object.flags & REACHABLE)
 			continue;
-		if (parse_commit(commit))
+		if (parse_commit_limited(commit))
 			continue;
 		commit->object.flags |=3D REACHABLE;
 		if (commit->date < expire_limit) {
diff --git a/commit.c b/commit.c
index 946ea70..aa32658 100644
--- a/commit.c
+++ b/commit.c
@@ -7,6 +7,7 @@
 #include "revision.h"
 #include "notes.h"
 #include "gpg-interface.h"
+#include "sha1_cache.h"
=20
 int save_commit_buffer =3D 1;
=20
@@ -28,7 +29,11 @@ static struct commit *check_commit(struct object *ob=
j,
 struct commit *lookup_commit_reference_gently(const unsigned char *sha=
1,
 					      int quiet)
 {
-	struct object *obj =3D deref_tag(parse_object(sha1), NULL, 0);
+	struct object *obj;
+	struct commit *c =3D lookup_commit(sha1);
+	if (c)
+		return c;
+	obj =3D deref_tag(parse_object(sha1), NULL, 0);
=20
 	if (!obj)
 		return NULL;
@@ -258,6 +263,12 @@ int parse_commit_buffer(struct commit *item, const=
 void *buffer, unsigned long s
=20
 	if (item->object.parsed)
 		return 0;
+
+	if (item->parents) {
+		free_commit_list(item->parents);
+		item->parents =3D NULL;
+	}
+
 	item->object.parsed =3D 1;
 	tail +=3D size;
 	if (tail <=3D bufptr + 46 || memcmp(bufptr, "tree ", 5) || bufptr[45]=
 !=3D '\n')
@@ -332,6 +343,21 @@ int parse_commit(struct commit *item)
 	return ret;
 }
=20
+int parse_commit_limited(struct commit *c)
+{
+	unsigned char tree[20];
+	unsigned char parent[20];
+
+	if (c->object.parsed || c->parents)
+		return 0;
+	if (has_commit_cache(c->object.sha1, tree, parent, &c->date)) {
+		commit_list_insert(lookup_commit(parent), &c->parents);
+		c->tree =3D lookup_tree(tree);
+		return 0;
+	}
+	return parse_commit(c);
+}
+
 int find_commit_subject(const char *commit_buffer, const char **subjec=
t)
 {
 	const char *eol;
@@ -413,7 +439,7 @@ struct commit *pop_most_recent_commit(struct commit=
_list **list,
=20
 	while (parents) {
 		struct commit *commit =3D parents->item;
-		if (!parse_commit(commit) && !(commit->object.flags & mark)) {
+		if (!parse_commit_limited(commit) && !(commit->object.flags & mark))=
 {
 			commit->object.flags |=3D mark;
 			commit_list_insert_by_date(commit, list);
 		}
@@ -605,10 +631,10 @@ static struct commit_list *merge_bases_many(struc=
t commit *one, int n, struct co
 			return commit_list_insert(one, &result);
 	}
=20
-	if (parse_commit(one))
+	if (parse_commit_limited(one))
 		return NULL;
 	for (i =3D 0; i < n; i++) {
-		if (parse_commit(twos[i]))
+		if (parse_commit_limited(twos[i]))
 			return NULL;
 	}
=20
@@ -645,7 +671,7 @@ static struct commit_list *merge_bases_many(struct =
commit *one, int n, struct co
 			parents =3D parents->next;
 			if ((p->object.flags & flags) =3D=3D flags)
 				continue;
-			if (parse_commit(p))
+			if (parse_commit_limited(p))
 				return NULL;
 			p->object.flags |=3D flags;
 			commit_list_insert_by_date(p, &list);
diff --git a/commit.h b/commit.h
index 154c0e3..113303b 100644
--- a/commit.h
+++ b/commit.h
@@ -47,6 +47,7 @@ struct commit *lookup_commit_or_die(const unsigned ch=
ar *sha1, const char *ref_n
=20
 int parse_commit_buffer(struct commit *item, const void *buffer, unsig=
ned long size);
 int parse_commit(struct commit *item);
+int parse_commit_limited(struct commit *item);
=20
 /* Find beginning and length of commit subject. */
 int find_commit_subject(const char *commit_buffer, const char **subjec=
t);
diff --git a/log-tree.c b/log-tree.c
index cea8756..047ddec 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -643,7 +643,7 @@ void show_log(struct rev_info *opt)
 		show_mergetag(opt, commit);
 	}
=20
-	if (!commit->buffer)
+	if (!commit->buffer && parse_commit(commit) < 0)
 		return;
=20
 	/*
diff --git a/revision.c b/revision.c
index c97d834..4c229fd 100644
--- a/revision.c
+++ b/revision.c
@@ -273,7 +273,7 @@ static struct commit *handle_commit(struct rev_info=
 *revs, struct object *object
 	 */
 	if (object->type =3D=3D OBJ_COMMIT) {
 		struct commit *commit =3D (struct commit *)object;
-		if (parse_commit(commit) < 0)
+		if (parse_commit_limited(commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
 			commit->object.flags |=3D UNINTERESTING;
@@ -465,7 +465,7 @@ static void try_to_simplify_commit(struct rev_info =
*revs, struct commit *commit)
 		 */
 		if (revs->first_parent_only && nth_parent++)
 			break;
-		if (parse_commit(p) < 0)
+		if (parse_commit_limited(p) < 0)
 			die("cannot simplify commit %s (because of %s)",
 			    sha1_to_hex(commit->object.sha1),
 			    sha1_to_hex(p->object.sha1));
@@ -498,7 +498,7 @@ static void try_to_simplify_commit(struct rev_info =
*revs, struct commit *commit)
 				 * IOW, we pretend this parent is a
 				 * "root" commit.
 				 */
-				if (parse_commit(p) < 0)
+				if (parse_commit_limited(p) < 0)
 					die("cannot simplify commit %s (invalid %s)",
 					    sha1_to_hex(commit->object.sha1),
 					    sha1_to_hex(p->object.sha1));
@@ -561,7 +561,7 @@ static int add_parents_to_list(struct rev_info *rev=
s, struct commit *commit,
 			parent =3D parent->next;
 			if (p)
 				p->object.flags |=3D UNINTERESTING;
-			if (parse_commit(p) < 0)
+			if (parse_commit_limited(p) < 0)
 				continue;
 			if (p->parents)
 				mark_parents_uninteresting(p);
@@ -588,7 +588,7 @@ static int add_parents_to_list(struct rev_info *rev=
s, struct commit *commit,
 	for (parent =3D commit->parents; parent; parent =3D parent->next) {
 		struct commit *p =3D parent->item;
=20
-		if (parse_commit(p) < 0)
+		if (parse_commit_limited(p) < 0)
 			return -1;
 		if (revs->show_source && !p->util)
 			p->util =3D commit->util;
diff --git a/upload-pack.c b/upload-pack.c
index bb08e2e..d30e604 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -694,7 +694,7 @@ static void receive_needs(void)
 				/* make sure the real parents are parsed */
 				unregister_shallow(object->sha1);
 				object->parsed =3D 0;
-				if (parse_commit((struct commit *)object))
+				if (parse_commit_limited((struct commit *)object))
 					die("invalid commit");
 				parents =3D ((struct commit *)object)->parents;
 				while (parents) {
diff --git a/walker.c b/walker.c
index be389dc..7b818f5 100644
--- a/walker.c
+++ b/walker.c
@@ -71,7 +71,7 @@ static struct commit_list *complete =3D NULL;
=20
 static int process_commit(struct walker *walker, struct commit *commit=
)
 {
-	if (parse_commit(commit))
+	if (parse_commit_limited(commit))
 		return -1;
=20
 	while (complete && complete->item->date >=3D commit->date) {
--=20
1.7.3.1.256.g2539c.dirty
