Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC444201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 19:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbdCNTnY (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 15:43:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61666 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751823AbdCNTnX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 15:43:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6A2D6B49C;
        Tue, 14 Mar 2017 15:43:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nDiuwAXb/jcmoAxzVKhfDnFFNwA=; b=JK6Fnd
        bR3ncOMEnPcB2Ujs2PtJCM8x8FMrvwORGQcU3M+TI9PGZQHBxia2ILaNiyZ/vx+Z
        KOZ8u3SE7n57KrbJDI+D1fk1Mxu1PeCkLfWWmtNECB9xs/oVN8gL8bZibtN851Yc
        /qu2gJXGR7+y/mQoTgMRfEK/stynE0MbNEiuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q8Emg4E7j5b3LQRF5ti9TMkSLkVUo86l
        wjxYA6AMksHaipmKbAL6abxkUSs32jQmApvbEYYuyx6POJkHwUI6j1U+0YH4T+2r
        kMvaRPNnk1KXa4xh3eRr3k+4V1HsHR1azKQnFAztNwC0ZCyeqLuX93iFHEpngbJZ
        4esKQaGdqsw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFBDB6B49A;
        Tue, 14 Mar 2017 15:43:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B65A6B499;
        Tue, 14 Mar 2017 15:43:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 09/10] submodule--helper init: set submodule.<name>.active
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-10-bmwill@google.com>
Date:   Tue, 14 Mar 2017 12:43:19 -0700
In-Reply-To: <20170313214341.172676-10-bmwill@google.com> (Brandon Williams's
        message of "Mon, 13 Mar 2017 14:43:40 -0700")
Message-ID: <xmqqinnbiqzs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AB313C0-08EE-11E7-91F3-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> When initializing a submodule set the submodule.<name>.active config to
> true to indicate that the submodule is active.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

Hmph.  When you do

	git clone --submodule-spec=lib/

and resulting repository says "submodule.active = lib/", you are
saying that you are interested in anything in "lib/", now or in the
future--that is the point of 08/10.

It is unclear what your desire would be for a submodule that was
bound to somewhere in "lib/" in the superproject when you cloned
when it later gets moved outside "lib/".  With changes up to 08/10,
that submodule will no longer be interesting, but with this 09/10,
when recursing clone will activate it upon the initial clone, the
submodule is explicitly marked as active by its name, so no matter
where it gets moved later, it will remain to be interesting.

I am not sure if that is a desired behaviour.

>  builtin/submodule--helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a3acc9e4c..b669ed031 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -361,6 +361,13 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  		die(_("No url found for submodule path '%s' in .gitmodules"),
>  			displaypath);
>  
> +	/* Set active flag for the submodule being initialized */
> +	if (!is_submodule_initialized(path)) {
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "submodule.%s.active", sub->name);
> +		git_config_set_gently(sb.buf, "true");
> +	}
> +
>  	/*
>  	 * Copy url setting when it is not set yet.
>  	 * To look up the url in .git/config, we must not fall back to
