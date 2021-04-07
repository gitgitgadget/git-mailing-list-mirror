Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41CFC433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 21:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732206124B
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 21:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhDGVSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 17:18:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:43772 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232037AbhDGVSC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 17:18:02 -0400
Received: (qmail 18000 invoked by uid 109); 7 Apr 2021 21:17:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Apr 2021 21:17:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23182 invoked by uid 111); 7 Apr 2021 21:17:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Apr 2021 17:17:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Apr 2021 17:17:50 -0400
From:   Jeff King <peff@peff.net>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
Message-ID: <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
References: <20210403090412.GH2271@szeder.dev>
 <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 05, 2021 at 03:02:33AM +0200, Rafael Silva wrote:

> When I was digging into the code and adding trace2_region_*() calls, I
> notice most of the time spent on the `git gc` (for the reported
> situation) was in:
> 
>        # In builtin/pack-objects.c
>        static void get_object_list(int ac, const char **av)
>        {
>                ...
>                if (unpack_unreachable)
>                        loosen_unused_packed_objects();
>                ...
>        }

Yeah, good find.

This is my first time looking at the repacking strategy for partial
clones. It looks like we run an initial pack-objects to cover all the
promisor objects, and then do the "real" repack for everything else,
with "--exclude-promisor-objects".

The purpose of loosen_unused_packed_objects() is to catch any objects
that will be lost when our caller deletes all of the packs. But in this
case, those promisor objects are in a pack which won't be deleted, so
they should not be included.

> Another interesting thing is, the loosen_unused_packed_objects()
> function is being called twice because the function loads all packs
> files, via get_all_packs(), which will return the .temp-*pack file that
> is created by the `git pack-objects` child process from `git gc`:
> 
>     git pack-objects ... --delta-base-offset objects/pack/.tmp-82853-pack ...

Yes, this is the "promisor" pack created by git-repack. It seems like
git-repack should tell pack-objects about the new pack with --keep-pack,
so that we know it is not going to be deleted.

That would also solve the rest of the problem, I _think_. In your
suggestion here:

> I'm not entirely sure about this (not this late in the day), but it seems to
> me that we should simply skip the "missing" (promisor) files when
> operating on a partial clone.
> 
> Perhaps something like:
> 
> --- >8 ---
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 525c2d8552..fedf58323d 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3468,6 +3468,8 @@ static int loosened_object_can_be_discarded(const struct object_id *oid,
>  {
>         if (!unpack_unreachable_expiration)
>                 return 0;
> +       if (exclude_promisor_objects && is_promisor_object(oid))
> +               return 1;
>         if (mtime > unpack_unreachable_expiration)
>                 return 0;
>         if (oid_array_lookup(&recent_objects, oid) >= 0)
> --- >8 ---

you are avoiding writing out the file. But we should realize much
earlier that it is not something we need to even consider loosening.

In the loop in loosen_unused_packed_objects(), we skip packs that are
marked as "keep", so we'd skip the new promisor pack entirely. But we'd
still see all these objects in the _old_ promisor pack. However, for
each object there, we call has_sha1_pack_kept_or_nonlocal(), so that
would likewise realize that each object is already being kept in the
other pack.

Something like this seems to work, but I only lightly tested it, and it
could probably use some refactoring to make it less horrible:

diff --git a/builtin/repack.c b/builtin/repack.c
index fdee8e4578..457525953a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -574,6 +574,23 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		repack_promisor_objects(&po_args, &names);
 
 		if (existing_packs.nr && delete_redundant) {
+			/*
+			 * tell pack-objects about our new promisor pack, which
+			 * we will also be keeping
+			 */
+			for_each_string_list_item(item, &names) {
+				/*
+				 * yuck, we seem to only have the name with the
+				 * packdir prefixed
+				 */
+				const char *prefix;
+				if (!skip_prefix(packtmp, packdir, &prefix) ||
+				    *prefix++ != '/')
+					BUG("confused by packtmp");
+				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
+					     prefix, item->string);
+			}
+
 			if (unpack_unreachable) {
 				strvec_pushf(&cmd.args,
 					     "--unpack-unreachable=%s",

Do you want to try to work with that?

> A quick benchmark did show some promising result:
> 
>     # built from: 2e36527f23 (The sixth batch, 2021-04-02)
>     Benchmark #1: ./bin-wrappers/git -C git.git gc
>           Time (mean ± σ):     135.669 s ±  0.665 s    [User: 42.789 s, System: 91.332 s]
>           Range (min … max):   134.905 s … 136.115 s    3 runs
> 
>     # built from: 2e36527f23 + minor patch (from above)
>     Benchmark #2: ./bin-wrappers/git -C git.git gc
>           Time (mean ± σ):     12.586 s ±  0.031 s    [User: 11.462 s, System: 1.365 s]
>           Range (min … max):   12.553 s … 12.616 s    3 runs
> 
>     Summary:
>           'Benchmark #2' ran 10.78 ± 0.06 times faster than 'Benchmark #1'

It's still quite a bit slower than a non-partial clone because the
traversal with --exclude-promisor-objects is slow. I think that's
because it has to open up all of the objects in the promisor pack to see
what they refer to. I don't know if we can do better (and it's largely
an orthogonal problem to what you're solving here, so it probably makes
sense to just punt on it for now).

-Peff
