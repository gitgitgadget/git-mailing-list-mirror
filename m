Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5A1758F
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900179; cv=none; b=tKD71dGkRs6XOeC6lhg25oBUM2rCyy5+QGLBpKsn5CDcQFxCwyMuUkHt4Af4K6zGYfj3kDK90YjJRsUYwbn/tMbcWqgZ//QI9Gmdeq5ckFUSPIbU/xCJCxIrn0kW63B88nt8M9UlChObkrCgZlHa9q9GsxX/XhNNNklQnQbPLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900179; c=relaxed/simple;
	bh=DBNL6+2QwLSOzno/T1Wi5p9iDNiyFtTmvR67toFmxUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZlsk+wn27XNp8nhYXqnSO3YcHbWilRPmR/WNeZhMv3rnou8nuuE9uKpm8Hk1ztmt28hkMcj3TP19EY9tMJ6WbjKI8Fh73rn9UMjp8Vpv+Pfx+ITb+rwjv6jjoYZV+/AvErRjzUBfNeh0KwOS3y7wHAmcPlUSecPnzoTBtLIKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lkZyNYkq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lkZyNYkq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A3521F869;
	Mon,  9 Sep 2024 12:42:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DBNL6+2QwLSOzno/T1Wi5p9iDNiyFtTmvR67to
	FmxUs=; b=lkZyNYkqqP+LG0BG/Aot9SwEwykEamdjd7dPEK1e0AeMnzfl6aUR2z
	SaSJ5sh4tUgHP8NsptLQ+oklCLVJmrl+ONOTI/j0WN2IWsIniXvwnsJY7ZJ/kxUb
	LwZIbQLY9E0UBsVkUyYOaFrLmQ7lUBkr//lLtTeGpD/utiZIEU6X4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 212461F868;
	Mon,  9 Sep 2024 12:42:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 804531F867;
	Mon,  9 Sep 2024 12:42:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  "Derrick
 Stolee [ ]" <stolee@gmail.com>,  Shubham Kanodia
 <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH] remote: introduce config to set prefetch refs
