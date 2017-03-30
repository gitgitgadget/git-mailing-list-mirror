Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30D1320966
	for <e@80x24.org>; Thu, 30 Mar 2017 22:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933470AbdC3WHh (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 18:07:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51518 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750903AbdC3WHh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 18:07:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 048AB6FF7C;
        Thu, 30 Mar 2017 18:07:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J8HKfSiKWqFdkXQK7kvn77PdqI0=; b=w/aDb5
        6m1taOnzXFx/OaBvcLKaBZ9cxdwIpjW5hm8+zxnzW8MCTABlQIumjl6lnr8phUdr
        N4DKlke8pfvey2mabBtOoWRtbuhFGCHFyK9PvcSd8Wmpc9YVxd0jaxrc4Jin19kH
        I3hfhEhw/cjzepKtQMf1+XY3u1rBasxRcPW30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OAPrLK4obC/IXpM8SKC9MTpMZ31RsMxv
        4pUa8q22mHWl7epJQPn1E6JDVXCqyU09fo7hrA2Syj5BGcK4ohmKZFC+Wra56geX
        GFsThAz7YYOj690BDD1rbnfNFVs9MEKaU4YoHOkZbrWlfTuFBeBBrL4Bh5VF/6dQ
        XYpAIHtIFDE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF7506FF7A;
        Thu, 30 Mar 2017 18:07:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C9456FF79;
        Thu, 30 Mar 2017 18:07:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http.postbuffer: make a size_t
References: <20170330202917.24281-1-dturner@twosigma.com>
Date:   Thu, 30 Mar 2017 15:07:33 -0700
In-Reply-To: <20170330202917.24281-1-dturner@twosigma.com> (David Turner's
        message of "Thu, 30 Mar 2017 16:29:17 -0400")
Message-ID: <xmqqwpb61kre.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47053090-1595-11E7-8CFB-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> Unfortunately, in order to push some large repos, the http postbuffer
> must sometimes exceed two gigabytes.  On a 64-bit system, this is OK:
> we just malloc a larger buffer.
>
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  cache.h  |  1 +
>  config.c | 17 +++++++++++++++++
>  http.c   |  2 +-
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/cache.h b/cache.h
> index fbdf7a815a..a8c1b65db0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1900,6 +1900,7 @@ extern int git_parse_maybe_bool(const char *);
>  extern int git_config_int(const char *, const char *);
>  extern int64_t git_config_int64(const char *, const char *);
>  extern unsigned long git_config_ulong(const char *, const char *);
> +extern size_t git_config_size_t(const char *, const char *);
>  extern int git_config_bool_or_int(const char *, const char *, int *);
>  extern int git_config_bool(const char *, const char *);
>  extern int git_config_maybe_bool(const char *, const char *);
> diff --git a/config.c b/config.c
> index 1a4d85537b..7b706cf27a 100644
> --- a/config.c
> +++ b/config.c
> @@ -834,6 +834,15 @@ int git_parse_ulong(const char *value, unsigned long *ret)
>  	return 1;
>  }
>  
> +static size_t git_parse_size_t(const char *value, unsigned long *ret)
> +{
> +	size_t tmp;
> +	if (!git_parse_signed(value, &tmp, maximum_unsigned_value_of_type(size_t)))

I am getting these:

config.c:840:2: error: pointer targets in passing argument 2 of 'git_parse_signed' differ in signedness [-Werror=pointer-sign]
  if (!git_parse_signed(value, &tmp, maximum_unsigned_value_of_type(size_t)))
  ^

config.c:753:12: note: expected 'intmax_t *' but argument is of type 'size_t *'
 static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
            ^

Changing "size_t tmp" to "intmax_t tmp" squelches it but the maximum
unsigned value of size_t type would probably overflow "intmax_t max"
which is signed, so...
