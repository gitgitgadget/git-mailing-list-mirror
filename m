Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322211386C6
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727210250; cv=none; b=Wkl6XBe7fkE1QBkjZqPRbG6Totu/l0gOPJ1AnUnrhsIx6AJDAy20fx6IdA6fZHS4cueKVNnh452RxgB4lwCiIe87OAEH/B2v9Di9A4f/O4QiaFhuKs/7mSSZFvllr3fjup70AI/alzKbLFW9i+O7gDNGfe0XuoAIjntveRgjeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727210250; c=relaxed/simple;
	bh=yxXkd0AWIIEYxyHSQPPeSzyMYCm0Luy3EnHhrP76RZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4UUEscpuxDa8qs0UTS4Sx8aWGQlX8R5ceUx8K7PwE75uFBLBLZoKjA4Hkd6a/y7+j075W9fKYiKtjXXDXGd2r7KqILoXE8Ox4F0A6kbHo+be72xru/bgj0p8l4ueodl/KNie4MDLUuyPFy+S3BYuDQkmOIpazfbS6gsD83oO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14470 invoked by uid 109); 24 Sep 2024 20:37:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 20:37:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17165 invoked by uid 111); 24 Sep 2024 20:37:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 16:37:19 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 16:37:18 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/8] finalize_object_file(): implement collision check
Message-ID: <20240924203718.GA586150@coredump.intra.peff.net>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
 <ed9eeef8513e08935c59defafde99956eb62d49a.1727199118.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed9eeef8513e08935c59defafde99956eb62d49a.1727199118.git.me@ttaylorr.com>

On Tue, Sep 24, 2024 at 01:32:17PM -0400, Taylor Blau wrote:

> Loose objects are exempt from this check, and the collision check may be
> skipped by calling the _flags variant of this function with the
> FOF_SKIP_COLLISION_CHECK bit set. This is done for a couple of reasons:
> 
>   - We don't treat the hash of the loose object file's contents as a
>     checksum, since the same loose object can be stored using different
>     bytes on disk (e.g., when adjusting core.compression, using a
>     different version of zlib, etc.).
> 
>     This is fundamentally different from cases where
>     finalize_object_file() is operating over a file which uses the hash
>     value as a checksum of the contents. In other words, a pair of
>     identical loose objects can be stored using different bytes on disk,
>     and that should not be treated as a collision.

OK, this explains why a byte-for-byte hash-check would be the wrong
thing (it would cause false positives)...

>   - We already use the path of the loose object as its hash value /
>     object name, so checking for collisions at the content level doesn't
>     add anything.
> 
>     This is why we do not bother to check the inflated object contents
>     for collisions either, since either (a) the object contents have the
>     fingerprint of a SHA-1 collision, in which case the collision
>     detecting SHA-1 implementation used to hash the contents to give us
>     a path would have already rejected it, or (b) the contents are part
>     of a colliding pair which does not bear the same fingerprints of
>     known collision attacks, in which case we would not have caught it
>     anyway.
> 
>     So skipping the collision check here does not change for better or
>     worse the hardness of loose object writes.

...and this is the argument for why it is not necessary to do a
content-level check. As you say, we're not making anything worse here,
as we've never implemented this collision check. But I think the "FIXME"
in the code was really there under the notion that it was a backstop to
SHA-1 being broken (belt-and-suspenders, if you will). And your argument
above assumes that SHA-1 (using the DC variant) is safe.

But I think we can expand the argument a bit. I don't think this is a
very good place for such a collision check, because race conditions
aside, we'll already have bailed long before! When we do a write via
write_object_file(), for example, we'll hit the freshen paths that
assume the contents are identical, and skip the write (and thus this
finalize) entirely.

So if you want a collision check, we have to do it at a much higher
level. And indeed we do: index-pack already implements such a check
(through the confusingly named "check_collison" function). I don't think
unpack-objects does so (it looks like it just feeds the result to
write_object_file(), which does the freshening thing).

