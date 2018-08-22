Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2BE1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 03:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeHVG0g (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 02:26:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:51216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726469AbeHVG0g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 02:26:36 -0400
Received: (qmail 24371 invoked by uid 109); 22 Aug 2018 03:03:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 03:03:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28879 invoked by uid 111); 22 Aug 2018 03:03:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 23:03:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 23:03:44 -0400
Date:   Tue, 21 Aug 2018 23:03:44 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180822030344.GA14684@sigill.intra.peff.net>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822004815.GA535143@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 12:48:16AM +0000, brian m. carlson wrote:

> > diff --git a/cache.h b/cache.h
> > index b1fd3d58ab..9c004a26c9 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1023,7 +1023,10 @@ extern const struct object_id null_oid;
> >  
> >  static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
> >  {
> > -	return memcmp(sha1, sha2, the_hash_algo->rawsz);
> > +	if (the_hash_algo->rawsz == 20)
> > +		return memcmp(sha1, sha2, 20);
> > +	else
> > +		return memcmp(sha1, sha1, the_hash_algo->rawsz);
> >  }
> >  
> >  static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
> > on top of v2.19-rc0 seems to give me about a 3% speedup (though I might
> > be imaging it, as there's a bit of noise). A function pointer in
> > the_hash_algo might make even more sense.
> 
> It's possible that might be a better solution.  I looked into a GCC
> assertion that the value was either 20 or 32, and that in itself didn't
> seem to help, at least in the generated code.  Your solution is likely
> better in that regard.
> 
> We could wire it up to be either 20 or 32 and let people experimenting
> with other sizes of algorithms just add another branch.  I haven't
> tested how that performs, though.

Here's a _really_ dirty one:

diff --git a/cache.h b/cache.h
index b1fd3d58ab..a6750524ea 100644
--- a/cache.h
+++ b/cache.h
@@ -1023,6 +1023,7 @@ extern const struct object_id null_oid;
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
+	assert(the_hash_algo->rawsz == 20);
 	return memcmp(sha1, sha2, the_hash_algo->rawsz);
 }
 

We probably don't want to do that, because it makes experimenting with
new hash algos a bit painful, but it gives the same 3-4% speedup pretty
consistently. But I think it demonstrates pretty clearly that giving the
compiler the extra limit information is sufficient. Presumably the
fixed-size memcmp turns into a few multi-word compares.

And indeed, if I look at the generated asm for the call in lookup_object
(which is likely the one we're hitting a lot in this case), I see:

  # cache.h:1027:         return memcmp(sha1, sha2, the_hash_algo->rawsz);
          .loc 4 1027 9 is_stmt 0 view .LVU86
          movq    (%rsi), %rcx    # MEM[(void *)sha1_25(D)], MEM[(void *)sha1_25(D)]
          movq    8(%rsi), %rdi   # MEM[(void *)sha1_25(D)], tmp125
          xorq    4(%rax), %rcx   # MEM[(void *)_6], tmp116
          xorq    8(%r8), %rdi    # MEM[(void *)_6], tmp115
          orq     %rcx, %rdi      # tmp116, tmp115
          jne     .L27    #,
          movl    16(%r8), %ecx   # MEM[(void *)_6], tmp129
          cmpl    %ecx, 16(%rsi)  # tmp129, MEM[(void *)sha1_25(D)]
          jne     .L27    #,

So I wonder if there's some other way to tell the compiler that we'll
only have a few values. An enum comes to mind, though I don't think the
enum rules are strict enough to make this guarantee (after all, it's OK
to bitwise-OR enums, so they clearly don't specify all possible values).

Having a dedicate hashcmp function for each hash_algo seems like the
sanest approach. We pay for one indirect function call, but the function
itself will have the constants available. But it does introduce one
extra complication. We're benefiting here from knowing that the size is
always 20, but also the inline hashcmp knows that we only care about
equality, not comparison.

So if I do this:

diff --git a/cache.h b/cache.h
index b1fd3d58ab..da56da7be2 100644
--- a/cache.h
+++ b/cache.h
@@ -1023,7 +1023,7 @@ extern const struct object_id null_oid;
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
-	return memcmp(sha1, sha2, the_hash_algo->rawsz);
+	return the_hash_algo->cmp_fn(sha1, sha2);
 }
 
 static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
diff --git a/hash.h b/hash.h
index 7c8238bc2e..ac22ba63b6 100644
--- a/hash.h
+++ b/hash.h
@@ -64,6 +64,7 @@ typedef union git_hash_ctx git_hash_ctx;
 typedef void (*git_hash_init_fn)(git_hash_ctx *ctx);
 typedef void (*git_hash_update_fn)(git_hash_ctx *ctx, const void *in, size_t len);
 typedef void (*git_hash_final_fn)(unsigned char *hash, git_hash_ctx *ctx);
+typedef int (*git_hash_cmp_fn)(const void *a, const void *b);
 
 struct git_hash_algo {
 	/*
@@ -90,6 +91,8 @@ struct git_hash_algo {
 	/* The hash finalization function. */
 	git_hash_final_fn final_fn;
 
+	git_hash_cmp_fn cmp_fn;
+
 	/* The OID of the empty tree. */
 	const struct object_id *empty_tree;
 
diff --git a/sha1-file.c b/sha1-file.c
index 97b7423848..7072e360d7 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -69,6 +69,11 @@ static void git_hash_sha1_final(unsigned char *hash, git_hash_ctx *ctx)
 	git_SHA1_Final(hash, &ctx->sha1);
 }
 
+static int git_hash_sha1_cmp(const void *a, const void *b)
+{
+	return memcmp(a, b, 20);
+}
+
 static void git_hash_unknown_init(git_hash_ctx *ctx)
 {
 	BUG("trying to init unknown hash");
@@ -84,6 +89,11 @@ static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ctx)
 	BUG("trying to finalize unknown hash");
 }
 
