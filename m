Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C51C43217
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 22:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933E263219
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 22:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbhKOWzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:55:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:59544 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349824AbhKOWtY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 17:49:24 -0500
Received: (qmail 14481 invoked by uid 109); 15 Nov 2021 22:39:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Nov 2021 22:39:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19893 invoked by uid 111); 15 Nov 2021 22:39:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Nov 2021 17:39:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Nov 2021 17:39:41 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: New-ish warning in refs.c with GCC (at least 11.2) under -O3
Message-ID: <YZLhrSoTzrC7wcQo@coredump.intra.peff.net>
References: <211115.86a6i5s4bn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211115.86a6i5s4bn.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 06:41:00PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This happens on "master", but is old, going back to at least v2.25.0 (I
> didn't bother to test older versions):
>     
>     $ gcc --version
>     gcc (Debian 11.2.0-10) 11.2.0
>     [...]
>     $ make refs.o CC=gcc CFLAGS=-O2
>         * new build flags
>         CC refs.o
>     $ make refs.o CC=gcc CFLAGS=-O3
>         * new build flags
>         CC refs.o
>     In file included from hashmap.h:4,
>                      from cache.h:6,
>                      from refs.c:5:
>     In function ‘oidcpy’,
>         inlined from ‘ref_transaction_add_update’ at refs.c:1065:3,
>         inlined from ‘ref_transaction_update’ at refs.c:1094:2,
>         inlined from ‘ref_transaction_verify’ at refs.c:1132:9:
>     hash.h:262:9: error: argument 2 null where non-null expected [-Werror=nonnull]
>       262 |         memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This seems like a false positive. In ref_transaction_update() we do:

          if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
                  BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
  
          flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);

So we make sure that flags cannot have REF_HAVE_* in it (the allowed
refs are only bits 0 and 1, whereas the HAVE flags are bits 2 and 3).
And then we set them based on the non-NULLness of the parameters. So no
matter what we got passed in, the two are in sync.

And then we call add_update():

          ref_transaction_add_update(transaction, refname, flags,
				     new_oid, old_oid, msg);

which copies only if the flag is set:

        if (flags & REF_HAVE_NEW)
                oidcpy(&update->new_oid, new_oid);

So I don't see how this could go wrong. And the compiler should be able
to figure that out, but only if it does enough analysis to understand
that the flags will always be cleared going into that "|=" line.

We can verify that the ALLOWED_FLAGS check works correctly by doing
something stupid like:

diff --git a/refs.c b/refs.c
index d7cc0a23a3..340d807066 100644
--- a/refs.c
+++ b/refs.c
@@ -1131,7 +1131,7 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 		BUG("verify called with old_oid set to NULL");
 	return ref_transaction_update(transaction, refname,
 				      NULL, old_oid,
-				      flags, NULL, err);
+				      flags | REF_HAVE_NEW, NULL, err);
 }
 
 int refs_update_ref(struct ref_store *refs, const char *msg,

which is caught by the BUG() rather than segfaulting.

So I guess the compiler just isn't smart enough to consider the possible
flag values. Which is not too surprising. But what's surprising to me is
that it insists that we hit the bogus memcpy(), even though it's gated
behind a conditional that it can't know whether it will be true or not.

Unless I'm missing something?

> It seems like the whole business of passing REF_HAVE_{NEW,OLD} is at
> least partially redundant to simply checking the relevant
> variables. Maybe.

There's definitely some Chesterton's Fence going on here. Once upon a
time we had a lot of bugs caused by confusing NULL and all-zero oids
(where one meant "I don't care what the old value was" and the other was
"the old value must be that there was no ref at all"). I think the flags
are necessary within the "struct ref_update" because there it is no
longer holding pointers, but actual embedded structs.

Now it could be that these days add_update() could check the pointers
and decide whether to set the flags there itself. But it looks like
there are a couple of callers which rely on the flags being the source
of truth. E.g.:

  - in files_initial_transaction_commit(), we pass in old_oid but clear
    the HAVE_OLD flag. I think this is just a minor bug-let that doesn't
    affect anything currently, but we probably ought to be passing NULL.

  - in split_head_update(), we propagate the flags from one struct to
    another, but pass new_oid and old_oid unconditionally. If
    add_update() starts caring about NULL-ness, then we'd have to decide
    what to pass here.

  - ditto in split_symref_update()

So something like the patch at the end of this email works (compiles
with -O3 and passes the tests), but I think it is just making things
more confusing.

> I.e. our entire test suite passes with the patch below. We "could"
> unconditionally check the variable name itself, but I haven't dug enough
> to see if that's introducing a subtle bug we're not testing for, or just
> a lot of redundant work.

It's not surprising that your patch doesn't trigger any test failures.
Any case it would catch would have segfaulted already. And the cases I
mentioned above are why you had to comment out the BUG in the final
branch here:

> +	if (new_oid && flags & REF_HAVE_NEW)
>  		oidcpy(&update->new_oid, new_oid);
> +	else if (!new_oid && flags & REF_HAVE_NEW)
> +		BUG("would have passed NULL to memcpy() with REF_HAVE_NEW");
> +	else if (new_oid && !(flags & REF_HAVE_NEW))
> +		oidcpy(&update->new_oid, new_oid);
> +		//BUG("missed a memcpy() new_oid due to no REF_HAVE_NEW");

My patch is below, but like I said, I think it makes things even more
brittle. I think an assertion similar to what you have above is a better
bet, but perhaps written more simply as:

  if (flags & REF_HAVE_NEW) {
	/* silence gcc 11's over-eager compile-time analysis */
	if (!new_oid)
		BUG("REF_HAVE_NEW set without passing new_oid");
	oidcpy(&update->new_oid, new_oid);
  }

---
diff --git a/refs.c b/refs.c
index d7cc0a23a3..90c17118e5 100644
--- a/refs.c
+++ b/refs.c
@@ -1061,10 +1061,14 @@ struct ref_update *ref_transaction_add_update(
 
 	update->flags = flags;
 
-	if (flags & REF_HAVE_NEW)
+	if (new_oid) {
 		oidcpy(&update->new_oid, new_oid);
-	if (flags & REF_HAVE_OLD)
+		update->flags |= REF_HAVE_NEW;
+	}
+	if (old_oid) {
 		oidcpy(&update->old_oid, old_oid);
+		update->flags |= REF_HAVE_OLD;
+	}
 	update->msg = normalize_reflog_message(msg);
 	return update;
 }
@@ -1089,8 +1093,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
 
-	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
-
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, msg);
 	return 0;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 151b0056fe..39a57f6b5e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2281,7 +2281,8 @@ static int split_head_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
-			&update->new_oid, &update->old_oid,
+			update->flags & REF_HAVE_NEW ? &update->new_oid : NULL,
+			update->flags & REF_HAVE_OLD ? &update->old_oid : NULL,
 			update->msg);
 
 	/*
@@ -2344,7 +2345,8 @@ static int split_symref_update(struct ref_update *update,
 
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
-			&update->new_oid, &update->old_oid,
+			new_flags & REF_HAVE_NEW ? &update->new_oid : NULL,
+			new_flags & REF_HAVE_OLD ? &update->old_oid : NULL,
 			update->msg);
 
 	new_update->parent_update = update;
@@ -3016,7 +3018,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		 */
 		ref_transaction_add_update(packed_transaction, update->refname,
 					   update->flags & ~REF_HAVE_OLD,
-					   &update->new_oid, &update->old_oid,
+					   &update->new_oid, NULL,
 					   NULL);
 	}
 
