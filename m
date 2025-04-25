Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65F2701B7
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569652; cv=none; b=G6w95W9uu9QK7JRmAEAI2dXY93ENyV9HrzdYl7Ze4uELYv7AdoY2/U3qcIL93Nc1DL+MhortGnAnWeZ+AVfMs4Y9VKdGCOvBkUk27bufeM5UzeQxBgEpAH9pLzHz/4N/GRrBbcaXKVul2tTi/PCu5MAj8phpwh1wYsarsgSTVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569652; c=relaxed/simple;
	bh=6yah/0Qzc4m47zAzd9u5koaJdpl81c69WeKGuq10xm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TW3IcsYnLvgGk3QxXeOKV0jT7h4vod60BWE37GE4a1lv+0uw03qqfPHvnbFBEIMR09G/RUDEqCvH4ZhvuhrcOLSk5QT5VZrUagKEV23DEOe4mZZro3o3d6b9xly5eIilTqM9PJjaMxflyTe3lEfLrtWDjr5uArJV+O0mGff7iHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=01qngttD; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="01qngttD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1745569646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FaQnLaPaOXTNHaJGa1oiAelOuqBn4hcuYkZkSAYGyv8=;
	b=01qngttDkDVLIVz2OTRKp3wpy96+JrFDFnY/AKXJ1+pC92tgJVNglAV7SyzsJjh1Jd+ACG
	wYPqn6GmtBRvmVxRFalOibU2nTdr41/ZkAe/hyJu2uJrzpamL2WLBkcPhIOgEXN/4PxP7m
	AEehr0bCTPQMcbmqFFGgBH89A6lSC0Q=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>, Junio C Hamano <gitster@pobox.com>,
 Eli Schwartz <eschwartz@gentoo.org>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/2] meson: report detected runtime executable paths
In-Reply-To: <20250425-pks-meson-posix-shell-v2-1-fddc6123511b@pks.im>
References: <20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im>
 <20250425-pks-meson-posix-shell-v2-1-fddc6123511b@pks.im>
Date: Fri, 25 Apr 2025 10:27:12 +0200
Message-ID: <877c38fxy7.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Git needs to know about a couple of executable paths to pick at runtime.
> This includes the system shell, but may also optionally include the Perl
> and Python interpreters. Meson detects the location of these paths
> automatically via `find_program()`, which does a lookup via the `PATH`
> environment variable. As such, it may not be immediately obvious to the
> developer which paths have been autodetected.
>
> Improve this by exposing runtime executable paths at setup time.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index c47cb79af08..a180c66ee69 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2080,3 +2080,9 @@ summary({
>    'sha256': sha256_backend,
>    'zlib': zlib_backend,
>  }, section: 'Backends')
> +
> +summary({
> +  'perl': target_perl,
> +  'python': target_python,
> +  'shell': target_shell,
> +}, section: 'Runtime executable paths')

I appreciate this change. Without [PATCH 2/2] applied I'm getting:

  Runtime executable paths
    perl         : /usr/bin/perl
    python       : /usr/bin/python3
    shell        : /usr/bin/sh

And with [PATHCH 2/2] I'm getting:

  Runtime executable paths
    perl         : /usr/bin/perl
    python       : /usr/bin/python3
    shell        : /bin/sh

As expected. :+1:

--
Toon
