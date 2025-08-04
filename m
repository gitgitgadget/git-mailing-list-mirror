Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F32F2D
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318849; cv=none; b=fzUwb50eyfF9yEidZP8UgcYGLex2WUK+1zdyD5C3Dqsif1Ns/rVmc2bFwa0w/Ax+MYjw0UzfMudY3/lmxA7LWJgSMR3tSKrkJQTGwzAkFc9FsUpuLtLOgul6DQZCifsiVeMG3XOdC9FG04lyM0bTNumxk39hPP19uivJN8/ggUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318849; c=relaxed/simple;
	bh=6bjrCbW54HlCMc8mOu/tO8Mkbi8qs6+13N3+JO2AOBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIjaObeZNOKH8ob17WEvkGTE2DEJRmtsMek5hW7jqDspHqeNCW0sH5/LAsM8k/ciboqZaOdIhR9jhxVy9DTtWuV3tNNhMbSFB+SuoqwmVkHnQI7Cp3SFSp0IoRcQPBbrpmilgH9vSNjIdzCWjsEUv6UqOlbhu29D27j91cRjHCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OA1ZQjm9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OA1ZQjm9"
Received: (qmail 1738 invoked by uid 109); 4 Aug 2025 14:47:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6bjrCbW54HlCMc8mOu/tO8Mkbi8qs6+13N3+JO2AOBQ=; b=OA1ZQjm9vYdkS66g6AA8QdZiKEprCMoB9Veotim8YlSaOTAdgt4rXy1p+Ye+Qj9kHDjtkQOlX82/Bm/l5PFJZpWJGAIc4KLSYR5JFyjORWD3FtCZne20yPnBLGbZoB3zCKCQJWr+JiFR8CBFa5X1kHWzUXvydAxrMoGeIA35GAAn3jwyMgPWCNDfmO+yBc4duPoyicRPdCs1e6nIxZb8lD0GL6+HGVl/V1aW+/WvhwHuhjiZck+VKI06T8bPWEgmNpcXWz/7i/q4U3P6cFkxSg2bZG9muYjxyqjMeQv9GXt2uMZ5FEOWQtf0kuvvGq6l2nG2ig//UI/Kf+KSHDp72Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Aug 2025 14:47:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20736 invoked by uid 111); 4 Aug 2025 14:47:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Aug 2025 10:47:26 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Aug 2025 10:47:25 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 7/9] refs/files: detect race when generating reflog
 entry for HEAD
Message-ID: <20250804144725.GA109984@coredump.intra.peff.net>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
 <20250729-pks-reflog-append-v3-7-9614d310f073@pks.im>
 <20250802111128.GC1180347@coredump.intra.peff.net>
 <aJBjdWv9qUeBL25-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJBjdWv9qUeBL25-@pks.im>

On Mon, Aug 04, 2025 at 09:38:29AM +0200, Patrick Steinhardt wrote:

> > Shouldn't we quietly drop the HEAD reflog update, rather than forcing
> > the whole transaction to fail? The user never asked us to update HEAD at
> > all. It was something we opportunistically decided to do, and now we
> > find out that it is not appropriate to do so.
> 
> That's something I wasn't quite sure about, either. Honestly, the reason
> I shied away from it is that it needs a bit more munging for an edge
> case that is hard to test reliably. But I guess we can do something like
> the below patch to skip writing the reflog message instea.

Yeah, I wondered what it would look like to drop a single update from a
transaction, since that's not something we currently allow. And indeed,
this is a bit scary:

> @@ -2626,8 +2632,16 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
>  		 */
>  		if (!(update->type & REF_ISSYMREF) ||
>  		    strcmp(update->parent_update->refname, referent.buf)) {
> -			strbuf_addstr(err, "HEAD has been racily updated");
> -			ret = REF_TRANSACTION_ERROR_GENERIC;
> +			if (unlock_ref(lock))
> +				strmap_remove(&backend_data->ref_locks,
> +					      update->refname, 0);
> +
> +			memmove(transaction->updates + update_idx,
> +				transaction->updates + update_idx + 1,
> +				(transaction->nr - update_idx - 1) * sizeof(*transaction->updates));
> +			transaction->nr--;
> +
> +			ret = 1;
>  			goto out;
>  		}

Not because it's necessarily wrong, but it feels like a maintainability
problem, when the transaction code learns some new struct field similar
to "ref_locks", and we have to update it here, too. I dunno. Pulling it
out into a "transaction_drop_update()" helper would make that a bit more
obvious, but you're right that the fundamental issue is that we're not
going to be testing this very well.

Maybe erroring out, as your original patch did, is the least-bad thing,
then? I think that _might_ even be what happens in the current code as
an emergent behavior. We leave HAVE_OLD_OID set, so we'd expect HEAD to
resolve to the same thing it originally did. If you've pointed it
elsewhere, then it probably would fail to resolve to that same oid
(unless you pointed to a different branch with the same tip commit).

I really wish there was an easy way to test this. I guess something like
this:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 89ae4517a9..6aeec2e8e0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2393,6 +2393,7 @@ static enum ref_transaction_error split_head_update(struct ref_update *update,
 						    const char *head_ref,
 						    struct strbuf *err)
 {
+	static int force_split = -1;
 	struct ref_update *new_update;
 
 	if ((update->flags & REF_LOG_ONLY) ||
@@ -2401,7 +2402,10 @@ static enum ref_transaction_error split_head_update(struct ref_update *update,
 	    (update->flags & REF_UPDATE_VIA_HEAD))
 		return 0;
 
-	if (strcmp(update->refname, head_ref))
+	if (force_split < 0)
+		force_split = git_env_bool("GIT_TEST_FORCE_SPLIT_HEAD_UPDATE", 0);
+
+	if (!force_split && strcmp(update->refname, head_ref))
 		return 0;
 
 	/*

along with:

  git commit --allow-empty one
  git commit --allow-empty two
  GIT_TEST_FORCE_SPLIT_HEAD_UPDATE=1 git branch foo HEAD^

creates roughly the situation (HEAD was never pointed at "foo", but
we'll create the reflog update for it anyway). It does fail with:

  fatal: cannot lock ref 'HEAD': reference already exists

even before your patch. And after, we get:

  fatal: HEAD has been racily updated

So it probably is just not something that happens very often, as I don't
recall ever seeing any discussion of it.

I dunno. Looks like you posted a new version of the series that loosens
this, so I'll take a peek at that (I also wondered whether what you
posted above leaks entries in the update struct, so maybe you've dealt
with that).

-Peff
