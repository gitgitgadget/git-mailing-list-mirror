Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8247F2F6
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495161; cv=none; b=WxnJ+e3kACH5AO9dU1TR1k9bPcds4WnklflZLk4J7Ih2SIIvwVWB4aC+8/YVjGVTnTpii96GfejA/qNdsgdHLgQmir6ZBRrwHoV8SImtqA8key0sogXEfkemOn1HP7cbHOF6sq/i269u+wXzpLt0i4tz7sFX6v7m/8UFak4WCgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495161; c=relaxed/simple;
	bh=AHxXeYD5gDTcTST42lKMmw5j9eceImKyRyBZ/VKtC8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uwa67ztgBWsrYdocbPuvKaBG5kHV38XoVF1fO89i2IFHBmzRNByUe8UtqGLIqiZUEteK8hBl7z05oYHHlwDl1GTYZVQewD2TR7aGU5Y2iEhGcNRfeXHUWl+ZouxEr5nCuwGuHLs3CJJ/c8Bcr9M0upuaJFCzBodMqoKwJgZ3+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Y+AKLF4X; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Y+AKLF4X"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1780495149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9/ijaZgFEZo0/qRq3gaFhGSvFGc453MsLH3JkttXQFg=;
	b=Y+AKLF4XBDSheZi18O2PRuDfJJOUOZ4r0CvT1ORv5fgeRuBEOwhKdyYLnG9hz7xtgma9lN
	CJfJKrGhMFJ3qtYwxXwNtMt/sMAhJeV6s8SnROpQg/oCeUlhKuwfAizgAeXRl06uYyw6hX
	fPkXHt4+bRhmr0slWdj22N71/Gktn0A=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, Weijie
 Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 3/3] b4: introduce configuration for the Git project
In-Reply-To: <20260603-pks-b4-v2-3-a8aea0aa2c23@pks.im>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
 <20260603-pks-b4-v2-3-a8aea0aa2c23@pks.im>
Date: Wed, 03 Jun 2026 15:58:38 +0200
Message-ID: <87qzmn20a9.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> We're about to extend our documentation to recommend b4 for sending
> patch series to the mailing list. Prepare for this by introducing a b4
> configuration so that the tool knows to honor our preferences. For now,
> this configuration does two things:
>
>   - It configures "send-same-thread = shallow", which tells b4 to always
>     send subsequent versions of the same patch series as a reply to the
>     cover letter of the first version.
>
>   - It configures "prep-cover-template", which tells b4 to use a custom
>     template for the cover letter. The most important change compared to
>     the default template is that our custom template also includes a
>     range-diff.
>
> There's potentially more things that we may want to configure going
> forward, like for example auto-configuration of folks to Cc on certain
> patches. But these two tweaks feel like a good place to start.
>
> Note that these values only serve as defaults, and users may want to
> tweak those defaults based on their own preference. Luckily, users can
> do that without having to touch `.b4-config` at all, as b4 allows them
> to override values via Git configuration:
>
>     ```
>     $ git config set b4.prep-cover-template /does/not/exist
>     $ b4 send --dry-run
>     ERROR: prep-cover-template says to use x, but it does not exist
>     ```
>
> So this gives users an easy way to override our defaults without having
> to touch ".b4-config", which would dirty the tree.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .b4-config         |  6 ++++++
>  .b4-cover-template | 11 +++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 0000000000..fd4fb56b6d
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,6 @@
> +# Note that these are default values that you can tweak via the typical
> +# git-config(1) machinery. You thus shouldn't ever have to change this file.
> +# See also https://b4.docs.kernel.org/en/latest/config.html.
> +[b4]
> +send-same-thread = shallow

Is it worth to note this requires v0.15 or higher?

That version was released only 2 months ago, I can imagine many distros
still ship an older version, what happens if a version doesn't support
this setting yet?

> +prep-cover-template = ./.b4-cover-template
> diff --git a/.b4-cover-template b/.b4-cover-template
> new file mode 100644
> index 0000000000..ab864933b5
> --- /dev/null
> +++ b/.b4-cover-template
> @@ -0,0 +1,11 @@
> +${cover}
> +
> +---
> +${shortlog}
> +
> +${diffstat}
> +
> +${range_diff}
> +---
> +base-commit: ${base_commit}
> +${prerequisites}
>
> -- 
> 2.54.0.1064.gd145956f57.dirty
>
>

-- 
Cheers,
Toon
