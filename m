Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E61361C0
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159837; cv=none; b=EUcJgOoU5Loep02mKBXJ+WMzYdpnxacVbqS1UKaJ7iBsfrdeTlohZAf6Tevth46yA674PDseXd/w0zjgXwAH5v6kHilPN8azoEExhYNn0GoyitIByksofHcNdSdhr8h7QJF7AEGyBA9MSJhR9UO6rrk6PA35aENdi1GuJW84giA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159837; c=relaxed/simple;
	bh=FjO4bKIzsuKCsMop8lwQq9OC/8dAVX0xZdVr5WqOmIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyJ4F/43japnUifLqeGqYHL2/MAeNPPN9cbB9Jsd7XxEOe/wlKXgSIzTkDLk3UHbYngB5TopU8VMXw46ht3PnCAFlLgvwHC+NgchtactP63TFh0Rt6uL2xuBfUw74WtSWtIjDbce9SK6FfgTUlyBiVqK/DiZJVtBLxX2zp1hNK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23646 invoked by uid 109); 28 Feb 2024 22:37:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:37:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26720 invoked by uid 111); 28 Feb 2024 22:37:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:37:15 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:37:13 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benjamin Flesch <benjaminflesch@icloud.com>
Subject: [PATCH 1/9] upload-pack: drop separate v2 "haves" array
Message-ID: <20240228223713.GA1158131@coredump.intra.peff.net>
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

When upload-pack sees a "have" line in the v0 protocol, it immediately
calls got_oid() with its argument and potentially produces an ACK
response. In the v2 protocol, we simply record the argument in an
oid_array, and only later process all of the "have" objects by calling
the equivalent of got_oid() on the contents of the array.

This makes some sense, as v2 is a pure request/response protocol, as
opposed to v0's asynchronous negotiation phase. But there's a downside:
a client can send us an infinite number of garbage "have" lines, which
we'll happily slurp into the array, consuming memory. Whereas in v0,
they are limited by the number of objects in the repository (because
got_oid() only records objects we have ourselves, and we avoid
duplicates by setting a flag on the object struct).

We can make v2 behave more like v0 by also calling got_oid() directly
when v2 parses a "have" line. Calling it early like this is OK because
got_oid() itself does not interact with the client; it only confirms
that we have the object and sets a few flags. Note that unlike v0, v2
does not ever (before or after this patch) check the return code of
got_oid(), which lets the caller know whether we have the object. But
again, that makes sense; v0 is using it to asynchronously tell the
client to stop sending. In v2's synchronous protocol, we just discard
those entries (and decide how to ACK at the end of each round).

There is one slight tweak we need, though. In v2's state machine, we
reach the SEND_ACKS state if the other side sent us any "have" lines,
whether they were useful or not. Right now we do that by checking
whether the "have" array had any entries, but if we record only the
useful ones, that doesn't work. Instead, we can add a simple boolean
that tells us whether we saw any have line (even if it was useless).

This lets us drop the "haves" array entirely, as we're now placing
objects directly into the "have_obj" object array (which is where
got_oid() put them in the long run anyway). And as a bonus, we can drop
the secondary "common" array used in process_haves_and_send_acks(). It
was essentially a copy of "haves" minus the objects we do not have. But
now that we are using "have_obj" directly, we know everything in it is
useful. So in addition to protecting ourselves against malicious input,
we should slightly lower our memory usage for normal inputs.

Note that there is one user-visible effect. The trace2 output records
the number of "haves". Previously this was the total number of "have"
lines we saw, but now is the number of useful ones. We could retain the
original meaning by keeping a separate counter, but it doesn't seem
worth the effort; this trace info is for debugging and metrics, and
arguably the count of common oids is at least as useful as the total
count.

Reported-by: Benjamin Flesch <benjaminflesch@icloud.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 48 ++++++++++--------------------------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 2537affa90..7a83127121 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -61,7 +61,6 @@ struct upload_pack_data {
 	struct string_list symref;				/* v0 only */
 	struct object_array want_obj;
 	struct object_array have_obj;
-	struct oid_array haves;					/* v2 only */
 	struct string_list wanted_refs;				/* v2 only */
 	struct strvec hidden_refs;
 
@@ -113,6 +112,7 @@ struct upload_pack_data {
 	unsigned done : 1;					/* v2 only */
 	unsigned allow_ref_in_want : 1;				/* v2 only */
 	unsigned allow_sideband_all : 1;			/* v2 only */
+	unsigned seen_haves : 1;				/* v2 only */
 	unsigned advertise_sid : 1;
 	unsigned sent_capabilities : 1;
 };
@@ -124,7 +124,6 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	struct strvec hidden_refs = STRVEC_INIT;
 	struct object_array want_obj = OBJECT_ARRAY_INIT;
 	struct object_array have_obj = OBJECT_ARRAY_INIT;
-	struct oid_array haves = OID_ARRAY_INIT;
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
@@ -137,7 +136,6 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->hidden_refs = hidden_refs;
 	data->want_obj = want_obj;
 	data->have_obj = have_obj;
-	data->haves = haves;
 	data->shallows = shallows;
 	data->deepen_not = deepen_not;
 	data->uri_protocols = uri_protocols;
@@ -159,7 +157,6 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	strvec_clear(&data->hidden_refs);
 	object_array_clear(&data->want_obj);
 	object_array_clear(&data->have_obj);
-	oid_array_clear(&data->haves);
 	object_array_clear(&data->shallows);
 	string_list_clear(&data->deepen_not, 0);
 	object_array_clear(&data->extra_edge_obj);
@@ -1532,15 +1529,14 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
 	return 0;
 }
 
