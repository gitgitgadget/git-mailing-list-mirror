Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06731AF0DE
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839614; cv=none; b=vFLXNH2uvQ+QNZw0fqJBpAuSBAtaVdBASeWs1gwcf9QbbBLTW4s4QUlkdwXz0Rrm/ikpTlHll8jJ468U6q42ogYh9nr+rQgZhnkOs3VdHhkzesJPnbpy5GCwLoNvDy61S9Vq0EfPydw8v4HI1mM14onzizvxK10ArLNABfarLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839614; c=relaxed/simple;
	bh=VQjlTCqxlJxLPvpUAtD57p3Xs8gclA30Bg6ooHtuN+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXOp6U1lSB65Wi+42mVlA/cUZksqL9Hv4UzENnQaDnBCVg2lktMPYQgG4szOoU0RJaYon7SrlMfVLxzndTdpuNbt9CWtxIeHtVr2DTQmNA7n9Mun0lDXthIaK9KLv63yif7CRTvQTygYl81lMknSmzmMjdmitYGhxEve5RV1r6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Zji/KSDw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Zji/KSDw"
Received: (qmail 501 invoked by uid 109); 25 Oct 2024 07:00:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VQjlTCqxlJxLPvpUAtD57p3Xs8gclA30Bg6ooHtuN+w=; b=Zji/KSDwKYNyLbtWbXpPzBZ9g4idY4+uDwvX7J8oEZPxUMiIvcTpojzRZVtVZUGCxhy7/y9L5XY+Xcn+no2CfvJ+wO3cTZH56qqTJK1mszJMiqOqluU5tfkT+n29j54j2DZa5Eqtjc+atPgWNA6DmC5OhLSbnIx+O+Bqr7l4TJOhFxUli1FvjrOrduJga73W8fZO1aIibVIpzixJ/0Lw6+zkPFM8jq23CTPJQSjQr2gaPpkQ/SvEzgwpUE7ABu47yErUwi8chSDU2WZFa9aXFpiw0E9hoH6NYgErGr6Og2pWC78mKLUc985E46QsRMEZeXyxMcu88chWHh2KMuSTYw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 07:00:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12834 invoked by uid 111); 25 Oct 2024 07:00:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 03:00:10 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 03:00:09 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: [PATCH 04/11] packfile: drop has_pack_index()
Message-ID: <20241025070009.GD2110355@coredump.intra.peff.net>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025064148.GA2110169@coredump.intra.peff.net>

The has_pack_index() function has several oddities that may make it
surprising if you are trying to find out if we have a pack with some
$hash:

  - it is not looking for a valid pack that we found while searching
    object directories. It just looks for any pack-$hash.idx file in the
    pack directory.

  - it only looks in the local directory, not any alternates

  - it takes a bare "unsigned char" hash, which we try to avoid these
    days

The only caller it has is in the dumb http code; it wants to know if we
already have the pack idx in question. This can happen if we downloaded
the pack (and generated its index) during a previous fetch.

Before the previous patch ("dumb-http: store downloaded pack idx as
tempfile"), it could also happen if we downloaded the .idx from the
remote but didn't get the matching .pack. But since that patch, we don't
hold on to those .idx files. So there's no need to look for the .idx
file in the filesystem; we can just scan through the packed_git list to
see if we have it.

That lets us simplify the dumb http code a bit, as we know that if we
have the .idx we have the matching .pack already. And it lets us get rid
of this odd function that is unlikely to be needed again.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c     | 15 ++++++++-------
 packfile.c |  8 --------
 packfile.h |  2 --
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/http.c b/http.c
index 9642cad2e3..03802b9049 100644
--- a/http.c
+++ b/http.c
@@ -2420,15 +2420,17 @@ static char *fetch_pack_index(unsigned char *hash, const char *base_url)
 static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	unsigned char *sha1, const char *base_url)
 {
-	struct packed_git *new_pack;
+	struct packed_git *new_pack, *p;
 	char *tmp_idx = NULL;
 	int ret;
 
-	if (has_pack_index(sha1)) {
-		new_pack = parse_pack_index(sha1, sha1_pack_index_name(sha1));
-		if (!new_pack)
-			return -1; /* parse_pack_index() already issued error message */
-		goto add_pack;
+	/*
+	 * If we already have the pack locally, no need to fetch its index or
+	 * even add it to list; we already have all of its objects.
+	 */
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		if (hasheq(p->hash, sha1, the_repository->hash_algo))
+			return 0;
 	}
 
 	tmp_idx = fetch_pack_index(sha1, base_url);
@@ -2450,7 +2452,6 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	if (ret)
 		return -1;
 
-add_pack:
 	new_pack->next = *packs_head;
 	*packs_head = new_pack;
 	return 0;
diff --git a/packfile.c b/packfile.c
index 16d3bcf7f7..0ead2290d4 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2160,14 +2160,6 @@ int has_object_kept_pack(const struct object_id *oid, unsigned flags)
 	return find_kept_pack_entry(the_repository, oid, flags, &e);
 }
 
-int has_pack_index(const unsigned char *sha1)
-{
-	struct stat st;
-	if (stat(sha1_pack_index_name(sha1), &st))
-		return 0;
-	return 1;
-}
-
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn cb, void *data,
 			    enum for_each_object_flags flags)
diff --git a/packfile.h b/packfile.h
index 0f78658229..b4df3546a3 100644
--- a/packfile.h
+++ b/packfile.h
@@ -193,8 +193,6 @@ int find_kept_pack_entry(struct repository *r, const struct object_id *oid, unsi
 int has_object_pack(const struct object_id *oid);
 int has_object_kept_pack(const struct object_id *oid, unsigned flags);
 
-int has_pack_index(const unsigned char *sha1);
-
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
  * object, 0 otherwise.
-- 
2.47.0.363.g6e72b256be

