Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103233989
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534104; cv=none; b=GhIi+M2QZKcU9LrDxwyqyPy0UVpKWwt5J102ngo3pZgJZRTR9TrzecZTsgSjGV8xvPveG9NQ+IdTsD1M6obqdQHN18jEQrh8j38QHU1o//kyZ4afCqPk81tVsJauIS+AIXAEiKpM8XxlVEWhTZ1Ff45Y6rTvKu5Gqt9Fn/vLwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534104; c=relaxed/simple;
	bh=jZQjrcBmCZoyJ5F2YeBkVfajZMxm9WZG/jbj36R52ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8oPY7ciK23u73AInE/v7Fxsb0JDDlzdz3FadDtbsGKi6kEVMR9InHrq/0ZuN2u8DuLhzwyxTBUQo8cEOQJ3uDHfBAkZnLz32RlSzd3pMYgajEGsuCn11pocOetES676DnkqW2dOBVZP6AChK56dRgkUu2fGeHyZJN+RFValbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23612 invoked by uid 109); 27 Mar 2024 10:08:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Mar 2024 10:08:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25434 invoked by uid 111); 27 Mar 2024 10:08:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Mar 2024 06:08:25 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Mar 2024 06:08:19 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: repositoryformatversion and extensions
Message-ID: <20240327100819.GB857435@coredump.intra.peff.net>
References: <CA+WKDT0fAASYE_ZhSxATv2NUnYceOP-_EF1kqKNFSOWU4QdPVQ@mail.gmail.com>
 <Zfv-kpa4CJJvop2j@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zfv-kpa4CJJvop2j@tanuki>

On Thu, Mar 21, 2024 at 10:32:11AM +0100, Patrick Steinhardt wrote:

> > > When reading the core.repositoryformatversion variable, a git
> > > implementation which supports version 1 MUST also read any configuration
> > > keys found in the extensions section of the configuration file.
> 
> Yeah, indeed. As far as I understand, the major difference between
> version 1 and version 0 is that version 1 asks the Git client to bail
> out as soon as there is any extension that isn't understood by the
> client. To me this behaviour is somewhat surprising because it doesn't
> allow for in-between states where some extensions are mandatory whereas
> others aren't. It would have been better to have a mechanism that
> disregards the version but makes each extension itself highlight whether
> it is mandatory or not.

The point of bumping "0" to "1" at all was that older versions of Git,
which did not understand extensions at all, would continue to bail. So
yes, I do think it's unfortunate that we do not insist that the version
is set to "1" when parsing extensions, but it is a bug for any writer to
set an extension and _not_ bump the version. Versions of Git older than
v2.6.3 would quietly ignore them.

And you're correct that it does not allow for non-mandatory extensions.
But then, that is the whole point of the extensions.* mechanism: it is
to make sure that versions of Git that do not understand the particular
extension refuse to run. If something isn't mandatory, then it should
not be in extensions.* at all. It should be regular config, with the
knowledge that older versions may ignore it.

At least that was how it was all originally designed. I think later
extensions did not always correctly set the repository version. We tried
to fix that later, but ran into compatibility issues. See 11664196ac
(Revert "check_repository_format_gently(): refuse extensions for old
repositories", 2020-07-15).

So that splits us our extensions into two sets:

  - ones that existed at the time of 11664196ac, which are allowed with
    v0 for compatibility. These are found in handle_extension_v0() in
    Git's code

  - everything else that is added should do things correctly, and should
    go into handle_extension_v1()

So getting back to Ed's question...

> > Despite that, at least one extension (objectformat) does require
> > core.repositoryformatversion >= 1. Though, do note that objectformat
> > is not mentioned in the repository-version documentation.
> > 
> > What other extensions require repository format version >= 1? Is
> > core.objectformat the outlier here?

...the answer is that it's the other way around. Those older extensions
are the outliers. But since we don't add extensions often, for a long
time it was the only one that did things right. ;) And now refstorage
does it right, too.

If we add more extensions, they will also behave that way.

> In any case, the policy of the Git project is that any new extension
> should only ever be understood when the repository format version is >=
> 1 from now on. At least, that's what the code tells us:
> 
> ```
> /*
>  * Do not add new extensions to this function. It handles extensions which are
>  * respected even in v0-format repositories for historical compatibility.
>  */
> static enum extension_result handle_extension_v0(const char *var,
> 						 const char *value,
> 						 const char *ext,
> 						 struct repository_format *data)
> ```
> 
> So it's probably safe to assume that every new extension should be at
> least v1 from now on.

Right, exactly.

If you really want more gory details, I think the discussion is all in:

  https://lore.kernel.org/git/pull.675.git.1594677321039.gitgitgadget@gmail.com/

-Peff
