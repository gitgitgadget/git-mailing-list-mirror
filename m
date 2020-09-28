Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E16C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 16:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A672080A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 16:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgI1QCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 12:02:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43522 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1QCi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 12:02:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id f18so1412410pfa.10
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 09:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+Dkk7VEEAel80ZYHubEj2E6hLeNa/gGaWJ5Bz2A3ao=;
        b=XmmvIrqmvvXPjZsnqeTiiT420T7XGECNyYOJJ0sbI5OSEUnhEbwLMfCPEhv1QOBfqm
         +c028Z1C3cNvAKJQ++EvcIBd5MZ+hosqBncTrNqavN8+JK8wDOsy4za0Xwi0uUoEAILR
         SdELobGD2Of6Quum4t5Ljq2akIADgnGIEWTBathvaQiOrGIggCsfD8bW+HqBquqsmO3I
         hTy7WF/aQXu3E8nlc8+AN8pj0ErE0G0uhDr1peLwUJNwQFDcD3+2Tj8m5+OcYKD/f6zL
         4K01eO3hLU1QA7cXy8HcBJPKx/f3PUn1vWwTj0JuiAeSZZ5Bok5aB3hwYuH5fDwCN9Gh
         ANfw==
X-Gm-Message-State: AOAM530Zt5YISgzcKdVDnDlaQtpfQwmzpgQEzl8XJ3e4MUNnwU3eHRda
        tdu0F8LJkhGiFZGekP3A4E90piF2MLHVtg==
X-Google-Smtp-Source: ABdhPJz/KJTNjCoInDkWOAfhJ4MtnPczlLasv4bVSXexDyOJct9v30UTaFIUuKNS90BOIPYkq81Yxg==
X-Received: by 2002:a17:902:501:b029:d2:628a:d59f with SMTP id 1-20020a1709020501b02900d2628ad59fmr185824plf.43.1601308957152;
        Mon, 28 Sep 2020 09:02:37 -0700 (PDT)
Received: from localhost.localdomain (50-125-94-129.hllk.wa.frontiernet.net. [50.125.94.129])
        by smtp.gmail.com with ESMTPSA id s2sm1679650pjg.52.2020.09.28.09.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:02:36 -0700 (PDT)
From:   Sean Barag <sean@barag.org>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        johannes.schindelin@gmx.de, sean@barag.org
Subject: Re: [PATCH 4/4] clone: allow configurable default for `-o`/`--origin`
Date:   Mon, 28 Sep 2020 09:02:17 -0700
Message-Id: <20200928160217.3412067-1-sean@barag.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqqwo10m3kv.fsf@gitster.c.googlers.com>
References: <xmqqwo10m3kv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> clone.defaultremotename is a single valued configuration variable,
> and this correctly implements the "last one wins" behaviour (but
> previous remote_name will leak every time clone.defaultremotename
> is seen in the config stream).

Great catch - fixed for v2.

> I thought the whole point of doing the write_config() was so that
> anything came from the command line option can be written back to the
> configuration file, so I am not sure what the harm would be to update
> remote_name from the configuration whether option_origin is used or
> not here.  Perhaps add "clone.defaultremotename" to the set of
> configuration setting write_config() uses, when --option is given from
> the command line, and remove this special case?

That's true!  The special case was there mostly to keep --origin as the
highest priority, but that can be solved much more naturally by moving
the assignment from option_origin to remote_name down below the second
git_config call.  Included in v2.

Sean
