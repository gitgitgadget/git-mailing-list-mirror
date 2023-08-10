Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6CAC001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjHJUgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjHJUgV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:36:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0544B2733
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:36:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B67431E463;
        Thu, 10 Aug 2023 16:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VfywBIlXpybxyWhh1jEMRmF2dhLikNFARV11ZC
        qmY0Y=; b=RRGCT+2QFdTDgdVHcoz/A0MF6s2047TfIhXc41/ZHOqubcGQ+10vlS
        doma/L76uvUAj2CVtm5x2AcvxMwxzC76TEUTKRA7Zz1r5H2dW1O+uAzTjXizf+62
        ovr04dk1s+PIgarunL2Gu6kwIE2J97jsB354YZidKWYPN/2c/4OUg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B05641E462;
        Thu, 10 Aug 2023 16:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD5D81E460;
        Thu, 10 Aug 2023 16:36:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com, chooglen@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Subject: Re: [RFC PATCH v2 3/7] config: correct bad boolean env value error
 message
References: <20230810163346.274132-1-calvinwan@google.com>
        <20230810163654.275023-3-calvinwan@google.com>
Date:   Thu, 10 Aug 2023 13:36:15 -0700
In-Reply-To: <20230810163654.275023-3-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 10 Aug 2023 16:36:50 +0000")
Message-ID: <xmqqttt6r5xc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E16A40E-37BD-11EE-98DA-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> An incorrectly defined boolean environment value would result in the
> following error message:
>
> bad boolean config value '%s' for '%s'
>
> This is a misnomer since environment value != config value. Instead of
> calling git_config_bool() to parse the environment value, mimic the
> functionality inside of git_config_bool() but with the correct error
> message.

Makes sense.

>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  config.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/config.c b/config.c
> index 09851a6909..5b71ef1624 100644
> --- a/config.c
> +++ b/config.c
> @@ -2172,7 +2172,14 @@ void git_global_config(char **user_out, char **xdg_out)
>  int git_env_bool(const char *k, int def)
>  {
>  	const char *v = getenv(k);
> -	return v ? git_config_bool(k, v) : def;
> +	int val;
> +	if (!v)
> +		return def;
> +	val = git_parse_maybe_bool(v);
> +	if (val < 0)
> +		die(_("bad boolean environment value '%s' for '%s'"),
> +		    v, k);
> +	return val;
>  }
>  
>  /*
