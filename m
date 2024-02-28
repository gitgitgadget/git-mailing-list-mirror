Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24DB70049
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159924; cv=none; b=NMpP4YiZVm/pk+lQtwxszMl9hCHEzdmVCry/68Vivsj6FvphDjCmG1Ji/YbDg5DD4VxDiw0957WJ6/x7oGeZ/hoXP8qdVigUE6DMq65qbqA3nU9m9IFWvULN/7bCTzqEFpf/RidkLL/uejaLVfME8Cl7EKKME86DJ/yeGTrrLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159924; c=relaxed/simple;
	bh=hGvK0X35QMCtl4linrZNKhDWUC+8pCbGZHFC/XkZh5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPUkkK0fSt9PeqvtEoDM3iEjAAytTNLcORikS/xDXlT9ad6mfSXoH4fl3B6zv1w1yJMDb442fRYuU5OhR7lJejNJoADuZ1LUdSkX8O9bLXffboLwSmmnYiDXe371qsMAfBgJEG6z7/NIY+7RbMM6CwmvEn7pV6yeuQL+4MkVxZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23674 invoked by uid 109); 28 Feb 2024 22:38:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:38:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26756 invoked by uid 111); 28 Feb 2024 22:38:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:38:43 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:38:40 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benjamin Flesch <benjaminflesch@icloud.com>
Subject: [PATCH 4/9] upload-pack: use a strmap for want-ref lines
Message-ID: <20240228223840.GD1158131@coredump.intra.peff.net>
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

When the "ref-in-want" capability is advertised (which it is not by
default), then upload-pack processes a "want-ref" line from the client
by checking that the name is a valid ref and recording it in a
string-list.

In theory this list should grow no larger than the number of refs in the
server-side repository. But since we don't do any de-duplication, a
client which sends "want-ref refs/heads/foo" over and over will cause
the array to grow without bound.

We can fix this by switching to strmap, which efficiently detects
duplicates. There are two client-visible changes here:

  1. The "wanted-refs" response will now be in an apparently-random
     order (based on iterating the hashmap) rather than the order given
     by the client. The protocol documentation is quiet on ordering
     here. The current fetch-pack implementation is happy with any
     order, as it looks up each returned ref using a binary search in
     its local sorted list. JGit seems to implement want-ref on the
     server side, but has no client-side support. libgit2 doesn't
     support either side.

     It would obviously be possible to record the original order or to
     use the strmap as an auxiliary data structure. But if the client
     doesn't care, we may as well do the simplest thing.

  2. We'll now reject duplicates explicitly as a protocol error. The
     client should never send them (and our current implementation, even
     when asked to "git fetch master:one master:two" will de-dup on the
     client side).

     If we wanted to be more forgiving, we could perhaps just throw away
     the duplicates. But then our "wanted-refs" response back to the
     client would omit the duplicates, and it's hard to say what a
     client that accidentally sent a duplicate would do with that. So I
     think we're better off to complain loudly before anybody
     accidentally writes such a client.

Let's also add a note to the protocol documentation clarifying that
duplicates are forbidden. As discussed above, this was already the
intent, but it's not very explicit.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitprotocol-v2.txt |  3 ++-
 upload-pack.c                    | 30 +++++++++++++++++-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 0b800abd56..837ea6171e 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -346,7 +346,8 @@ the 'wanted-refs' section in the server's response as explained below.
     want-ref <ref>
 	Indicates to the server that the client wants to retrieve a
 	particular ref, where <ref> is the full name of a ref on the
-	server.
+	server.  It is a protocol error to send want-ref for the
+	same ref more than once.
 
 If the 'sideband-all' feature is advertised, the following argument can be
 included in the client's request:
diff --git a/upload-pack.c b/upload-pack.c
index ebad9026d7..8b47576ec7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -28,6 +28,7 @@
 #include "shallow.h"
 #include "write-or-die.h"
 #include "json-writer.h"
+#include "strmap.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -61,7 +62,7 @@ struct upload_pack_data {
 	struct string_list symref;				/* v0 only */
 	struct object_array want_obj;
 	struct object_array have_obj;
