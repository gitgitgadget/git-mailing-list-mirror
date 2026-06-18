Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CC9291C10
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800838; cv=none; b=olWz12UdJzO+cnvO2EiAW/v0GTkNFPyy0gwEId/hGugBs1fXeIVh5TQACS10Li4U1YND93hv/Pd9V0qEmYu0T7zRpjwC7QLuUiYmYpd1Cktc0YUtozm7UNGbEShkYXq5Tc2+1CtmJyVOfRPa+jACfCosbPZokc027A+j6W8YFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800838; c=relaxed/simple;
	bh=hEg0IPxMeM52jF/wTXLOrpMlMh5oHsL5jtG47BRcmog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtkPZhbnl7lfp5DvVXkL+dsShemhs6w6dIuZI9Vor8D+jZgSnOrzJ4BkZIQDb5l7FOsZDX3PDyYnQNPaHbkpN5tLbHbF8y9lQC1kiXPKMAurxIVt1chxs3VNxdT+lCBcjuM0QAZszKJuTy7CjMBpiC2yEDEWWCyp37jK6HRROmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bwLbKEof; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bwLbKEof"
Received: (qmail 168203 invoked by uid 106); 18 Jun 2026 16:40:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hEg0IPxMeM52jF/wTXLOrpMlMh5oHsL5jtG47BRcmog=; b=bwLbKEofgUQDKk5+FuGSs0lNVtOs8HRQwNPr6Dy4MH8kfzlDBY5sM+ASUcksjXChX1MqbQRiiXxCwawhh/j5JDV2RDPxr+e45hKZe6UnZxcMLVHuHx8qB3zVn3TtXRWJsNGrAI1YZjjQ11ql+YsCEjE7Hkf7garIHHeeYsMJ24mVIJ+FbZTC9H4Fczju6ZY9ogOk7+Ks/B73QxoCHZez34zPvGtxVGqTbe91iITyuXH4n6PAE1fX1ogfqXm6l0Y7ewpHcqUJ03/59Q3pf3e+cdH1o3/BNYJBvjf8wXIPegtV1ySMYKLf0+5CsHmtknjFIwcYQ1TOB/bSgR1sxYbDjA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Jun 2026 16:40:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 474539 invoked by uid 111); 18 Jun 2026 16:40:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Jun 2026 12:40:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Jun 2026 12:40:35 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 7/8] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Message-ID: <20260618164035.GA1218204@coredump.intra.peff.net>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-7-f4854aa99859@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-7-f4854aa99859@pks.im>

On Mon, Jun 15, 2026 at 03:56:53PM +0200, Patrick Steinhardt wrote:

> When we have an "onbranch" condition we need to ask the reference
> database whether HEAD currently points at the configured branch. This
> unfortunately creates a chicken-and-egg problem:
> 
>   - The reference database needs to read the configuration so that it
>     can configure itself.
> 
>   - The configuration needs to construct a reference database to fully
>     parse all of its conditionals.
> 
> The way we handle this is by simply excluding "onbranch" conditionals
> when we haven't yet configured the reference database.

My gut feeling upon reading this is that some part of the config reading
is being done wrong to create this chicken-and-egg situation.

I'd expect the ref database config (like the ref format) to be read not
through the regular config subsystem, but via read_repository_format()
and friends. And while that does build on the regular config code, it
should never enable includes at all. So includeIf.onbranch:foo.path is
just another uninteresting config key to it.

In other words, there should be two passes over the config file: one to
load basic repository information (and not respect includes), and one to
actually load what we think of as user-visible config[1].

And it seems to work. If I do this:

diff --git a/config.c b/config.c
index 45144f73c5..343af2cf9a 100644
--- a/config.c
+++ b/config.c
@@ -303,7 +303,7 @@ static int include_by_branch(struct config_include_data *data,
 	const char *refname, *shortname;
 
 	if (!data->repo || data->repo->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
-		return 0;
+		BUG("chicken and egg");
 
 	refname = refs_resolve_ref_unsafe(get_main_ref_store(data->repo),
 					  "HEAD", 0, NULL, &flags);

and then:

  git config includeIf.onbranch:main.path alt-config
  git config -f .git/alt-config foo.bar baz
  git config foo.bar

then we correctly read the value without triggering this code path.

Looking back at the last commit that touched include_by_branch(), the
problem does not appear to be about a chicken-and-egg at all, though. It
is about reading config with includes when there is _no_ repository at
all. I.e., this:

  git config -f main-config includeIf.onbranch:main.path alt-config
  git config -f  alt-config foo.bar baz
  GIT_DIR=/does/not/exist git.compile config --include -f main-config foo.bar

will trigger that BUG() marker, and quietly returning "no match" (like
the current code does) is the right thing.

Looking below...

> The consequence is that we have recursion:
> 
>   1. We call `get_main_ref_store()`.
> 
>   2. We don't yet have a reference store, so we call `ref_store_init()`.
> 
>   3. We parse the configuration required for the reference store.
> 
>   4. We eventually end up in `include_by_branch()`.
> 
>   5. We have already configured the reference storage format, so we end
>      up calling `get_main_ref_store()` again.

Ah, the culprit seems to be ref_store_init() calling into the regular
config parser via repo_settings_get_log_all_ref_updates(). But that
feels weird to me. Either:

  1. It is application config that should not be something we need to
     load in order to initialize the backend. We could lazy-load it
     later, or rely on higher level code to set the option.

  2. It is crucial to the ref backend functioning, in which case we
     ought to be reading it alongside core.repositoryFormatVersion, etc.

-Peff
