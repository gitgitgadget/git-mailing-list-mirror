Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654DD13C8EA
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755551061; cv=none; b=JTwdAVvLcAV/mamthToLjP6FPLhOQVyGqEuVWeKhhI1levVch1x0Bu9bUtywI6LslNF9EwVhxUz5rP1cbURTIMzKXkx8wmmOHkAms9Tzi7WzaEMfqysblxBBZNgT5Rjfhk9jTB5egGzplPVfAMVhH3/F5YJDAK9+zZh2/TbsF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755551061; c=relaxed/simple;
	bh=/udO4ib7ZKxo2KEEargsybPrW+bQTOmwo5V5T+GjxL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD82LvPg925X+f5YFANIyoojZGgSMqaHNvFilBAf4Q0don+AKeKcgXRBpfKWGZdX8RDn0K4794Rh3KbVCX6LxserDmBM4bsFDQF3QI4tHRJ2r7vybYikq9996AXZSfUPh86z12WfNkwxy3cOmeN6HMlPbf7G6hws4aFsTE7YZo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gBnSfEp2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gBnSfEp2"
Received: (qmail 23328 invoked by uid 109); 18 Aug 2025 21:04:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/udO4ib7ZKxo2KEEargsybPrW+bQTOmwo5V5T+GjxL8=; b=gBnSfEp2KP/LIvYdpswmfle0hbH+8VrwLfw3D/YfqY8OY3FpMy9aIOOF9HUEQ3nkVNpm4K16j0GR+04ZH1CCUQJXfMw9tWIPwACi0lDAmZu+/28JJrBYoUJhmmYjbQt9Gux3Ckw0q5/e13vd4yQ5MrndyeM0mlaOtsvVnWndlAfnKMML677vMcvdpZxA0Ts0vkUMXmParbW/pZe3s986koYpiX3y/Z9ArdHeDdwAK0bEQY0gLRTKQbu1ramsoH3oUTvBTUfnPOR4MttuVZeE6Sm65S3yRsrhX/0JQ3kHvW4qUemd8LrN/kkqx2L5wIib0ImbU288jizANLeUSvf2Tg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Aug 2025 21:04:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30338 invoked by uid 111); 18 Aug 2025 21:04:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Aug 2025 17:04:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Aug 2025 17:04:17 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
	git@vger.kernel.org
Subject: [PATCH 5/5] describe: pass commit to describe_commit()
Message-ID: <20250818210417.GE1024556@coredump.intra.peff.net>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818205812.GA1018043@coredump.intra.peff.net>

There's a call in describe_commit() to lookup_commit_reference(), but we
don't check the return value. If it returns NULL, we'll segfault as we
immediately dereference the result.

In practice this can never happen, since all callers pass an oid which
came from a "struct commit" already. So we can make this more obvious
by just taking that commit struct in the first place.

Reported-by: Cheng <prophecheng@stu.pku.edu.cn>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 72b2e1162c..04df89d56b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -313,26 +313,24 @@ static void append_suffix(int depth, const struct object_id *oid, struct strbuf
 		    repo_find_unique_abbrev(the_repository, oid, abbrev));
 }
 
-static void describe_commit(struct object_id *oid, struct strbuf *dst)
+static void describe_commit(struct commit *cmit, struct strbuf *dst)
 {
-	struct commit *cmit, *gave_up_on = NULL;
+	struct commit *gave_up_on = NULL;
 	struct commit_list *list;
 	struct commit_name *n;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
 	unsigned long seen_commits = 0;
 	unsigned int unannotated_cnt = 0;
 
-	cmit = lookup_commit_reference(the_repository, oid);
-
 	n = find_commit_name(&cmit->object.oid);
 	if (n && (tags || all || n->prio == 2)) {
 		/*
 		 * Exact match to an existing ref.
 		 */
 		append_name(n, dst);
 		if (n->misnamed || longformat)
-			append_suffix(0, n->tag ? get_tagged_oid(n->tag) : oid, dst);
+			append_suffix(0, n->tag ? get_tagged_oid(n->tag) : &cmit->object.oid, dst);
 		if (suffix)
 			strbuf_addstr(dst, suffix);
 		return;
@@ -489,7 +487,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 }
 
 struct process_commit_data {
-	struct object_id current_commit;
+	struct commit *current_commit;
 	const struct object_id *looking_for;
 	struct strbuf *dst;
 	struct rev_info *revs;
@@ -498,7 +496,7 @@ struct process_commit_data {
 static void process_commit(struct commit *commit, void *data)
 {
 	struct process_commit_data *pcd = data;
-	pcd->current_commit = commit->object.oid;
+	pcd->current_commit = commit;
 }
 
 static void process_object(struct object *obj, const char *path, void *data)
@@ -507,8 +505,8 @@ static void process_object(struct object *obj, const char *path, void *data)
 
 	if (oideq(pcd->looking_for, &obj->oid) && !pcd->dst->len) {
 		reset_revision_walk();
-		if (!is_null_oid(&pcd->current_commit)) {
-			describe_commit(&pcd->current_commit, pcd->dst);
+		if (pcd->current_commit) {
+			describe_commit(pcd->current_commit, pcd->dst);
 			strbuf_addf(pcd->dst, ":%s", path);
 		}
 		free_commit_list(pcd->revs->commits);
@@ -521,7 +519,7 @@ static void describe_blob(const struct object_id *oid, struct strbuf *dst)
 	struct rev_info revs;
 	struct strvec args = STRVEC_INIT;
 	struct object_id head_oid;
-	struct process_commit_data pcd = { *null_oid(the_hash_algo), oid, dst, &revs};
+	struct process_commit_data pcd = { NULL, oid, dst, &revs};
 
 	if (repo_get_oid(the_repository, "HEAD", &head_oid))
 		die(_("cannot search for blob '%s' on an unborn branch"),
@@ -562,7 +560,7 @@ static void describe(const char *arg, int last_one)
 	cmit = lookup_commit_reference_gently(the_repository, &oid, 1);
 
 	if (cmit)
-		describe_commit(&oid, &sb);
+		describe_commit(cmit, &sb);
 	else if (odb_read_object_info(the_repository->objects,
 				      &oid, NULL) == OBJ_BLOB)
 		describe_blob(&oid, &sb);
-- 
2.51.0.326.gecbb38d78e
