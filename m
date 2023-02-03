Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AE9C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 18:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjBCSMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 13:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjBCSLz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 13:11:55 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F8ADBA6
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 10:11:49 -0800 (PST)
Received: (qmail 26853 invoked by uid 109); 3 Feb 2023 18:11:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Feb 2023 18:11:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10656 invoked by uid 111); 3 Feb 2023 18:11:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Feb 2023 13:11:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Feb 2023 13:11:48 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] delta-islands: free island_marks and bitmaps
Message-ID: <Y91OZHrMfca6tb/2@coredump.intra.peff.net>
References: <20230202010353.23391-1-e@80x24.org>
 <230202.86mt5wq1i7.gmgdl@evledraar.gmail.com>
 <20230202094217.M955476@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230202094217.M955476@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 02, 2023 at 09:42:17AM +0000, Eric Wong wrote:

> > > +			free(bitmap);
> > > +	});
> > > +	kh_destroy_oid_map(island_marks);
> > > +	island_marks = (void *)1; /* crash on unintended future use */
> > 
> > This seems counter-productive. If you just leave it free'd then various
> > analysis tools will spot a use-after-free earlier, won't they?
> 
> *shrug*  I thought it might be better to use an explicitly bad
> pointer to catch lifetime issues that I might've missed from
> reading the code.  Since I've run and tested at this point,
> it probably doesn't matter, now.  So I'll just omit the
> assignment and save some icache footprint.

I think it is still worth protecting ourselves. You've run and tested
the current code, but the risk remains that somebody will later change
the code and introduce a regression.

Yes, analysis tools may spot it. But only if we actually trigger the
case in question via the test suite, and while running those tools. We
can get more consistent behavior by overwriting the pointer.

The usual thing, of course, would just be to set it to NULL. I guess you
used "(void *)1" in the original because code like in_same_island()
checks for NULL. And so it becomes indistinguishable whether we intended
not to use islands, or if there's a bug in the program.

If we are going to reduce the lifetime of island_marks, I think it would
make things cleaner to push the "do we expect to have islands" boolean
into its own variable, something like:

diff --git a/delta-islands.c b/delta-islands.c
index c09dab31a4..7dd4e1419a 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -22,6 +22,7 @@
 
 KHASH_INIT(str, const char *, void *, 1, kh_str_hash_func, kh_str_hash_equal)
 
+static int using_island_marks;
 static kh_oid_map_t *island_marks;
 static unsigned island_counter;
 static unsigned island_counter_core;
@@ -96,7 +97,7 @@ int in_same_island(const struct object_id *trg_oid, const struct object_id *src_
 	khiter_t trg_pos, src_pos;
 
 	/* If we aren't using islands, assume everything goes together. */
-	if (!island_marks)
+	if (!using_island_marks)
 		return 1;
 
 	/*
@@ -124,7 +125,7 @@ int island_delta_cmp(const struct object_id *a, const struct object_id *b)
 	khiter_t a_pos, b_pos;
 	struct island_bitmap *a_bitmap = NULL, *b_bitmap = NULL;
 
-	if (!island_marks)
+	if (!using_island_marks)
 		return 0;
 
 	a_pos = kh_get_oid_map(island_marks, *a);
@@ -485,6 +486,7 @@ void load_delta_islands(struct repository *r, int progress)
 {
 	struct island_load_data ild = { 0 };
 
+	using_island_marks = 1;
 	island_marks = kh_init_oid_map();
 
 	git_config(island_config_callback, &ild);
@@ -522,6 +524,7 @@ static void free_island_marks(void)
 			free(bitmap);
 	});
 	kh_destroy_oid_map(island_marks);
+	island_marks = NULL;
 }
 
 int compute_pack_layers(struct packing_data *to_pack)

Of course it would be cleaner still if there was a "struct
delta_islands" that encapsulated the variables, and then the caller
could free it when they're done. That's more work to retro-fit, though.

>  int compute_pack_layers(struct packing_data *to_pack)
>  {
>  	uint32_t i;
>  
> -	if (!core_island_name || !island_marks)
> +	if (!island_marks)
> +		return 1;
> +
> +	if (!core_island_name) {
> +		free_island_marks();
>  		return 1;
> +	}
>  
>  	for (i = 0; i < to_pack->nr_objects; ++i) {
>  		struct object_entry *entry = &to_pack->objects[i];
> @@ -533,6 +549,7 @@ int compute_pack_layers(struct packing_data *to_pack)
>  				oe_set_layer(to_pack, entry, 0);
>  		}
>  	}
> +	free_island_marks();
>  
>  	return 2;
>  }

This is pretty subtle. It implicitly assumes that compute_pack_layers()
is the last thing that will ever need to look at islands. Which is true
now (I think), but it's reasonable to think that somebody might use
island data during bitmap generation, too.

It seems like it would be a lot more obvious if the sole caller did the
free explicitly, like:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cabace4abb..3395f63aba 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -929,8 +929,10 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for_each_tag_ref(mark_tagged, NULL);
 
-	if (use_delta_islands)
+	if (use_delta_islands) {
 		max_layers = compute_pack_layers(&to_pack);
+		free_island_marks();
+	}
 
 	ALLOC_ARRAY(wo, to_pack.nr_objects);
 	wo_end = 0;

And of course that would also be a tiny step in the right direction if
the delta islands API learned to use a struct (this would be the same
spot where we'd say "we're done with islands; free the struct").

-Peff
