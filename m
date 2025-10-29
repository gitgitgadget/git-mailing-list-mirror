Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CB326E719
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747904; cv=none; b=FVni5ZDeR3IkkBdRV/KeAwWsRFKkY+zr2IOO9OaWXJY9rJvqPjXvwjDy5oAtj/BlZrv+iIBo6lz2egBrXRvyLgOncIzRjqdQ9A60wSuAriKv1vIHkmbJ6du4mTOoU1Ri2HL9rb4/XKjn3zpZTXZp5zrXeeIVXCts5HcIWVTMFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747904; c=relaxed/simple;
	bh=mQkU+B4iV7M+PJrvJpdl5bgM1DSd4xy5ILIqTbXRi/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SNY95HPTr7yP2DRSx/3Rrc8tZ4QNnvu/UvfUpow6mYJLZ10PvuTdtB37+rkZbe/cj7U5fXoDFczkpc4pZUNBy+lk+IBcJ+T14klIr8oZhzdUSNDvQJ/tpw3bEooTd3FyVgGId1anI3+5CPS9cjr1jZAXQ66SHojgidFXWgBHGoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=FcOU/YR9; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="FcOU/YR9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1761747897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iJHHRQsJkYMNaRmJxm/mMHCUolbkrTehxhhluuOBc1Y=;
	b=FcOU/YR99JTj1NVINdoBLGA8kOPkUchlofsTDnAwy5TLg2KeKHdaNdmzOhM/rsBkCaS5J8
	UatRbkpVfSaVuYsUm18zCN/pNRwvVFJ3kghKSPt7dHaJdCVgREceuazZUAL4sv/T7aYZVI
	rsTiMs0LMJhHCje9CVCMYNtHUmGvZm0=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/8] http: refactor subsystem to use `packfile_list`s
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-3-1a3b82030a7a@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-3-1a3b82030a7a@pks.im>
Date: Wed, 29 Oct 2025 15:24:41 +0100
Message-ID: <87h5vhrdjq.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The dumb HTTP protocol directly fetches packfiles from the remote server
> and temporarily stores them in a list of packfiles. Those packfiles are
> not yet added to the repository's packfile store until we finalize the
> whole fetch.
>
> Refactor the code to instead use a `struct packfile_list` to store those
> packs. This prepares us for a subsequent change where the `->next`
> pointer of `struct packed_git` will go away.
>
> Note that this refactoring creates some temporary duplication of code,
> as we now have both `packfile_list_find_oid()` and `find_oid_pack()`.
> The latter function will be removed in a subsequent commit though.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  http-push.c   |  6 +++---
>  http-walker.c | 26 +++++++++-----------------
>  http.c        | 21 ++++++++-------------
>  http.h        |  5 +++--
>  packfile.c    |  9 +++++++++
>  packfile.h    |  8 ++++++++
>  6 files changed, 40 insertions(+), 35 deletions(-)
>
> [snip]
>
> diff --git a/packfile.c b/packfile.c
> index 4d2d3b674f3..6aa2ca8ac9e 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -121,6 +121,15 @@ void packfile_list_append(struct packfile_list *list, struct packed_git *pack)
>  	}
>  }
>  
> +struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
> +					  const struct object_id *oid)
> +{

Why does it take a `struct packfile_list_entry` and not a `struct
packfile_list` ?

-- 
Cheers,
Toon
