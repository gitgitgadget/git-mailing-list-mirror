Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8A0C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 23:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjBCXoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 18:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBCXob (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 18:44:31 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB864402E7
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 15:44:30 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9536A1F5A0;
        Fri,  3 Feb 2023 23:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1675467870;
        bh=qa4DusLO2rYh7YdqO/N79Lr+wyVFO33/FxY4ODE8xQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wo+l/zJbshNTNvj9XkX7VpbY3XjSr5pHgg/Ru7gMuiKcw0bAbtIy8WMpqQgtqcsU4
         opvHgkW5yznAQv9+v2o4aW5ibyDTsMtERc2aNFfBavUyDOBWHLFV1U6USrrLVKHOoZ
         lheelPX00EYr6swBRmaUwoLYmftnpJ2hb9krDInM=
Date:   Fri, 3 Feb 2023 23:44:30 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH v3] delta-islands: free island_marks and bitmaps
Message-ID: <20230203234430.M553381@dcvr>
References: <20230202010353.23391-1-e@80x24.org>
 <230202.86mt5wq1i7.gmgdl@evledraar.gmail.com>
 <20230202094217.M955476@dcvr>
 <Y91OZHrMfca6tb/2@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y91OZHrMfca6tb/2@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Thu, Feb 02, 2023 at 09:42:17AM +0000, Eric Wong wrote:
> 
> > > > +			free(bitmap);
> > > > +	});
> > > > +	kh_destroy_oid_map(island_marks);
> > > > +	island_marks = (void *)1; /* crash on unintended future use */
> > > 
> > > This seems counter-productive. If you just leave it free'd then various
> > > analysis tools will spot a use-after-free earlier, won't they?
> > 
> > *shrug*  I thought it might be better to use an explicitly bad
> > pointer to catch lifetime issues that I might've missed from
> > reading the code.  Since I've run and tested at this point,
> > it probably doesn't matter, now.  So I'll just omit the
> > assignment and save some icache footprint.
> 
> I think it is still worth protecting ourselves. You've run and tested
> the current code, but the risk remains that somebody will later change
> the code and introduce a regression.
> 
> Yes, analysis tools may spot it. But only if we actually trigger the
> case in question via the test suite, and while running those tools. We
> can get more consistent behavior by overwriting the pointer.

OK.

> The usual thing, of course, would just be to set it to NULL. I guess you
> used "(void *)1" in the original because code like in_same_island()
> checks for NULL. And so it becomes indistinguishable whether we intended
> not to use islands, or if there's a bug in the program.

Yes, I used `(void *)1' because of the existing NULL checks.  I
should have used `(void *)-1' (MAP_FAILED) instead since
attempts to dereference 1 could conceivably point to a valid
address, whereas using a maximum value would not.

> If we are going to reduce the lifetime of island_marks, I think it would
> make things cleaner to push the "do we expect to have islands" boolean
> into its own variable, something like:
> 
> diff --git a/delta-islands.c b/delta-islands.c
> index c09dab31a4..7dd4e1419a 100644
> --- a/delta-islands.c
> +++ b/delta-islands.c
> @@ -22,6 +22,7 @@
>  
>  KHASH_INIT(str, const char *, void *, 1, kh_str_hash_func, kh_str_hash_equal)
>  
> +static int using_island_marks;
>  static kh_oid_map_t *island_marks;
>  static unsigned island_counter;
>  static unsigned island_counter_core;
> @@ -96,7 +97,7 @@ int in_same_island(const struct object_id *trg_oid, const struct object_id *src_
>  	khiter_t trg_pos, src_pos;
>  
>  	/* If we aren't using islands, assume everything goes together. */
> -	if (!island_marks)
> +	if (!using_island_marks)
>  		return 1;

I much prefer to rely on invalid pointers than extra flags since
having multiple sources of truth confuses me[1].

> Of course it would be cleaner still if there was a "struct
> delta_islands" that encapsulated the variables, and then the caller
> could free it when they're done. That's more work to retro-fit, though.

Yes and yes :>

> >  int compute_pack_layers(struct packing_data *to_pack)
> >  {
> >  	uint32_t i;
> >  
> > -	if (!core_island_name || !island_marks)
> > +	if (!island_marks)
> > +		return 1;
> > +
> > +	if (!core_island_name) {
> > +		free_island_marks();
> >  		return 1;
> > +	}
> >  
> >  	for (i = 0; i < to_pack->nr_objects; ++i) {
> >  		struct object_entry *entry = &to_pack->objects[i];
> > @@ -533,6 +549,7 @@ int compute_pack_layers(struct packing_data *to_pack)
> >  				oe_set_layer(to_pack, entry, 0);
> >  		}
> >  	}
> > +	free_island_marks();
> >  
> >  	return 2;
> >  }
> 
> This is pretty subtle. It implicitly assumes that compute_pack_layers()
> is the last thing that will ever need to look at islands. Which is true
> now (I think), but it's reasonable to think that somebody might use
> island data during bitmap generation, too.

