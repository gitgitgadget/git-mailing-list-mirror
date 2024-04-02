Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B679DD4
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094584; cv=none; b=AYMQ39KJjsvo5+5NEVBwK05fgeDmXECPtvcMu7WTg75bo2z0BkkSvlNFiVrBmaqIjcdL7l/LfbV9nSu5r88h4gp6JmbOCiBlsrgr0mXPP30VllRHtMWFZeZKbP8FCvI7V4NIW1qn5DoWzS6q2DV3mLTsyUKNmbLd6oFc+MVSBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094584; c=relaxed/simple;
	bh=5EHBg0XO1rSR64ZcgdLFN/jo24dP83BR4ArKApDQ88w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZRxOhWEpFueJ4XsBPAWFNvSuoAvsBnvYQnyy/wpDNe05fuq9xaMfBGMB6S0MN4X8Y+9KARwKFlxxbyc1bzjCZ+bCeWHFGjyQ1Z7BSgDhF7TyXJTDRYKzA8pX0GN34TyCNnaLxWjla8+nU6UdBmkDiF2OO2Harf6LsT8QHXGb7/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uc/ZHDSE; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uc/ZHDSE"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A1101E436E;
	Tue,  2 Apr 2024 17:49:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5EHBg0XO1rSR64ZcgdLFN/jo24dP83BR4ArKAp
	DQ88w=; b=Uc/ZHDSEOf+2qimVUFu09k+BcLVAbyZA0Kx+k5Y7laO/2usOj1zLa0
	wUTYR9ugxZJfmNRZsJYol0TQ19ZLHqTjNprrtaFjOmfu7GBR1iyXqVJWUGyVI4yt
	J+xFq1BlMz6JDU9t2GckxDTLFEI83Wy5FxQQlmtFXk7SIjv8CuCYs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 406EE1E436D;
	Tue,  2 Apr 2024 17:49:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9834B1E436C;
	Tue,  2 Apr 2024 17:49:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] builtin/add: error out when passing untracked
 path with -u
In-Reply-To: <20240402213640.139682-7-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Wed, 3 Apr 2024 03:06:26 +0530")
References: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
	<20240402213640.139682-7-shyamthakkar001@gmail.com>
Date: Tue, 02 Apr 2024 14:49:40 -0700
Message-ID: <xmqqh6gj305n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E91C2F86-F13A-11EE-A3E9-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> When passing untracked path with -u option, it silently succeeds.
> There is no error message and the exit code is zero. This is
> inconsistent with other instances of git commands where the expected
> argument is a known path. In those other instances, we error out when
> the path is not known.
>
> Fix this by passing a character array to add_files_to_cache() to
> collect the pathspec matching information and report the error and
> exit if a pathspec does not match any cache entry. Also add a testcase
> to cover this scenario.
>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
>  builtin/add.c         | 11 ++++++++++-
>  t/t2200-add-update.sh | 10 ++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index dc4b42d0ad..88261b0f2b 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -370,6 +370,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	int add_new_files;
>  	int require_pathspec;
>  	char *seen = NULL;
> +	char *ps_matched = NULL;
>  	struct lock_file lock_file = LOCK_INIT;
>  
>  	git_config(add_config, NULL);
> @@ -549,13 +550,20 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  
>  	begin_odb_transaction();
>  
> +	ps_matched = xcalloc(pathspec.nr, 1);
>  	if (add_renormalize)
>  		exit_status |= renormalize_tracked_files(&pathspec, flags);
>  	else
>  		exit_status |= add_files_to_cache(the_repository, prefix,
> -						  &pathspec, NULL,
> +						  &pathspec, ps_matched,
>  						  include_sparse, flags);
>  
> +	if (take_worktree_changes && !add_renormalize &&
> +	    report_path_error(ps_matched, &pathspec)) {
> +		free(ps_matched);
> +		exit(1);
> +	}

Shouldn't we pay attention to ignore_add_errors?  The same comments
about free'ing and exit code from the review on the previous step
apply here, too.

Other than that, looking good.
