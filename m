Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2A146017
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717584410; cv=none; b=OAqZ7fLy/8JWJ3EZJ+d5gW0X3TE1A/VN2ozkmXi0jx3p2+v29neGAAzMAzH8B8cf4Zlnsy4jpQ+CkLT06bqCBf2LyyrOs6EbDNelvS7qQmXca6a94StmvFvn/I10MrtTD9BQo+Y7XeWFDc+boRCgdyrMM+ohC9arncavDSoVNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717584410; c=relaxed/simple;
	bh=zRCVeS+PrNeWAlttRYUdZ+wv3M441+XrtVRdJ9JL/IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYS+xNBFHlOtLfYY3NW2D07u4eWuNtguAhQrZgYp3xTfogekMZF226ABbG4tQ5liNy3cWMa8v+DAXQ9j4QT5JQy1PuRqsDZ0DdELIqiFPTxkEq04wXRjj5KN064hjSbNxlEXw/yfsxYx6lz85vlm5nbPnOBC00kAKGzg8ZJftXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26735 invoked by uid 109); 5 Jun 2024 10:46:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Jun 2024 10:46:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29091 invoked by uid 111); 5 Jun 2024 10:46:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jun 2024 06:46:46 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Jun 2024 06:46:46 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 02/19] global: assign non-const strings as required
Message-ID: <20240605104646.GA3972667@coredump.intra.peff.net>
References: <cover.1716983704.git.ps@pks.im>
 <51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
 <xmqqplt4y1gk.fsf@gitster.g>
 <ZlhjN7K8JKYz6Opd@tanuki>
 <xmqq34pzozsq.fsf@gitster.g>
 <ZlnJ83qSnGlQ0FWR@tanuki>
 <xmqq4jaehui6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jaehui6.fsf@gitster.g>

On Fri, May 31, 2024 at 08:27:13AM -0700, Junio C Hamano wrote:

> I wonder if we can do something to separate these two concerns
> apart, using a trick similar to what we often use with an extra
> variable "to_free".  Doing so would bloat the refspec_item, but
> unlike the references themselves, there won't be thousands of them,
> so it may not be an issue, perhaps?

I had a similar thought while looking at this spot a while ago, so I dug
this attempt out of my stash. It's quite ugly, as you need to keep the
storage pointer and the const pointer in sync. Especially because
there's a lot of clever pointer indirection via match_name_with_pattern().

So I don't think it's the best way to refactor this code, but I present
it here for your amusement/disgust. This is on top of what you have
queued in ps/no-writable-strings.

---
 branch.c         |  6 +++---
 builtin/fetch.c  |  8 ++++----
 builtin/remote.c |  6 +++---
 checkout.c       | 13 +++++++------
 refspec.c        |  6 ++++--
 refspec.h        |  6 ++++--
 remote.c         | 30 +++++++++++++++++-------------
 transport.c      |  2 +-
 8 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/branch.c b/branch.c
index df5d24fec6..e1585b10c2 100644
--- a/branch.c
+++ b/branch.c
@@ -38,7 +38,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 	if (!remote_find_tracking(remote, &tracking->spec)) {
 		switch (++tracking->matches) {
 		case 1:
-			string_list_append_nodup(tracking->srcs, tracking->spec.src);
+			string_list_append_nodup(tracking->srcs, tracking->spec.src_storage);
 			tracking->remote = remote->name;
 			break;
 		case 2:
@@ -47,7 +47,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 			/* fall through */
 		default:
 			string_list_append(&ftb->ambiguous_remotes, remote->name);
-			free(tracking->spec.src);
+			free(tracking->spec.src_storage);
 			string_list_clear(tracking->srcs, 0);
 		break;
 		}
@@ -489,7 +489,7 @@ static int check_tracking_branch(struct remote *remote, void *cb_data)
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.dst = tracking_branch;
 	res = !remote_find_tracking(remote, &query);
-	free(query.src);
+	free(query.src_storage);
 	return res;
 }
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 06b60867f5..00a67c99ef 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -443,7 +443,7 @@ static void filter_prefetch_refspec(struct refspec *rs)
 
 	for (i = 0; i < rs->nr; i++) {
 		struct strbuf new_dst = STRBUF_INIT;
-		char *old_dst;
+		const char *old_dst;
 		const char *sub = NULL;
 
 		if (rs->items[i].negative)
@@ -454,8 +454,8 @@ static void filter_prefetch_refspec(struct refspec *rs)
 				 ref_namespace[NAMESPACE_TAGS].ref))) {
 			int j;
 
-			free(rs->items[i].src);
-			free(rs->items[i].dst);
+			free(rs->items[i].src_storage);
+			free(rs->items[i].dst_storage);
 
 			for (j = i + 1; j < rs->nr; j++) {
 				rs->items[j - 1] = rs->items[j];
@@ -481,7 +481,7 @@ static void filter_prefetch_refspec(struct refspec *rs)
 		rs->items[i].dst = strbuf_detach(&new_dst, NULL);
 		rs->items[i].force = 1;
 
-		free(old_dst);
+		free(rs->items[i].dst_storage);
 	}
 }
 
