Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C64C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 18:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiKPSU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 13:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiKPSU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 13:20:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D73CDD
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 10:20:22 -0800 (PST)
Received: (qmail 21730 invoked by uid 109); 16 Nov 2022 18:20:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Nov 2022 18:20:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2706 invoked by uid 111); 16 Nov 2022 18:20:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Nov 2022 13:20:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Nov 2022 13:20:21 -0500
From:   Jeff King <peff@peff.net>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC][PATCH] object.c: use has_object() instead of
 repo_has_object_file()
Message-ID: <Y3Up5Vi75Up8LaGQ@coredump.intra.peff.net>
References: <20221116163956.1039137-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221116163956.1039137-1-five231003@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2022 at 10:09:56PM +0530, Kousik Sanagavarapu wrote:

> It is mentioned in object-store.h that the function
> repo_has_object_file() is deprecated. One possible alternative for this
> function is has_object() (or atleast that is how I understood it).
> 
> The file object-store.h also mentions that repo_has_object_file() and
> its fellow functions and macros can be removed once the migrations take
> place. This patch therefore is an attempt to reduce the usage of these
> functions and macros.
> 
> I request for comments as I'm not really sure about the "flags" argument
> of the has_object() function and its usage in this patch.

So you've stumbled into quite a tricky spot. :)

Yes, without specifying new flags, this patch has a change of behavior
which I think is not what we want. From 1d8d9cb620 (sha1-file: introduce
no-lazy-fetch has_object(), 2020-08-05):

  There have been a few bugs wherein Git fetches missing objects
  whenever the existence of an object is checked, even though it does
  not need to perform such a fetch. To resolve these bugs, we could look
  at all the places that has_object_file() (or a similar function) is
  used. As a first step, introduce a new function has_object() that
  checks for the existence of an object, with a default behavior of not
  fetching if the object is missing and the repository is a partial
  clone. As we verify each has_object_file() (or similar) usage, we can
  replace it with has_object(), and we will know that we are done when
  we can delete has_object_file() (and the other similar functions).
  
  Also, the new function has_object() has more appropriate defaults:
  besides not fetching, it also does not recheck packed storage.

So the new function will:

  - not recheck packed objects unless we pass HAS_OBJECT_RECHECK_PACKED;
    this is done in the default paths because a simultaneous git-gc may
    be repacking objects (and we would rather double-check than racily
    miss it). So it's appropriate behavior if the caller is
    speculatively asking "hey, we _might_ have this object", but not if
    we expect to have it.

  - not lazily fetch objects in a partial-clone repository. This again
    depends on the caller being in a situation where they are OK saying
    "no we don't have it" for an object we _could_ get if it was worth
    spending effort

The call you're touching here is in parse_object_with_flags(), which is
using the check as part of the "is it a blob that we should stream?"
check. If this call returns "no we don't have it", when we could get it
(either due to racy repack or by fetching), then we'll hit the non-blob
path that calls repo_read_object_file(). Where we would do a fresh
lookup, including re-checking packs and/or lazily fetching!

So the new behavior seems strictly worse to me. We don't avoid those
behaviors, _and_ we fail to follow the streaming-blob code path (which
means we may accidentally read a huge blob into memory. I think we'd
want to leave it as-is, or if we really want to eventually drop to a
single interface, we need has_object() to learn a new flag to enable the
lazy-fetch (and then use it along with RECHECK_PACKED).

Now all of that said, I am skeptical that these calls to
repo_has_object_file() are even doing anything useful at all. Looking at
the existing code (dropping the "+" lines from your patch):

> -	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
> -	    (!obj && repo_has_object_file(r, oid) &&
>  	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
>  		if (!skip_hash && stream_object_signature(r, repl) < 0) {
>  			error(_("hash mismatch %s"), oid_to_hex(oid));

we are checking that it exits if either:

  - another object (e.g., a tree) referred to it as a blob during this
    process, and we created an in-memory "struct object" with that type

  - nobody has referred to it, and we want to check its type via
    oid_object_info()

In the second case, this seems totally pointless. We can just ask
oid_object_info() what it's type is, and it will say "no, we don't have
it" if appropriate. It will do the usual recheck-pack and lazy-fetch,
but so is repo_has_object_file(), so the short-circuit "&&" is not
helping. _If_ we were to switch to has_object() it would start to do
something, but I think that's a bad idea for the reasons given above.

In the first case, I'd likewise argue it's not doing anything useful. It
is confirming that we have the object, but so would the call to
stream_object_signature() immediately below (assuming skip_hash is not
set). If skip_hash is set, then we could either:

  1. Just assume we have it. The point of the caller passing skip_hash
     is that we don't care about checking the integrity for this use
     case, and "missing" is not really any different than "there's a
     file on disk but it might contain garbage bytes".

  2. Check repo_has_object_file() in this code path only when skip_hash
     is set. That retains the same "do we even have it" check for
     skip_hash that is performed now.

I.e., I'd suggest this patch to remove both calls entirely:

diff --git a/object.c b/object.c
index 248530ba7b..a370545405 100644
--- a/object.c
+++ b/object.c
@@ -285,9 +285,8 @@ struct object *parse_object_with_flags(struct repository *r,
 			return &commit->object;
 	}
 
-	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
-	    (!obj && repo_has_object_file(r, oid) &&
-	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
+	if ((obj && obj->type == OBJ_BLOB) ||
+	    (!obj && oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
 		if (!skip_hash && stream_object_signature(r, repl) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;

But there may be some subtlety I'm missing. I'm cc-ing Jonathan Tan, who
added has_object(), and who added the top call to repo_has_object_file()
via df11e19648 (rev-list: support termination at promisor objects,
2017-12-08). The second call is from 090ea12671 (parse_object: avoid
putting whole blob in core, 2012-03-07), but he's no longer active on
the project. Looking at the commit, I think it was just a case of "let's
be extra careful". But as far as I can tell, it's not helping anything,
and both calls are introducing extra work doing object lookups.

-Peff
