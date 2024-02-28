Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6742B9A7
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159867; cv=none; b=MZHu6pAo5nVia6BWmuo1dhQqYPfVfJ4lpIpeNDJsl7h27ucTK08eqpNq2h0ZyFbP0VXJ5eEUsBS3nqYpBBYURLhRRVAJBfqMnhXlH6wdrtEqJ05Tgidddkmhs49Y9a/c2r47LJkKRROPKCbpx5m4WpLyI9as6hn9pGGZW+1eFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159867; c=relaxed/simple;
	bh=87TtlTAuhL/xX7Cv9B9UsWtHyn1rGU6UqHYkJDuMvfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbqJK2MyQ7J91UQU9UHPevepmrB4L118H/forzwO6idc5TKJLav9en8WS6hSp5BTUpd/dcOBVaGExfieXtRnRNJkFA7z72P38+78B4uUZFTR+JxrGC7uNL1ppW5P1l0VM7kloe3Hop4b1Bzl8ChOg/kwqpcDYJws7/QurC5/+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23664 invoked by uid 109); 28 Feb 2024 22:37:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:37:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26750 invoked by uid 111); 28 Feb 2024 22:37:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:37:47 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:37:44 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benjamin Flesch <benjaminflesch@icloud.com>
Subject: [PATCH 3/9] upload-pack: use oidset for deepen_not list
Message-ID: <20240228223744.GC1158131@coredump.intra.peff.net>
References: <20240228223700.GA1157826@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228223700.GA1157826@coredump.intra.peff.net>

We record the oid of every deepen-not line the client sends to us. For a
well-behaved client, the resulting array should be bounded by the number
of unique refs we have. But because there's no de-duplication, a
malicious client can cause the array to grow unbounded by just sending
the same "refs/heads/foo" over and over (assuming such a ref exists).

Since the deepen-not list is just being fed to a "rev-list --not"
traversal, the order of items doesn't matter. So we can replace the
oid_array with an oidset which notices and skips duplicates.

That bounds the memory in malicious cases to be linear in the number of
unique refs. And even in non-malicious cases, there may be a slight
improvement in memory usage if multiple refs point to the same oid
(though in practice this list is probably pretty tiny anyway, as it
comes from the user specifying "--shallow-exclude" on the client fetch).

Note that in the trace2 output we'll now output the number of
de-duplicated objects, rather than the total number of "deepen-not"
lines we received. This is arguably a more useful value for tracing /
debugging anyway.

Reported-by: Benjamin Flesch <benjaminflesch@icloud.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index f6395b210e..ebad9026d7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -65,7 +65,7 @@ struct upload_pack_data {
 	struct strvec hidden_refs;
 
 	struct object_array shallows;
-	struct oid_array deepen_not;
+	struct oidset deepen_not;
 	struct object_array extra_edge_obj;
 	int depth;
 	timestamp_t deepen_since;
@@ -125,7 +125,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	struct object_array want_obj = OBJECT_ARRAY_INIT;
 	struct object_array have_obj = OBJECT_ARRAY_INIT;
 	struct object_array shallows = OBJECT_ARRAY_INIT;
-	struct oid_array deepen_not = OID_ARRAY_INIT;
+	struct oidset deepen_not = OID_ARRAY_INIT;
 	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 	struct object_array extra_edge_obj = OBJECT_ARRAY_INIT;
 	struct string_list allowed_filters = STRING_LIST_INIT_DUP;
@@ -158,7 +158,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	object_array_clear(&data->want_obj);
 	object_array_clear(&data->have_obj);
 	object_array_clear(&data->shallows);
-	oid_array_clear(&data->deepen_not);
+	oidset_clear(&data->deepen_not);
 	object_array_clear(&data->extra_edge_obj);
 	list_objects_filter_release(&data->filter_options);
 	string_list_clear(&data->allowed_filters, 0);
@@ -923,12 +923,13 @@ static int send_shallow_list(struct upload_pack_data *data)
 		strvec_push(&av, "rev-list");
 		if (data->deepen_since)
 			strvec_pushf(&av, "--max-age=%"PRItime, data->deepen_since);
-		if (data->deepen_not.nr) {
+		if (oidset_size(&data->deepen_not)) {
+			const struct object_id *oid;
+			struct oidset_iter iter;
 			strvec_push(&av, "--not");
-			for (i = 0; i < data->deepen_not.nr; i++) {
-				struct object_id *oid = data->deepen_not.oid + i;
+			oidset_iter_init(&data->deepen_not, &iter);
+			while ((oid = oidset_iter_next(&iter)))
 				strvec_push(&av, oid_to_hex(oid));
-			}
 			strvec_push(&av, "--not");
 		}
 		for (i = 0; i < data->want_obj.nr; i++) {
@@ -1004,15 +1005,15 @@ static int process_deepen_since(const char *line, timestamp_t *deepen_since, int
 	return 0;
 }
 
-static int process_deepen_not(const char *line, struct oid_array *deepen_not, int *deepen_rev_list)
+static int process_deepen_not(const char *line, struct oidset *deepen_not, int *deepen_rev_list)
 {
 	const char *arg;
 	if (skip_prefix(line, "deepen-not ", &arg)) {
 		char *ref = NULL;
 		struct object_id oid;
 		if (expand_ref(the_repository, arg, strlen(arg), &oid, &ref) != 1)
 			die("git upload-pack: ambiguous deepen-not: %s", line);
-		oid_array_append(deepen_not, &oid);
+		oidset_insert(deepen_not, &oid);
 		free(ref);
 		*deepen_rev_list = 1;
 		return 1;
@@ -1554,7 +1555,7 @@ static void trace2_fetch_info(struct upload_pack_data *data)
 	jw_object_intmax(&jw, "depth", data->depth);
 	jw_object_intmax(&jw, "shallows", data->shallows.nr);
 	jw_object_bool(&jw, "deepen-since", data->deepen_since);
-	jw_object_intmax(&jw, "deepen-not", data->deepen_not.nr);
+	jw_object_intmax(&jw, "deepen-not", oidset_size(&data->deepen_not));
 	jw_object_bool(&jw, "deepen-relative", data->deepen_relative);
 	if (data->filter_options.choice)
 		jw_object_string(&jw, "filter", list_object_filter_config_name(data->filter_options.choice));
-- 
2.44.0.rc2.424.gbdbf4d014b