In-Reply-To: <pull.1782.git.1725875232922.gitgitgadget@gmail.com> (Shubham
	Kanodia via GitGitGadget's message of "Mon, 09 Sep 2024 09:47:12
	+0000")
References: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
Date: Mon, 09 Sep 2024 09:42:55 -0700
Message-ID: <xmqqzfogsrqo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 90EA0F3C-6ECA-11EF-BDE8-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void apply_prefetch_refspec(struct remote *remote, struct refspec *rs)
> +{
> +	if (remote->prefetch_refs.nr > 0) {
> +		int i;
> +		for (i = 0; i < remote->prefetch_refs.nr; i++) {
> +			const char *src = remote->prefetch_refs.items[i].string;
> +			struct strbuf dst = STRBUF_INIT;
> +
> +			strbuf_addf(&dst, "refs/prefetch/%s/", remote->name);
> +			if (starts_with(src, "refs/heads/")) {
> +				strbuf_addstr(&dst, src + 11);
> +			} else if (starts_with(src, "refs/")) {
> +				strbuf_addstr(&dst, src + 5);
> +			} else {
> +				strbuf_addstr(&dst, src);
> +			}
> +
> +			refspec_appendf(rs, "%s:%s", src, dst.buf);
> +			strbuf_release(&dst);
> +		}
> +	}
> +}
>  static void filter_prefetch_refspec(struct refspec *rs)
>  {
>  	int i;
> @@ -502,8 +526,11 @@ static struct ref *get_ref_map(struct remote *remote,
>  	int existing_refs_populated = 0;
>  
>  	filter_prefetch_refspec(rs);
> -	if (remote)
> +	if (remote) {
>  		filter_prefetch_refspec(&remote->fetch);
> +		if (prefetch)
> +			apply_prefetch_refspec(remote, rs);
> +	}

Hmph, a separate helper function with a separate loop was something
I did not expect to see.  Looking at the filter_prefetch_refspec(),
it already limits what it prefetched to what we usually fetch from
the remote, and filteres out the tag namespace.  I was hoping that
this will _extend_ that existing mechanism, as if by default we
have prefetch refspec "!refs/tags/*", which can be replaced by the
configuration to say "!refs/tags/* !refs/changes/*", or positive
ones like "refs/heads/*".  The filtering semantics should be

 * a refspec whose src matches negated pattern (like !refs/tags/*)
   is rejected.

 * if the prefetch_refs has *only* positive patterns, then a refspec
   whose src does not match *any* of the pattern is rejected.

 * a refspec that is not rejected is prefetched.

But the above still allows what filter_prefetch_refspec() does by
default, without any way to narrow it down, and then adds its own
entries.

This is a half-tangent, but while studying for this topic, I noticed
that filter_prefetch_refspec() triggers O(n) loop every time a fetch
refspec is skipped.  

It all comes from 2e03115d (fetch: add --prefetch option,
2021-04-16) but rewriting the loop to use two pointers into the
array seemed trivial and the result seemed a bit more readable.

Your "further limit the prefetched refs with configuration" feature
would probably replace this part of the updated code:

+		/* skip ones that do not store, or store in refs/tags */
+		if (!rs->items[scan].dst ||
+		    (rs->items[scan].src &&
+		     starts_with(rs->items[scan].src,
+				 ref_namespace[NAMESPACE_TAGS].ref))) {

That is, instead of "skip ones that do not store, or store in refs/tags",
filtering using the configured value (probably implemented as a helper
function) would be used as the condition of the if statement.

Thoughts?

 builtin/fetch.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git c/builtin/fetch.c w/builtin/fetch.c
index 693f02b958..219302ed67 100644
--- c/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -436,37 +436,38 @@ static void find_non_local_tags(const struct ref *refs,
 
 static void filter_prefetch_refspec(struct refspec *rs)
 {
-	int i;
+	int scan, store;
 
 	if (!prefetch)
 		return;
 
-	for (i = 0; i < rs->nr; i++) {
+	/*
+	 * scan refspec items with 'scan', and decide to either
+	 * mangle and store it in 'store', or omit it from the result.
+	 */
+	for (scan = store = 0; scan < rs->nr; scan++, store++) {
 		struct strbuf new_dst = STRBUF_INIT;
 		char *old_dst;
 		const char *sub = NULL;
 
-		if (rs->items[i].negative)
-			continue;
-		if (!rs->items[i].dst ||
-		    (rs->items[i].src &&
-		     starts_with(rs->items[i].src,
-				 ref_namespace[NAMESPACE_TAGS].ref))) {
-			int j;
-
-			free(rs->items[i].src);
-			free(rs->items[i].dst);
-
-			for (j = i + 1; j < rs->nr; j++) {
-				rs->items[j - 1] = rs->items[j];
-				rs->raw[j - 1] = rs->raw[j];
-			}
-			rs->nr--;
-			i--;
+		/* negative ones are kept as-is */
+		if (rs->items[scan].negative) {
+			if (store != scan)
+				rs->items[store] = rs->items[scan];
 			continue;
 		}
 
-		old_dst = rs->items[i].dst;
+		/* skip ones that do not store, or store in refs/tags */
+		if (!rs->items[scan].dst ||
+		    (rs->items[scan].src &&
+		     starts_with(rs->items[scan].src,
+				 ref_namespace[NAMESPACE_TAGS].ref))) {
+			refspec_item_clear(&rs->items[scan]);
+			store--; /* compensate for loop's auto increment */
+			continue;
+		}
+
+		old_dst = rs->items[scan].dst;
 		strbuf_addstr(&new_dst, ref_namespace[NAMESPACE_PREFETCH].ref);
 
 		/*
@@ -478,11 +479,12 @@ static void filter_prefetch_refspec(struct refspec *rs)
 			sub = old_dst;
 		strbuf_addstr(&new_dst, sub);
 
-		rs->items[i].dst = strbuf_detach(&new_dst, NULL);
-		rs->items[i].force = 1;
+		rs->items[store].dst = strbuf_detach(&new_dst, NULL);
+		rs->items[store].force = 1;
 
 		free(old_dst);
 	}
+	rs->nr = store;
 }
 
 static struct ref *get_ref_map(struct remote *remote,
