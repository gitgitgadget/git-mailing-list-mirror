Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A491CC433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 23:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiKQXHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 18:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240631AbiKQXHA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 18:07:00 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFB343879
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 15:06:58 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9B0D91F910;
        Thu, 17 Nov 2022 23:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1668726418;
        bh=MImDH0XBXF2x9zT2VZ0KRtDvqGNiZ+BJMVyyk9eMdZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WcO9OXrNZCvE0uvjDMGLfGoeVoQXk2EJ6rG+gVoa+St4tB73jANIMPaAF2Y3gLwF6
         DgQEzzREU+inmibWyQfTFGtJloZz7WnAZF7C6ULflZshrdq/szT/d17GcNYffps7Up
         Tf5/xuXSAflL8vFF7Jg8H7jVngoyV6fhovHSue+s=
Date:   Thu, 17 Nov 2022 23:06:58 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: [PATCH v2] delta-islands: free island-related data after use
Message-ID: <20221117230658.M516129@dcvr>
References: <20221116105013.1777440-1-e@80x24.org>
 <221116.861qq2kieu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221116.861qq2kieu.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Wed, Nov 16 2022, Eric Wong wrote:
> >   Memory savings were measured using the following patch which
> >   relies on a patched LD_PRELOAD-based malloc debugger:
> >   https://80x24.org/spew/20221116095404.3974691-1-e@80x24.org/raw
> 
> FWIW SANITIZE=leak will find this if you stick a "remote_islands = NULL"
> and run e.g. t5320-delta-islands.sh, but maybe you needed this closer to
> production.
> 
> Valgrind will also work, but of course be *much* slower.

Yeah, I run that LD_PRELOAD thing in production since it's
cheap compared to valgrind.

> Perfect shouldn't be the enemy of the good & all that, but in this case
> it's not too much more effort to just give this data an appropriate
> lifetime instead of the global, I tried that out for just the "regex"
> part of this below.
> 
> The free_remote_islands() seems to be similarly alive between
> "find_island_for_ref" and "deduplicate_islands".
> 
> Your version also works, but the root cause of this sort of thing is
> these global lifetimes, which sometimes we do for a good reason, but in
> this case we don't.

Agreed on all points.  Overall, the amount of globals in git has
long seemed excessive and offputting to me (and likely other
drive-by hackers).

> diff --git a/delta-islands.c b/delta-islands.c
> index 26f9e99e1a9..ef86a91059c 100644
> --- a/delta-islands.c
> +++ b/delta-islands.c
> @@ -312,29 +312,41 @@ void resolve_tree_islands(struct repository *r,
>  	free(todo);
>  }
>  
> -static regex_t *island_regexes;
> -static unsigned int island_regexes_alloc, island_regexes_nr;
> +struct island_config_data {
> +	regex_t *rx;
> +	size_t nr;
> +	size_t alloc;
> +};

I've added kh_str_t *remote_islands and renamed
s/island_config_data/island_load_data/ in the below version
to reflect the slightly different scope of remote_islands.

>  static const char *core_island_name;
>  
> -static int island_config_callback(const char *k, const char *v, void *cb UNUSED)
> +static void island_config_data_release(struct island_config_data *icd)
> +{
> +	for (size_t i = 0; i < icd->nr; i++)
> +		regfree(&icd->rx[i]);
> +	free(icd->rx);
> +}

icd => ild since config => load

