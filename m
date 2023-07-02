Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33F5EB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 12:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGBM4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 08:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGBM4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 08:56:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B4C1AC
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 05:56:17 -0700 (PDT)
Received: (qmail 11342 invoked by uid 109); 2 Jul 2023 12:56:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 02 Jul 2023 12:56:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12176 invoked by uid 111); 2 Jul 2023 12:56:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 02 Jul 2023 08:56:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 2 Jul 2023 08:56:11 -0400
From:   Jeff King <peff@peff.net>
To:     Jan =?utf-8?Q?Kl=C3=B6tzke?= <jan@kloetzke.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Steve Kemp <steve@steve.org.uk>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] ref-filter: handle nested tags in --points-at option
Message-ID: <20230702125611.GA1036686@coredump.intra.peff.net>
References: <20230701205703.1172505-1-jan@kloetzke.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230701205703.1172505-1-jan@kloetzke.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 01, 2023 at 10:57:02PM +0200, Jan Klötzke wrote:

> Tags are dereferenced until reaching a different object type to handle
> nested tags, e.g. on checkout. In contrast, "git tag --points-at=..."
> fails to list such nested tags because only one level of indirection is
> obtained in filter_refs(). Implement the recursive dereferencing for the
> "--points-at" option when filtering refs to unify the behaviour.

That seems reasonable to me. It is changing the definition of
--points-at slightly, but I think in a way that should be less
surprising to users (i.e., we can consider the old behavior a bug).  The
existing documentation is sufficiently vague about "points" that I don't
think it needs to be updated (though arguably we could improve that
here, too).

Note that most other tag-peeling in Git (like the peeled values returned
by upload-pack) errs in the opposite direction: they peel completely,
and don't show the intermediate values. We _could_ switch to that here,
but I think it would be a behavior regression (but see below on why we
might entertain the thought).

My biggest question would be whether this introduces any performance
penalty for the more common cases (lightweight tags and single-level
annotated tags). The answer is "no", I think; we are already paying the
cost to parse every object to find out if it's a tag, and your new loop
only does an extra parse if we see a tag-of-tag. Good.

  Let me go off on a tangent here, since I'm looking at the performance
  of this function. The current code is already rather pessimal here, as
  we could probably avoid parsing non-tags entirely. Some strategies
  there are:

    1. We could check the object type via oid_object_info() before
       parsing. This carries a small penalty (two lookups) for tags but
       a big win (avoiding loading the object contents) for non-tags.

       An easy way to do this is to replace the parse_object() with
       parse_object_with_flags(PARSE_OBJECT_SKIP_HASH_CHECK), which
       tries to avoid loading object contents (especially using the
       commit-graph for commits, which presumably covers most non-tag
       refs).

    2. We could be using the peel_iterated_oid() interface (this is the
       peel_ref() thing mentioned in the comment you touched, but it has
       since been renamed). But it does the "peel all the way" thing
       mentioned above (both because of its interface, but also because
       that's what the packed-refs peel lines store).

       So to do that we'd either have to enhance the packed-refs store
       (which would not be too hard to do in a backwards-compatible
       way), or switch --points-at to only match either the direct ref
       value or the fully-peeled value.

  I don't think either of those is something your patch needs to deal
  with. It is not making these kinds of optimizations any harder (it is
  the existing "peel only once" behavior that does so). I mostly wanted
  to get it written down while we are all looking at this function.

> diff --git a/ref-filter.c b/ref-filter.c
> index e0d03a9f8e..ad7f244414 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2211,10 +2211,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
>   * of oids. If the given ref is a tag, check if the given tag points
>   * at one of the oids in the given oid array.
>   * NEEDSWORK:
> - * 1. Only a single level of indirection is obtained, we might want to
> - * change this to account for multiple levels (e.g. annotated tags
> - * pointing to annotated tags pointing to a commit.)
> - * 2. As the refs are cached we might know what refname peels to without
> + * As the refs are cached we might know what refname peels to without
>   * the need to parse the object via parse_object(). peel_ref() might be a
>   * more efficient alternative to obtain the pointee.
>   */

Great, thanks for cleaning up this comment.

> @@ -2222,18 +2219,19 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
>  					       const struct object_id *oid,
>  					       const char *refname)
>  {
> -	const struct object_id *tagged_oid = NULL;
>  	struct object *obj;
>  
>  	if (oid_array_lookup(points_at, oid) >= 0)
>  		return oid;
>  	obj = parse_object(the_repository, oid);
> +	while (obj && obj->type == OBJ_TAG) {
> +		oid = get_tagged_oid((struct tag *)obj);
> +		if (oid_array_lookup(points_at, oid) >= 0)
> +			return oid;
> +		obj = parse_object(the_repository, oid);
> +	}

OK, so we are doing the usual peeling loop here. I wondered if we might
be able to use peel_object(), but it again suffers from the "peel all
the way" syndrome. So we have to loop ourselves so that we can check at
each level. Good.

>  	if (!obj)
>  		die(_("malformed object at '%s'"), refname);

This will now trigger if refname points to a broken object, or if its
tag does. I think the resulting message is OK in either case (and
presumably lower level code would produce extra error messages, too).

> -	if (obj->type == OBJ_TAG)
> -		tagged_oid = get_tagged_oid((struct tag *)obj);
> -	if (tagged_oid && oid_array_lookup(points_at, tagged_oid) >= 0)
> -		return tagged_oid;

This code is moved into the loop body, but your version there drops the
"if (tagged_oid)" check. I think that is OK (and even preferable),
though. In get_tagged_oid() we will die() if the tagged object is NULL
(though even before switching to that function this check was
questionable, because it is "tag->tagged" that may be NULL, and we were
dereferencing that unconditionally).

So the code looks good.

> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 1ce5f490e9..af223e44d6 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -45,6 +45,8 @@ test_expect_success 'check signed tags with --points-at' '
>  	sed -e "s/Z$//" >expect <<-\EOF &&
>  	refs/heads/side Z
>  	refs/tags/annotated-tag four
> +	refs/tags/doubly-annotated-tag An annotated tag
> +	refs/tags/doubly-signed-tag A signed tag
>  	refs/tags/four Z
>  	refs/tags/signed-tag four
>  	EOF

And the test looks good, too. It is nice that we can rely on the
existing setup for the doubly-* tags.

Thanks for an easy-to-review patch. :)

-Peff
