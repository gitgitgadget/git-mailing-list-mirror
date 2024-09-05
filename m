Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D209F1EBFEC
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532661; cv=none; b=YJae3hxjFQk+NJp6rycQ3KcxegzORbDSxpc7lHXQ9laxaV8Rn2rA+jYnvg/cZwFTaDfuZ8oisZloGyQfakHlnidTkc674zp3u8pI/2U8QenH5ow5OgVvSLFEQnyxOBYGNiZcKihIKeEU24JXsVpr5vleVQumf/OqID6ZT/rm9l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532661; c=relaxed/simple;
	bh=fs9s9qNGwAO5Yvztt8tAKR3vT/Avu/hNNV0MqXoFM10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lV9ledGJVPe7YxdfxSsNZ9oYDYuAqQL5qX7zTgDHHW30HDtVyWnAKe5rt8qKlmRSEL/VV83xI9FzKaBzmYi10ItYkCmh6J6bY0qyMWvCgV7lj/qRWBClM5mMk2yQ2GPX4zoxb7k7a4C5IzTNQShMHkhNvyRDpuQcll6+Bv8oe/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7166 invoked by uid 109); 5 Sep 2024 10:37:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Sep 2024 10:37:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7933 invoked by uid 111); 5 Sep 2024 10:37:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 06:37:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 06:37:36 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <20240905103736.GC2556395@coredump.intra.peff.net>
References: <cover.1725206584.git.me@ttaylorr.com>
 <ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>
 <Ztdn25zfi8WHO+GS@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ztdn25zfi8WHO+GS@nand.local>

On Tue, Sep 03, 2024 at 03:47:39PM -0400, Taylor Blau wrote:

> > Hmm, I'm not sure this is the case.  Let's consider the case where SHA-1
> > becomes as easy to collide as MD4, which requires less than 2 hash
> > operations for a collision, in which case we can assume that it's
> > trivial, because eventually we expect that will happen with advances in
> > technology.
> 
> I'm not sure this attack is possible as you described.
> 
> We still run any packs through index-pack before landing them in
> $GIT_DIR/objects/pack, and index-pack still uses the collision-detecting
> SHA-1 implementation (if the repository uses SHA-1 and Git was compiled
> with it).

I agree this is not a problem with your series as it is, but I think in
the long run we'd want to switch over index-pack, too, for two reasons:

  1. It could benefit from the same speedups on the receiving side that
     your patches give on the sending side (though the difference is
     less noticeable there, because we're also hashing the expanded
     contents).

  2. We'll have to do so if switch to a non-cryptographic hash (as is
     discussed elsewhere in this thread), since the two obviously have
     to match.

So let's imagine for a moment that we make that change.

I don't think you can smuggle any duplicate objects this way. We'll
still index each individual object using sha1dc, so any attempts to
collide there will be caught. You'd need totally different objects that
are in a packfile that happens to hash to the same checksum. And then
since the receiver is the one computing the object id of those objects,
they won't match (modulo some racing, which I'll get to).

