Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734AEC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6F420936
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgIPUYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:24:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36581 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbgIPR1s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 13:27:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id d9so4391703pfd.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 10:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W59sF4sUtxV3kd0FFfQWrxp5cZk+BTXxgaf3e48FgIM=;
        b=Xd8+KqoxyBOcEqxnNM8m/Ka/5VLGirtW2QZLyPWKizHMYQMAEIbyQSQ8LQE+3Q5zrT
         xaWL5VvWiER5p1cguNTFumGl9K0PKm4UNViu79L9vNHfuZLpZKySg4M670Pzx+NV6jrU
         h0Kbm1o6FzBfRPScRxTfNU8ecNKpV7UDQStMTk1BaOMYvAXlKf7YxyG8U47WuwL0jQIl
         NZtxVvD7cuBv6kOs2HcBVYRAqLI7vSVdbTQuxk8Oix00HcDrlZ8o15l8pANR2S0D7yWg
         M5UIQvlpPpENlilSwY4KzJZ2SH/H8Ji/f63ofQve8SeS6IGJQC1JeB400slTJsfk4P+b
         boYA==
X-Gm-Message-State: AOAM530qsBVgrAuhS9J5pMdhl8JFHupWm1Ea0wzwfNx/zjb+KY2IMIZl
        VHHX5bSgbtZL1wfd1dCZaT9g9b1dY8jt/A==
X-Google-Smtp-Source: ABdhPJwzlqGaBLTl0sAh8AxY2g/G8gu9IRxnlBfdM1kwiNUNx5foMQlYqfM/DmuzP2QM5jDAGYqt1w==
X-Received: by 2002:a63:5561:: with SMTP id f33mr18779705pgm.13.1600272773622;
        Wed, 16 Sep 2020 09:12:53 -0700 (PDT)
Received: from localhost.localdomain (50-125-94-129.hllk.wa.frontiernet.net. [50.125.94.129])
        by smtp.gmail.com with ESMTPSA id 84sm17452459pfw.14.2020.09.16.09.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 09:12:53 -0700 (PDT)
From:   Sean Barag <sean@barag.org>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        johannes.schindelin@gmx.de, sean@barag.org
Subject: Re: [PATCH 2/4] clone: call git_config before parse_options
Date:   Wed, 16 Sep 2020 09:12:27 -0700
Message-Id: <20200916161227.1873247-1-sean@barag.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqq5z8knjou.fsf@gitster.c.googlers.com>
References: <xmqq5z8knjou.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano <gitster@pobox.com>
> > From: Sean Barag <sean@barag.org>
> >
> > While Junio's request [1] was to avoids the unusual  "write config
> > then immediately read it" pattern that exists in `cmd_clone`,
> > Johannes mentioned that --template can write new config values that
> > aren't automatically included in the environment [2]. This requires
> > a config re-read after `init_db` is called.
> >
> > Moving the initial config up does allow settings from config to be
> > overwritten by ones provided via CLI options in a more natural way
> > though, so that part of Junio's suggestion remains.
>
> The title says what the code does after this change.  The code calls
> git_config() before calling parse_options(), but not much in the
> proposed log message explains what the patch tries to achieve by doing
> so.
>
> The above refers to suggestions but does not describe what problem the
> patch is trying to address and what approach is taken to address it.

Thanks for the pointer - I completely agree.  Rewriting for v2.

> > +static int git_clone_config(const char *k, const char *v, void *cb)
> > +{
> > +	return git_default_config(k, v, cb);
> > +}
> > +
> >  static int write_one_config(const char *key, const char *value, void *data)
> >  {
> > +	/*
> > +	 * give git_config_default a chance to write config values back to the environment, since
> > +	 * git_config_set_multivar_gently only deals with config-file writes
> > +	 */
>
> Overlong lines...

How embarrassing!  Re-wrapped for v2.

> > +	int apply_failed = git_default_config(key, value, data);
>
> Not git_clone_config()?  Presumably you'll make git_clone_config()
> recognise more variables than git_default_config() does, and the
> caller of this helper wants us to recognise "clone.*" that are
> ignored by git_default_config() callback, no?

Great catch!  This gets changed to `git_clone_config` in patch 4/4
anyway, so there's no need for the confusing intermediate state in 2/4.
Will be fixed in v2.

--
Thanks for being so patient with a newbie :)
Sean