diff --git a/builtin/remote.c b/builtin/remote.c
index b44f580b8c..87b97f5ef1 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -496,8 +496,8 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 	struct refspec_item refspec = {
 		.force = 0,
 		.pattern = 1,
-		.src = (char *) "refs/heads/*",
-		.dst = (char *) "refs/heads/*",
+		.src = "refs/heads/*",
+		.dst = "refs/heads/*",
 	};
 
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
@@ -981,7 +981,7 @@ static int append_ref_to_tracked_list(const char *refname,
 		return 0;
 
 	memset(&refspec, 0, sizeof(refspec));
-	refspec.dst = (char *)refname;
+	refspec.dst = refname;
 	if (!remote_find_tracking(states->remote, &refspec))
 		string_list_append(&states->tracked, abbrev_branch(refspec.src));
 
diff --git a/checkout.c b/checkout.c
index cfaea4bd10..327ab5f6e3 100644
--- a/checkout.c
+++ b/checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 struct tracking_name_data {
-	/* const */ char *src_ref;
+	const char *src_ref;
 	char *dst_ref;
 	struct object_id *dst_oid;
 	int num_matches;
@@ -27,7 +27,7 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 	query.src = cb->src_ref;
 	if (remote_find_tracking(remote, &query) ||
 	    repo_get_oid(the_repository, query.dst, cb->dst_oid)) {
-		free(query.dst);
+		free(query.dst_storage);
 		return 0;
 	}
 	cb->num_matches++;
@@ -38,10 +38,10 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 		cb->default_dst_oid = dst;
 	}
 	if (cb->dst_ref) {
-		free(query.dst);
+		free(query.dst_storage);
 		return 0;
 	}
-	cb->dst_ref = query.dst;
+	cb->dst_ref = query.dst_storage;
 	return 0;
 }
 