But I do think you could do a denial-of-service attack by corrupting the
receiving repo. Imagine that:

  1. I (somehow) know you have a pack with hash XYZ, and thus that
     you'll be storing objects/pack/pack-XYZ.pack.

  2. I generate a new, valid pack that contains 100 random objects
     (or enough to defeat transfer.unpackLimit). I mutate that objects'
     contents until my new pack also has hash XYZ.

  3. I send you that pack (e.g., via push if you're a server, or by
     manipulating you into fetch if you're a client). You index the
     pack, see that it should be called pack-XYZ.pack, and then rename()
     it on top of your existing file.

Now you've just lost access to all of those objects, and your repo is
broken.

We should be able to simulate this in practice. First, let's weaken the
"fast" sha1 such that it retains only the final two bits:

diff --git a/sha1/openssl.h b/sha1/openssl.h
index 1038af47da..f0d5c59c43 100644
--- a/sha1/openssl.h
+++ b/sha1/openssl.h
@@ -32,6 +32,8 @@ static inline void openssl_SHA1_Final(unsigned char *digest,
 {
 	EVP_DigestFinal_ex(ctx->ectx, digest, NULL);
 	EVP_MD_CTX_free(ctx->ectx);
+	memset(digest, 0, 19);
+	digest[19] &= 0x3;
 }
 
 static inline void openssl_SHA1_Clone(struct openssl_SHA1_CTX *dst,

Now we can build with OPENSSL_SHA1_FAST=1, and use the result (which I
call git.compile below) to repack some victim repo:

  # use regular Git to clone first
  git clone --no-local --bare /some/repo victim.git

  # and now use our weak hash to repack; you should end up with
  # pack-000000...003.pack or similar
  git.compile -C victim.git repack -ad

We can even fsck it, if we teach the fsck code to use our weak hash (as
an aside, I think it is weird that fsck has its own hash verification;
it should probably be relying on verify-pack for this, but I haven't dug
into this in a while and IIRC there are some complications):

diff --git a/pack-check.c b/pack-check.c
index e883dae3f2..1b80616c70 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -67,7 +67,7 @@ static int verify_packfile(struct repository *r,
 	if (!is_pack_valid(p))
 		return error("packfile %s cannot be accessed", p->pack_name);
 
-	r->hash_algo->init_fn(&ctx);
+	r->hash_algo->fast_init_fn(&ctx);
 	do {
 		unsigned long remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
@@ -76,9 +76,9 @@ static int verify_packfile(struct repository *r,
 			pack_sig_ofs = p->pack_size - r->hash_algo->rawsz;
 		if (offset > pack_sig_ofs)
 			remaining -= (unsigned int)(offset - pack_sig_ofs);
-		r->hash_algo->update_fn(&ctx, in, remaining);
+		r->hash_algo->fast_update_fn(&ctx, in, remaining);
 	} while (offset < pack_sig_ofs);
-	r->hash_algo->final_fn(hash, &ctx);
+	r->hash_algo->fast_final_fn(hash, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
 	if (!hasheq(hash, pack_sig, the_repository->hash_algo))
 		err = error("%s pack checksum mismatch",

And now let's teach index-pack to use the weak hash, too:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index fd968d673d..de99405880 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -284,7 +284,7 @@ static void flush(void)
 	if (input_offset) {
 		if (output_fd >= 0)
 			write_or_die(output_fd, input_buffer, input_offset);
-		the_hash_algo->update_fn(&input_ctx, input_buffer, input_offset);
+		the_hash_algo->fast_update_fn(&input_ctx, input_buffer, input_offset);
 		memmove(input_buffer, input_buffer + input_offset, input_len);
 		input_offset = 0;
 	}
@@ -357,7 +357,7 @@ static const char *open_pack_file(const char *pack_name)
 		output_fd = -1;
 		nothread_data.pack_fd = input_fd;
 	}
-	the_hash_algo->init_fn(&input_ctx);
+	the_hash_algo->fast_init_fn(&input_ctx);
 	return pack_name;
 }
 
@@ -1202,9 +1202,9 @@ static void parse_pack_objects(unsigned char *hash)
 
 	/* Check pack integrity */
 	flush();
-	the_hash_algo->init_fn(&tmp_ctx);
-	the_hash_algo->clone_fn(&tmp_ctx, &input_ctx);
-	the_hash_algo->final_fn(hash, &tmp_ctx);
+	the_hash_algo->fast_init_fn(&tmp_ctx);
+	the_hash_algo->fast_clone_fn(&tmp_ctx, &input_ctx);
+	the_hash_algo->fast_final_fn(hash, &tmp_ctx);
 	if (!hasheq(fill(the_hash_algo->rawsz), hash, the_repository->hash_algo))
 		die(_("pack is corrupted (SHA1 mismatch)"));
 	use(the_hash_algo->rawsz);

Now the code is all set. We need to adjust two things in the victim
repo:

  # we could just send 100+ fake objects from the client, but setting this to
  # "1" makes our attack loop simpler
  git -C victim.git config transfer.unpackLimit 1

  # Pushing happens into a quarantine area. And then when we move the
  # files out of quarantine, we do it with finalize_object_file(), which
  # does the usual link collision detection. But:
  #
  #   1. That doesn't happen for fetches, which are done directly in
  #      the pack directory, so the rename() done by index-pack applies
  #      there.
  #
  #   2. If the link() doesn't work for any reason other than EEXIST,
  #      we'll retry it as a rename(). So depending on your filesystem,
  #      this might be triggerable even for push.
  #
  # To simulate the worst case, we'll manually force the push into
  # rename mode.
  git -C victim.git config core.createObject rename

And now we can attack, like so:

  git init evil
  cd evil
  while git.compile -C ../victim.git fsck; do
          ls -l ../victim.git/objects/pack/
          git.compile commit --allow-empty -m foo
          git.compile push ../victim.git HEAD:foo
  done
  ls -l ../victim.git/objects/pack/

It's random whether we'll collide, but since there are only 4
possibilities (from 2 bits), it happens within a couple attempts.
Obviously sha1 is stronger than that, but I think the point is to
prepare for a world where collisions are cheap and easy to produce
(whether because sha1 gets more broken, or because we start using a
non-cryptographic hash).

So I do think there are problems in this general path, even though your
patch is not (yet) exposing them (although it would be easy to do so
accidentally; I was actually moderately surprised that index-pack is not
relying on the hashfile API already).

Probably the solution is:

  - renaming packfiles into place should use finalize_object_file() to
    avoid collisions.  That happens for tmp-objdir migration already,
    but we should do it more directly in index-pack (and maybe even
    pack-objects). And possibly we should implement an actual
    byte-for-byte comparison if we think we saw a collision, rather than
    just assuming that the write was effectively a noopi (see the FIXME
    in that function). That becomes more important if the checksum gets
    more likely to collide accidentally (we essentially ignore the
    possibility that sha1 would ever do so).

  - possibly object_creation_mode should have a more strict setting that
    refuses to fall back to renames. Or alternatively, we should do our
    own check for existence when falling back to a rename() in
    finalize_object_file().


And finally, I mentioned races earlier. I didn't try to reproduce it,
but I suspect there could also be a race like:

  - you have pack-XYZ.pack and pack-XYZ.idx

  - attacker generates evil pack-XYZ.pack as above (and assuming we have
    no fixed anything as I suggested above, and they really can replace
    the receiver's copy).

  - at some moment we will have moved pack-XYZ.pack into place, but not
    yet the matching idx. So we'll have the old idx and the new pack. An
    object lookup at that moment could cause us to find the object using
    the old idx, but then get the data out of the new pack file,
    replacing real data with the attacker's data. It's a pretty small
    window, but probably possible with enough simultaneous reading
    processes. Not something you'd probably want to spend $40k
    generating a collision for, but if we used a weak enough checksum,
    then attempts become cheap.

So I think we really do need to address this to prefer local data. At
which point it should be safe to use a much weaker checksum. But IMHO it
is still worth having a "fast" SHA1. Even if the future is SHA256 repos
or xxHash pack trailers, older clients will still use SHA1.

-Peff
