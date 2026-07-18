Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07089381B05
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784362451; cv=none; b=ET/AsrAocz1U9dVWTD6s8SBv7TXPcHjtaKoC0++stP1M33p0825rWuvuQOkmWw5UAQ79oA3Nai3jbsxMox0b5Me2ra4MR9Q2uyhytO+GqStng9kDID/3K8Xh6tqDiq8h7u01Bqho3iLscMOckNb3saibzQN194A+dh0l5AbLz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784362451; c=relaxed/simple;
	bh=MDX+KL3by4dPjfyfEFvJKdn6Zz0BbGNTKy+2N1dyJjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaHoxaU4GZ4JYmvoxm2VpNfyeA6ihnrf7XIGUCuzq0GdoMJsnDXDI/aqgjs4mQ6QLbPPwgtchpY0PRWHnSp89+Ng1NFra7D3QvIfbzJvP0ZIyffsFpCOwOupcsgWzzS5NnuDEaT75cO00McsbgBiOOtsbrzI9mi2lz2vBsEizVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CID1Eizz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CID1Eizz"
Received: (qmail 60392 invoked by uid 106); 18 Jul 2026 08:14:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MDX+KL3by4dPjfyfEFvJKdn6Zz0BbGNTKy+2N1dyJjA=; b=CID1EizzF9olkNh/dchrJj+GgNKuvAe761eRyHusL5KRlnE+FiAsQoX82kqkY/XOzIFl/kicXNxXbq83da8BM7xJdUS9sGJ7zmGqtGxxvu/oTFDUQCbQ9mp4iLlGCE0uTudxOH1NRiNObEszg1/tMtyyfv8ZmyXsY3cPDz8psNsmGpt6TJ/zcPfhzK4qO5p4oWER/LOUeTgxWqfw/g+8EYBNWqXOHs9elkv3tgykqSEzC+bUP0dxJSvjoiWY8ixS3WJWbCBsW1P/DI1LxkwaL3b1kQmBXNwyxSy/39arOw6PWFMKhHRajAQIrfO2N2idk8FWojGdYH71oegLFA3dFQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jul 2026 08:14:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 106824 invoked by uid 111); 18 Jul 2026 08:14:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jul 2026 04:14:12 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jul 2026 04:14:07 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>
Subject: Re: [PATCH 4/4] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
Message-ID: <20260718081407.GC22588@coredump.intra.peff.net>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-4-410418f18614@iotcl.com>
 <87a4rp1l65.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a4rp1l65.fsf@emacs.iotcl.com>

On Fri, Jul 17, 2026 at 09:16:34PM +0200, Toon Claes wrote:

> > +	/*
> > +	 * prepare_revision_walk() clears bloom_filter_settings for pathspecs
> > +	 * without a Bloom key. Restore it so the per-path check keeps working.
> > +	 */
> > +	if (!lm->rev.bloom_filter_settings)
> > +		lm->rev.bloom_filter_settings =
> > +			get_bloom_filter_settings(lm->rev.repo);
> > +
> 
> @Peff, as far I could tell:
> 
> * This change was not needed to be able to use the Bloom filters with
>   the pathspec.

Ah, right. In my earlier attempt I came at it from the bottom up: I
found the bloom_keyvec, saw how it was populated, and then worked my way
back to prepare_to_use_bloom_filter() without going further.

But it is much nicer if we can rely on prepare_revision_walk() here, as
we don't need to make an additional function public.

> * Only restoring bloom_filter_settings was needed. In your patch you're
>   calling prepare_to_use_bloom_filter(), but that is being called by
>   prepare_revision_walk(). Thus the restoring of the filter settings
>   I've added after that function.

Hmm, OK. The "clearing" done by prepare_revision_walk() is kind of
weird. The bloom settings are a const pointer, not a resource we own, so
there is really no need to clear them.

But accepting for a moment that we do clear them, is this maybe an
indication that we are abusing rev_info.bloom_filter_settings? It is
really an internal implementation detail that revision.c uses for its
own bloom filters. Wouldn't it be cleaner for last-modified to keep its
own, like this:

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index fe012b0c2e..5e176bbeed 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -61,6 +61,8 @@ struct last_modified {
 	size_t all_paths_nr;
 	struct active_paths_for_commit active_paths;
 
+	struct bloom_filter_settings *bloom_filter_settings;
+
 	/* 'scratch' to avoid allocating a bitmap every process_parent() */
 	struct bitmap *scratch;
 };
@@ -114,9 +116,9 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 
 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
-		if (lm->rev.bloom_filter_settings)
+		if (lm->bloom_filter_settings)
 			bloom_key_fill(&ent->key, path, strlen(path),
-				       lm->rev.bloom_filter_settings);
+				       lm->bloom_filter_settings);
 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
 		hashmap_add(&lm->paths, &ent->hashent);
 	}
@@ -262,7 +264,7 @@ static bool maybe_changed_path(struct last_modified *lm,
 	struct last_modified_entry *ent;
 	struct hashmap_iter iter;
 
-	if (!lm->rev.bloom_filter_settings)
+	if (!lm->bloom_filter_settings)
 		return true;
 
 	if (commit_graph_generation(origin) == GENERATION_NUMBER_INFINITY)
@@ -277,7 +279,7 @@ static bool maybe_changed_path(struct last_modified *lm,
 			continue;
 
 		if (bloom_filter_contains(filter, &ent->key,
-					  lm->rev.bloom_filter_settings))
+					  lm->bloom_filter_settings))
 			return true;
 	}
 	return false;
@@ -502,7 +504,7 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 		return argc;
 	}
 
-	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
+	lm->bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
 
 	if (populate_paths_from_revs(lm) < 0)
 		return -1;

It's mostly academic, as both of the pointers (if not NULL) would always
point to the same setting that ultimately come from the repository
object. But it feels cleaner for them to keep their own pointers,
because that pointer may also signal "do we have usable bloom filters".
We are a little lucky in dodging a bug here: last-modified uses the
pointer for that purpose, but if revision.c did so also, they'd
conflict.

  Side note: this is really a repository property, so it would be nice
  if we could just do:

    repo_bloom_filter_contains(filter, &ent->key);

  without managing the settings pointer ourselves at all. But the cost
  to fetch it from the graph linked list is not totally trivial, so we'd
  probably end up having to cache it somewhere. I don't know if that's
  worth it (plus last-modified would still have to keep a boolean
  somewhere to decide whether it is using bloom filters or not).

-Peff
