Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDAAC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 16:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434442100A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 16:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgI1QFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 12:05:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39184 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgI1QFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 12:05:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id n14so1437991pff.6
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 09:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2JK3mTekyemEvTwAzQFmMWQnhdWT/JVdNoBltIE+Co=;
        b=HDYdI4QCHtuZVoYR4fH9wYW0cCInv1kKz5m/eMspQvJBjxztQLzaDch0JRL/Tr6Ho0
         TtAJWb+frbRLCmhqlqpcGnJTipcTghWlTequmGSrR6KpmmB0zyQ7+UkDH3Y9vcFuQ3Xk
         sdrgFRINzwLHaQX7eTUTSHIdoWPk2Eu7eRJKYyC2Yd3sbLaflw3gnW8aFOIKiZkwtYeO
         WmX/C8l1hYYq3S0YgBy5ZbProaPQln7LDeqY1CGw1ohls02pPAQRbJh7xFToNfOP82nx
         v8O9lQrMYqQ0WWhyqBfYTnitmNYB3MgkE0y97btTsgI1Jg+kN6LWygD7UfBdCuEnWQBW
         V/Kw==
X-Gm-Message-State: AOAM533e/DacidE5Jt0qJ3Xuv3y1gtEDPdLFV2SEj5ycPFDzE71Hk96l
        FavG0lEDU+f/EF69xv5xNiY=
X-Google-Smtp-Source: ABdhPJxXrCHiSZhPwEFTXZsFzkY7uDUBoHkUL/FvDoT/GQrginUoebQJU/obcP52RJw/Xl1sSZUJ+g==
X-Received: by 2002:aa7:939b:0:b029:142:2501:35f1 with SMTP id t27-20020aa7939b0000b0290142250135f1mr75984pfe.81.1601309118137;
        Mon, 28 Sep 2020 09:05:18 -0700 (PDT)
Received: from localhost.localdomain (50-125-94-129.hllk.wa.frontiernet.net. [50.125.94.129])
        by smtp.gmail.com with ESMTPSA id l13sm1954786pgq.33.2020.09.28.09.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:05:17 -0700 (PDT)
From:   Sean Barag <sean@barag.org>
To:     stolee@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de, sean@barag.org
Subject: Re: [PATCH 4/4] clone: allow configurable default for `-o`/`--origin`
Date:   Mon, 28 Sep 2020 09:04:57 -0700
Message-Id: <20200928160457.3412744-1-sean@barag.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0739858e-83f1-3b3f-aba0-7549e7e47cfc@gmail.com>
References: <0739858e-83f1-3b3f-aba0-7549e7e47cfc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> >  static char *option_origin = NULL;
> > +static char *remote_name = "origin";
> 
> This patch could have used a prep patch that had all consumers
> of option_origin use remote_name instead, with this adjustment
> to the way to use option_origin:
>   
> > -	if (!option_origin)
> > -		option_origin = "origin";
> > +	if (option_origin)
> > +		remote_name = option_origin;
> > +	else
> > +		remote_name = "origin";
>   
> Then this patch introducing the config option would have a
> very limited change in the builtin consisting of these two
> hunks:
> 
> >  static int git_clone_config(const char *k, const char *v, void *cb)
> >  {
> > +	if (!strcmp(k, "clone.defaultremotename") && !option_origin)
> > +		remote_name = xstrdup(v);
> >  	return git_default_config(k, v, cb);
> >  }
> ...
> >  	if (option_origin)
> >  		remote_name = option_origin;
> > -	else
> > -		remote_name = "origin"

That's a great idea!  Implemented for v2 :)

Sean
