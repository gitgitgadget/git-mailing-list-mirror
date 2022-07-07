Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B8EC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbiGGSS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 14:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiGGSS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 14:18:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F5E1109
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 11:18:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2043B1AEB73;
        Thu,  7 Jul 2022 14:18:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZcBQUrGW1Y3u6ggx6Mc6CdAtKRWE6aX8v3FdRE
        hb4/4=; b=TKJMRKZNmiJIHrOMKNk7B2P+QUHwEZSDMfHnmOB7xPGfpCoc4qZKBA
        4Ya5XxMmok/cEI9118p3qr63HsLzMFmTM4WQQ32HZGHIRrlhTftWJBAIh+ajyzgB
        GuQzwEfU2+Fg2jLQayha0kOqpyCiEv//rhHKJGwbJQZGgnAboiy8E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 088A81AEB72;
        Thu,  7 Jul 2022 14:18:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A2CC41AEB70;
        Thu,  7 Jul 2022 14:18:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jaydeep Das via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jaydeep Das <jaydeepjd.8914@gmail.com>
Subject: Re: [PATCH] gpg-interface: add function for converting trust level
 to string
References: <pull.1281.git.1657202265048.gitgitgadget@gmail.com>
Date:   Thu, 07 Jul 2022 11:18:20 -0700
In-Reply-To: <pull.1281.git.1657202265048.gitgitgadget@gmail.com> (Jaydeep Das
        via GitGitGadget's message of "Thu, 07 Jul 2022 13:57:44 +0000")
Message-ID: <xmqqwncozt03.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EF505DC-FE21-11EC-A232-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jaydeep Das via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 947b58ad4da..fe6e5ce5127 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -165,6 +165,7 @@ static struct {
>  	{ 0, "TRUST_", GPG_STATUS_TRUST_LEVEL },
>  };
>  
> +/* Keep the order same as enum signature_trust_level */
>  static struct {
>  	const char *key;
>  	enum signature_trust_level value;
> @@ -905,6 +906,12 @@ const char *get_signing_key(void)
>  	return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
>  }
>  
> +const char *gpg_trust_level_to_str(enum signature_trust_level level){
> +	if (level < TRUST_UNDEFINED || level > TRUST_ULTIMATE)
> +		return NULL;
> +	return sigcheck_gpg_trust_level[level].key;
> +}
> +
>  int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
>  {
>  	return use_format->sign_buffer(buffer, signature, signing_key);
> diff --git a/gpg-interface.h b/gpg-interface.h
> index b30cbdcd3da..48f7edd916b 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -71,6 +71,14 @@ size_t parse_signed_buffer(const char *buf, size_t size);
>  int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
>  		const char *signing_key);
>  
> +
> +/*
> + * Returns corresponding string for a given member of
> + * enum signature_trust_level. For example, `TRUST_ULTIMATE` will
> + * return "ULTIMATE".
> + */
> +const char *gpg_trust_level_to_str(enum signature_trust_level level);
> +			sig_str = gpg_trust_level_to_str(c->signature_check.trust_level);
> +			if (sig_str){

Missing SP before open-brace.

> +				const char *sig_str_lower = xstrdup_tolower(sig_str);
> +				strbuf_addstr(sb, sig_str_lower);
> +				free((char *)sig_str_lower);

Unnecessary const plus casting-away of it.  You are getting a copy
to work with, so there is no reason to declare sig_str_lower to be
"const".  This downcasing should be done in gpg_trust_level_to_str()
function, shouldn't it?  After all, the "str" version of the trust
level existing end-users are familiar with are the strings you
removed from pretty.c that are all lowercase.

Thanks.
