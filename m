Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCC9C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE55760525
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbhHEUGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 16:06:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57985 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhHEUGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 16:06:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5486613AE44;
        Thu,  5 Aug 2021 16:05:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=loHrPhlXrZcY2+L/+++Kqj0343kuugx003riQ+
        aN0t4=; b=DvvcJolfPyLN/RNEBJJbGA+ui8hw+FsuOzP0nz4bOP+by7Gm+pUsMJ
        6ad6HRAWAFG1wO67Pqzv0LHptEOBu59Y7ZKFuDivx9D6+XLJx6thRSQGnz90HuL0
        9Fo3OILFegUmuroDpjaL/6B4srEQBbX8R80MXUMzP582PLkOd0ClM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C98313AE43;
        Thu,  5 Aug 2021 16:05:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8EB4413AE42;
        Thu,  5 Aug 2021 16:05:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v2 1/9] submodule--helper: add options for
 compute_submodule_clone_url()
References: <20210805071917.29500-1-raykar.ath@gmail.com>
        <20210805074054.29916-1-raykar.ath@gmail.com>
        <20210805074054.29916-2-raykar.ath@gmail.com>
Date:   Thu, 05 Aug 2021 13:05:49 -0700
In-Reply-To: <20210805074054.29916-2-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 5 Aug 2021 13:10:46 +0530")
Message-ID: <xmqqzgtvk676.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 889CB7BC-F628-11EB-AD6A-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> -static char *compute_submodule_clone_url(const char *rel_url)
> +static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
>  {
>  	char *remoteurl, *relurl;
>  	char *remote = get_default_remote();
> @@ -598,10 +598,14 @@ static char *compute_submodule_clone_url(const char *rel_url)
>  
>  	strbuf_addf(&remotesb, "remote.%s.url", remote);
>  	if (git_config_get_string(remotesb.buf, &remoteurl)) {
> -		warning(_("could not look up configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
> +		if (!quiet)
> +			warning(_("could not look up configuration '%s'. "
> +				  "Assuming this repository is its own "
> +				  "authoritative upstream."),
> +				remotesb.buf);
>  		remoteurl = xgetcwd();
>  	}
> -	relurl = relative_url(remoteurl, rel_url, NULL);
> +	relurl = relative_url(remoteurl, rel_url, up_path);

OK, so we can optionally operate silently, and also tell
relative_url the path the URL should be made relative to.

Existing callers, of course, should pass NULL and 0 as these
optional features are new, as we can see below.

>  	free(remote);
>  	free(remoteurl);
> @@ -660,7 +664,7 @@ static void init_submodule(const char *path, const char *prefix,
>  		if (starts_with_dot_dot_slash(url) ||
>  		    starts_with_dot_slash(url)) {
>  			char *oldurl = url;
> -			url = compute_submodule_clone_url(oldurl);
> +			url = compute_submodule_clone_url(oldurl, NULL, 0);
>  			free(oldurl);
>  		}
>  
> @@ -2134,7 +2138,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
>  		if (starts_with_dot_slash(sub->url) ||
>  		    starts_with_dot_dot_slash(sub->url)) {
> -			url = compute_submodule_clone_url(sub->url);
> +			url = compute_submodule_clone_url(sub->url, NULL, 0);
>  			need_free_url = 1;
>  		} else
>  			url = sub->url;

All makes sense.
