Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707073233
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815155; cv=none; b=KPi7s6Ate2Mgmxp3/yFDxxsoKyiwt3NPpT5Gn80aiCNM1yBbKgxYz+rLOBli3GbAQdq1buNj5vH74XuyyuBof3Kw7UCgUjPjtjrrz1GEGantc/+pA5096gKvwWjV4nq+/MIclRTqFiP6XGR8ErteJ7MEP09zvR7snXA/HkhJPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815155; c=relaxed/simple;
	bh=o+T0pd+a354hwt9/yQPdSZXFo5trtDH6TFwiEzyC00w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DsA2LM/ZYMSRrDW/dmSfcsxE28E1RNa7S153F1poFgLnDIy9leBoW+Gwgl1jAHxFzJKaTvURSpCKNk/1INoK39MLHn0IlpUveb7GEEQxaLo0YfJgsfc+YCGAajrL7Cu1OY+F80r4BdhLY2e5RS39XaSO3gbeFRO/TdSaHRJDOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=n+HNj7jS; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="n+HNj7jS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1709815149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BVL0zSeX0ynTRrFhIXoGq5HOaSuBVL7ws6uGQ6AIAxs=;
	b=n+HNj7jS5ArPATgAF5Czk8KzHUAQeukFsYSKfw4Jxz+b1uV01JhMXI8WUQaN+FcuBaCO/p
	JVbPDRu8xX7VWtehdFg+EWBdp4Nb41varrxZ1MOD0EaSL5Nc19Gi2WTvQ3BeS1uymMG1EH
	q+QqblC1snQ2hN7rT5xS30kYVd8Avss=
From: Toon claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] reftable/stack: register compacted tables as tempfiles
In-Reply-To: <b952d54a05e1c0cf47371f78e3901cfb2119e246.1709549619.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 4 Mar 2024 12:10:59 +0100")
References: <cover.1709549619.git.ps@pks.im>
	<b952d54a05e1c0cf47371f78e3901cfb2119e246.1709549619.git.ps@pks.im>
Date: Thu, 07 Mar 2024 13:38:56 +0100
Message-ID: <87sf12fc7z.fsf@to1.studio>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

> diff --git a/reftable/stack.c b/reftable/stack.c
> index 977336b7d5..40129da16c 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -827,51 +827,57 @@ uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
>  
>  static int stack_compact_locked(struct reftable_stack *st,
>  				size_t first, size_t last,
> -				struct strbuf *temp_tab,
> -				struct reftable_log_expiry_config *config)
> +				struct reftable_log_expiry_config *config,
> +				struct tempfile **temp_table_out)
>  {
>  	struct strbuf next_name = STRBUF_INIT;
> -	int tab_fd = -1;
> +	struct strbuf table_path = STRBUF_INIT;
>  	struct reftable_writer *wr = NULL;
> +	struct tempfile *temp_table;
> +	int temp_table_fd;

Just one small nit, if you don't mind? In PATCH 2/4 you use
`struct tempfile *tab_file` and `int tab_fd`. I would like to see
consistency and use similar names. Personally I don't like table being
shortened to "tab", and I think you feel the same as you've renamed the
parameter from this function.


-- 
Toon
