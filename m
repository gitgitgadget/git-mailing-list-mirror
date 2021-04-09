Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC75C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF97B61165
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhDIWTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:19:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59195 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhDIWTG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:19:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2747137C22;
        Fri,  9 Apr 2021 18:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cFCvnrrYQnBo8eA8ydS0Hg5g7NI=; b=BfWKA/
        CBeoBqQM2NbxQx/wXvD+wY5+TV3OVzfpWzU4KwSa8WtPG2ItOhEpntWAMTrXm0Ra
        xHIWR5Ow5/7jZO9G6vUeaLGmMGE3ZUnIn282MPSrtaKh1CYPPRKILfvX6G0/kxRb
        vufwOagApI29nVhW7PlVLxv5K0ER5pL6kI4lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lmEeC4aUxnpMyXAQl1Wm4IQ79ZoPhDxx
        +Fhv34IA6m1PhSKtKIicg2q09gk9kUAUKmSLljYTe/NydwuAjJR4hMDcji/Sz2wM
        q6zY+v9KaTS83VpdpkSq2jPLzhDw3swXDulzehsN763+chPhwQ8yAebcAeUbtjt0
        wl9QE6Ezhew=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B276137C21;
        Fri,  9 Apr 2021 18:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DAD48137C1E;
        Fri,  9 Apr 2021 18:18:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] config: allow overriding of global and system
 configuration
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
        <cover.1617975637.git.ps@pks.im>
        <272a3b31aa73da8d65b04e647b1b9ca860f4e783.1617975637.git.ps@pks.im>
Date:   Fri, 09 Apr 2021 15:18:48 -0700
In-Reply-To: <272a3b31aa73da8d65b04e647b1b9ca860f4e783.1617975637.git.ps@pks.im>
        (Patrick Steinhardt's message of "Fri, 9 Apr 2021 15:43:30 +0200")
Message-ID: <xmqqo8enm793.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F4FA118-9981-11EB-B6C5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/config.c b/config.c
> index 6af0244085..9dfc4a79f7 100644
> --- a/config.c
> +++ b/config.c
> @@ -1847,8 +1847,22 @@ static int git_config_from_blob_ref(config_fn_t fn,
>  const char *git_system_config(void)
>  {
>  	static const char *system_wide;
> -	if (!system_wide)
> -		system_wide = system_path(ETC_GITCONFIG);
> +
> +	if (!system_wide) {
> +		system_wide = xstrdup_or_null(getenv("GIT_CONFIG_SYSTEM"));
> +		if (system_wide) {
> +			/*
> +			 * If GIT_CONFIG_SYSTEM is set, it overrides the
> +			 * /etc/gitconfig. Furthermore, the file must exist in
> +			 * order to prevent any typos by the user.
> +			 */
> +			if (access(system_wide, R_OK))
> +				die(_("cannot access '%s'"), system_wide);
> +		} else {
> +			system_wide = system_path(ETC_GITCONFIG);
> +		}
> +	}
> +
>  	return system_wide;
>  }

I wrote the design to truly special case "/dev/null" at the pathname
string level, and we do not even try to open/read from a file when
"/dev/null" is given, so that we can even allow "/dev/null" to be
missing in a funny embedded or containerized environment, but that
does not seem to be what is going on here.

I do not think "access()" here is a good idea; the result we get
here may not match what happens when we actually try to open the
path.  Just remembering if we got the system_wide value from the
GIT_CONFIG_SYSTEM, and change what happens when the open fails when
we try to use the system-wide configuration depending on that, would
be the right approach.