@@ -50,14 +50,15 @@ char *unique_tracking_name(const char *name, struct object_id *oid,
 {
 	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	const char *default_remote = NULL;
+	char *src_ref;
 	if (!git_config_get_string_tmp("checkout.defaultremote", &default_remote))
 		cb_data.default_remote = default_remote;
-	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
+	cb_data.src_ref = src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
 	if (dwim_remotes_matched)
 		*dwim_remotes_matched = cb_data.num_matches;
-	free(cb_data.src_ref);
+	free(src_ref);
 	if (cb_data.num_matches == 1) {
 		free(cb_data.default_dst_ref);
 		free(cb_data.default_dst_oid);
diff --git a/refspec.c b/refspec.c
index 1df5de6c2f..a7473c9628 100644
--- a/refspec.c
+++ b/refspec.c
@@ -163,8 +163,10 @@ void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
 
 void refspec_item_clear(struct refspec_item *item)
 {
-	FREE_AND_NULL(item->src);
-	FREE_AND_NULL(item->dst);
+	FREE_AND_NULL(item->src_storage);
+	item->src = NULL;
+	FREE_AND_NULL(item->dst_storage);
+	item->dst = NULL;
 	item->force = 0;
 	item->pattern = 0;
 	item->matching = 0;
diff --git a/refspec.h b/refspec.h
index 754be45cee..fbc4352397 100644
--- a/refspec.h
+++ b/refspec.h
@@ -24,8 +24,10 @@ struct refspec_item {
 	unsigned exact_sha1 : 1;
 	unsigned negative : 1;
 
-	char *src;
-	char *dst;
+	const char *src;
+	const char *dst;
+	char *src_storage;
+	char *dst_storage;
 };
 
 #define REFSPEC_FETCH 1
diff --git a/remote.c b/remote.c
index d319f28757..5cdc3a17cc 100644
--- a/remote.c
+++ b/remote.c
@@ -827,7 +827,8 @@ int remote_has_url(struct remote *remote, const char *url)
 }
 
 static int match_name_with_pattern(const char *key, const char *name,
-				   const char *value, char **result)
+				   const char *value, char **result,
+				   const char **result_const)
 {
 	const char *kstar = strchr(key, '*');
 	size_t klen;
@@ -850,6 +851,8 @@ static int match_name_with_pattern(const char *key, const char *name,
 		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
 		strbuf_addstr(&sb, vstar + 1);
 		*result = strbuf_detach(&sb, NULL);
+		if (result_const)
+			*result_const = *result;
 	}
 	return ret;
 }
@@ -858,7 +861,7 @@ static int refspec_match(const struct refspec_item *refspec,
 			 const char *name)
 {
 	if (refspec->pattern)
-		return match_name_with_pattern(refspec->src, name, NULL, NULL);
+		return match_name_with_pattern(refspec->src, name, NULL, NULL, NULL);
 
 	return !strcmp(refspec->src, name);
 }
@@ -927,7 +930,7 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 			const char *key = refspec->dst ? refspec->dst : refspec->src;
 			const char *value = refspec->src;
 
-			if (match_name_with_pattern(key, needle, value, &expn_name))
+			if (match_name_with_pattern(key, needle, value, &expn_name, NULL))
 				string_list_append_nodup(&reversed, expn_name);
 		} else if (refspec->matching) {
 			/* For the special matching refspec, any query should match */
@@ -967,12 +970,12 @@ static void query_refspecs_multiple(struct refspec *rs,
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
 		const char *needle = find_src ? query->dst : query->src;
-		char **result = find_src ? &query->src : &query->dst;
+		char **result = find_src ? &query->src_storage : &query->dst_storage;
 
 		if (!refspec->dst || refspec->negative)
 			continue;
 		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result))
+			if (match_name_with_pattern(key, needle, value, result, NULL))
 				string_list_append_nodup(results, *result);
 		} else if (!strcmp(needle, key)) {
 			string_list_append(results, value);
@@ -985,7 +988,8 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 	int i;
 	int find_src = !query->src;
 	const char *needle = find_src ? query->dst : query->src;
-	char **result = find_src ? &query->src : &query->dst;
+	char **result = find_src ? &query->src_storage : &query->dst_storage;
+	const char **result_const = find_src ? &query->src : &query->dst;
 
 	if (find_src && !query->dst)
 		BUG("query_refspecs: need either src or dst");
@@ -1001,12 +1005,12 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 		if (!refspec->dst || refspec->negative)
 			continue;
 		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result)) {
+			if (match_name_with_pattern(key, needle, value, result, result_const)) {
 				query->force = refspec->force;
 				return 0;
 			}
 		} else if (!strcmp(needle, key)) {
-			*result = xstrdup(value);
+			*result_const = *result = xstrdup(value);
 			query->force = refspec->force;
 			return 0;
 		}
@@ -1019,12 +1023,12 @@ char *apply_refspecs(struct refspec *rs, const char *name)
 	struct refspec_item query;
 
 	memset(&query, 0, sizeof(struct refspec_item));
-	query.src = (char *)name;
+	query.src = name;
 
 	if (query_refspecs(rs, &query))
 		return NULL;
 
-	return query.dst;
+	return query.dst_storage;
 }
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
@@ -1399,9 +1403,9 @@ static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
 			const char *dst_side = item->dst ? item->dst : item->src;
 			int match;
 			if (direction == FROM_SRC)
-				match = match_name_with_pattern(item->src, ref->name, dst_side, &name);
+				match = match_name_with_pattern(item->src, ref->name, dst_side, &name, NULL);
 			else
-				match = match_name_with_pattern(dst_side, ref->name, item->src, &name);
+				match = match_name_with_pattern(dst_side, ref->name, item->src, &name, NULL);
 			if (match) {
 				matching_refs = i;
 				break;
@@ -2020,7 +2024,7 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
 		if (match_name_with_pattern(refspec->src, ref->name,
-					    refspec->dst, &expn_name) &&
+					    refspec->dst, &expn_name, NULL) &&
 		    !ignore_symref_update(expn_name, &scratch)) {
 			struct ref *cpy = copy_ref(ref);
 
diff --git a/transport.c b/transport.c
index 83ddea8fbc..0cedda425c 100644
--- a/transport.c
+++ b/transport.c
@@ -550,7 +550,7 @@ static void update_one_tracking_ref(struct remote *remote, char *refname,
 			refs_update_ref(get_main_ref_store(the_repository),
 					"update by push", rs.dst, new_oid,
 					NULL, 0, 0);
-		free(rs.dst);
+		free(rs.dst_storage);
 	}
 }
 
