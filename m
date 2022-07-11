Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B7DCCA47B
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 19:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiGKTT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 15:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGKTT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 15:19:58 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C60BEE1A
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 12:19:57 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A81A53F4161;
        Mon, 11 Jul 2022 15:19:56 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1008:b064:efb1:d9c7:dcfd:b3c3:5b0])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D007C3F4149;
        Mon, 11 Jul 2022 15:19:55 -0400 (EDT)
Subject: Re: [PATCH v6 7/7] tr2: dump names if config exist in multiple scopes
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
References: <cover.1657540174.git.dyroneteng@gmail.com>
 <c45ead51ffc5a9176493d627da8332d35a31d87c.1657540174.git.dyroneteng@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9934c512-7e82-b024-5292-71a0ebcf2351@jeffhostetler.com>
Date:   Mon, 11 Jul 2022 15:19:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c45ead51ffc5a9176493d627da8332d35a31d87c.1657540174.git.dyroneteng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/11/22 8:44 AM, Teng Long wrote:
> When we specify GIT_TRACE2_CONFIG_PARAMS or trace2.configparams,
> trace2 will prints "interesting" config values to log. Sometimes,
> when a config set in multiple scope files, the following output
> looks like (the irrelevant fields are omitted here as "..."):
> 
> ...| def_param    |  ...  | core.multipackindex:false
> ...| def_param    |  ...  | core.multipackindex:false
> ...| def_param    |  ...  | core.multipackindex:false
> 
> As the log shows, even each config in different scope is dumped, but
> we don't know which scope it comes from. Therefore, it's better to
> add the scope names as well to make them be more recognizable. For
> example, when execute:
> 
>      $ GIT_TRACE2_PERF=1 \
>      > GIT_TRACE2_CONFIG_PARAMS=core.multipackIndex \
>      > git rev-list --test-bitmap HEAD"
> 
> The following is the ouput (the irrelevant fields are omitted here
> as "..."):
> 
> Format normal:
> ... git.c:461 ... def_param scope:system core.multipackindex=false
> ... git.c:461 ... def_param scope:global core.multipackindex=false
> ... git.c:461 ... def_param scope:local core.multipackindex=false
> 
> Format perf:
> 
> ... | def_param    | ... | scope:system | core.multipackindex:false
> ... | def_param    | ... | scope:global | core.multipackindex:false
> ... | def_param    | ... | scope:local  | core.multipackindex:false
> 
> Format event:
> 
> {"event":"def_param", ... ,"scope":"system","param":"core.multipackindex","value":"false"}
> {"event":"def_param", ... ,"scope":"global","param":"core.multipackindex","value":"false"}
> {"event":"def_param", ... ,"scope":"local","param":"core.multipackindex","value":"false"}
> 
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>   trace2/tr2_tgt_event.c  | 3 +++
>   trace2/tr2_tgt_normal.c | 5 ++++-
>   trace2/tr2_tgt_perf.c   | 9 +++++++--
>   3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
> index c5c8cfbbaa..37a3163be1 100644
> --- a/trace2/tr2_tgt_event.c
> +++ b/trace2/tr2_tgt_event.c
> @@ -479,9 +479,12 @@ static void fn_param_fl(const char *file, int line, const char *param,
>   {
>   	const char *event_name = "def_param";
>   	struct json_writer jw = JSON_WRITER_INIT;
> +	enum config_scope scope = current_config_scope();
> +	const char *scope_name = config_scope_name(scope);
>   
>   	jw_object_begin(&jw, 0);
>   	event_fmt_prepare(event_name, file, line, NULL, &jw);
> +	jw_object_string(&jw, "scope", scope_name);
>   	jw_object_string(&jw, "param", param);
>   	jw_object_string(&jw, "value", value);
>   	jw_end(&jw);
> diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
> index c42fbade7f..69f8033077 100644
> --- a/trace2/tr2_tgt_normal.c
> +++ b/trace2/tr2_tgt_normal.c
> @@ -298,8 +298,11 @@ static void fn_param_fl(const char *file, int line, const char *param,
>   			const char *value)
>   {
>   	struct strbuf buf_payload = STRBUF_INIT;
> +	enum config_scope scope = current_config_scope();
> +	const char *scope_name = config_scope_name(scope);
>   
> -	strbuf_addf(&buf_payload, "def_param %s=%s", param, value);
> +	strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param,
> +		    value);
>   	normal_io_write_fl(file, line, &buf_payload);
>   	strbuf_release(&buf_payload);
>   }
> diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
> index a1eff8bea3..8cb792488c 100644
> --- a/trace2/tr2_tgt_perf.c
> +++ b/trace2/tr2_tgt_perf.c
> @@ -441,12 +441,17 @@ static void fn_param_fl(const char *file, int line, const char *param,
>   {
>   	const char *event_name = "def_param";
>   	struct strbuf buf_payload = STRBUF_INIT;
> +	struct strbuf scope_payload = STRBUF_INIT;
> +	enum config_scope scope = current_config_scope();
> +	const char *scope_name = config_scope_name(scope);
>   
>   	strbuf_addf(&buf_payload, "%s:%s", param, value);
> +	strbuf_addf(&scope_payload, "%s:%s", "scope", scope_name);
>   
> -	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
> -			 &buf_payload);
> +	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL,
> +			 scope_payload.buf, &buf_payload);
>   	strbuf_release(&buf_payload);
> +	strbuf_release(&scope_payload);
>   }
>   
>   static void fn_repo_fl(const char *file, int line,
> 

Nicely done.

Thanks for your attention on this.
Jeff

