Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF22FC3B2
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172909; cv=none; b=sz14bQF06CvoK/nlUYi5WZBVTwFoF0vVBHEVGXEd81o96Kqv6Eoh7MSz96a9nplmV+hOoWvSi3sW6e381TN2yvLKM8ubO1PHWU9CNCc7B8WR0WxlJ0Q5ngAyUx2PJeDo183gwY9CyjErm9lMyTiHFteSIK7r/CR/8SkJQONwuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172909; c=relaxed/simple;
	bh=m98je77/rdNebwiDSuA2PrwACdES5OE2qVdeg3EYPTM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L5lwsO/wg9GkCagOzRGCy+4cl/3fAIuuzLvIuYW9ReyVQtU9R24ig5XwEiXGBKEq+w6hlt79oeTQbarVtpNjmKoic0OgE7ljqf9Vt/8Nk74/W29Ub+AGZ+r77FUM2st5DwYo+YIJJKvhoCRhpfOwcYEA5ChiWOiwgFSF0TwemgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ZIOhNvoV; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ZIOhNvoV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752172904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FlVN8S2+4EK2mOsfPfFUQKMP+NcRyKbgKMjwQrkB8d0=;
	b=ZIOhNvoVkYEabrfZKH6oCf8tZvDfmlWs3VsZ7Zfmc19FxTbL7SRptJUs/qixQ928Ag14zC
	OS7wxKlvWGVBl1/GwFzsCGAEVWcMyOGAwYUWqJHXJtw/okWEdnvu7PImuXpVFNsBABjOGn
	6IXaOoOqfpxOSfCwH3Ch/u5kDQI1imo=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 13/19] object-file: get rid of `the_repository` in loose
 object iterators
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-13-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-13-62627b55707f@pks.im>
Date: Thu, 10 Jul 2025 20:41:28 +0200
Message-ID: <875xfzdh2f.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The iterators for loose objects still rely on `the_repository`. Refactor
> them:
>
>   - `for_each_loose_file_in_objdir()` is refactored so that the caller
>     is now expected to pass an `odb_source` as parameter instead of the
>     path to that source. Furthermore, it is renamed accordingly to
>     `for_each_loose_file_in_source()`.
>
>   - `for_each_loose_object()` is refactored to take in an object
>     database now and calls the above function in a loop.
>
> This allows us to get rid of the global dependency.
>
> Adjust callers accordingly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/cat-file.c      |  2 +-
>  builtin/count-objects.c |  2 +-
>  builtin/fsck.c          | 14 ++++++++------
>  builtin/gc.c            | 10 ++++------
>  builtin/pack-objects.c  |  5 ++---
>  builtin/prune.c         |  2 +-
>  object-file.c           | 18 +++++++++---------
>  object-file.h           |  5 +++--
>  prune-packed.c          |  2 +-
>  reachable.c             |  2 +-
>  10 files changed, 31 insertions(+), 31 deletions(-)
>

[snip]

> diff --git a/object-file.c b/object-file.c
> index bd93f17dcfe..b894379d22c 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1388,7 +1388,7 @@ static int for_each_file_in_obj_subdir(unsigned int subdir_nr,
>  	return r;
>  }
>  
> -int for_each_loose_file_in_objdir(const char *path,
> +int for_each_loose_file_in_source(struct odb_source *source,

I really enjoy seeing how your plan comes together here. So much nicer
to not pass in the path directly.

-- 
Cheers,
Toon