-	struct string_list wanted_refs;				/* v2 only */
+	struct strmap wanted_refs;				/* v2 only */
 	struct strvec hidden_refs;
 
 	struct object_array shallows;
@@ -120,7 +121,7 @@ struct upload_pack_data {
 static void upload_pack_data_init(struct upload_pack_data *data)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
-	struct string_list wanted_refs = STRING_LIST_INIT_DUP;
+	struct strmap wanted_refs = STRMAP_INIT;
 	struct strvec hidden_refs = STRVEC_INIT;
 	struct object_array want_obj = OBJECT_ARRAY_INIT;
 	struct object_array have_obj = OBJECT_ARRAY_INIT;
@@ -153,7 +154,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 static void upload_pack_data_clear(struct upload_pack_data *data)
 {
 	string_list_clear(&data->symref, 1);
-	string_list_clear(&data->wanted_refs, 1);
+	strmap_clear(&data->wanted_refs, 1);
 	strvec_clear(&data->hidden_refs);
 	object_array_clear(&data->want_obj);
 	object_array_clear(&data->have_obj);
@@ -1488,14 +1489,13 @@ static int parse_want(struct packet_writer *writer, const char *line,
 }
 
 static int parse_want_ref(struct packet_writer *writer, const char *line,
-			  struct string_list *wanted_refs,
+			  struct strmap *wanted_refs,
 			  struct strvec *hidden_refs,
 			  struct object_array *want_obj)
 {
 	const char *refname_nons;
 	if (skip_prefix(line, "want-ref ", &refname_nons)) {
 		struct object_id oid;
-		struct string_list_item *item;
 		struct object *o = NULL;
 		struct strbuf refname = STRBUF_INIT;
 
@@ -1507,8 +1507,11 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
 		}
 		strbuf_release(&refname);
 
-		item = string_list_append(wanted_refs, refname_nons);
-		item->util = oiddup(&oid);
+		if (strmap_put(wanted_refs, refname_nons, oiddup(&oid))) {
+			packet_writer_error(writer, "duplicate want-ref %s",
+					    refname_nons);
+			die("duplicate want-ref %s", refname_nons);
+		}
 
 		if (!starts_with(refname_nons, "refs/tags/")) {
 			struct commit *commit = lookup_commit_in_graph(the_repository, &oid);
@@ -1551,7 +1554,7 @@ static void trace2_fetch_info(struct upload_pack_data *data)
 	jw_object_begin(&jw, 0);
 	jw_object_intmax(&jw, "haves", data->have_obj.nr);
 	jw_object_intmax(&jw, "wants", data->want_obj.nr);
-	jw_object_intmax(&jw, "want-refs", data->wanted_refs.nr);
+	jw_object_intmax(&jw, "want-refs", strmap_get_size(&data->wanted_refs));
 	jw_object_intmax(&jw, "depth", data->depth);
 	jw_object_intmax(&jw, "shallows", data->shallows.nr);
 	jw_object_bool(&jw, "deepen-since", data->deepen_since);
@@ -1705,17 +1708,18 @@ static int process_haves_and_send_acks(struct upload_pack_data *data)
 
 static void send_wanted_ref_info(struct upload_pack_data *data)
 {
-	const struct string_list_item *item;
+	struct hashmap_iter iter;
+	const struct strmap_entry *e;
 
-	if (!data->wanted_refs.nr)
+	if (strmap_empty(&data->wanted_refs))
 		return;
 
 	packet_writer_write(&data->writer, "wanted-refs\n");
 
-	for_each_string_list_item(item, &data->wanted_refs) {
+	strmap_for_each_entry(&data->wanted_refs, &iter, e) {
 		packet_writer_write(&data->writer, "%s %s\n",
-				    oid_to_hex(item->util),
-				    item->string);
+				    oid_to_hex(e->value),
+				    e->key);
 	}
 
 	packet_writer_delim(&data->writer);
-- 
2.44.0.rc2.424.gbdbf4d014b

