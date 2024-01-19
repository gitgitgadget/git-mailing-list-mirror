Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AD51E520
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705692495; cv=none; b=pwFdhScP3lLjZUdP9RKAbzyIDSSCxD6efJRBxnXIw9QE7rvncOh3PLVmdWJKFB0VKt7zTqfyB3ScWRxVK51eg7p/Dhn5fJRm0znS1iYufvXVgJESdy/nli2QQAS+jXLzwhvsgIFN5Ge9uaAd8YKjWxPyGAiLM+nYD6tskrjfvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705692495; c=relaxed/simple;
	bh=0fv7+teUIlLydfxtN169XvVCkXNTN7rMKW7YqHcnAk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H5CfuYGYo0M22NOt6bE6B/ccSAQtW5l1cZPzJ50UzvsMJueV2oDbOs1uc4TGoVb/piFYVWE1+baZ6eWAWr/YR7fL8ZoOa+qphQeFk7DVU1d/G83zWdYBC0vOmEtfviYIKf6+L+QC6cmR3LFuZmChJUDVYnbd//gpV2rRCk/Pcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OkrTr1aj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OkrTr1aj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB2B31D5627;
	Fri, 19 Jan 2024 14:28:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0fv7+teUIlLydfxtN169XvVCkXNTN7rMKW7YqH
	cnAk8=; b=OkrTr1ajd+VuLTCgtf6dt72xduB15xs+TimkP8/iLohXBDIsd/JrKy
	adgqD8178C9OlQoYbE1+l5swVpAeOXe/wILj5ECloYsbqECNO0w5M1zVf8mJmtBh
	xI1cfpTs9BCN/iDw7bHPrPd0wyHto0zPOcZvWnrSNISIyiQ1TSwJM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D14C31D5626;
	Fri, 19 Jan 2024 14:28:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4266C1D5625;
	Fri, 19 Jan 2024 14:28:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/7] refs: convert AUTO_MERGE to become a normal pseudo-ref
In-Reply-To: <ae2df6316f79e372c51d59666d685e59981d2f98.1705659748.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 19 Jan 2024 11:40:09 +0100")
References: <cover.1705659748.git.ps@pks.im>
	<ae2df6316f79e372c51d59666d685e59981d2f98.1705659748.git.ps@pks.im>
Date: Fri, 19 Jan 2024 11:28:10 -0800
Message-ID: <xmqqjzo5jf79.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E27E4E9E-B700-11EE-B3B8-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In 70c70de616 (refs: complete list of special refs, 2023-12-14) we have
> inrtoduced a new `is_special_ref()` function that classifies some refs

"introduced"

> @@ -4687,10 +4685,17 @@ void merge_switch_to_result(struct merge_options *opt,
>  		trace2_region_leave("merge", "record_conflicted", opt->repo);
>  
>  		trace2_region_enter("merge", "write_auto_merge", opt->repo);
> -		filename = git_path_auto_merge(opt->repo);
> -		fp = xfopen(filename, "w");
> -		fprintf(fp, "%s\n", oid_to_hex(&result->tree->object.oid));
> -		fclose(fp);
> +		if (refs_update_ref(get_main_ref_store(opt->repo), "", "AUTO_MERGE",
> +				    &result->tree->object.oid, NULL, REF_NO_DEREF,
> +				    UPDATE_REFS_MSG_ON_ERR)) {
> +			/* failure to function */
> +			opt->priv = NULL;
> +			result->clean = -1;
> +			merge_finalize(opt, result);
> +			trace2_region_leave("merge", "write_auto_merge",
> +					    opt->repo);
> +			return;
> +		}
>  		trace2_region_leave("merge", "write_auto_merge", opt->repo);
>  	}
>  	if (display_update_msgs)

We used to ignore errors while updating AUTO_MERGE, implying that it
is an optional nicety that does not have to block the merge.  Now we
explicitly mark the resulting index unclean.  While my gut feeling
says that it should not matter all that much (as such a failure
would be rare enough that the user may want to inspect and double
check the situation before going forward), I am not 100% sure if the
change is behaviour is acceptable by everybody (cc'ed Elijah for
second opinion).

Everything else in this patch looked good.

Thanks.
