Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63D1201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 17:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbdCNRrD (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 13:47:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57994 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751853AbdCNRrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 13:47:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A4EC6F056;
        Tue, 14 Mar 2017 13:47:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eU4EJy6CHOk/sqbYucifHSZAol4=; b=FDzy4U
        tQmAqkegIMSqRRg72xlD83uGOUG1QLOCNjU9yTxAeAXb5Pw02qMAML1lUDqQJm04
        giGQj52yqRu6tFUwfo2aGHyDjRFfr1HoB1+yI8kFIRrJRmh3D6MGdehVev4juOA6
        fykPt3+5Q/s2OQ0j7+A63zQtqljPSmlfsVLg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sl8w3C4QqKLxvNBkeUKM6IDbDLLKIm//
        dnuRSGJ2erUUp/LESnQOd9hb8KoRc2btYEDN/vUERUzoBUVsqXcuoB9dE7ZA7ZXl
        4efZ8IcnNt+5M2qDFuGP0CuB3ajLTmQixC4qbh1To00qkhMvCGqUXHXedTxjRyVT
        0oojI5u+JdA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 706EE6F055;
        Tue, 14 Mar 2017 13:47:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B55776F053;
        Tue, 14 Mar 2017 13:47:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 02/10] submodule status: use submodule--helper is-active
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-3-bmwill@google.com>
Date:   Tue, 14 Mar 2017 10:46:59 -0700
In-Reply-To: <20170313214341.172676-3-bmwill@google.com> (Brandon Williams's
        message of "Mon, 13 Mar 2017 14:43:33 -0700")
Message-ID: <xmqqd1djkay4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A0A0226-08DE-11E7-8F7B-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  git-submodule.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 136e26a2c..ab233712d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1010,14 +1010,13 @@ cmd_status()
>  	do
>  		die_if_unmatched "$mode" "$sha1"
>  		name=$(git submodule--helper name "$sm_path") || exit
> -		url=$(git config submodule."$name".url)
>  		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
>  		if test "$stage" = U
>  		then
>  			say "U$sha1 $displaypath"
>  			continue
>  		fi
> -		if test -z "$url" ||
> +		if ! git submodule--helper is-active "$sm_path" ||
>  		{
>  			! test -d "$sm_path"/.git &&
>  			! test -f "$sm_path"/.git

The $name is no longer used after this step in cmd_status function, 
as the sole purpose of learning the name from the path was so that
we can ask if the submodule has .URL defined and the query is done
by name, not path.

This actually raises a question.  

Shouldn't "submodule--helper is-active" ask about submodule while
identifying the submodule in question by name?  Or do all (or most
of) the callers start from path and ask is-active on them so that it
is handier to let them ask by path?
