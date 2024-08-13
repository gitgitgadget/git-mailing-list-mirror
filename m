Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246923749
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 05:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723525341; cv=none; b=Gz/KXpGLWh7gxhEeoyP/Vi5QxvO0K3jTXwEyB9bsdpRZGu8dXgXHeblHltyY1v085so4s+N6N6TlIDUyA9fbkVXXV8iZcamOl82dba/WlQa2np+FQr6QfAxo4gwTSSSC1uA3Ai2RuBrLKAUZtm9JU+1bJ/2mV8sFZh1dAY5XQXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723525341; c=relaxed/simple;
	bh=a705GlRxw0BpUqdAxV6aK8sQBULOqFXerHXaIDKxdfc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DnemS0X5L8ZxbtPOn6jwb7mOyXMiD7bvbTHS6rSB/vRscZIxD06TfFKPI5BVNux+0gCSUu+fyeUJOXwb6dF3Qd4AxjC9tTRysb5S3eCQZYMjmdukKga9kJFd8ibLn/L6SfzEyWVgRwd6AiDOUmS515CfbOUsFGe/j41NZwxnh/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1817 invoked by uid 109); 13 Aug 2024 05:02:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Aug 2024 05:02:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3175 invoked by uid 111); 13 Aug 2024 05:02:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Aug 2024 01:02:20 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Aug 2024 01:02:16 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: [PATCH] midx: drop unused parameters from add_midx_to_chain()
Message-ID: <20240813050216.GA394231@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

When loading a chained midx, we build up an array of hashes, one per
layer of the chain. But since the chain is also represented by the
linked list of multi_pack_index structs, nobody actually reads this
array. We pass it to add_midx_to_chain(), but the parameters are
completely ignored.

So we can drop those unused parameters. And then we can see that its
sole caller, load_midx_chain_fd_st(), only cares about one layer hash at a
time (for parsing each line and feeding it to the single-layer midx
code). So we can replace the array with a single object_id on the stack.

Signed-off-by: Jeff King <peff@peff.net>
---
The tb/incremental-midx-part-1 topic hit 'next', so my unused-parameter
topic flagged this. Usually I just queue the annotations to send in a
batch, but this one made me think for a minute to make sure that it
wasn't a bug (I think it's just a leftover from early development).
It should apply directly on top of what Junio has queued.

I really need to polish up the remainder of those annotations and send
them in (I've been waiting a bit because there's a lot of flux around
t/helper and unit-test migrations, which all need a lot of annotations).
But then we could notice this stuff in a more timely manner.

 midx.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/midx.c b/midx.c
index c867b2b6c2..ca98bfd7c6 100644
--- a/midx.c
+++ b/midx.c
@@ -264,9 +264,7 @@ static int open_multi_pack_index_chain(const char *chain_file,
 }
 
 static int add_midx_to_chain(struct multi_pack_index *midx,
-			     struct multi_pack_index *midx_chain,
-			     struct object_id *oids,
-			     int n)
+			     struct multi_pack_index *midx_chain)
 {
 	if (midx_chain) {
 		if (unsigned_add_overflows(midx_chain->num_packs,
@@ -300,21 +298,20 @@ static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
 {
 	struct multi_pack_index *midx_chain = NULL;
 	struct strbuf buf = STRBUF_INIT;
-	struct object_id *layers = NULL;
 	int valid = 1;
 	uint32_t i, count;
 	FILE *fp = xfdopen(fd, "r");
 
 	count = st->st_size / (the_hash_algo->hexsz + 1);
-	CALLOC_ARRAY(layers, count);
 
 	for (i = 0; i < count; i++) {
 		struct multi_pack_index *m;
+		struct object_id layer;
 
 		if (strbuf_getline_lf(&buf, fp) == EOF)
 			break;
 
-		if (get_oid_hex(buf.buf, &layers[i])) {
+		if (get_oid_hex(buf.buf, &layer)) {
 			warning(_("invalid multi-pack-index chain: line '%s' "
 				  "not a hash"),
 				buf.buf);
@@ -325,12 +322,12 @@ static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
 		valid = 0;
 
 		strbuf_reset(&buf);
-		get_split_midx_filename_ext(&buf, object_dir, layers[i].hash,
+		get_split_midx_filename_ext(&buf, object_dir, layer.hash,
 					    MIDX_EXT_MIDX);
 		m = load_multi_pack_index_one(object_dir, buf.buf, local);
 
 		if (m) {
-			if (add_midx_to_chain(m, midx_chain, layers, i)) {
+			if (add_midx_to_chain(m, midx_chain)) {
 				midx_chain = m;
 				valid = 1;
 			} else {
@@ -343,7 +340,6 @@ static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
 		}
 	}
 
-	free(layers);
 	fclose(fp);
 	strbuf_release(&buf);
 
-- 
2.46.0.419.g66cd00f2b7
