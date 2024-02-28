Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593D31361C0
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159844; cv=none; b=ctMaqUakE1MDscloG+LVh5TccIHKFvm5sK7594Uaw50/ylf3sOg6ZJPB37d15qvwirvmA0fFtyKqvz/2xvW6arhJIASQ2tTAYGHPUq8Xb09lUN+NyJJ0y7rcAxbrzjRHcN9s0DEDPsM5vQJB4ekMj9dGzLJh4C26MPLQgx00TTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159844; c=relaxed/simple;
	bh=DeWKpWdQ7QjUYFKDaRt0vuZGCDAK0/Wf2eLpSi05YJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mS1Zcjw5xsPaKVSXLk7DCtNzPyGsaqYezp5kZIwwONblGgDkNpCBHLI9vY2qC8wJpTWooBCGk6ZSLSQFyUTDQZfOzwzBGXiIcwKNrZE5MppbpwKLlwCqEQYEgwrORwxTpy6ugco/Y583TNvB72LvNSPl9/hxnZKRRgspomDHFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23654 invoked by uid 109); 28 Feb 2024 22:37:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:37:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26727 invoked by uid 111); 28 Feb 2024 22:37:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:37:23 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:37:20 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benjamin Flesch <benjaminflesch@icloud.com>
Subject: [PATCH 2/9] upload-pack: switch deepen-not list to an oid_array
Message-ID: <20240228223720.GB1158131@coredump.intra.peff.net>
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

When we see a "deepen-not" line from the client, we verify that the
given name can be resolved as a ref, and then add it to a string list to
be passed later to an internal "rev-list --not" traversal. We record the
actual refname in the string list (so the traversal resolves it again
later), but we'd be better off recording the resolved oid:

  1. There's a tiny bit of wasted work in resolving it twice.

  2. There's a small race condition with simultaneous updates; the later
     traversal may resolve to a different value (or not at all). This
     shouldn't cause any bad behavior (we do not care about the value
     in this first resolution, so whatever value rev-list gets is OK)
     but it could mean a confusing error message (if upload-pack fails
     to resolve the ref it produces a useful message, but a failing
     traversal later results in just "revision walk setup failed").

  3. It makes it simpler to de-duplicate the results. We don't de-dup at
     all right now, but we will in the next patch.

From the client's perspective the behavior should be the same.

Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 7a83127121..f6395b210e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -65,7 +65,7 @@ struct upload_pack_data {
 	struct strvec hidden_refs;
 
 	struct object_array shallows;
-	struct string_list deepen_not;
+	struct oid_array deepen_not;
 	struct object_array extra_edge_obj;
 	int depth;
 	timestamp_t deepen_since;
@@ -125,7 +125,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	struct object_array want_obj = OBJECT_ARRAY_INIT;
 	struct object_array have_obj = OBJECT_ARRAY_INIT;
 	struct object_array shallows = OBJECT_ARRAY_INIT;
-	struct string_list deepen_not = STRING_LIST_INIT_DUP;
+	struct oid_array deepen_not = OID_ARRAY_INIT;
 	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 	struct object_array extra_edge_obj = OBJECT_ARRAY_INIT;
 	struct string_list allowed_filters = STRING_LIST_INIT_DUP;
@@ -158,7 +158,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	object_array_clear(&data->want_obj);
 	object_array_clear(&data->have_obj);
 	object_array_clear(&data->shallows);
-	string_list_clear(&data->deepen_not, 0);
+	oid_array_clear(&data->deepen_not);
 	object_array_clear(&data->extra_edge_obj);
 	list_objects_filter_release(&data->filter_options);
 	string_list_clear(&data->allowed_filters, 0);
@@ -926,8 +926,8 @@ static int send_shallow_list(struct upload_pack_data *data)
 		if (data->deepen_not.nr) {
 			strvec_push(&av, "--not");
 			for (i = 0; i < data->deepen_not.nr; i++) {
-				struct string_list_item *s = data->deepen_not.items + i;
-				strvec_push(&av, s->string);
+				struct object_id *oid = data->deepen_not.oid + i;
+				strvec_push(&av, oid_to_hex(oid));
 			}
 			strvec_push(&av, "--not");
 		}
@@ -1004,15 +1004,15 @@ static int process_deepen_since(const char *line, timestamp_t *deepen_since, int
 	return 0;
 }
 
-static int process_deepen_not(const char *line, struct string_list *deepen_not, int *deepen_rev_list)
+static int process_deepen_not(const char *line, struct oid_array *deepen_not, int *deepen_rev_list)
 {
 	const char *arg;
 	if (skip_prefix(line, "deepen-not ", &arg)) {
 		char *ref = NULL;
 		struct object_id oid;
 		if (expand_ref(the_repository, arg, strlen(arg), &oid, &ref) != 1)
 			die("git upload-pack: ambiguous deepen-not: %s", line);
-		string_list_append(deepen_not, ref);
+		oid_array_append(deepen_not, &oid);
 		free(ref);
 		*deepen_rev_list = 1;
 		return 1;
-- 
2.44.0.rc2.424.gbdbf4d014b

