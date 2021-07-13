Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D71FC07E9A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 00:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE136115A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 00:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhGMAJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 20:09:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:47274 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230099AbhGMAJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 20:09:09 -0400
Received: (qmail 25314 invoked by uid 109); 13 Jul 2021 00:06:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 00:06:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3667 invoked by uid 111); 13 Jul 2021 00:06:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 20:06:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 20:06:18 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v1] load_ref_decorations(): fix decoration with tags
Message-ID: <YOzY+qNFM2GsgKMO@coredump.intra.peff.net>
References: <20210712224152.2698500-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210712224152.2698500-1-martin.agren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 12:41:52AM +0200, Martin Ågren wrote:

> Commit 88473c8bae ("load_ref_decorations(): avoid parsing non-tag
> objects", 2021-06-22) introduced a shortcut to `add_ref_decoration()`:
> Rather than calling `parse_object()` directly, call `oid_object_info()`
> and then either return early or go on to call `lookup_object_by_type()`
> using the type just discovered. As detailed in the commit message, this
> provides a significant time saving.
> 
> Unfortunately, it also changes the behavior. As an example, on git.git,
> 
>   git log --oneline --decorate origin/master | grep '(.*tag:.*)'
> 
> returns zero hits after 88473c8bae. Before it, we have around 800 hits.
> What happens is, all annotated tags are lost from the decoration.

Eek. Thanks for catching this.

I wondered how I could have missed this, but it does work if somebody
else happens to have parsed it. For example:

  $ git log -1 --oneline --decorate v5.11
  f40ddce88593 (tag: v5.11) Linux 5.11

works because we'll already have parsed it as a traversal tip.

> Let's do a partial revert of 88473c8bae: Keep doing that early
> `oid_object_info()`, but after that, go on with the full
> `parse_object()`. This restores the pre-88473c8bae behavior.

Your fix is _almost_ there. There's not much point in doing
oid_object_info() if we're just going to parse unconditionally. But we
would want to parse only tags.

And we even do parse tags recursively in the peeling loop. The trouble
is that we do so after realizing we need to recurse. We just need to
bump it up in the loop, like:

diff --git a/log-tree.c b/log-tree.c
index 4f69ed176d..6dc4412268 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -174,11 +174,11 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 
 	add_name_decoration(deco_type, refname, obj);
 	while (obj->type == OBJ_TAG) {
+		if (!obj->parsed)
+			parse_object(the_repository, &obj->oid);
 		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			break;
-		if (!obj->parsed)
-			parse_object(the_repository, &obj->oid);
 		add_name_decoration(DECORATION_REF_TAG, refname, obj);
 	}
 	return 0;

That's the minimum needed to unbreak things. I think we could do even
better, though. There is no need for us to parse a commit object pointed
to by a tag here. We should only be parsing tags we see (whether at the
top-level or recursively).

Do you want to incorporate the fix above, or would you prefer me to pick
it up from here?

> We clearly
> have lacking test coverage here, so make sure to add a test. Without
> this fix to log-tree.c, the git-log invocation in this new test does
> pick up the lightweight tags involved, but misses out on the annotated
> tag.

Yeah, definitely.

>  In my brief testing (time git log -1 --decorate on git.git), the time
>  savings from 88473c8bae seem to be gone. So maybe this should be a full
>  revert, rather than a partial one. (Plus the test.) Let's hope that
>  won't be necessary.

Right. After your patch, the oid_object_info() is pointless, because
we're still parsing everything (the "< 0" error check would only trigger
in a corrupted repo). And it adds some overhead, so it may even be
slightly slower than the original code. :)

The timings I get for "git log -1 --decorate" on git.git are:

  -  before either patch: 27.5ms
  - with my broken patch:  5.9ms
  - with the patch above: 11.3ms

which makes sense. I have a bunch of branches, and now we don't parse
them. We do still have to parse tags. On linux.git, where it's almost
entirely tags, most of the advantage dries up (but it would probably be
helped a bit by the further suggestion I gave above to avoid parsing
tagged commits).

On my big ~220k ref test case (where it's mostly non-tags), the timings
are:

  -  before either patch: 2.945s
  - with my broken patch: 0.707s
  - with the patch above: 0.788s

so the savings are retained.

>  Also, I'm not sure whether the test really needs to worry about the
>  order of the decorations suddenly changing -- maybe it's supposed to be
>  stable.

I think it's probably OK to count on it being stable. We iterate the
refs in a stable order to insert them, and then store the result as a
linked list. If that strategy ever changed, I think we'd end up doing a
manual sort on them to get a stable order anyway.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 350cfa3593..3aa5451913 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1905,6 +1905,20 @@ test_expect_success '--exclude-promisor-objects does not BUG-crash' '
>  	test_must_fail git log --exclude-promisor-objects source-a
>  '
>  
> +test_expect_success 'log --decorate includes, e.g., all kinds of tags' '
> +	git log --oneline --decorate >log &&
> +	test_line_count = 2 log &&
> +	grep "^1ac6c77 (tag: one) one$" log &&

This presumably breaks when the tests are run in sha256 mode. Coupled
with the ordering simplification, maybe:

        cat >expect <<-\EOF &&
        three HEAD -> source-b, tag: three, tag: source-tag
        one tag: one
        EOF
        git log --format="%s %D" >actual &&
        test_cmp expect actual

(or maybe %d is more readable in the output; it doesn't matter much if
we're matching it verbatim).

Thanks again for noticing this.

-Peff
