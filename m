Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE06A208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 23:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbdHOXXx (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 19:23:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57867 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752694AbdHOXXx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 19:23:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84D0AB0185;
        Tue, 15 Aug 2017 19:23:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XfnVOrYzhULoSL840okmrKT61pw=; b=fMr4cw
        24yzKWXbNOcPaQMbXhAmBcpWcO8RYu7w+NClr93w00TAFsoJQJibz/w2xxaBvpGX
        4a3Jc7ZO0vo16/2Io8EBkEV/XQ3+OPuyt7AX4H3RVUSrRp8u0XOu7RCOtr7oJoua
        2yspW+atUc6/oybPYzVCQpwhhbt6ExRwVfScA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DcpCA+MpnHEnAv+Kl/fnU1425usZ61zj
        gsLWyQByOHfF08ZsTz93NIANmphxMgh9cWKg2jtBeAFzWbTEIuzuNxUP8o0DnQXD
        B5HYt+UCef3P77+z4eczSyRSuFpmokDN0xWRD1VzIxpCewmscMKGBfZynQTkTQiL
        ZmhuI7E6hZI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CF07B0184;
        Tue, 15 Aug 2017 19:23:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA492B0183;
        Tue, 15 Aug 2017 19:23:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH] push: do not add submodule odb as an alternate when recursing on demand
References: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
        <20170815224332.22730-1-sbeller@google.com>
Date:   Tue, 15 Aug 2017 16:23:50 -0700
In-Reply-To: <20170815224332.22730-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 15 Aug 2017 15:43:32 -0700")
Message-ID: <xmqqh8x8pg8p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC70D67A-8210-11E7-8AA7-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> "git push --recurse-submodules=on-demand" adds each submodule as an
> alternate with add_submodule_odb before checking whether the
> submodule has anything to push and pushing it if so.
>
> However, it never accesses any objects from the submodule.
> ...
> Use is_submodule_populated_gently instead, which is simpler and
> cheaper.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  Originally I intended to send this out as part of a larger series,
>  but the series is getting too large series, sending all things in smaller
>  units!

This vaguely reminds me that you sent something imilar perhaps for a
different codepath.

Is "is it populated" a good thing to check here, though?  IIRC,
add-submodule-odb allows you to add the object database of an
inactivated submodule, so this seems to change the behaviour.  I do
not know if the behaviour change is a good thing (i.e. bugfix) or
not (i.e. regression) offhand, though.

Thanks.

> diff --git a/submodule.c b/submodule.c
> index 111a3007fc..e20216bc0f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -966,7 +966,9 @@ static int push_submodule(const char *path,
>  			  const struct string_list *push_options,
>  			  int dry_run)
>  {
> -	if (add_submodule_odb(path))
> +	int code;
> +
> +	if (!is_submodule_populated_gently(path, &code))
>  		return 1;
>  
>  	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
