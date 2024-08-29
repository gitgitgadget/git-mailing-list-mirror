Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F5F1AD3FC
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940982; cv=none; b=rl6+VwwtSOPB4ZdeSfwoANpXPF0iHuau1h+tbTvA47aAi8G5+oGXjV+3h6zaUVt2bepNT9P+l76/KntHsax6CIE3KTvvuPZKdNb05qbQgk3c0elu9p5YdMaV4Mn5VqaKYW0n0VG6f3mqWrPSvAUcaoVDfieSo6e0fdmUCjTjAzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940982; c=relaxed/simple;
	bh=0Dsnpk1jO1svgYcSya2yzkaYwRcbZ1hwIDIQ2fCWbBM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sVXtG4GA57TqNIn444R7TwDB7D+5T2EcqvGORJk2EuOkdRXm12/BQNp1Lva2jjmZZo56MaIV5javY2+2+Bxfu6eyyQKPlyICHvfna0oO8whjrvqWNn3Z9UTjC42tzy4SkhIAITeaU7Wc1D+Fifqh4VVZMxAw91pIh98ofKtUO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Cbfu/mP3; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Cbfu/mP3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1724940977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kIkiaWkJB2eOUWIJqDkOLaJtU7brcehW0HEZTbgdHBE=;
	b=Cbfu/mP3sp+Tw2pV24OBnSlJsRIEaGmKBjq9cKNWdD1C4oos52KkXV7PvPv9ZqQF7YHVBb
	aQk+hifgaugQxtOerU00dn3CCqvv9lsmGHEk/v2lrbOsC4mvN7NlwtoGOY79TiI5GBgHt9
	xEsCQ3Pf8h2imf/Xbh9mLSnedDEjyHo=
From: Toon claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 14/22] shallow: fix leaking members of `struct
 shallow_info`
In-Reply-To: <2a63030ff09f938d705c117406b501ecf81f67de.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <2a63030ff09f938d705c117406b501ecf81f67de.1724656120.git.ps@pks.im>
Date: Thu, 29 Aug 2024 16:16:09 +0200
Message-ID: <87ed67jtxy.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> We do not free several struct members in `clear_shallow_info()`. Fix
> this to plug the resulting leaks.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  shallow.c               | 9 +++++++++
>  t/t5538-push-shallow.sh | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/shallow.c b/shallow.c
> index 7e0ee96ead9..dcebc263d70 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -489,6 +489,15 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
>  
>  void clear_shallow_info(struct shallow_info *info)
>  {
> +	if (info->used_shallow) {
> +		for (size_t i = 0; i < info->shallow->nr; i++)
> +			free(info->used_shallow[i]);
> +		free(info->used_shallow);
> +	}
> +
> +	free(info->need_reachability_test);
> +	free(info->reachable);
> +	free(info->shallow_ref);
>  	free(info->ours);
>  	free(info->theirs);
>  }

Recently was agreed in the CodingGuidelines `S_clear()` functions do a
`S_release()` + `S_init()`. I see we're not initializing the struct for
future use (i.e. we don't reset the `nr_*` fields to 0). But we cannot
really do an init, because that would be calling
`prepare_shallow_info()`, which allocates new memory. So would it be
worth to rename this function to `release_shallow_info()`?

--
Toon
