Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596A18CBFF
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838625; cv=none; b=EJmeCrqtQUBv8wYc/KfQ+AlcTt+VW8NZSvX/kyvdocFg0NKJw88Woy92yMDsejPasqA7rMInSTn4BdyKkiUFOD1EQTRsKTMEm/2hUVtSE1KcR+GqgvpYg5yMSyfewYNqTDdUi2SI0OP4q796PpUADZULe9chS1A3ahvEpxepMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838625; c=relaxed/simple;
	bh=hMhxGCHIMwT3dqGHqhiJ/U7wqkZnzxJUq6qRk/MgySY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4NmL9kp8RtXi+VwI8EcctaeIYrCsng4k5HExPQ5fVYjo6BfwiD+lpdzLF+M6I/kSMDimkq4kLjnxCwUUQTUFlHe77aZlAqNfRd1/Un58KR1Xzy+fJJiGyk3SKcX/Uyu1Yhm4qRyMW9lU4Wa2z227C2kUxCdiSl/Ac7R74eyI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B+RELIaQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B+RELIaQ"
Received: (qmail 346 invoked by uid 109); 25 Oct 2024 06:43:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hMhxGCHIMwT3dqGHqhiJ/U7wqkZnzxJUq6qRk/MgySY=; b=B+RELIaQwH4oWERhIXc5ckh6PgVBHeCxMMRrgpOr8mtekcfQfYoUHgm3pdkv8u2+aECzMggIZOm9zRFgz1FKry9CaBUSBEmGa6rVNNvesaxCIywR4JaJtPkR2OjVyQHls1u5uNITXlmMNO7yBgQdVpawGTInD9ZMZFWaXJLXOe/iMLXO6o3gKFQOCke+8Qz+nym9FJ2e8viTp0gMfSYJicQt9d8zcyiw0Dl4QoJrM1Jhi/GthbrzVvKh7MSWMmuIsrLfmZPqiJzZ5vaIs+U5isrsdnplf2vBO2tEcIVSPPOproYFHGM9j0SirLaKSkVaDy34pJ7CYiQ9BFrKT5+alg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 06:43:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12661 invoked by uid 111); 25 Oct 2024 06:43:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 02:43:41 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 02:43:40 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee <stolee@gmail.com>, fox <fox.gbr@townlong-yak.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: [PATCH 01/11] midx: avoid duplicate packed_git entries
Message-ID: <20241025064340.GA2110355@coredump.intra.peff.net>
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

When we scan a pack directory to load the idx entries we find into the
packed_git list, we skip any of them that are contained in a midx. We
then load them later lazily if we actually need to access the
corresponding pack, referencing them both from the midx struct and the
packed_git list.

The lazy-load in the midx code checks to see if the midx already
mentions the pack, but doesn't otherwise check the packed_git list. This
makes sense, since we should have added any pack to both lists.

But there's a loophole! If we call close_object_store(), that frees the
midx entirely, but _not_ the packed_git structs, which we must keep
around for Reasons[1]. If we then try to look up more objects, we'll
auto-load the midx again, which won't realize that we've already loaded
those packs, and will create duplicate entries in the packed_git list.

This is possibly inefficient, because it means we may open and map the
pack redundantly. But it can also lead to weird user-visible behavior.
The case I found is in "git repack", which closes and reopens the midx
after repacking and then calls update_server_info(). We end up writing
the duplicate entries into objects/info/packs.

We could obviously de-dup them while writing that file, but it seems
like a violation of more core assumptions that we end up with these
duplicate structs at all.

We can avoid the duplicates reasonably efficiently by checking their
names in the pack_map hash. This annoyingly does require a little more
than a straight hash lookup due to the naming conventions, but it should
only happen when we are about to actually open a pack. I don't think one
extra malloc will be noticeable there.

[1] I'm not entirely sure of all the details, except that we generally
    assume the packed_git structs never go away. We noted this
    restriction in the comment added by 6f1e9394e2 (object: fix leaking
    packfiles when closing object store, 2024-08-08), but it's somewhat
    vague. At any rate, if you try freeing the structs in
    close_object_store(), you can observe segfaults all over the test
    suite. So it might be fixable, but it's not trivial.

Signed-off-by: Jeff King <peff@peff.net>
---
+cc Stolee here as the original midx author. I can't think of a good
reason we'd want to avoid this dup-detection here.

 midx.c                        | 20 +++++++++++++++++---
 t/t5200-update-server-info.sh |  8 ++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 67e0d64004..479812cb9b 100644
--- a/midx.c
+++ b/midx.c
@@ -445,6 +445,7 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 		      uint32_t pack_int_id)
 {
 	struct strbuf pack_name = STRBUF_INIT;
+	struct strbuf key = STRBUF_INIT;
 	struct packed_git *p;
 
 	pack_int_id = midx_for_pack(&m, pack_int_id);
@@ -455,16 +456,29 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
 		    m->pack_names[pack_int_id]);
 
-	p = add_packed_git(pack_name.buf, pack_name.len, m->local);
+	/* pack_map holds the ".pack" name, but we have the .idx */
+	strbuf_addbuf(&key, &pack_name);
+	strbuf_strip_suffix(&key, ".idx");
+	strbuf_addstr(&key, ".pack");
+	p = hashmap_get_entry_from_hash(&r->objects->pack_map,
+					strhash(key.buf), key.buf,
+					struct packed_git, packmap_ent);
+	if (!p) {
+		p = add_packed_git(pack_name.buf, pack_name.len, m->local);
+		if (p) {
+			install_packed_git(r, p);
+			list_add_tail(&p->mru, &r->objects->packed_git_mru);
+		}
+	}
+
 	strbuf_release(&pack_name);
+	strbuf_release(&key);
 
 	if (!p)
 		return 1;
 
 	p->multi_pack_index = 1;
 	m->packs[pack_int_id] = p;
-	install_packed_git(r, p);
-	list_add_tail(&p->mru, &r->objects->packed_git_mru);
 
 	return 0;
 }
diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
index ed9dfd624c..cc51c73986 100755
--- a/t/t5200-update-server-info.sh
+++ b/t/t5200-update-server-info.sh
@@ -39,4 +39,12 @@ test_expect_success 'info/refs updates when changes are made' '
 	! test_cmp a b
 '
 
+test_expect_success 'midx does not create duplicate pack entries' '
+	git repack -d --write-midx &&
+	git repack -d &&
+	grep ^P .git/objects/info/packs >packs &&
+	uniq -d <packs >dups &&
+	test_must_be_empty dups
+'
+
 test_done
-- 
2.47.0.363.g6e72b256be

