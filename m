Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44E1D88CA
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733090355; cv=none; b=aPCyT0be4KVV7+WC3HkiAoEuvf55cYyWCJHGkLsLQc4KIdhoy/aw8hp0BASxVqlqmIYfbY2RljAOA97+IfbDKhYSd8casWnT1XLZbIZJBbc6h3fGmpz+nrOgOP9qIAsgE4XX895A4J5G9qZj7Cd+W7gllzuC3B0QHkEJy23PQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733090355; c=relaxed/simple;
	bh=OkHytYXl2SIrkom9bKcm5PkjGWQt+KBeoCt/6Q9JORs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV9HIHNgTiJX7sWjzGXtC261NbBZ5ImJbK0kM4fXziBhJ0q+bw531+P6p9w9kCJgmcGVCBbIbfTSzFTdQ8L54jH+5VglfGPW6CjPiCAqMsg7QWUNgRhtBmHHcj/CWmJjud8Xt08vuRIb3ffmkSyhnWfHafxqIAmJtcwqEX1TiWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ii6W+ebw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ii6W+ebw"
Received: (qmail 3793 invoked by uid 109); 1 Dec 2024 21:59:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=OkHytYXl2SIrkom9bKcm5PkjGWQt+KBeoCt/6Q9JORs=; b=Ii6W+ebwJ5DgadPoo59yQR8Nou7KMS9xaro+jBtxEMfoWXslKq+Vr486KEcPAiz4youmyfqXQbd4sMQkt7BH18vfuwjkSYvmJSt0a9Wt3Aa3uhQFgYlklza/0r7+bMyM1T+2dFQTi/o9Hr3hExY4jwyp45q+dlvfhMml9hCz9G8R+ig572Ol1RANcB8RdB8BBHjLgLuNyqlMexNiZyOLmXQLk7AGMbcqYKQc5Ry/Ez34c+jmnzwB3zY6UlRZEV4bLyWb9TpLVSSmTUwWcRn1cIzNK//cJrGgrjsKCKz4Qci0iAQLgOltpaVNPKj310PIryckkBvyC6hwwlVoyhCGpg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 01 Dec 2024 21:59:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14366 invoked by uid 111); 1 Dec 2024 21:59:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 01 Dec 2024 16:59:11 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 1 Dec 2024 16:59:11 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/10] global: fix unsigned integer promotions in ternary
 statements
Message-ID: <20241201215911.GD145938@coredump.intra.peff.net>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241129-pks-sign-compare-v1-6-fc406b984bc9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241129-pks-sign-compare-v1-6-fc406b984bc9@pks.im>

On Fri, Nov 29, 2024 at 02:13:27PM +0100, Patrick Steinhardt wrote:

> diff --git a/builtin/blame.c b/builtin/blame.c
> index f0d209791e44025b1965cd447cf4fc1e2ca5f009..6c6b0c7ef1a4d992064c7664bbf1229ef0286b97 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -470,7 +470,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>  
>  	for (cnt = 0; cnt < ent->num_lines; cnt++) {
>  		char ch;
> -		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? the_hash_algo->hexsz : abbrev;
> +		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ?
> +			cast_size_t_to_int(the_hash_algo->hexsz) : abbrev;

Hmm. I'm surprised that -Wsign-compare would trigger here. We are not
comparing, but assigning. I'd have thought the actual error is the
truncation from the size_t the_hash_algo->hexsz down to "length".

But the actual error from gcc is:

  builtin/blame.c:472:87: error: operand of ‘?:’ changes signedness from ‘int’ to ‘size_t’ {aka ‘long unsigned int’} due to unsignedness of other operand [-Werror=sign-compare]
    472 |                 int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? the_hash_algo->hexsz : abbrev;
        |                                                                                       ^~~~~~

So that makes sense that "abbrev" is promoted to unsigned to match the
other side, though I still think it's a little weird this comes via
-Wsign-compare.

Another solution would be to change "abbrev" into a size_t. But then
we'd still have truncation assigning to "length", unless we also make
that a size_t. But wouldn't that be the more natural type? We pass it to
memset() later.

We also subtract from it (without checking that it doesn't become
negative!), and use it with a printf("%.*s"). The latter does want an
int because of the lousy historical interface. IMHO we are probably
better off using fwrite() or strbuf_add() instead of "%.*s" specifiers.
In this case, I think it's just:

  fwrite(hex, 1, length, stdout);

(that assumes "length" is clamped to the hex size; I think it is here
but I also would not be opposed to a helper function that checks it
against the string length).


So I don't think what you've written above is _wrong_. But I think that
ultimately the right type here probably is size_t, and I worry that
sprinkling casts around makes it harder to see that. It converts what
would be a compile-time complaint (the truncation and sign conversion)
into a run-time one (that in this case I suspect can't be triggered, but
as a general rule may be something that _can_ be a problem but which our
tests are unlikely to actually poke at). I dunno.

I didn't dig carefully into the other ones, but I suspect they may be
similar. E.g.:

> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index 56585757477911c96bbb9ef2cf3710691b8e744e..87fa586c4d552ba61cd2ac2cf079d68241eb3275 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -163,7 +163,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
>  			after--;
>  
>  		/* Add line to hash algo (possibly removing whitespace) */
> -		len = verbatim ? strlen(line) : remove_space(line);
> +		len = verbatim ? cast_size_t_to_int(strlen(line)) : remove_space(line);
>  		patchlen += len;
>  		the_hash_algo->update_fn(&ctx, line, len);
>  	}

Here we are assigning the result of strlen() to an int, but I think it's
unbounded (it points to a strbuf we read from stdin). The cast helper
does at least mean we'll bail rather than continue on bogus input, but
consistently using size_t seems better still to me.

-Peff