> +static int island_config_callback(const char *k, const char *v, void *cb)
>  {
> +	struct island_config_data *data = cb;
> +

data => ild

I don't like the name `data' for a typed variable.

Aside from that, v2 below still frees the regex memory early on
in the hopes deduplicate_islands() can reuse some of the freed
regexp memory.

Anyways, here's v2, which seems to work.  I'm still trying to
figure out SATA errors+resets after replacing a CMOS battery,
but I really hope this patch isn't the cause.

-----8<-----
From: Eric Wong <e@80x24.org>
Subject: [PATCH] delta-islands: free island-related data after use

On my use case involving 771 islands of Linux on kernel.org,
this reduces memory usage by around 25MB.  The bulk of that
comes from free_remote_islands, since free_config_regexes only
saves around 40k.

This memory is saved early in the memory-intensive pack process,
making it available for the remainder of the long process.

Signed-off-by: Eric Wong <e@80x24.org>
Co-authored-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 v2: reduce scope of load-time data structures with hints from Ævar

 delta-islands.c | 71 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 20 deletions(-)

diff --git a/delta-islands.c b/delta-islands.c
index 26f9e99e1a..90c0d6958f 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -26,8 +26,6 @@ static kh_oid_map_t *island_marks;
 static unsigned island_counter;
 static unsigned island_counter_core;
 
-static kh_str_t *remote_islands;
-
 struct remote_island {
 	uint64_t hash;
 	struct oid_array oids;
@@ -312,29 +310,55 @@ void resolve_tree_islands(struct repository *r,
 	free(todo);
 }
 
-static regex_t *island_regexes;
-static unsigned int island_regexes_alloc, island_regexes_nr;
+struct island_load_data {
+	kh_str_t *remote_islands;
+	regex_t *rx;
+	size_t nr;
+	size_t alloc;
+};
 static const char *core_island_name;
 
-static int island_config_callback(const char *k, const char *v, void *cb UNUSED)
+static void free_config_regexes(struct island_load_data *ild)
 {
+	for (size_t i = 0; i < ild->nr; i++)
+		regfree(&ild->rx[i]);
+	free(ild->rx);
+}
+
+static void free_remote_islands(kh_str_t *remote_islands)
+{
+	const char *island_name;
+	struct remote_island *rl;
+
+	kh_foreach(remote_islands, island_name, rl, {
+		free((void *)island_name);
+		oid_array_clear(&rl->oids);
+		free(rl);
+	});
+	kh_destroy_str(remote_islands);
+}
+
+static int island_config_callback(const char *k, const char *v, void *cb)
+{
+	struct island_load_data *ild = cb;
+
 	if (!strcmp(k, "pack.island")) {
 		struct strbuf re = STRBUF_INIT;
 
 		if (!v)
 			return config_error_nonbool(k);
 
-		ALLOC_GROW(island_regexes, island_regexes_nr + 1, island_regexes_alloc);
+		ALLOC_GROW(ild->rx, ild->nr + 1, ild->alloc);
 
 		if (*v != '^')
 			strbuf_addch(&re, '^');
 		strbuf_addstr(&re, v);
 
-		if (regcomp(&island_regexes[island_regexes_nr], re.buf, REG_EXTENDED))
+		if (regcomp(&ild->rx[ild->nr], re.buf, REG_EXTENDED))
 			die(_("failed to load island regex for '%s': %s"), k, re.buf);
 
 		strbuf_release(&re);
-		island_regexes_nr++;
+		ild->nr++;
 		return 0;
 	}
 
@@ -344,7 +368,8 @@ static int island_config_callback(const char *k, const char *v, void *cb UNUSED)
 	return 0;
 }
 
-static void add_ref_to_island(const char *island_name, const struct object_id *oid)
+static void add_ref_to_island(kh_str_t *remote_islands, const char *island_name,
+				const struct object_id *oid)
 {
 	uint64_t sha_core;
 	struct remote_island *rl = NULL;
@@ -365,8 +390,10 @@ static void add_ref_to_island(const char *island_name, const struct object_id *o
 }
 
 static int find_island_for_ref(const char *refname, const struct object_id *oid,
-			       int flags UNUSED, void *data UNUSED)
+			       int flags UNUSED, void *cb)
 {
+	struct island_load_data *ild = cb;
+
 	/*
 	 * We should advertise 'ARRAY_SIZE(matches) - 2' as the max,
 	 * so we can diagnose below a config with more capture groups
@@ -377,8 +404,8 @@ static int find_island_for_ref(const char *refname, const struct object_id *oid,
 	struct strbuf island_name = STRBUF_INIT;
 
 	/* walk backwards to get last-one-wins ordering */
-	for (i = island_regexes_nr - 1; i >= 0; i--) {
-		if (!regexec(&island_regexes[i], refname,
+	for (i = ild->nr - 1; i >= 0; i--) {
+		if (!regexec(&ild->rx[i], refname,
 			     ARRAY_SIZE(matches), matches, 0))
 			break;
 	}
@@ -403,12 +430,12 @@ static int find_island_for_ref(const char *refname, const struct object_id *oid,
 		strbuf_add(&island_name, refname + match->rm_so, match->rm_eo - match->rm_so);
 	}
 
-	add_ref_to_island(island_name.buf, oid);
+	add_ref_to_island(ild->remote_islands, island_name.buf, oid);
 	strbuf_release(&island_name);
 	return 0;
 }
 
-static struct remote_island *get_core_island(void)
+static struct remote_island *get_core_island(kh_str_t *remote_islands)
 {
 	if (core_island_name) {
 		khiter_t pos = kh_get_str(remote_islands, core_island_name);
@@ -419,7 +446,7 @@ static struct remote_island *get_core_island(void)
 	return NULL;
 }
 
-static void deduplicate_islands(struct repository *r)
+static void deduplicate_islands(kh_str_t *remote_islands, struct repository *r)
 {
 	struct remote_island *island, *core = NULL, **list;
 	unsigned int island_count, dst, src, ref, i = 0;
@@ -445,7 +472,7 @@ static void deduplicate_islands(struct repository *r)
 	}
 
 	island_bitmap_size = (island_count / 32) + 1;
-	core = get_core_island();
+	core = get_core_island(remote_islands);
 
 	for (i = 0; i < island_count; ++i) {
 		mark_remote_island_1(r, list[i], core && list[i]->hash == core->hash);
@@ -456,12 +483,16 @@ static void deduplicate_islands(struct repository *r)
 
 void load_delta_islands(struct repository *r, int progress)
 {
+	struct island_load_data ild = { 0 };
+
 	island_marks = kh_init_oid_map();
-	remote_islands = kh_init_str();
 
-	git_config(island_config_callback, NULL);
-	for_each_ref(find_island_for_ref, NULL);
-	deduplicate_islands(r);
+	git_config(island_config_callback, &ild);
+	ild.remote_islands = kh_init_str();
+	for_each_ref(find_island_for_ref, &ild);
+	free_config_regexes(&ild);
+	deduplicate_islands(ild.remote_islands, r);
+	free_remote_islands(ild.remote_islands);
 
 	if (progress)
 		fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);