Yeah.  The reason I used an invalid pointer in the original was
because I wasn't certain compute_pack_layers() was the last user.

> It seems like it would be a lot more obvious if the sole caller did the
> free explicitly, like:
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index cabace4abb..3395f63aba 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -929,8 +929,10 @@ static struct object_entry **compute_write_order(void)
>  	 */
>  	for_each_tag_ref(mark_tagged, NULL);
>  
> -	if (use_delta_islands)
> +	if (use_delta_islands) {
>  		max_layers = compute_pack_layers(&to_pack);
> +		free_island_marks();
> +	}

OK, I've done that for v3.  Thanks.

>  	ALLOC_ARRAY(wo, to_pack.nr_objects);
>  	wo_end = 0;
> 
> And of course that would also be a tiny step in the right direction if
> the delta islands API learned to use a struct (this would be the same
> spot where we'd say "we're done with islands; free the struct").

I do wonder about performance on register-starved systems,
though, especially if stuff like island_delta_cmp gets called
frequently.  I already have enough performance problems atm :<

[1] to go farther, I might even eliminate `int use_delta_islands' as
    a global from builtin/pack-objects.c and just have that become a
    `struct delta_islands_foo *' or something.  But I have more
    pressing performance problems to figure out :<

--------8<-------
Subject: [PATCH v3] delta-islands: free island_marks and bitmaps

On my mirror of linux.git forkgroup with 780 islands, this saves
nearly 4G of heap memory in pack-objects.  This savings only
benefits delta island users of pack bitmaps, as the process
would otherwise be exiting anyways.

However, there's probably not many delta island users, but the
majority of delta island users would also be pack bitmaps users.

Signed-off-by: Eric Wong <e@80x24.org>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jeff King <peff@peff.net>
---
 v3: use (void *)-1 to detect use-after-free,
     hoist out free_island_marks() call for readability

 builtin/pack-objects.c |  4 +++-
 delta-islands.c        | 14 ++++++++++++++
 delta-islands.h        |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

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
diff --git a/delta-islands.c b/delta-islands.c
index 90c0d6958f..8b234cb85b 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -513,6 +513,20 @@ void propagate_island_marks(struct commit *commit)
 	}
 }
 
+void free_island_marks(void)
+{
+	struct island_bitmap *bitmap;
+
+	kh_foreach_value(island_marks, bitmap, {
+		if (!--bitmap->refcount)
+			free(bitmap);
+	});
+	kh_destroy_oid_map(island_marks);
+
+	/* detect use-after-free with a an address which is never valid: */
+	island_marks = (void *)-1;
+}
+
 int compute_pack_layers(struct packing_data *to_pack)
 {
 	uint32_t i;
diff --git a/delta-islands.h b/delta-islands.h
index eb0f952629..8d1591ae28 100644
--- a/delta-islands.h
+++ b/delta-islands.h
@@ -14,5 +14,6 @@ void resolve_tree_islands(struct repository *r,
 void load_delta_islands(struct repository *r, int progress);
 void propagate_island_marks(struct commit *commit);
 int compute_pack_layers(struct packing_data *to_pack);
+void free_island_marks(void);
 
 #endif /* DELTA_ISLANDS_H */
