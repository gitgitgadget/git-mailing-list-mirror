Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B910C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7747F61004
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbhHEUUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 16:20:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63834 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbhHEUUl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 16:20:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B09FE7C22;
        Thu,  5 Aug 2021 16:20:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OcEydUmC+TMOHjsRiDFaRGj5T5TP2Yr+tgkk3a
        p7z+M=; b=H0iOFxmv4W6Sx+KBVDMLx2jVlCHcHPg3JuZ9igtdOeF3nSGMAORHBg
        lxlU/ViID+dCvfml9lZcJ9Jefsq9f2EC0eoygeVTTaF8fICYopTP3wPqNKawXh1W
        aN634aXODsYIlfV4KAQJ0TovM20Jnv8azDVVHaTa3Eew3mHYYNM1o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30CB2E7C21;
        Thu,  5 Aug 2021 16:20:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E396E7C20;
        Thu,  5 Aug 2021 16:20:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v2 3/9] submodule--helper: remove repeated code
 in sync_submodule()
References: <20210805071917.29500-1-raykar.ath@gmail.com>
        <20210805074054.29916-1-raykar.ath@gmail.com>
        <20210805074054.29916-4-raykar.ath@gmail.com>
Date:   Thu, 05 Aug 2021 13:20:24 -0700
In-Reply-To: <20210805074054.29916-4-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 5 Aug 2021 13:10:48 +0530")
Message-ID: <xmqqr1f7k5iv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 919872F0-F62A-11EB-BFB3-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> This part of `sync_submodule()` is doing the same thing that
> `compute_submodule_clone_url()` is doing. Let's reuse that helper here.
>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> ---
>  builtin/submodule--helper.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)

The original used the result of get_default_remote() twice before
freeing it, but now all that code to allocate and free remote is
contained in compute_submodule_clone_url(), which mean swe allocate,
use, and free twice.  In exchange, our logic here works at a higher
level of abstraction, which is a big plus.

Nice.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f4b496bac6..9b676c12f8 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1373,20 +1373,10 @@ static void sync_submodule(const char *path, const char *prefix,
>  	if (sub && sub->url) {
>  		if (starts_with_dot_dot_slash(sub->url) ||
>  		    starts_with_dot_slash(sub->url)) {
> -			char *remote_url, *up_path;
> -			char *remote = get_default_remote();
> -			strbuf_addf(&sb, "remote.%s.url", remote);
> -
> -			if (git_config_get_string(sb.buf, &remote_url))
> -				remote_url = xgetcwd();
> -
> -			up_path = get_up_path(path);
> -			sub_origin_url = relative_url(remote_url, sub->url, up_path);
> -			super_config_url = relative_url(remote_url, sub->url, NULL);
> -
> -			free(remote);
> +			char *up_path = get_up_path(path);
> +			sub_origin_url = compute_submodule_clone_url(sub->url, up_path, 1);
> +			super_config_url = compute_submodule_clone_url(sub->url, NULL, 1);
>  			free(up_path);
> -			free(remote_url);
>  		} else {
>  			sub_origin_url = xstrdup(sub->url);
>  			super_config_url = xstrdup(sub->url);
