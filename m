Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A72B20899
	for <e@80x24.org>; Sun, 20 Aug 2017 21:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbdHTVpY (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 17:45:24 -0400
Received: from avasout06.plus.net ([212.159.14.18]:52677 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbdHTVpX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 17:45:23 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id zZlM1v00118PUFB01ZlN2K; Sun, 20 Aug 2017 22:45:22 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=NfZXjSg7wBXkDsQh-pgA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/2] rerere: allow approxidate in
 gc.rerereResolved/gc.rerereUnresolved
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Uwe Hausbrand <uwe.hausbrand@gmx.de>
References: <xmqqfudpj1vo.fsf@gitster.mtv.corp.google.com>
 <20170819203013.3053-1-gitster@pobox.com>
 <20170819203013.3053-3-gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d1ce349c-a6ca-796d-7ac1-8c720e48e02f@ramsayjones.plus.com>
Date:   Sun, 20 Aug 2017 22:45:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170819203013.3053-3-gitster@pobox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/08/17 21:30, Junio C Hamano wrote:
> These two configuration variables are described in the documentation
> to take an expiry period expressed in the number of days:
> 
>     gc.rerereResolved::
> 	    Records of conflicted merge you resolved earlier are
> 	    kept for this many days when 'git rerere gc' is run.
> 	    The default is 60 days.
> 
>     gc.rerereUnresolved::
> 	    Records of conflicted merge you have not resolved are
> 	    kept for this many days when 'git rerere gc' is run.
> 	    The default is 15 days.
> 
> There is no strong reason not to allow a more general "approxidate"
> expiry specification, e.g. "5.days.ago", or "never".
> 
> Tweak the config_get_expiry() helper introduced in the previous step
> to use date.c::parse_expiry_date() to do so.
> 
> In the future, we may find other variables that only allow an
> integer that specifies "this many days" (or other unit of time) and
> allow them to also do the same, and at that point we probably would
> want to move the helper to a place that is not specific to the
> rerere machinery.  Perhaps config.c would be such a good neutral
> place, as it will allow git_parse_signed() to go back to static to
> the file.

You make git_parse_unsigned() external in this patch, in addition
to git_parse_signed(), but don't actually call it. Was that intended?

ATB,
Ramsay Jones

> 
> But this will do for now.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config.txt |  2 ++
>  config.c                 |  4 ++--
>  config.h                 |  3 +++
>  rerere.c                 | 14 ++++++++++++--
>  4 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d5c9c4cab6..ac95f5f954 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1553,11 +1553,13 @@ gc.<pattern>.reflogExpireUnreachable::
>  gc.rerereResolved::
>  	Records of conflicted merge you resolved earlier are
>  	kept for this many days when 'git rerere gc' is run.
> +	You can also use more human-readable "1.month.ago", etc.
>  	The default is 60 days.  See linkgit:git-rerere[1].
>  
>  gc.rerereUnresolved::
>  	Records of conflicted merge you have not resolved are
>  	kept for this many days when 'git rerere gc' is run.
> +	You can also use more human-readable "1.month.ago", etc.
>  	The default is 15 days.  See linkgit:git-rerere[1].
>  
>  gitcvs.commitMsgAnnotation::
> diff --git a/config.c b/config.c
> index 231f9a750b..ac9071c5cf 100644
> --- a/config.c
> +++ b/config.c
> @@ -769,7 +769,7 @@ static int parse_unit_factor(const char *end, uintmax_t *val)
>  	return 0;
>  }
>  
> -static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
> +int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
>  {
>  	if (value && *value) {
>  		char *end;
> @@ -799,7 +799,7 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
>  	return 0;
>  }
>  
> -static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
> +int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
>  {
>  	if (value && *value) {
>  		char *end;
> diff --git a/config.h b/config.h
> index 0352da117b..039a9295de 100644
> --- a/config.h
> +++ b/config.h
> @@ -215,4 +215,7 @@ struct key_value_info {
>  extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
>  extern NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
>  
> +int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
> +int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
> +
>  #endif /* CONFIG_H */
> diff --git a/rerere.c b/rerere.c
> index f0b4bce881..8bbdfe8569 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -1178,11 +1178,21 @@ static void prune_one(struct rerere_id *id,
>  
>  static void config_get_expiry(const char *key, timestamp_t *cutoff, timestamp_t now)
>  {
> -	int days;
> +	char *expiry_string;
> +	intmax_t days;
> +	timestamp_t when;
>  
> -	if (!git_config_get_int(key, &days)) {
> +	if (git_config_get_string(key, &expiry_string))
> +		return;
> +
> +	if (git_parse_signed(expiry_string, &days, maximum_signed_value_of_type(int))) {
>  		const int scale = 86400;
>  		*cutoff = now - days * scale;
> +		return;
> +	}
> +
> +	if (!parse_expiry_date(expiry_string, &when)) {
> +		*cutoff = when;
>  	}
>  }
>  
> 
