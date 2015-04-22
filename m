From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 02/16] refs: convert for_each_tag_ref to struct object_id
Date: Wed, 22 Apr 2015 23:24:07 +0000
Message-ID: <1429745061-295908-3-git-send-email-sandals@crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 01:25:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl41D-0004EH-0x
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965600AbbDVXZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:25:17 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44736 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758563AbbDVXY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 19:24:27 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id ABD92282A7;
	Wed, 22 Apr 2015 23:24:26 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267668>

To allow piecemeal conversion of the for_each_*_ref functions, introduce
an additional typedef for a callback function that takes struct
object_id * instead of unsigned char *.  Provide an extra field in
struct ref_entry_cb for this callback and ensure at most one is set at a
time.  Temporarily suffix these new entries with _oid to distinguish
them.  Convert for_each_tag_ref and its callers to use the new _oid
functions, introducing temporary wrapper functions to avoid type
mismatches.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-objects.c |  4 ++--
 builtin/rev-parse.c    |  7 ++++++-
 builtin/tag.c          |  8 ++++----
 refs.c                 | 34 ++++++++++++++++++++++++++++++----
 refs.h                 | 10 +++++++++-
 5 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c067107..0c69b0c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -540,11 +540,11 @@ static enum write_one_status write_one(struct sha1file *f,
 	return WRITE_ONE_WRITTEN;
 }
 
-static int mark_tagged(const char *path, const unsigned char *sha1, int flag,
+static int mark_tagged(const char *path, const struct object_id *oid, int flag,
 		       void *cb_data)
 {
 	unsigned char peeled[20];
-	struct object_entry *entry = packlist_find(&to_pack, sha1, NULL);
+	struct object_entry *entry = packlist_find(&to_pack, oid->hash, NULL);
 
 	if (entry)
 		entry->tagged = 1;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 4d10dd9..7b70650 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -198,6 +198,11 @@ static int show_reference(const char *refname, const unsigned char *sha1, int fl
 	return 0;
 }
 
+static int show_reference_oid(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+{
+	return show_reference(refname, oid->hash, flag, cb_data);
+}
+
 static int anti_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	show_rev(REVERSED, sha1, refname);
@@ -682,7 +687,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--tags")) {
-				for_each_tag_ref(show_reference, NULL);
+				for_each_tag_ref(show_reference_oid, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
diff --git a/builtin/tag.c b/builtin/tag.c
index 6f07ac6..61399b7 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -215,7 +215,7 @@ free_return:
 	free(buf);
 }
 
-static int show_reference(const char *refname, const unsigned char *sha1,
+static int show_reference(const char *refname, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
 	struct tag_filter *filter = cb_data;
@@ -224,14 +224,14 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 		if (filter->with_commit) {
 			struct commit *commit;
 
-			commit = lookup_commit_reference_gently(sha1, 1);
+			commit = lookup_commit_reference_gently(oid->hash, 1);
 			if (!commit)
 				return 0;
 			if (!contains(commit, filter->with_commit))
 				return 0;
 		}
 
-		if (points_at.nr && !match_points_at(refname, sha1))
+		if (points_at.nr && !match_points_at(refname, oid->hash))
 			return 0;
 
 		if (!filter->lines) {
@@ -242,7 +242,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 			return 0;
 		}
 		printf("%-15s ", refname);
-		show_tag_lines(sha1, filter->lines);
+		show_tag_lines(oid->hash, filter->lines);
 		putchar('\n');
 	}
 
diff --git a/refs.c b/refs.c
index 522d15d..95863f2 100644
--- a/refs.c
+++ b/refs.c
@@ -694,6 +694,7 @@ struct ref_entry_cb {
 	int trim;
 	int flags;
 	each_ref_fn *fn;
+	each_ref_fn_oid *fn_oid;
 	void *cb_data;
 };
 
@@ -717,8 +718,13 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	/* Store the old value, in case this is a recursive call: */
 	old_current_ref = current_ref;
 	current_ref = entry;
-	retval = data->fn(entry->name + data->trim, entry->u.value.oid.hash,
-			  entry->flag, data->cb_data);
+	if (data->fn_oid) {
+		retval = data->fn_oid(entry->name + data->trim, &entry->u.value.oid,
+				 entry->flag, data->cb_data);
+	} else {
+		retval = data->fn(entry->name + data->trim, entry->u.value.oid.hash,
+				 entry->flag, data->cb_data);
+	}
 	current_ref = old_current_ref;
 	return retval;
 }
@@ -1950,6 +1956,21 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 	data.trim = trim;
 	data.flags = flags;
 	data.fn = fn;
+	data.fn_oid = NULL;
+	data.cb_data = cb_data;
+
+	return do_for_each_entry(refs, base, do_one_ref, &data);
+}
+
+static int do_for_each_ref_oid(struct ref_cache *refs, const char *base,
+			   each_ref_fn_oid fn, int trim, int flags, void *cb_data)
+{
+	struct ref_entry_cb data;
+	data.base = base;
+	data.trim = trim;
+	data.flags = flags;
+	data.fn = NULL;
+	data.fn_oid = fn;
 	data.cb_data = cb_data;
 
 	if (ref_paranoia < 0)
@@ -1998,6 +2019,11 @@ int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
 }
 
+static int for_each_ref_in_oid(const char *prefix, each_ref_fn_oid fn, void *cb_data)
+{
+	return do_for_each_ref_oid(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
+}
+
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
@@ -2009,9 +2035,9 @@ int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
 }
 
-int for_each_tag_ref(each_ref_fn fn, void *cb_data)
+int for_each_tag_ref(each_ref_fn_oid fn, void *cb_data)
 {
-	return for_each_ref_in("refs/tags/", fn, cb_data);
+	return for_each_ref_in_oid("refs/tags/", fn, cb_data);
 }
 
 int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index 6d7d9b4..b83529b 100644
--- a/refs.h
+++ b/refs.h
@@ -1,6 +1,8 @@
 #ifndef REFS_H
 #define REFS_H
 
+#include "cache.h"
+
 /*
  * A ref_transaction represents a collection of ref updates
  * that should succeed or fail together.
@@ -70,6 +72,12 @@ typedef int each_ref_fn(const char *refname,
 			const unsigned char *sha1, int flags, void *cb_data);
 
 /*
+ * Like each_ref_fn, but passes the object ID using a struct.
+ */
+typedef int each_ref_fn_oid(const char *refname,
+			const struct object_id *oid, int flags, void *cb_data);
+
+/*
  * The following functions invoke the specified callback function for
  * each reference indicated.  If the function ever returns a nonzero
  * value, stop the iteration and return that value.  Please note that
@@ -81,7 +89,7 @@ typedef int each_ref_fn(const char *refname,
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_ref_in(const char *, each_ref_fn, void *);
-extern int for_each_tag_ref(each_ref_fn, void *);
+extern int for_each_tag_ref(each_ref_fn_oid, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 extern int for_each_replace_ref(each_ref_fn, void *);
-- 
2.3.5
