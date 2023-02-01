Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD90DC636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 23:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBAXzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAXzp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 18:55:45 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB42137F25
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 15:55:44 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-514bf89d3cfso4199327b3.21
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 15:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/tAQdW/hNl+Oz1pK/91liWcpYVldcZSjCTIMZD41/Q=;
        b=lTnMfx8IWsE8y3ku0uXPel5p4XNeiQtW1RmaElAdy+eirg/Dfs10GGiy9Ct3KKZNRK
         Pe7KUgz/gpU4tn3Jmn4P/SokvbD1a7kVoChEpqu72a/r+kaJsJLu1/02VaH1kENi1pjM
         fQHUmc4W3mu3mP2l6yCmwYi9Qfs8la68uuOO9c64AEMOvMLsScAmuiMfmCsawjW62hV2
         XxGZGduYgJ9HMDO4riLKQ2uIG6hAC83FvKYYyEaFQJVkdx06/R/oMy8iAKu3IPseWGs8
         GXr6GptInf8V4YNb7GwPwsSa4tI6gpUPWPF4vsVAjEQsCwh9gSdf3ZgVbJQmxJF5w1Br
         GF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/tAQdW/hNl+Oz1pK/91liWcpYVldcZSjCTIMZD41/Q=;
        b=oBwAwcLUYD7/LkBX9h6Z8B7BxK90COW30mgP2exJawRiAyowD9ZCiIKjrTzOnj0V7b
         AdK7/58D0v5MJcKPDZ6wadMlcgbjDVsFzBLvBtF2o4/7pme4WSCPOslPVacrlkhsfJsI
         t4OTbEjnMQdvG7TxAe8BA/L1peqyHBbXIqo+2tj4XY5SEG1AasMvnNoDZ1IO6HjMXeEH
         53BfLscS3mZazuOeYJdnjxKXNaqMmpT+nJJ5nK6IIDcW4jUiP0TFnIH41dDQ8pNyWzqw
         QejN4WHjxqx9HtfI6uSWq7c8FgCjUM7CowaOEoYAQQ9eRdmkuWXqFqbw4HdnqIGmClMM
         jfiw==
X-Gm-Message-State: AO0yUKXOXp3NsEMcvoPHRPwMS4HMfDegni0T8eWZXmHxPdZ0fL3riQjE
        j7sdP3843QcnlaGvFrcaAOkcoQ74DtjLmRc=
X-Google-Smtp-Source: AK7set9u+1CIH0LMcHzhNOcCEH25Cc3t+oqaaRQCaGMco2xkBpKV4A+CjgLEwGl4nWiU4WiTRnFU7aWePLYwvcM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:fcf:0:b0:50f:329:6e1c with SMTP id
 198-20020a810fcf000000b0050f03296e1cmr644051ywp.499.1675295744255; Wed, 01
 Feb 2023 15:55:44 -0800 (PST)
Date:   Wed,  1 Feb 2023 23:52:51 +0000
In-Reply-To: <20230119223858.29262-4-zev@bewilderbeest.net>
Mime-Version: 1.0
References: <20230201235253.1891546-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230201235253.1891546-3-calvinwan@google.com>
Subject: Re: [PATCH 3/5] log: Push to/cc handling down into show_log()
From:   Calvin Wan <calvinwan@google.com>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Denton Liu <liu.denton@gmail.com>,
        Emma Brooks <me@pluvano.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Hemmer <git@stormcloud9.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  void log_write_email_headers(struct rev_info *opt, struct commit *commit,
>  			     const char **extra_headers_p,
>  			     int *need_8bit_cte_p,
> @@ -647,10 +655,12 @@ static void next_commentary_block(struct rev_info *opt, struct strbuf *sb)
>  void show_log(struct rev_info *opt)
>  {
>  	struct strbuf msgbuf = STRBUF_INIT;
> +	struct strbuf hdrbuf = STRBUF_INIT;
>  	struct log_info *log = opt->loginfo;
>  	struct commit *commit = log->commit, *parent = log->parent;
>  	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : the_hash_algo->hexsz;
>  	const char *extra_headers = opt->extra_headers;
> +	char *to_free;
>  	struct pretty_print_context ctx = {0};
>  
>  	opt->loginfo = NULL;
> @@ -770,6 +780,11 @@ void show_log(struct rev_info *opt)
>  		ctx.notes_message = strbuf_detach(&notebuf, NULL);
>  	}
>  
> +	format_recipients(opt, &hdrbuf);
> +
> +	if (extra_headers)
> +		strbuf_addstr(&hdrbuf, extra_headers);
> +
>  	/*
>  	 * And then the pretty-printed message itself
>  	 */
> @@ -779,7 +794,7 @@ void show_log(struct rev_info *opt)
>  	ctx.date_mode = opt->date_mode;
>  	ctx.date_mode_explicit = opt->date_mode_explicit;
>  	ctx.abbrev = opt->diffopt.abbrev;
> -	ctx.after_subject = extra_headers;
> +	ctx.after_subject = to_free = strbuf_detach(&hdrbuf, NULL);

Can you explain in the commit message why hdrbuf, which contains the
output from format_recipients and extra_headers, is still the same
functionality as before?

> -void recipients_to_header_buf(const char *hdr, struct strbuf *buf,
> -			      const struct string_list *recipients);
> +void format_recipients(struct rev_info *rev, struct strbuf *sb);

What do you think about renaming this function to strbuf_add_recipients
and swapping the parameters? 
