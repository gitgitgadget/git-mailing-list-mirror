Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04014EB64DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGCGS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGCGSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:18:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542A9CD
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:18:41 -0700 (PDT)
Received: (qmail 11284 invoked by uid 109); 3 Jul 2023 06:18:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:18:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2430 invoked by uid 111); 3 Jul 2023 06:18:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:18:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:18:39 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 12/16] refs/packed-backend.c: ignore complicated
 hidden refs rules
Message-ID: <20230703061839.GH3502534@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <845904853eeae1741d681a35fdd7816ea16b939a.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <845904853eeae1741d681a35fdd7816ea16b939a.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 10:22:02AM -0400, Taylor Blau wrote:

> In subsequent commits, we'll teach `receive-pack` and `upload-pack` to
> use the new jump list feature in the packed-refs iterator by ignoring
> references which are mentioned via its respective hideRefs lists.
> 
> However, the packed-ref jump lists cannot handle un-hiding rules (that
> begin with '!'), or namespace comparisons (that begin with '^'). Detect
> and avoid these cases by falling back to the normal enumeration without
> a jump list when such patterns exist.

I'm a fan of punting on such cases to keep things simple and
incremental. But the location here seems weird to me:

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 80b877e00c..2aeec5c601 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1008,6 +1008,25 @@ static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
>  	if (!excluded_patterns)
>  		return;
>  
> +	for (pattern = excluded_patterns; *pattern; pattern++) {
> +		/*
> +		 * We also can't feed any excludes from hidden refs
> +		 * config sections, since later rules may override
> +		 * previous ones. For example, with rules "refs/foo" and
> +		 * "!refs/foo/bar", we should show "refs/foo/bar" (and
> +		 * everything underneath it), but the earlier exclusion
> +		 * would cause us to skip all of "refs/foo". We likewise
> +		 * don't implement the namespace stripping required for
> +		 * '^' rules.
> +		 *
> +		 * Both are possible to do, but complicated, so avoid
> +		 * populating the jump list at all if we see either of
> +		 * these patterns.
> +		 */
> +		if (**pattern == '!' || **pattern == '^')
> +			return;
> +	}
> +

This is deep in the packed-refs code, but the magic of "!" and "^" are
specific to ref_is_hidden().

So if I did:

  git for-each-ref --exclude='!refs/heads/foo'

my understanding is that "!" would _not_ have an affect normally, but
now it is turning off this optimization.

The point may be somewhat academic for "^", as it is not allowed in a
refname anyway. But I don't think "!" is forbidden (as stupid as it
would be to include it in this way), is it?

It feels like the hiderefs code should be the one checking for these,
and then feeding only non-adorned refnames to the "exclude" list (though
there is no need to un-adorn them; once we see any with either form of
magic, we know we cannot use this "exclude" feature at all).

Something along the lines of (you'd want a similar tweak for
upload-pack):

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2b2faa5d18..80a6b11c90 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -339,7 +339,8 @@ static void write_head_info(void)
 	static struct oidset seen = OIDSET_INIT;
 
 	refs_for_each_fullref_in(get_main_ref_store(the_repository), "",
-				 hidden_refs.v, show_ref_cb, &seen);
+				 hidden_refs_to_excludes(&hidden_refs),
+				 show_ref_cb, &seen);
 	for_each_alternate_ref(show_one_alternate_ref, &seen);
 	oidset_clear(&seen);
 	if (!sent_capabilities)
diff --git a/refs.c b/refs.c
index 3065e514fd..213412efd4 100644
--- a/refs.c
+++ b/refs.c
@@ -1482,6 +1482,31 @@ int ref_is_hidden(const char *refname, const char *refname_full,
 	return 0;
 }
 
+const char **hidden_refs_to_excludes(const struct strvec *hide_refs)
+{
+	const char **pattern;
+
+	for (pattern = hide_refs->v; *pattern; pattern++) {
+		/*
+		 * We also can't feed any excludes from hidden refs
+		 * config sections, since later rules may override
+		 * previous ones. For example, with rules "refs/foo" and
+		 * "!refs/foo/bar", we should show "refs/foo/bar" (and
+		 * everything underneath it), but the earlier exclusion
+		 * would cause us to skip all of "refs/foo". We likewise
+		 * don't implement the namespace stripping required for
+		 * '^' rules.
+		 *
+		 * Both are possible to do, but complicated, so avoid
+		 * populating the jump list at all if we see either of
+		 * these patterns.
+		 */
+		if (**pattern == '!' || **pattern == '^')
+			return NULL;
+	}
+	return hide_refs->v;
+}
+
 const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
diff --git a/refs.h b/refs.h
index 27d341d282..50c92d1f55 100644
--- a/refs.h
+++ b/refs.h
@@ -829,6 +829,8 @@ int parse_hide_refs_config(const char *var, const char *value, const char *,
  */
 int ref_is_hidden(const char *, const char *, const struct strvec *);
 
+const char **hidden_refs_to_excludes(const struct strvec *hide_refs);
+
 /* Is this a per-worktree ref living in the refs/ namespace? */
 int is_per_worktree_ref(const char *refname);
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 9dd1795bf2..59c3fe9d91 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1009,25 +1009,6 @@ static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
 	if (!excluded_patterns)
 		return;
 
-	for (pattern = excluded_patterns; *pattern; pattern++) {
-		/*
-		 * We also can't feed any excludes from hidden refs
-		 * config sections, since later rules may override
-		 * previous ones. For example, with rules "refs/foo" and
-		 * "!refs/foo/bar", we should show "refs/foo/bar" (and
-		 * everything underneath it), but the earlier exclusion
-		 * would cause us to skip all of "refs/foo". We likewise
-		 * don't implement the namespace stripping required for
-		 * '^' rules.
-		 *
-		 * Both are possible to do, but complicated, so avoid
-		 * populating the jump list at all if we see either of
-		 * these patterns.
-		 */
-		if (**pattern == '!' || **pattern == '^')
-			return;
-	}
-
 	for (pattern = excluded_patterns; *pattern; pattern++) {
 		struct jump_list_entry *e;
 