-static int parse_have(const char *line, struct oid_array *haves)
+static int parse_have(const char *line, struct upload_pack_data *data)
 {
 	const char *arg;
 	if (skip_prefix(line, "have ", &arg)) {
 		struct object_id oid;
 
-		if (get_oid_hex(arg, &oid))
-			die("git upload-pack: expected SHA1 object, got '%s'", arg);
-		oid_array_append(haves, &oid);
+		got_oid(data, arg, &oid);
+		data->seen_haves = 1;
 		return 1;
 	}
 
@@ -1552,7 +1548,7 @@ static void trace2_fetch_info(struct upload_pack_data *data)
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	jw_object_intmax(&jw, "haves", data->haves.nr);
+	jw_object_intmax(&jw, "haves", data->have_obj.nr);
 	jw_object_intmax(&jw, "wants", data->want_obj.nr);
 	jw_object_intmax(&jw, "want-refs", data->wanted_refs.nr);
 	jw_object_intmax(&jw, "depth", data->depth);
@@ -1586,7 +1582,7 @@ static void process_args(struct packet_reader *request,
 				   &data->hidden_refs, &data->want_obj))
 			continue;
 		/* process have line */
-		if (parse_have(arg, &data->haves))
+		if (parse_have(arg, data))
 			continue;
 
 		/* process args like thin-pack */
@@ -1664,27 +1660,7 @@ static void process_args(struct packet_reader *request,
 		trace2_fetch_info(data);
 }
 
-static int process_haves(struct upload_pack_data *data, struct oid_array *common)
-{
-	int i;
-
-	/* Process haves */
-	for (i = 0; i < data->haves.nr; i++) {
-		const struct object_id *oid = &data->haves.oid[i];
-
-		if (!repo_has_object_file_with_flags(the_repository, oid,
-						     OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT))
-			continue;
-
-		oid_array_append(common, oid);
-
-		do_got_oid(data, oid);
-	}
-
-	return 0;
-}
-
-static int send_acks(struct upload_pack_data *data, struct oid_array *acks)
+static int send_acks(struct upload_pack_data *data, struct object_array *acks)
 {
 	int i;
 
@@ -1696,7 +1672,7 @@ static int send_acks(struct upload_pack_data *data, struct oid_array *acks)
 
 	for (i = 0; i < acks->nr; i++) {
 		packet_writer_write(&data->writer, "ACK %s\n",
-				    oid_to_hex(&acks->oid[i]));
+				    oid_to_hex(&acks->objects[i].item->oid));
 	}
 
 	if (!data->wait_for_done && ok_to_give_up(data)) {
@@ -1710,13 +1686,11 @@ static int send_acks(struct upload_pack_data *data, struct oid_array *acks)
 
 static int process_haves_and_send_acks(struct upload_pack_data *data)
 {
-	struct oid_array common = OID_ARRAY_INIT;
 	int ret = 0;
 
-	process_haves(data, &common);
 	if (data->done) {
 		ret = 1;
-	} else if (send_acks(data, &common)) {
+	} else if (send_acks(data, &data->have_obj)) {
 		packet_writer_delim(&data->writer);
 		ret = 1;
 	} else {
@@ -1725,8 +1699,6 @@ static int process_haves_and_send_acks(struct upload_pack_data *data)
 		ret = 0;
 	}
 
-	oid_array_clear(&data->haves);
-	oid_array_clear(&common);
 	return ret;
 }
 
@@ -1796,7 +1768,7 @@ int upload_pack_v2(struct repository *r UNUSED, struct packet_reader *request)
 				 * they didn't want anything.
 				 */
 				state = FETCH_DONE;
-			} else if (data.haves.nr) {
+			} else if (data.seen_haves) {
 				/*
 				 * Request had 'have' lines, so lets ACK them.
 				 */
-- 
2.44.0.rc2.424.gbdbf4d014b

