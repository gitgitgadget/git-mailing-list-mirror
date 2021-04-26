Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBACC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011DB613A9
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbhDZUVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:21:24 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:43674 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbhDZUVX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 16:21:23 -0400
Received: by mail-ed1-f46.google.com with SMTP id e7so67183413edu.10
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 13:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lIRRGZO1lpn6ysc+rzTTB99VXFvQ9LEyCs+i2UJsrY=;
        b=bRZCfEpXEfaWcCelEBk5ziFFXobEkM0lPL2rFbjBVnJ4xlecd+LD9T5c8khAVSnP2/
         W9KwziKEbMNB44U01SI1jhfwMFWcHDmwih4xuRnzG/knkZcku0NVvJOVmkMj/OTnWJes
         mBfs51auAJc2OQn43S6rlIaPCC+lXDVH1/VBKZ8+pULp9WKImivZKSRhxDBVSegPRjdd
         fVkkCY+0y58G7yj08C2EOvaKHLfs49aB9s1kjHyBOC7b7vQ0I4XD989S2r1VMlMEiLh1
         M+cz/dWVHOvVhhcDQKW4P1OgWS8e0FOYxS1DOeNpikJhf1vkdHCi0LE9GtcJiTSSBLDd
         S3Pg==
X-Gm-Message-State: AOAM532O6+1Kk5nEAF5pbwX+MGcF0OCyPFtaGLsNICNQaOSjJw3XRznT
        iqACCT427VtX5YLcKvm6jflxj94Liscmf+RufCjIkg8qGPTC3w==
X-Google-Smtp-Source: ABdhPJyoEwA/PtJcXcpRSaUFhpTXS+wKE+pFCeon91TF0n93/k2AaQA+j5mTP0uTNvhNgiD7gaP7R20ptAAqt/JGFOA=
X-Received: by 2002:a05:6402:145:: with SMTP id s5mr457328edu.221.1619468440267;
 Mon, 26 Apr 2021 13:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <3dac63eae201e6d0b949680e682238625cad59bd.1617291666.git.gitgitgadget@gmail.com>
 <5b63eb3f-0b87-209b-3943-ced8412abb93@gmail.com>
In-Reply-To: <5b63eb3f-0b87-209b-3943-ced8412abb93@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 26 Apr 2021 16:20:29 -0400
Message-ID: <CAPig+cTjso8B=E0pGsr4TDU5zikVhjwbrrWD19uaiwJXvuXZ0w@mail.gmail.com>
Subject: Re: [PATCH 02/23] fsmonitor-ipc: create client routines for git-fsmonitor--daemon
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 26, 2021 at 10:31 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> > +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> > +#define FSMONITOR_DAEMON_IS_SUPPORTED 1
> > +#else
> > +#define FSMONITOR_DAEMON_IS_SUPPORTED 0
> > +#endif
> > +
> > +int fsmonitor_ipc__is_supported(void)
> > +{
> > +     return FSMONITOR_DAEMON_IS_SUPPORTED;
> > +}
>
> I don't see any other use of FSMONITOR_DAEMON_IS_SUPPORTED,
> so I was thinking you could use the #ifdef/#else/#endif
> construct within the implementation of this method instead
> of creating a macro outside. But my suggestion might be an
> anti-pattern, so feel free to ignore me.

On this project, it is preferred to keep the #if / #else / #endif
outside of functions since embedding them within functions often makes
it difficult to follow how the code flows (and generally makes
functions unnecessarily noisy). So, the way Jeff did this seems fine.

An alternative would have been:

  #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
  #define fsmonitor_ipc__is_supported() 1
  #else
  #define fsmonitor_ipc__is_supported() 0
  #endif

which would still allow calling it as a function:

    if (fsmonitor_ipc__is_supported())
        ...

but it's subjective whether that's actually any cleaner or better.
