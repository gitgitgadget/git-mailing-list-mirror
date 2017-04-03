Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12251FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 22:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbdDCWYG (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 18:24:06 -0400
Received: from avasout08.plus.net ([212.159.14.20]:50244 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdDCWYG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 18:24:06 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id 3yQ31v0041keHif01yQ4yW; Mon, 03 Apr 2017 23:24:04 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=B5zJ6KlM c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=KFpA8Q4GAAAA:8 a=UcOsCTv2HdVbHC7pYMcA:9 a=QEXdDO2ut3YA:10
 a=n8sMt3pHIuYvP_eQiBdH:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4] http.postbuffer: allow full range of ssize_t values
To:     David Turner <dturner@twosigma.com>, git@vger.kernel.org
References: <20170403173015.15327-1-dturner@twosigma.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <233d3799-2d24-1d7e-c97f-bc41abb1411a@ramsayjones.plus.com>
Date:   Mon, 3 Apr 2017 23:24:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170403173015.15327-1-dturner@twosigma.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/04/17 18:30, David Turner wrote:
> Unfortunately, in order to push some large repos, the http postbuffer
> must sometimes exceed two gigabytes.  On a 64-bit system, this is OK:
> we just malloc a larger buffer.
> 
> This means that we need to use CURLOPT_POSTFIELDSIZE_LARGE to set the
> buffer size.
> 
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  cache.h       |  1 +
>  config.c      | 17 +++++++++++++++++
>  http.c        |  4 ++--
>  http.h        |  2 +-
>  remote-curl.c |  6 +++---
>  5 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index fbdf7a815a..5e6747dbb4 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1900,6 +1900,7 @@ extern int git_parse_maybe_bool(const char *);
>  extern int git_config_int(const char *, const char *);
>  extern int64_t git_config_int64(const char *, const char *);
>  extern unsigned long git_config_ulong(const char *, const char *);
> +extern ssize_t git_config_ssize_t(const char *, const char *);
>  extern int git_config_bool_or_int(const char *, const char *, int *);
>  extern int git_config_bool(const char *, const char *);
>  extern int git_config_maybe_bool(const char *, const char *);
> diff --git a/config.c b/config.c
> index 1a4d85537b..de5b155a4e 100644
> --- a/config.c
> +++ b/config.c
> @@ -834,6 +834,15 @@ int git_parse_ulong(const char *value, unsigned long *ret)
>  	return 1;
>  }
>  
> +static int git_parse_ssize_t(const char *value, ssize_t *ret)
> +{
> +	ssize_t tmp;
> +	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
> +		return 0;
> +	*ret = tmp;
> +	return 1;
> +}
> +

The previous version of this patch causes gcc to complain on
a Linux 32bit build, like so:

    CC config.o
config.c: In function ‘git_parse_ssize_t’:
config.c:840:31: warning: passing argument 2 of ‘git_parse_signed’ from incompatible pointer type [-Wincompatible-pointer-types]
  if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
                               ^
config.c:753:12: note: expected ‘intmax_t * {aka long long int *}’ but argument is of type ‘ssize_t * {aka int *}’
 static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
            ^

... and I don't think this version would be any different (though I
haven't tried).

ATB,
Ramsay Jones

