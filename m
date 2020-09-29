Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78623C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 23:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1F921548
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 23:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgI2XsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 19:48:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36546 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgI2XsS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 19:48:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id x16so5310425pgj.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 16:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GR7BG9mZrSGcz6zpAv39AsrsU8bMRWfITRxK7zZEoYg=;
        b=o6fYDaiRLxE8nH1/s20vK9wb682NlExJF4HIm5nscwRYW1URCPA4SDc4nvQMQlz5Gs
         v0140SF3EhhzQvaYmSoxwfrWdfgqJb4Adz5iMk/xuBgJYqLcvAirLdnjahDIKtYuURDE
         rCdV7eW68TQNNAAcchUa1PoU87NSARLNX3Oz0dhkQ6r1uoyTJz7F+lf1SfR3b7rnH/v/
         Ad7NU17tmnuPGcfzK8ZHhkaG6mB7XCiWHwIwjTIoW84h85FYoh4wwE3Rs8HjyCqXqPg8
         Gh3vyeyG3YnhqOZZDAYZSPZEikZWww9uOiihQDSpc2ChFn/zGnq5Bv/bqyyDsNCJBGZI
         i3PQ==
X-Gm-Message-State: AOAM530jYgyWBty2O4lIbnD1wR2Adlvsg5/DZJnmnqXedtoWxiF082qn
        uOxvoaHnJRTorMsl8XE9pdA=
X-Google-Smtp-Source: ABdhPJwDmCa5wYlZyesxIq/TjE+XUjk1lj9lM6jFctlZIPph9Wyud1M6L2z4HhtE5vFtV+N7DKCyEg==
X-Received: by 2002:a17:902:b186:b029:d1:cc21:9a7d with SMTP id s6-20020a170902b186b02900d1cc219a7dmr124041plr.8.1601423298155;
        Tue, 29 Sep 2020 16:48:18 -0700 (PDT)
Received: from localhost.localdomain (50-125-94-129.hllk.wa.frontiernet.net. [50.125.94.129])
        by smtp.gmail.com with ESMTPSA id h5sm21581pja.55.2020.09.29.16.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 16:48:17 -0700 (PDT)
From:   Sean Barag <sean@barag.org>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        johannes.schindelin@gmx.de, me@ttaylorr.com, peff@peff.net,
        rybak.a.v@gmail.com, sean@barag.org, stolee@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH] clone: add remote.cloneDefault config option
Date:   Tue, 29 Sep 2020 16:47:50 -0700
Message-Id: <20200929234750.879484-1-sean@barag.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <xmqqa6x8icbp.fsf@gitster.c.googlers.com>
References: <xmqqa6x8icbp.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Junio C Hamano" <gitster@pobox.com> writes:

> >  static int git_clone_config(const char *k, const char *v, void *cb)
> >  {
> > +	if (!strcmp(k, "clone.defaultremotename")) {
> > +		if (remote_name != default_remote_name)
> > +			free(remote_name);
> > +		remote_name = xstrdup(v);
> 
> This feels strange.  The usual arrangement is
> 
>     - initialize the variable to NULL (or any value that the code
>       can tell that nobody touched it);
> 
>     - let git_config() callback to update the variable, taking care
>       of freeing and strduping as needed.  Note that free(NULL) is
>       kosher.
> 
>     - let parse_options() to further update the variable, taking
>       care of freeing and strduping as needed.
> 
>     - finally, if the variable is still NULL, give it its default
>       value.
> 
> so there is no room for the "if the variable has the value of the
> fallback default, do things differently" logic to be in the
> git_config() callback function.

I agree, it felt pretty awkward while writing it!  I was hoping to match
the start-up sequence you'd mentioned in my original attempt [1] but I'm
happy to move the default value assignment down.

> > @@ -1153,10 +1154,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  
> >  	/*
> >  	 * re-read config after init_db and write_config to pick up any config
> > -	 * injected by --template and --config, respectively
> > +	 * injected by --template and --config, respectively.
> >  	 */
> 
> Squash this "oops, I forgot to finish the sentence" to the step the
> mistake was introduced, i.e. "use more conventional..."

How embarrassing, I thought I'd gotten all of those.  Will do.

Sean

--
[1] Original attempt at this feature, in separate thread because of the
    divergence: https://lore.kernel.org/git/xmqqlfi1utwi.fsf@gitster.c.googlers.com/
