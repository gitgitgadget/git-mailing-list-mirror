From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 12/12] remote: convert functions to struct object_id
Date: Tue, 10 Nov 2015 02:22:30 +0000
Message-ID: <1447122150-672570-13-git-send-email-sandals@crustytoothpaste.net>
References: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 03:23:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvyam-0001H9-If
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 03:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbbKJCXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 21:23:23 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58439 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752343AbbKJCXF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 21:23:05 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 56E8C28098;
	Tue, 10 Nov 2015 02:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1447122185;
	bh=qqQhbUAQ5FXzRL1j0mO+oFSWfmbMkdn2KUiCwcjc8+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwD8vk8Mzlt11lWWidZIMPmd8ls3Fn74bnhBLiD92j1yrsRkJuNg0yDnASeUPQEhi
	 uZ1p5egtltVMgsWd6pcxvtBme/fXENSj0QsPcrcnaYI4PTMnfuQF0gE/iJ7u/7nCjr
	 DrkFC4gyOM73CWM/nGJ+gVH9ESGIN+OMrEsoAGkpmKNGzn9Z4q5Evmsy3rnE5hK0Ai
	 Z2Hir9cPvp/plNfcA0wltpmFavo1AJkebu/cH69goMFFdUtuBt/3/nNAlkjVkbqsI1
	 B5dqWn48YKOYJbo8h2qgCnRjU/q7rfi45EBR6xbDdwwiFsykSwJOwu1mBYttE52esZ
	 1/jLPH7THFG+Gg6q5RH18mhu4lU7XztS4gRgni7GY3pza0w6rQ4f+B3fsII5754LJa
	 otGH86AII8c+N99SRjpm2JV6sPvFUlMxg+GBQzohb3ii8mGXOFvWkcIee/ce+mAI7c
	 m6OYzCGTds+hhM0/2Lyykv/9nK62a9Naf3TfwDq9Uoo8yIgTJyX
X-Mailer: git-send-email 2.6.2.409.gb049f0a
In-Reply-To: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281096>

Convert several unsigned char arrays to use struct object_id instead,
and change hard-coded 40-based constants to use GIT_SHA1_HEXSZ as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote.c | 58 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/remote.c b/remote.c
index 1abe1de2..9d34b5a5 100644
--- a/remote.c
+++ b/remote.c
@@ -456,7 +456,7 @@ static void alias_all_urls(void)
 static void read_config(void)
 {
 	static int loaded;
-	unsigned char sha1[20];
+	struct object_id oid;
 	const char *head_ref;
 	int flag;
 
@@ -465,7 +465,7 @@ static void read_config(void)
 	loaded = 1;
 
 	current_branch = NULL;
-	head_ref = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
+	head_ref = resolve_ref_unsafe("HEAD", 0, oid.hash, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
 	    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
 		current_branch = make_branch(head_ref, 0);
@@ -544,12 +544,12 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
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
@@ -1082,7 +1082,7 @@ static struct ref *alloc_delete_ref(void)
 static int try_explicit_object_name(const char *name,
 				    struct ref **match)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	if (!*name) {
 		if (match)
@@ -1090,12 +1090,12 @@ static int try_explicit_object_name(const char *name,
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
@@ -1110,10 +1110,10 @@ static struct ref *make_linked_ref(const char *name, struct ref ***tail)
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
 
@@ -1171,12 +1171,12 @@ static int match_explicit(struct ref *src, struct ref *dst,
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
@@ -1292,13 +1292,13 @@ struct tips {
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
@@ -1322,9 +1322,9 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
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
@@ -1609,7 +1609,7 @@ static void set_merge(struct branch *ret)
 {
 	struct remote *remote;
 	char *ref;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int i;
 
 	if (!ret)
@@ -1635,7 +1635,7 @@ static void set_merge(struct branch *ret)
 		    strcmp(ret->remote_name, "."))
 			continue;
 		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
-			     sha1, &ref) == 1)
+			     oid.hash, &ref) == 1)
 			ret->merge[i]->dst = ref;
 		else
 			ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
@@ -1795,10 +1795,10 @@ const char *branch_get_push(struct branch *branch, struct strbuf *err)
 
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
@@ -1995,7 +1995,7 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		       const char **upstream_name)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct commit *ours, *theirs;
 	struct rev_info revs;
 	const char *base;
@@ -2009,15 +2009,15 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
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
 
@@ -2328,14 +2328,14 @@ int is_empty_cas(const struct push_cas_option *cas)
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
@@ -2354,7 +2354,7 @@ static void apply_cas(struct push_cas_option *cas,
 		ref->expect_old_sha1 = 1;
 		if (!entry->use_tracking)
 			hashcpy(ref->old_oid_expect.hash, cas->entry[i].expect);
-		else if (remote_tracking(remote, ref->name, ref->old_oid_expect.hash))
+		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
 			ref->expect_old_no_trackback = 1;
 		return;
 	}
@@ -2364,7 +2364,7 @@ static void apply_cas(struct push_cas_option *cas,
 		return;
 
 	ref->expect_old_sha1 = 1;
-	if (remote_tracking(remote, ref->name, ref->old_oid_expect.hash))
+	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
 		ref->expect_old_no_trackback = 1;
 }
 
-- 
2.6.2.409.gb049f0a
