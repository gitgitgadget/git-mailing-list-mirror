Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B44219ED
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104943; cv=none; b=X3snGmK9NNS6CMeNF1clJYyumY4+44ZSbF0sAVL5CRwMZUay3+5bSPEwLbnfZ1vito6v+c8cK02SZVJuZE0QWhaZWRLtX/dn84d8oDXxLZPlqncQaZAP5Z4Z5SnnFY6qc+8q4skvH0aTLTREQZNcykUb7+8tstXEv1M+IYtj2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104943; c=relaxed/simple;
	bh=ubhjA2cYZWVNOsN95aV6KW2IgGZGtGGN0YTwYzNyOo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iH8oxxDpwLJTS/7Afm8ngMim1nhCLoIOP113tEuvvVKjSLQZArzYYgVwhrxnshTdWnTGDknBDKqvSyJnri0t5JT8nFMoPtKgi918IGl9Re2Ok+RoBJW94IQay+J60VLMdL5aV2tYdfDtK//+G29cLK63iVPhYaXcO4kpi7SX/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ndLDRimE; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ndLDRimE"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E3BC21E6A87;
	Fri, 16 Feb 2024 12:35:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ubhjA2cYZWVNOsN95aV6KW2IgGZGtGGN0YTwYz
	NyOo8=; b=ndLDRimEqniq3exd2rn4Wk77I5HpsR+7HzMOIR0Q/ieTPahGVlhyv9
	NDPj3I3ADcyA8aUuqNgao0ezFboToLVfM5id6O4sGSsUCHCu3AoGD0u4OoMb7cBI
	SnIh9MJh5GkMUQWbUfN3UHpL5+XyI2WYSna2EKPRAfGhATVviXzew=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DAF031E6A86;
	Fri, 16 Feb 2024 12:35:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A2931E6A85;
	Fri, 16 Feb 2024 12:35:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] completion: use awk for filtering the config entries
In-Reply-To: <20240216171046.927552-1-dev+git@drbeat.li> (Beat Bolli's message
	of "Fri, 16 Feb 2024 18:10:46 +0100")
References: <20240216171046.927552-1-dev+git@drbeat.li>
Date: Fri, 16 Feb 2024 09:35:31 -0800
Message-ID: <xmqqr0hcjorg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C966950E-CCF1-11EE-B5FF-25B3960A682E-77302942!pb-smtp2.pobox.com

Beat Bolli <dev+git@drbeat.li> writes:

> Commits 1e0ee4087e (completion: add and use
> __git_compute_first_level_config_vars_for_section, 2024-02-10) and
> 6e32f718ff (completion: add and use
> __git_compute_second_level_config_vars_for_section, 2024-02-10)
> introduced new helpers for config completion.
>
> Both helpers use a pipeline of grep and awk to filter the list of config
> entries. awk is perfectly capable of filtering, so let's eliminate the
> grep process and move the filtering into the awk script.

Makes sense.  I wonder if we can have some simple script sanity
checker that catches things like this, e.g., catting a single file
into pipe, grep appearing upstream of awk or sed, etc.

> The "-E" grep option (extended syntax) was not necessary, as $section is
> a single word.
>
> While at it, wrap the over-long lines to make them more readable.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>
> Junio, this goes on top of 'pb/complete-config' which is on next
> currently.

Alternatively we could redo the topic, squashing this fix in, after
the release when we rewind 'next'.

Thanks.

>
>  contrib/completion/git-completion.bash | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 444b3efa63..fcf1afd75d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2673,7 +2673,8 @@ __git_compute_first_level_config_vars_for_section ()
>  	__git_compute_config_vars
>  	local this_section="__git_first_level_config_vars_for_section_${section}"
>  	test -n "${!this_section}" ||
> -	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print $2}')"
> +	printf -v "__git_first_level_config_vars_for_section_${section}" %s \
> +		"$(echo "$__git_config_vars" | awk -F. "/^${section}\.[a-z]/ { print \$2 }")"
>  }
>  
>  __git_compute_second_level_config_vars_for_section ()
> @@ -2682,7 +2683,8 @@ __git_compute_second_level_config_vars_for_section ()
>  	__git_compute_config_vars_all
>  	local this_section="__git_second_level_config_vars_for_section_${section}"
>  	test -n "${!this_section}" ||
> -	printf -v "__git_second_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars_all" | grep -E "^${section}\.<" | awk -F. '{print $3}')"
> +	printf -v "__git_second_level_config_vars_for_section_${section}" %s \
> +		"$(echo "$__git_config_vars_all" | awk -F. "/^${section}\.</ { print \$3 }")"
>  }
>  
>  __git_config_sections=
