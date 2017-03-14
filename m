Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E64201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 19:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbdCNTS5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 15:18:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61811 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751113AbdCNTS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 15:18:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DBDC6AF0F;
        Tue, 14 Mar 2017 15:18:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SaqHhsC+tRJvDtfkQJBt0uv/YnU=; b=uvDFL+
        ur94knMrrTKcGijVWjFNbrU1Xk1ngwXoMizPIuK/99HuRYgOB4Pb1hPYgW6hLhr8
        qjIee4OvuCOUm3b28H0ifZWFTWP1sYeolpmGYhxehPVVKmcACF92/YTAUMbo87l/
        TH/WP/XVwU2PuVq3LnDuYkAaO8GgyqTPFdhTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nxEqLeB687Rm10CtzoAuSXB2+PTz1SHO
        XxtpYYnx6PDOEVd69cKdmdzXP4LoslPeYvpkQ2YtduPMMFN9Zngm/SrNO9Y7UMmY
        eOz/FK4P1YEZRHrueudwEWll2JhkO+MDnClF51H7wKI8LkPHlb/fSgV8EhkXpJFg
        8LABrXCg3iQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 775276AF0D;
        Tue, 14 Mar 2017 15:18:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D26416AF0A;
        Tue, 14 Mar 2017 15:18:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 06/10] submodule update: add `--init-active` switch
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-7-bmwill@google.com>
Date:   Tue, 14 Mar 2017 12:18:52 -0700
In-Reply-To: <20170313214341.172676-7-bmwill@google.com> (Brandon Williams's
        message of "Mon, 13 Mar 2017 14:43:37 -0700")
Message-ID: <xmqqvarbis4j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 101D164E-08EB-11E7-87A1-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +--init-active::
> +	This option is only valid for the update command.
> +	Initialize all submodules configured in "`submodule.active`"
> +	that have not been updated before.

You mean s/not been updated/not been initialized/ here?

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f38e332c5..a3acc9e4c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -270,6 +270,34 @@ static int module_list_compute(int argc, const char **argv,
>  	return result;
>  }
>  
> +static void module_list_active(struct module_list *list)
> +{
> +	int i;
> +
> +	if (read_cache() < 0)
> +		die(_("index file corrupt"));
> +
> +	gitmodules_config();

To this codepath, it probably would not make any difference, but in
general, calling gitmodules_config() after you did git_config()
would be a bug, right?  Otherwise, gitmodules_config() would
overwrite submodule.* configuration you read with git_config().

I have a feeling that we need to make this function hard to misuse;
it is not a fault of _this_ patch, but still any and all additions
to any of the submodule*.c files needs careful vetting.
