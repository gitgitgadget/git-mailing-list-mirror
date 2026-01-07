Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C476312837
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791770; cv=none; b=GDInplcsbVnH4NKlMPB4Svss4BNR/kIsmFQWNDGcPTMVO16svtZjN+INcyaHBvvHPmjC2UvKpek/HKA1yiKli0x1mTWb1z7lrXq3RoibLenSYmyEyDVZME3AJAdsfusQ8bt4VO3GhG5hEapfrb2MKo58nVeOTET4XcWOxEm8MB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791770; c=relaxed/simple;
	bh=80jXO76uYHDVaOfc9dcXEofKS8yO+4T+cCwI2dWGWN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nZXo3xitj/ceu4zKtLvUvpIddHxqILzO4wsKGWIz0pwIlGZyYwd2mZjPAZSCMu/kvFOQp+y0SSABhVGNFY3NrExiKH4YBVrovyayt9lkmkFQK137NxCRaOsmKropK43NVcsts4pTsnMMI8nbwgFA9+6+eLOHbU1DsPd3zlQs278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ZO4S7hlA; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ZO4S7hlA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1767791766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KxIUVtDHVvmEPOnXLdA2BTf6bntkMjry1WC2eFwRTSA=;
	b=ZO4S7hlAPc2qBTioFRSshV1pfpC7Kk8YfeSlx89Vp08OSNeTWymsj1ueYb8qG7KkVoT/5R
	MyMcJWR8ibGeCm5PGcttNgjyU2vMiRLxdNt8sQRS3xPYg4PSXj7StvDxjZ/xJVRaaetFuq
	gj0jczs9IaOGIGW3mTUHICCaOQcbDfc=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 07/10] packfile: only prepare owning store in
 `packfile_store_prepare()`
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-7-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
 <20251218-b4-pks-pack-store-via-source-v2-7-62849007ce21@pks.im>
Date: Wed, 07 Jan 2026 14:15:54 +0100
Message-ID: <877bttpnqt.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> When calling `packfile_store_prepare()` we prepare not only the provided
> packfile store, but also all those of all other sources part of the same
> object database. This was required when the store was still sitting on
> the object database level. But now that it sits on the source level it's
> not anymore.
>
> Refactor the code so that we only prepare the single packfile store
> passed by the caller. Adapt callers accordingly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/grep.c | 14 ++++++++------
>  packfile.c     | 19 +++++--------------
>  2 files changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 4855b871dd..5b8b87b1ac 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1213,12 +1213,14 @@ int cmd_grep(int argc,
>  		 */
>  		if (recurse_submodules)
>  			repo_read_gitmodules(the_repository, 1);
> -		/*
> -		 * Note: `packfile_store_prepare()` prepares stores from all
> -		 * sources. This will be fixed in a subsequent commit.
> -		 */
> -		if (startup_info->have_repository)
> -			packfile_store_prepare(the_repository->objects->sources->packfiles);
> +
> +		if (startup_info->have_repository) {
> +			struct odb_source *source;
> +
> +			odb_prepare_alternates(the_repository->objects);
> +			for (source = the_repository->objects->sources; source; source = source->next)
> +				packfile_store_prepare(source->packfiles);
> +		}

Ahha, I see what you mean in the previous commit now. Sorry, my mistake.

-- 
Cheers,
Toon