So the argument I'd make here is more like: this is the wrong place to
do it.

  Side thoughts on collision checks:

    I think index-pack is safe in the sense that it will always prefer
    on-disk copies and will complain if it sees a collision.
    unpack-objects is not, nor are regular in-repo writes (which
    normally cannot be triggered by remote, but on forges that do
    merges, etc, that's not always true). Both of the latter are also
    subject to races, where a simultaneous collision might let the
    attacker win.

    That race is kind of moot in a world where anybody can push to a
    fork of a repo that ends up in the same shared location (so they can
    actually win and become the "on disk" copy), and we're relying on
    sha1dc for protection there. That's specific to certain forges, but
    they do represent a lot of Git use.

    In general, the use of unpack-objects versus index-pack is up to the
    attacker (based on pack size). So I think it would be nice if
    unpack-objects did the collision check. Even if the attacker beats
    you to writing the object, it would be nice to see "holy crap, there
    was a collision" instead of just silently throwing your pushed
    object away.

    I know that GitHub only ever runs index-pack, which may give some
    amount of protection here. In general, I think we should consider
    deprecating unpack-objects in favor of teaching index-pack to
    unpack. It has many enhancements (this one, but also threading) that
    unpack-objects does not. I have an old patch series for this (sorry,
    only from 2017, I'm slipping). IIRC the sticking point was that
    unpack-objects is better about memory use in some cases (streaming
    large blobs?) and I hadn't figured out a way around that.

Phew. Sorry, that was a long digression for "I think you're right, but I
might have argued it a little differently". I think the direction of the
patch (skipping checks entirely for loose objects) is the right thing.

> As a small note related to the latter bullet point above, we must teach
> the tmp-objdir routines to similarly skip the content-level collision
> checks when calling migrate_one() on a loose object file, which we do by
> setting the FOF_SKIP_COLLISION_CHECK bit when we are inside of a loose
> object shard.

OK, this is the part I was wondering how you were going to deal with. :)
Let's look at the implementation...

> @@ -239,11 +247,15 @@ static int migrate_paths(struct strbuf *src, struct strbuf *dst)
>  
>  	for (i = 0; i < paths.nr; i++) {
>  		const char *name = paths.items[i].string;
> +		enum finalize_object_file_flags flags_copy = flags;
>  
>  		strbuf_addf(src, "/%s", name);
>  		strbuf_addf(dst, "/%s", name);
>  
> -		ret |= migrate_one(src, dst);
> +		if (is_loose_object_shard(name))
> +			flags_copy |= FOF_SKIP_COLLISION_CHECK;
> +
> +		ret |= migrate_one(src, dst, flags_copy);
>  
>  		strbuf_setlen(src, src_len);
>  		strbuf_setlen(dst, dst_len);

This looks pretty reasonable overall, though I'd note that
migrate_paths() is called recursively. So if I had:

  tmp-objdir-XXXXXX/pack/ab/foo.pack

we'd skip the collision check. I'm not sure how much we want to worry
about that. I don't think we'd ever create such a path, and the general
form of the paths is all under local control, so an attacker can't
convince us to do so. And I find it pretty unlikely that we'd change the
on-disk layout to accidentally trigger this.

So even though there are security implications if we have a false
positive from is_loose_object_shard(), I don't know that it's worth
caring about.

If we did want to, I think a more robust check is to make sure the shard
comes at the start of the path. Which is tricky, of course, because
we're building a path on top of an arbitrary root (tmp-objdir for
the src, and the repo object dir for the dst).

So you'd have to save that base_len and use it as a root, like the patch
below. I'm OK if you want to write all of this off as over-engineering,
though.

diff --git a/tmp-objdir.c b/tmp-objdir.c
index 9da0071cba..27ba9f4f57 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -207,10 +207,18 @@ static int read_dir_paths(struct string_list *out, const char *path)
 }
 
 static int migrate_paths(struct strbuf *src, struct strbuf *dst,
-			 enum finalize_object_file_flags flags);
+			 size_t base_len);
+
+static int is_loose_path(const char *name)
+{
+	return *name++ == '/' &&
+	       isxdigit(*name++) &&
+	       isxdigit(*name++) &&
+	       *name++ == '/';
+}
 
 static int migrate_one(struct strbuf *src, struct strbuf *dst,
-		       enum finalize_object_file_flags flags)
+		       size_t base_len)
 {
 	struct stat st;
 
@@ -222,18 +230,16 @@ static int migrate_one(struct strbuf *src, struct strbuf *dst,
 				return -1;
 		} else if (errno != EEXIST)
 			return -1;
-		return migrate_paths(src, dst, flags);
+		return migrate_paths(src, dst, base_len);
 	}
-	return finalize_object_file_flags(src->buf, dst->buf, flags);
+	return finalize_object_file_flags(src->buf, dst->buf,
+					  is_loose_path(src->buf + base_len) ?
+					  FOF_SKIP_COLLISION_CHECK : 0);
 }
 
-static int is_loose_object_shard(const char *name)
-{
-	return strlen(name) == 2 && isxdigit(name[0]) && isxdigit(name[1]);
-}
 
 static int migrate_paths(struct strbuf *src, struct strbuf *dst,
-			 enum finalize_object_file_flags flags)
+			 size_t base_len)
 {
 	size_t src_len = src->len, dst_len = dst->len;
 	struct string_list paths = STRING_LIST_INIT_DUP;
@@ -247,15 +253,11 @@ static int migrate_paths(struct strbuf *src, struct strbuf *dst,
 
 	for (i = 0; i < paths.nr; i++) {
 		const char *name = paths.items[i].string;
-		enum finalize_object_file_flags flags_copy = flags;
 
 		strbuf_addf(src, "/%s", name);
 		strbuf_addf(dst, "/%s", name);
 
-		if (is_loose_object_shard(name))
-			flags_copy |= FOF_SKIP_COLLISION_CHECK;
-
-		ret |= migrate_one(src, dst, flags_copy);
+		ret |= migrate_one(src, dst, base_len);
 
 		strbuf_setlen(src, src_len);
 		strbuf_setlen(dst, dst_len);
@@ -283,7 +285,7 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	strbuf_addbuf(&src, &t->path);
 	strbuf_addstr(&dst, repo_get_object_directory(the_repository));
 
-	ret = migrate_paths(&src, &dst, 0);
+	ret = migrate_paths(&src, &dst, src.len);
 
 	strbuf_release(&src);
 	strbuf_release(&dst);
