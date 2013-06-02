From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2 6/7] diff-lib, read-tree, unpack-trees: mark cache_entry array paramters const
Date: Sun,  2 Jun 2013 17:46:56 +0200
Message-ID: <1370188017-24672-7-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 02 17:47:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjAVA-0006uU-JM
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 17:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab3FBPrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 11:47:21 -0400
Received: from india601.server4you.de ([85.25.151.105]:58126 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab3FBPrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 11:47:06 -0400
Received: from debian.Speedport_W_504V_Typ_A (p579BEE4A.dip0.t-ipconnect.de [87.155.238.74])
	by india601.server4you.de (Postfix) with ESMTPSA id 0FF12663;
	Sun,  2 Jun 2013 17:47:04 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226163>

Change the type merge_fn_t to accept the array of cache_entry pointers
as const pointers to const pointers.  This documents the fact that the
merge functions don't modify the cache_entry contents or replace any of
the pointers in the array.

Only a single cast is necessary in unpack_nondirectories because adding
two const modifiers at once is not allowed in C.  The cast is safe in
that it doesn't mask any modfication; call_unpack_fn only needs the
array for reading.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/read-tree.c |  3 ++-
 diff-lib.c          |  3 ++-
 unpack-trees.c      | 21 +++++++++++++--------
 unpack-trees.h      | 14 +++++++++-----
 4 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index b847486..0f5d7fe 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -80,7 +80,8 @@ static void debug_stage(const char *label, const stru=
ct cache_entry *ce,
 		       sha1_to_hex(ce->sha1));
 }
=20
-static int debug_merge(struct cache_entry **stages, struct unpack_tree=
s_options *o)
+static int debug_merge(const struct cache_entry * const *stages,
+		       struct unpack_trees_options *o)
 {
 	int i;
=20
diff --git a/diff-lib.c b/diff-lib.c
index 83d0cb8..b6f4b21 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -424,7 +424,8 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
  * the fairly complex unpack_trees() semantic requirements, including
  * the skipping, the path matching, the type conflict cases etc.
  */
-static int oneway_diff(struct cache_entry **src, struct unpack_trees_o=
ptions *o)
+static int oneway_diff(const struct cache_entry * const *src,
+		       struct unpack_trees_options *o)
 {
 	const struct cache_entry *idx =3D src[0];
 	const struct cache_entry *tree =3D src[1];
diff --git a/unpack-trees.c b/unpack-trees.c
index c5a40df..2dbc05d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -300,7 +300,8 @@ static int apply_sparse_checkout(struct cache_entry=
 *ce, struct unpack_trees_opt
 	return 0;
 }
=20
-static inline int call_unpack_fn(struct cache_entry **src, struct unpa=
ck_trees_options *o)
+static inline int call_unpack_fn(const struct cache_entry * const *src=
,
+				 struct unpack_trees_options *o)
 {
 	int ret =3D o->fn(src, o);
 	if (ret > 0)
@@ -397,7 +398,7 @@ static void add_same_unmerged(struct cache_entry *c=
e,
 static int unpack_index_entry(struct cache_entry *ce,
 			      struct unpack_trees_options *o)
 {
-	struct cache_entry *src[MAX_UNPACK_TREES + 1] =3D { NULL, };
+	const struct cache_entry *src[MAX_UNPACK_TREES + 1] =3D { NULL, };
 	int ret;
=20
 	src[0] =3D ce;
@@ -600,7 +601,8 @@ static int unpack_nondirectories(int n, unsigned lo=
ng mask,
 	}
=20
 	if (o->merge)
-		return call_unpack_fn(src, o);
+		return call_unpack_fn((const struct cache_entry * const *)src,
+				      o);
=20
 	for (i =3D 0; i < n; i++)
 		if (src[i] && src[i] !=3D o->df_conflict_entry)
@@ -1574,7 +1576,8 @@ static void show_stage_entry(FILE *o,
 }
 #endif
=20
-int threeway_merge(struct cache_entry **stages, struct unpack_trees_op=
tions *o)
+int threeway_merge(const struct cache_entry * const *stages,
+		   struct unpack_trees_options *o)
 {
 	const struct cache_entry *index;
 	const struct cache_entry *head;
@@ -1746,7 +1749,8 @@ int threeway_merge(struct cache_entry **stages, s=
truct unpack_trees_options *o)
  * "carry forward" rule, please see <Documentation/git-read-tree.txt>.
  *
  */
-int twoway_merge(struct cache_entry **src, struct unpack_trees_options=
 *o)
+int twoway_merge(const struct cache_entry * const *src,
+		 struct unpack_trees_options *o)
 {
 	const struct cache_entry *current =3D src[0];
 	const struct cache_entry *oldtree =3D src[1];
@@ -1812,8 +1816,8 @@ int twoway_merge(struct cache_entry **src, struct=
 unpack_trees_options *o)
  * Keep the index entries at stage0, collapse stage1 but make sure
  * stage0 does not have anything there.
  */
-int bind_merge(struct cache_entry **src,
-		struct unpack_trees_options *o)
+int bind_merge(const struct cache_entry * const *src,
+	       struct unpack_trees_options *o)
 {
 	const struct cache_entry *old =3D src[0];
 	const struct cache_entry *a =3D src[1];
@@ -1836,7 +1840,8 @@ int bind_merge(struct cache_entry **src,
  * The rule is:
  * - take the stat information from stage0, take the data from stage1
  */
-int oneway_merge(struct cache_entry **src, struct unpack_trees_options=
 *o)
+int oneway_merge(const struct cache_entry * const *src,
+		 struct unpack_trees_options *o)
 {
 	const struct cache_entry *old =3D src[0];
 	const struct cache_entry *a =3D src[1];
diff --git a/unpack-trees.h b/unpack-trees.h
index 5e432f5..36a73a6 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -8,7 +8,7 @@
 struct unpack_trees_options;
 struct exclude_list;
=20
-typedef int (*merge_fn_t)(struct cache_entry **src,
+typedef int (*merge_fn_t)(const struct cache_entry * const *src,
 		struct unpack_trees_options *options);
=20
 enum unpack_trees_error_types {
@@ -77,9 +77,13 @@ struct unpack_trees_options {
 extern int unpack_trees(unsigned n, struct tree_desc *t,
 		struct unpack_trees_options *options);
=20
-int threeway_merge(struct cache_entry **stages, struct unpack_trees_op=
tions *o);
-int twoway_merge(struct cache_entry **src, struct unpack_trees_options=
 *o);
-int bind_merge(struct cache_entry **src, struct unpack_trees_options *=
o);
-int oneway_merge(struct cache_entry **src, struct unpack_trees_options=
 *o);
+int threeway_merge(const struct cache_entry * const *stages,
+		   struct unpack_trees_options *o);
+int twoway_merge(const struct cache_entry * const *src,
+		 struct unpack_trees_options *o);
+int bind_merge(const struct cache_entry * const *src,
+	       struct unpack_trees_options *o);
+int oneway_merge(const struct cache_entry * const *src,
+		 struct unpack_trees_options *o);
=20
 #endif
--=20
1.8.3