+static int git_hash_unknown_cmp(const void *a, const void *b)
+{
+	BUG("trying to compare unknown hash");
+}
+
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	{
 		NULL,
@@ -93,6 +103,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		git_hash_unknown_init,
 		git_hash_unknown_update,
 		git_hash_unknown_final,
+		git_hash_unknown_cmp,
 		NULL,
 		NULL,
 	},
@@ -105,6 +116,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		git_hash_sha1_init,
 		git_hash_sha1_update,
 		git_hash_sha1_final,
+		git_hash_sha1_cmp,
 		&empty_tree_oid,
 		&empty_blob_oid,
 	},

the result is actually _slower_ than the current code.

If I instead introduce an "eq" function, then that function can do the
optimized thing. So if I do something more like this:

diff --git a/cache.h b/cache.h
index b1fd3d58ab..52533a9710 100644
--- a/cache.h
+++ b/cache.h
@@ -1026,6 +1026,11 @@ static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 	return memcmp(sha1, sha2, the_hash_algo->rawsz);
 }
 
+static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
+{
+	return the_hash_algo->eq_fn(sha1, sha2);
+}
+
 static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
 {
 	return hashcmp(oid1->hash, oid2->hash);
diff --git a/sha1-file.c b/sha1-file.c
index 97b7423848..a491ff5bef 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -69,6 +69,11 @@ static void git_hash_sha1_final(unsigned char *hash, git_hash_ctx *ctx)
 	git_SHA1_Final(hash, &ctx->sha1);
 }
 
+static int git_hash_sha1_eq(const void *a, const void *b)
+{
+	return !memcmp(a, b, 20);
+}
+
 static void git_hash_unknown_init(git_hash_ctx *ctx)
 {
 	BUG("trying to init unknown hash");
> [omitting similar hunks from the last one]

plus converting this one callsite:

diff --git a/object.c b/object.c
index 51c4594515..e54160550c 100644
--- a/object.c
+++ b/object.c
@@ -95,7 +95,7 @@ struct object *lookup_object(struct repository *r, const unsigned char *sha1)
 
 	first = i = hash_obj(sha1, r->parsed_objects->obj_hash_size);
 	while ((obj = r->parsed_objects->obj_hash[i]) != NULL) {
-		if (!hashcmp(sha1, obj->oid.hash))
+		if (hasheq(sha1, obj->oid.hash))
 			break;
 		i++;
 		if (i == r->parsed_objects->obj_hash_size)

I get about a 1.5% speedup. If I apply this coccinelle patch:

@@
expression a, b;
@@
- !hashcmp(a, b)
+ hasheq(a, b)

@@
expression a, b;
@@
- !oidcmp(a, b)
+ oideq(a, b)

with the obvious "oideq()" implementation added, that seems to get me to
2-3%. Not _quite_ as good as the original branching version I showed.
And we had to touch all the callsites (although arguably that kind of
"eq" function is a better interface anyway, since it obviously allows
for more optimization.

So maybe the branching thing is actually not so insane. It makes new
hash_algo's Just Work; they just won't be optimized. And the change is
very localized.

Or maybe it's crazy to spend any effort at all chasing a few percent.
It's not like people's large repositories aren't just going to grow by
that much after a few months anyway. ;) It just seems like if we can do
it for little cost, it's worth it.

-Peff
