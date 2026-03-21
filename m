Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93CB34BA59
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774127166; cv=none; b=gC94fXmB1fbvJo6q6LPKlGPo2kHS3nhQXhmgMJBIXki50Mx2WRdDlifo71uE6tBzFTqpirnJNPyvFQqF5r4/IL+sN9c28foK4GAcOHgUItppERSTdEu6xD7Akwr4Sbwy0RFz7xiG4Ru7oENu3F+G+nWOPSRUGoJzYeBUa1Wql7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774127166; c=relaxed/simple;
	bh=koBJURWnTYXs4EAKcgfo12v1QnYshW9reMMw8IzmwAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY/rKvZBN7aFDIkG2HxGKHTCnTJFsh3U+jrpBpt9eBLvr9y1OT/W0gQsAfsyPvTbhMkU20AO7u+MkNZBnAYFYC5v8xxPwbL+qYs+rieaZmOyRQ3L9InxtXuTQzNk0l5+XdLlf/XncwucPZNC1qpcd+AF3UtV254RUUjoq/Or8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fY+BkSbv; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fY+BkSbv"
Received: (qmail 88949 invoked by uid 106); 21 Mar 2026 21:06:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=koBJURWnTYXs4EAKcgfo12v1QnYshW9reMMw8IzmwAU=; b=fY+BkSbvA+fOp4DpKxw7TUhfsgzMLCDoTY9xc03ZCmJtNoTAc3c7dA1Lr959zvm3obJetpq7I8IeBqjcPeFRIAsjLOxF2n456v0w3TPTseKy4rPAsS/XhHMGtPUzaiYmJwxw2u4lGE7LxmA1Qs4Hd87qaOkP1xWiwAsgycATkkaP4OLnosyNBSV8DhYCVx4KVPrl/+LuAIax40KBt+VNbMUCrf2qSVZz3QDjbhmrlmzV31mvy6ycIkqvLRmec7CeBAKbkv2TwW6RAyIYqOiJL+1YLBwaz5StuVWcivLSz07jw98aOlKjS3pvMXVOIWsJsRu9iDPz2hsxVXPJ/lx/hw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Mar 2026 21:06:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 123393 invoked by uid 111); 21 Mar 2026 21:06:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2026 17:06:02 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 21 Mar 2026 17:06:02 -0400
From: Jeff King <peff@peff.net>
To: Jo Liss <joliss42@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: remote-curl: segfault parsing remote.<name>.fetch outside a
 repository
Message-ID: <20260321210602.GA736981@coredump.intra.peff.net>
References: <CAN=xy38zCRdOAnMtBXtRyUHE=+gtS8J6mwUWFQqxDAaBLAm7dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN=xy38zCRdOAnMtBXtRyUHE=+gtS8J6mwUWFQqxDAaBLAm7dA@mail.gmail.com>

On Sat, Mar 21, 2026 at 07:11:18PM +0000, Jo Liss wrote:

> I ran into a bug and thought I'd report it! The following command
> segfaults for me (where ~/src/git is my clone):
> 
> env -C / \
>     GIT_CONFIG_NOSYSTEM=1 \
>     GIT_CONFIG_GLOBAL=/dev/null \
>     GIT_CONFIG_COUNT=1 \
>     GIT_CONFIG_KEY_0=remote.repro.fetch \
>     GIT_CONFIG_VALUE_0='+refs/tags/*:refs/tags/*' \
>     ~/src/git/git-remote-http repro
> 
> In other words, this is happening when the shared remote-curl code
> (here, git-remote-http) is called outside of any repository, while
> `remote.<name>.fetch` is set.
> 
> I can reproduce this on Ubuntu and macOS, with git master
> (7ff1e8dc1e16) and git 2.51.0.

This is another fallout from c8aed5e8da (repository: stop setting SHA1
as the default object hash, 2024-05-07).

It's a curious case, though. The crashing code is parse_refspec() does
this:

  if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
        item->exact_sha1 = 1; /* ok */

But what is the correct hash algo to use here when we are outside a
repository? Usually remote-curl tries to detect the hash algorithm in
use by the other side (based on its info/refs response). But we don't
contact the other side until we've run remote_get(), and the refspec
parsing is happening via that remote_get().

In this particular case, the origin refspecs are not even going to be
used, but you can construct a similar one where they are:

  git -C / \
      -c remote.foo.url=https://github.com/git/git \
      -c remote.foo.fetch=whatever \
      ls-remote foo

We could do this:

diff --git a/refspec.c b/refspec.c
index 0775358d96..e6c29b7dd0 100644
--- a/refspec.c
+++ b/refspec.c
@@ -101,7 +101,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		/* LHS */
 		if (!*item->src)
 			; /* empty is ok; it means "HEAD" */
-		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
+		else if (the_hash_algo && llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
 			item->exact_sha1 = 1; /* ok */
 		else if (!check_refname_format(item->src, flags))
 			; /* valid looking ref is ok */

to make the segfault go away, but it is mostly papering over the
problem. I'm not sure if the exact_sha1 flag would matter when we are
not actually fetching (and we cannot fetch when we are not in a local
repo). Grepping around, it looks like it does influence the ref prefixes
we send to the other side (yet another chicken-and-egg!).

-Peff
