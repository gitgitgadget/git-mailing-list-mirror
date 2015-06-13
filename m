From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 10/10] remote: convert functions to struct object_id
Date: Sat, 13 Jun 2015 22:16:43 +0000
Message-ID: <1434233803-422442-11-git-send-email-sandals@crustytoothpaste.net>
References: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 00:17:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3tjy-0002tS-8B
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 00:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbbFMWRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 18:17:18 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:42878 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751319AbbFMWQy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 18:16:54 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A51FB2809B;
	Sat, 13 Jun 2015 22:16:53 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1 ALL_TRUSTED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271594>

Convert several unsigned char arrays to use struct object_id instead,
and change hard-coded 40-based constants to use GIT_SHA1_HEXSZ as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote.c | 64 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/remote.c b/remote.c
index c72d796..92dc8d6 100644
--- a/remote.c
+++ b/remote.c
@@ -492,7 +492,7 @@ static void alias_all_urls(void)
 static void read_config(void)
 {
 	static int loaded;
-	unsigned char sha1[20];
+	struct object_id oid;
 	const char *head_ref;
 	int flag;
 
@@ -501,7 +501,7 @@ static void read_config(void)
 	loaded = 1;
 
 	current_branch = NULL;
-	head_ref = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
+	head_ref = resolve_ref_unsafe("HEAD", 0, oid.hash, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
 	    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
 		current_branch = make_branch(head_ref, 0);
@@ -580,12 +580,12 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 		flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
 
 		if (fetch) {
-			unsigned char unused[40];
+			struct object_id unused;
 
 			/* LHS */
 			if (!*rs[i].src)
 				; /* empty is ok; it means "HEAD" */
-			else if (llen == 40 && !get_sha1_hex(rs[i].src, unused))
+			else if (llen == GIT_SHA1_HEXSZ && !get_oid_hex(rs[i].src, &unused))
 				rs[i].exact_sha1 = 1; /* ok */
 			else if (!check_refname_format(rs[i].src, flags))
 				; /* valid looking ref is ok */
@@ -1118,7 +1118,7 @@ static struct ref *alloc_delete_ref(void)
 static int try_explicit_object_name(const char *name,
 				    struct ref **match)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	if (!*name) {
 		if (match)
@@ -1126,12 +1126,12 @@ static int try_explicit_object_name(const char *name,
 		return 0;
 	}
 
-	if (get_sha1(name, sha1))
+	if (get_sha1(name, oid.hash))
 		return -1;
 
 	if (match) {
 		*match = alloc_ref(name);
-		hashcpy((*match)->new_oid.hash, sha1);
+		oidcpy(&(*match)->new_oid, &oid);
 	}
 	return 0;
 }
@@ -1146,10 +1146,10 @@ static struct ref *make_linked_ref(const char *name, struct ref ***tail)
 static char *guess_ref(const char *name, struct ref *peer)
 {
 	struct strbuf buf = STRBUF_INIT;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	const char *r = resolve_ref_unsafe(peer->name, RESOLVE_REF_READING,
-					   sha1, NULL);
+					   oid.hash, NULL);
 	if (!r)
 		return NULL;
 
@@ -1207,12 +1207,12 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		return -1;
 
 	if (!dst_value) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		int flag;
 
 		dst_value = resolve_ref_unsafe(matched_src->name,
 					       RESOLVE_REF_READING,
-					       sha1, &flag);
+					       oid.hash, &flag);
 		if (!dst_value ||
 		    ((flag & REF_ISSYMREF) &&
 		     !starts_with(dst_value, "refs/heads/")))
@@ -1328,13 +1328,13 @@ struct tips {
 	int nr, alloc;
 };
 
-static void add_to_tips(struct tips *tips, const unsigned char *sha1)
+static void add_to_tips(struct tips *tips, const struct object_id *oid)
 {
 	struct commit *commit;
 
-	if (is_null_sha1(sha1))
+	if (is_null_oid(oid))
 		return;
-	commit = lookup_commit_reference_gently(sha1, 1);
+	commit = lookup_commit_reference_gently(oid->hash, 1);
 	if (!commit || (commit->object.flags & TMP_MARK))
 		return;
 	commit->object.flags |= TMP_MARK;
@@ -1358,9 +1358,9 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 	for (ref = *dst; ref; ref = ref->next) {
 		if (ref->peer_ref &&
 		    !is_null_oid(&ref->peer_ref->new_oid))
-			add_to_tips(&sent_tips, ref->peer_ref->new_oid.hash);
+			add_to_tips(&sent_tips, &ref->peer_ref->new_oid);
 		else
-			add_to_tips(&sent_tips, ref->old_oid.hash);
+			add_to_tips(&sent_tips, &ref->old_oid);
 		if (starts_with(ref->name, "refs/tags/"))
 			string_list_append(&dst_tag, ref->name);
 	}
@@ -1645,7 +1645,7 @@ static void set_merge(struct branch *ret)
 {
 	struct remote *remote;
 	char *ref;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int i;
 
 	if (!ret)
@@ -1671,7 +1671,7 @@ static void set_merge(struct branch *ret)
 		    strcmp(ret->remote_name, "."))
 			continue;
 		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
-			     sha1, &ref) == 1)
+			     oid.hash, &ref) == 1)
 			ret->merge[i]->dst = ref;
 		else
 			ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
