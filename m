Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB2D1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 10:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbeHCL56 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 07:57:58 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33043 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbeHCL56 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 07:57:58 -0400
Received: by mail-yw1-f66.google.com with SMTP id c135-v6so749831ywa.0
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 03:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmxruKyZFPWiKgQn90lyapTL0HuiHok7ekRS5dlkAS0=;
        b=Fu4qRTPGON7aUB8vXRGbVXqzUVXMF8DdAtJ0y5hpySuu/FmK3/rkniEFqFSNAD0uOT
         M5tgZJiCwbC55helcpMOOH+zUsfZ0ZS1PCn+b7t0qiznJgPT0QLZGPTwyPZQj0lCIfMT
         oAtFWNFVU5A1hHEwbUCvbnOxf/lsk4yYlAzVI6MYdLUjaqMJngRU9bOHN+JWYCBx7fBm
         dG0vfnOPt5Hf024pYZl5v9+JVV18fXJSa2iPoMF1AVqyIHdCS/aXLRaERZfz0RQgyzSU
         EhEyU9IAi0m2Zhr6ZkZ/BujL2EwJE5F4o2mZZ80fUDuLpfvpS1YZa8kdaqAdBEWn3zEb
         ZNKg==
X-Gm-Message-State: AOUpUlFRADYe5eTeCO/cVmNVCLmGxGXZ5Mzg4tT6G2V09IIdTMJUStq+
        y+jt97AaRl3FTHwa1Wggb8RvI0kYaATmYtjqtz4=
X-Google-Smtp-Source: AAOMgpchK7UstvIp/nQg+XPqP4/isSIKL6vRwSAb2p6U5xW2LzGUKUlZYQ5eDOFYvD9Y9BSgHZbpBF+S7EI4NZC4YtY=
X-Received: by 2002:a0d:f3c7:: with SMTP id c190-v6mr1621440ywf.98.1533290543199;
 Fri, 03 Aug 2018 03:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180802112002.720-1-phillip.wood@talktalk.net> <20180802112002.720-3-phillip.wood@talktalk.net>
 <xmqqk1p83cig.fsf@gitster-ct.c.googlers.com> <CAPig+cQaaHfkR8jrXb-+PB4bSZbKLQzRkZNo+DNfz92hKO=04Q@mail.gmail.com>
 <c7b8629d-7b93-2fbf-6793-0d566e86a229@talktalk.net>
In-Reply-To: <c7b8629d-7b93-2fbf-6793-0d566e86a229@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 3 Aug 2018 06:02:11 -0400
Message-ID: <CAPig+cTyTHxwFvk3ZtOq3L7KEtEjKLKu6-RnLC-_NuL1Xzhqzw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] sequencer: fix quoting in write_author_script
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 5:33 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> If there isn't some backward compatibility then if git gets upgraded
> while rebase is stopped then the author data will be silently corrupted
> if it contains "'". read_author_ident() will error out but that is only
> used for the root commit. read_env_script() which is used for normal
> picks will not dequote the badly quoted value correctly and will not
> return an error. It is unlikely but possible, I'll leave it to Junio to
> decide if it is worth it

If I understand correctly, the approach you implemented earlier[1]
(perhaps coupled with the more robust detection suggested here[2])
would be sufficient to handle this backward compatibility concern.
While it may not be as pretty or generalized as the current patch, it
involves far less machinery, thus is less likely to harbor its own
bugs. The earlier version is also much more self-contained, which
makes it easier to drop at some point when backward compatibility is
no longer a concern (if ever).

> There is a precedent for adding backwards compatibility 84df4560ed
> ("rebase: extract code for writing basic state", 2011-02-06) though it
> is much simpler.

Indeed, it is much simpler, adding a one-liner 'else' case to an
'if-then' for backward compatibility. Your earlier implementation[1]
was pretty much the equivalent, just adding an extra one-liner arm to
an 'if-then' statement.

The bug fix itself is important, and, while I do favor the cleaner
approach of not worrying about backward compatibility for this fairly
unlikely case, your earlier version seems a better compromise between
having no backward compatibility and the much more heavyweight version
implemented here.

Anyhow, I'm fine with whatever Junio decides.

[1]: https://public-inbox.org/git/20180731111532.9358-3-phillip.wood@talktalk.net/
[2]: https://public-inbox.org/git/CAPig+cTttbV2FjnoS_SZtwh2J4wwzsbK+48BAbt1cV0utynYzw@mail.gmail.com/
