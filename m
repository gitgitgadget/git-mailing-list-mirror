From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 20/25] sha1_name.c: add support for disambiguating other
 types
Date: Tue,  3 Jul 2012 14:37:10 -0700
Message-ID: <1341351435-31011-21-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAnr-0005gY-EI
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932858Ab2GCViZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35245 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756574Ab2GCVh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1B398692
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hKfx
	Cj3oyYgWE5zDmEEKlQOCJWo=; b=XNS0rTHMdefB4Q4VH5ywPd01JrDlSodzIAMG
	zUJyjHepzpOHeMedgaXKccU3EnyQw8vSG3vq9h2u5/9jhG0OkolW8E3qwNe64ZvK
	q/rYjKdpDFvmP4muhjvn04FdFmIx1Gdm7JYmykUAH4Njth3umVip3bLy4X3dBTq+
	LHiOZ4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=SgO3I+
	6svNsR/b9Dn1NoJ97bJddtBFQV01H1+yGrWru7bcUsE838/2crlpNzrOiPrMiLKv
	kAoDDVVJZkvA47hQZQNmXHQIIt0jHpi0fgrJCMVhayKfvIEZfKPwNmwKwKt86KUY
	d04Vi4AMNBj/QazlR8uW19Bo+Olwp8Z0LS2UU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8A228691
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E0878690 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5A1F0644-C557-11E1-8092-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200956>

This teaches the revision parser that in "$name:$path" (used for a
blob object name), "$name" must be a tree-ish.

There are many more places where we know what types of objects are
called for.  This patch adds support for "commit", "treeish", "tree",
and "blob", which could be used in the following contexts:

 - "git apply --build-fake-ancestor" reads the "index" lines from
   the patch; they must name blob objects (not even "blob-ish");

 - "git commit-tree" reads a tree object name (not "tree-ish"), and
   zero or more commit object names (not "committish");

 - "git reset $rev" wants a committish; "git reset $rev -- $path"
   wants a treeish.

They will come in later patches in the series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h                             | 13 ++++++--
 sha1_name.c                         | 66 ++++++++++++++++++++++++++++++++++++-
 t/t1512-rev-parse-disambiguation.sh |  2 +-
 3 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index e947b48..c8d6406 100644
--- a/cache.h
+++ b/cache.h
@@ -811,13 +811,20 @@ struct object_context {
 	unsigned mode;
 };
 
-#define GET_SHA1_QUIETLY 01
-#define GET_SHA1_COMMIT 02
-#define GET_SHA1_COMMITTISH 04
+#define GET_SHA1_QUIETLY        01
+#define GET_SHA1_COMMIT         02
+#define GET_SHA1_COMMITTISH     04
+#define GET_SHA1_TREE          010
+#define GET_SHA1_TREEISH       020
+#define GET_SHA1_BLOB	       040
 #define GET_SHA1_ONLY_TO_DIE 04000
 
 extern int get_sha1(const char *str, unsigned char *sha1);
+extern int get_sha1_commit(const char *str, unsigned char *sha1);
 extern int get_sha1_committish(const char *str, unsigned char *sha1);
+extern int get_sha1_tree(const char *str, unsigned char *sha1);
+extern int get_sha1_treeish(const char *str, unsigned char *sha1);
+extern int get_sha1_blob(const char *str, unsigned char *sha1);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
 extern int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc);
 
diff --git a/sha1_name.c b/sha1_name.c
index 9e13d60..18fac92 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -242,6 +242,36 @@ static int disambiguate_committish_only(const unsigned char *sha1, void *cb_data
 	return 0;
 }
 
+static int disambiguate_tree_only(const unsigned char *sha1, void *cb_data_unused)
+{
+	int kind = sha1_object_info(sha1, NULL);
+	return kind == OBJ_TREE;
+}
+
+static int disambiguate_treeish_only(const unsigned char *sha1, void *cb_data_unused)
+{
+	struct object *obj;
+	int kind;
+
+	kind = sha1_object_info(sha1, NULL);
+	if (kind == OBJ_TREE || kind == OBJ_COMMIT)
+		return 1;
+	if (kind != OBJ_TAG)
+		return 0;
+
+	/* We need to do this the hard way... */
+	obj = deref_tag(lookup_object(sha1), NULL, 0);
+	if (obj && (obj->type == OBJ_TREE || obj->type == OBJ_COMMIT))
+		return 1;
+	return 0;
+}
+
+static int disambiguate_blob_only(const unsigned char *sha1, void *cb_data_unused)
+{
+	int kind = sha1_object_info(sha1, NULL);
+	return kind == OBJ_BLOB;
+}
+
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  unsigned flags)
 {
@@ -281,6 +311,12 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 		ds.fn = disambiguate_commit_only;
 	else if (flags & GET_SHA1_COMMITTISH)
 		ds.fn = disambiguate_committish_only;
+	else if (flags & GET_SHA1_TREE)
+		ds.fn = disambiguate_tree_only;
+	else if (flags & GET_SHA1_TREEISH)
+		ds.fn = disambiguate_treeish_only;
+	else if (flags & GET_SHA1_BLOB)
+		ds.fn = disambiguate_blob_only;
 
 	find_short_object_filename(len, hex_pfx, &ds);
 	find_short_packed_object(len, bin_pfx, &ds);
@@ -1016,6 +1052,34 @@ int get_sha1_committish(const char *name, unsigned char *sha1)
 				     sha1, &unused);
 }
 
+int get_sha1_treeish(const char *name, unsigned char *sha1)
+{
+	struct object_context unused;
+	return get_sha1_with_context(name, GET_SHA1_TREEISH,
+				     sha1, &unused);
+}
+
+int get_sha1_commit(const char *name, unsigned char *sha1)
+{
+	struct object_context unused;
+	return get_sha1_with_context(name, GET_SHA1_COMMIT,
+				     sha1, &unused);
+}
+
+int get_sha1_tree(const char *name, unsigned char *sha1)
+{
+	struct object_context unused;
+	return get_sha1_with_context(name, GET_SHA1_TREE,
+				     sha1, &unused);
+}
+
+int get_sha1_blob(const char *name, unsigned char *sha1)
+{
+	struct object_context unused;
+	return get_sha1_with_context(name, GET_SHA1_BLOB,
+				     sha1, &unused);
+}
+
 /* Must be called only when object_name:filename doesn't exist. */
 static void diagnose_invalid_sha1_path(const char *prefix,
 				       const char *filename,
@@ -1221,7 +1285,7 @@ static int get_sha1_with_context_1(const char *name,
 			strncpy(object_name, name, cp-name);
 			object_name[cp-name] = '\0';
 		}
-		if (!get_sha1_1(name, cp-name, tree_sha1, 0)) {
+		if (!get_sha1_1(name, cp-name, tree_sha1, GET_SHA1_TREEISH)) {
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 417b436..4851a5f 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -44,7 +44,7 @@ test_expect_success 'warn ambiguity when no candidate matches type hint' '
 	grep "short SHA1 11021982 is ambiguous" actual
 '
 
-test_expect_failure 'disambiguate tree-ish' '
+test_expect_success 'disambiguate tree-ish' '
 	# feed tree-ish in an unambiguous way
 	git rev-parse --verify 1102198206:bz01t33 &&
 
-- 
1.7.11.1.229.g706c98f