@@ -1831,10 +1831,10 @@ const char *branch_get_push(struct branch *branch, struct strbuf *err)
 
 static int ignore_symref_update(const char *refname)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	int flag;
 
-	if (!resolve_ref_unsafe(refname, 0, sha1, &flag))
+	if (!resolve_ref_unsafe(refname, 0, oid.hash, &flag))
 		return 0; /* non-existing refs are OK */
 	return (flag & REF_ISSYMREF);
 }
@@ -2033,9 +2033,9 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		       const char **upstream_name)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct commit *ours, *theirs;
-	char symmetric[84];
+	char symmetric[GIT_SHA1_HEXSZ * 2 + 4];
 	struct rev_info revs;
 	const char *rev_argv[10], *base;
 	int rev_argc;
@@ -2048,15 +2048,15 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		return -1;
 
 	/* Cannot stat if what we used to build on no longer exists */
-	if (read_ref(base, sha1))
+	if (read_ref(base, oid.hash))
 		return -1;
-	theirs = lookup_commit_reference(sha1);
+	theirs = lookup_commit_reference(oid.hash);
 	if (!theirs)
 		return -1;
 
-	if (read_ref(branch->refname, sha1))
+	if (read_ref(branch->refname, oid.hash))
 		return -1;
-	ours = lookup_commit_reference(sha1);
+	ours = lookup_commit_reference(oid.hash);
 	if (!ours)
 		return -1;
 
@@ -2075,8 +2075,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	rev_argv[rev_argc] = NULL;
 
 	strcpy(symmetric, oid_to_hex(&ours->object.oid));
-	strcpy(symmetric + 40, "...");
-	strcpy(symmetric + 43, oid_to_hex(&theirs->object.oid));
+	strcpy(symmetric + GIT_SHA1_HEXSZ, "...");
+	strcpy(symmetric + GIT_SHA1_HEXSZ + 3, oid_to_hex(&theirs->object.oid));
 
 	init_revisions(&revs, NULL);
 	setup_revisions(rev_argc, rev_argv, &revs, NULL);
@@ -2369,14 +2369,14 @@ int is_empty_cas(const struct push_cas_option *cas)
  * If we cannot do so, return negative to signal an error.
  */
 static int remote_tracking(struct remote *remote, const char *refname,
-			   unsigned char sha1[20])
+			   struct object_id *oid)
 {
 	char *dst;
 
 	dst = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
 	if (!dst)
 		return -1; /* no tracking ref for refname at remote */
-	if (read_ref(dst, sha1))
+	if (read_ref(dst, oid->hash))
 		return -1; /* we know what the tracking ref is but we cannot read it */
 	return 0;
 }
@@ -2395,7 +2395,7 @@ static void apply_cas(struct push_cas_option *cas,
 		ref->expect_old_sha1 = 1;
 		if (!entry->use_tracking)
 			hashcpy(ref->old_oid_expect.hash, cas->entry[i].expect);
-		else if (remote_tracking(remote, ref->name, ref->old_oid_expect.hash))
+		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
 			ref->expect_old_no_trackback = 1;
 		return;
 	}
@@ -2405,7 +2405,7 @@ static void apply_cas(struct push_cas_option *cas,
 		return;
 
 	ref->expect_old_sha1 = 1;
-	if (remote_tracking(remote, ref->name, ref->old_oid_expect.hash))
+	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
 		ref->expect_old_no_trackback = 1;
 }
 
-- 
2.4.0
