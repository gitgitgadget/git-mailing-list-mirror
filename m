Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2C7C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 21:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiHLVRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiHLVRD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 17:17:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C36E6E885
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 14:17:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1D011B8DDA;
        Fri, 12 Aug 2022 17:17:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cBE7CIIA/vDb4Y0u+uyMaluHO/1PetnD7rIiA8
        pzDoo=; b=aDSJZWRgECOD+1uiDGLUmWZhOVL3BxWg36x+i7zPvhsun4Q1maQ0i9
        0bfbv/pQ3XB36LZT4OJaTCGpUHKN7V2DIGTpR6UaqfK5J5OFdlhnWBg2JalLe8rW
        1nxGxmG6YL24/AcfSzrMtW4NKj/pU4CxEEFQuP5l/a1ovcjr1NJZs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAB871B8DD9;
        Fri, 12 Aug 2022 17:17:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85F3D1B8DD7;
        Fri, 12 Aug 2022 17:16:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 2/2] tr2: shows scope unconditionally in addition to
 key-value pair
References: <cover.1660272404.git.dyroneteng@gmail.com>
        <9856058df68d61557b11dc2fc7179acae24f5d8e.1660272404.git.dyroneteng@gmail.com>
Date:   Fri, 12 Aug 2022 14:16:57 -0700
In-Reply-To: <9856058df68d61557b11dc2fc7179acae24f5d8e.1660272404.git.dyroneteng@gmail.com>
        (Teng Long's message of "Fri, 12 Aug 2022 10:56:46 +0800")
Message-ID: <xmqqo7wp9n7a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 199682D6-1A84-11ED-B8E9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
> index c5c8cfbbaa..37a3163be1 100644
> --- a/trace2/tr2_tgt_event.c
> +++ b/trace2/tr2_tgt_event.c
> @@ -479,9 +479,12 @@ static void fn_param_fl(const char *file, int line, const char *param,
>  {
>  	const char *event_name = "def_param";
>  	struct json_writer jw = JSON_WRITER_INIT;
> +	enum config_scope scope = current_config_scope();
> +	const char *scope_name = config_scope_name(scope);
>  
>  	jw_object_begin(&jw, 0);
>  	event_fmt_prepare(event_name, file, line, NULL, &jw);
> +	jw_object_string(&jw, "scope", scope_name);
>  	jw_object_string(&jw, "param", param);
>  	jw_object_string(&jw, "value", value);
>  	jw_end(&jw);

OK, that is quite straight-forward.

> diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
> index c42fbade7f..69f8033077 100644
> --- a/trace2/tr2_tgt_normal.c
> +++ b/trace2/tr2_tgt_normal.c
> @@ -298,8 +298,11 @@ static void fn_param_fl(const char *file, int line, const char *param,
>  			const char *value)
>  {
>  	struct strbuf buf_payload = STRBUF_INIT;
> +	enum config_scope scope = current_config_scope();
> +	const char *scope_name = config_scope_name(scope);
>  
> -	strbuf_addf(&buf_payload, "def_param %s=%s", param, value);
> +	strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param,
> +		    value);
>  	normal_io_write_fl(file, line, &buf_payload);
>  	strbuf_release(&buf_payload);
>  }

So is this one.  Quite nice.

Is everybody happy with the choice of ":" colon here, though?  The
one in tgt_perf below uses the same delimiter that is used between
<param, value> to delimit <"scope", scome_name>.  I am wondering if
this one should use "=", the delimiter used between <param, value>
in this output stream, to match.  I do not care at all either way,
but I am mentioning it because I happened have noticed it, and
because somebody else may care.

Thanks, will queue.


> diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
> index a1eff8bea3..8cb792488c 100644
> --- a/trace2/tr2_tgt_perf.c
> +++ b/trace2/tr2_tgt_perf.c
> @@ -441,12 +441,17 @@ static void fn_param_fl(const char *file, int line, const char *param,
>  {
>  	const char *event_name = "def_param";
>  	struct strbuf buf_payload = STRBUF_INIT;
> +	struct strbuf scope_payload = STRBUF_INIT;
> +	enum config_scope scope = current_config_scope();
> +	const char *scope_name = config_scope_name(scope);
>  
>  	strbuf_addf(&buf_payload, "%s:%s", param, value);
> +	strbuf_addf(&scope_payload, "%s:%s", "scope", scope_name);
>  
> -	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
> -			 &buf_payload);
> +	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL,
> +			 scope_payload.buf, &buf_payload);
>  	strbuf_release(&buf_payload);
> +	strbuf_release(&scope_payload);
>  }
>  
>  static void fn_repo_fl(const char *file, int line,
