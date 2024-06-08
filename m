Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3742A8D
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717844373; cv=none; b=YIkxvKas4Zutr3cG0srvuzTkH6ran8ZRLbpnjJES7CcXyCQGyYsfuKZV7c98rGypd13JpXGKb+DXiAgB4Pd7sm6Sv4NocXGW1uPOvbNN/o3GvqtjYHJz+xm6i3x6QZ/9avydP2quixArQ5Mit8XCW55rZn8XZmxofDnEGL6fW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717844373; c=relaxed/simple;
	bh=qW6M3T+coE5vvVRK7iMRmxhQ9vnHU6kWthVnS2jkMqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mX8DnKLm7ROvKoqWwERJ5ZcmgiY465WugfO3B5lm6o57aHodIfh2MAPd62g3dwssmFsfcW9aeXDSDeV8sN6BLEzEiZe9z9Y90mX7CoMN4KxC9U4UR/TCDrfrX6gVGNWtRqCEHYxpro/7jcsvyji6V23HaDhsOHflytJ5ipMxMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8646 invoked by uid 109); 8 Jun 2024 10:59:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 10:59:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29617 invoked by uid 111); 8 Jun 2024 10:59:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 06:59:29 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 06:59:29 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 02/19] global: assign non-const strings as required
Message-ID: <20240608105929.GA2966571@coredump.intra.peff.net>
References: <cover.1716983704.git.ps@pks.im>
 <51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
 <xmqqplt4y1gk.fsf@gitster.g>
 <ZlhjN7K8JKYz6Opd@tanuki>
 <xmqq34pzozsq.fsf@gitster.g>
 <ZlnJ83qSnGlQ0FWR@tanuki>
 <xmqq4jaehui6.fsf@gitster.g>
 <20240605104646.GA3972667@coredump.intra.peff.net>
 <xmqqplsvtirr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplsvtirr.fsf@gitster.g>

On Wed, Jun 05, 2024 at 10:13:28AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, May 31, 2024 at 08:27:13AM -0700, Junio C Hamano wrote:
> >
> >> I wonder if we can do something to separate these two concerns
> >> apart, using a trick similar to what we often use with an extra
> >> variable "to_free".  Doing so would bloat the refspec_item, but
> >> unlike the references themselves, there won't be thousands of them,
> >> so it may not be an issue, perhaps?
> >
> > I had a similar thought while looking at this spot a while ago, so I dug
> > this attempt out of my stash. It's quite ugly, as you need to keep the
> > storage pointer and the const pointer in sync. Especially because
> > there's a lot of clever pointer indirection via match_name_with_pattern().
> 
> Ah, true.  The patch itself does not look _too_ bad, but that may
> simply be because the original is bad enough ;-)

A lot of it is not how bad the patch itself looks, but how hard it was
to write. Each site which touches "src" needs to consider whether it
should be "src_storage", and there was a lot of running the test suite
with ASan, followed by head-scratching. I _think_ I got all of the right
spots, but who knows. ;)

Anyway, I think Patrick is quite sensible in not pursuing it further for
this series. But just for posterity, here's a slightly less invasive
version of the patch I showed earlier. I had added an extra arguments to
match_name_with_pattern() to auto-assign the "const" version, but it
turned out that only one caller cared about it (and had to manually
assign the const version in its fallback code path anyway!).

So this version has a little less noise in it.

---
 branch.c         |  6 +++---
 builtin/fetch.c  |  8 ++++----
 builtin/remote.c |  6 +++---
 checkout.c       | 13 +++++++------
 refspec.c        |  6 ++++--
 refspec.h        |  6 ++++--
 remote.c         | 12 +++++++-----
 transport.c      |  2 +-
 8 files changed, 33 insertions(+), 26 deletions(-)

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
index d319f28757..d1511ecf83 100644
--- a/remote.c
+++ b/remote.c
@@ -967,7 +967,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
 		const char *needle = find_src ? query->dst : query->src;
-		char **result = find_src ? &query->src : &query->dst;
+		char **result = find_src ? &query->src_storage : &query->dst_storage;
 
 		if (!refspec->dst || refspec->negative)
 			continue;
@@ -985,7 +985,8 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 	int i;
 	int find_src = !query->src;
 	const char *needle = find_src ? query->dst : query->src;
-	char **result = find_src ? &query->src : &query->dst;
+	char **result = find_src ? &query->src_storage : &query->dst_storage;
+	const char **result_const = find_src ? &query->src : &query->dst;
 
 	if (find_src && !query->dst)
 		BUG("query_refspecs: need either src or dst");
@@ -1002,11 +1003,12 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 			continue;
 		if (refspec->pattern) {
 			if (match_name_with_pattern(key, needle, value, result)) {
+				*result_const = *result;
 				query->force = refspec->force;
 				return 0;
 			}
 		} else if (!strcmp(needle, key)) {
-			*result = xstrdup(value);
+			*result_const = *result = xstrdup(value);
 			query->force = refspec->force;
 			return 0;
 		}
@@ -1019,12 +1021,12 @@ char *apply_refspecs(struct refspec *rs, const char *name)
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
 
