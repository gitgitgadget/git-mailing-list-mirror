Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427FAC4321E
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 21:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiK1VBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 16:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiK1VB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 16:01:29 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA22205D7
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 13:01:28 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-360b9418f64so105059217b3.7
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 13:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JFac1YesxGTKSf58ZvcvDsfq5hT4MajdnI5MFqCi5tU=;
        b=avSxM+ubh8All6cawK05CGfU8t9hr+pXT64sNp/5IlST3YSf19sXiWcO3aZf3tMhvF
         3qdwTtGHO+0WUK7s+j2l72ru1WS/Mx27p/wbgOst0SBBde23SjJEsiulX74E2tG/u+1T
         G7WLeMxr+qRGZPryFRicONfr/wwxtFZMr7jydcHPfaNu6fUhYuaPZDBlPvoHkw2gx3eR
         3aDFqjZrR4oU8+P6e4DXeztfmHFPuPfq57IySwzYbJEu2+xyczO7TjBtx7/3kJf8pmuj
         rB0vEI0Dfp0mOy0f5/eRJXMqz1zQ7NQtWXOecQFvVhKoRgsMVM6FRpjA+suHE9H6D8Zk
         sbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFac1YesxGTKSf58ZvcvDsfq5hT4MajdnI5MFqCi5tU=;
        b=u3xZ7mSF0sicMUy9s1ixHcQHGQTtPXTNRsfemzHKluI+x45sEUtmilIZjubbDtGJeL
         mHqTNhbSE2T1dCeav/mcWAd5UBoebEVm8gbF9/CAcJrjaMoxzKYXvNY+xLG4F6BmDvyA
         ECbwZPl40NsjRVfuYdatko70wcaC2II34dAg3G9EfOqogdz4WMinpgZGpM2xfjN2yDWZ
         ru77N+3N3P3/ANDmQMdkZx0bOJw2UrGvQmQQaQ8HjT9eKx+IHCdfQ6Q9GsiVp6qfJSYg
         c9dOEruFi9VXNqCUIz/SBz3CClyQ4wTL33qpoNnXosJAMiHxRSEtF6i47oFpdDp3fAul
         V0lQ==
X-Gm-Message-State: ANoB5plI12/7D3Us/olTxdlam2G+ZCYMemBOFTnEgDL0gkfQnSAdePVC
        HeEqgUNEGtED3k6izufa1S5WsVCAU1tAGfilZcHp
X-Google-Smtp-Source: AA0mqf75J7TeA+2d+6o1viPTH0BDLeU4xyoN7iuROLl/WGb3PeIMIaqazUvfQhUCTD7pVj89CL7v+bcxvZSlaHzCIso9
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:1d47:0:b0:354:eb29:3851 with
 SMTP id d68-20020a811d47000000b00354eb293851mr33245067ywd.393.1669669287851;
 Mon, 28 Nov 2022 13:01:27 -0800 (PST)
Date:   Mon, 28 Nov 2022 13:01:25 -0800
In-Reply-To: <20221108184200.2813458-6-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221128210125.2751300-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 5/5] diff-lib: parallelize run_diff_files for submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
>  submodule.c                        | 154 +++++++++++++++++++++++++++++

I think the way to implement this is to have a parallel implementation,
and then have the serial implementation call the parallel implementation's
functions, or have a common set of functions that both the parallel
implementation and the serial implementation call. Here, it seems that
the parallel implementation exists completely separate from the serial
implementation, with no code shared. That makes it both more difficult to
review, and also makes it difficult to make changes to how we diff submodules
in the future (since we would have to make changes in two parts of the code).

I think that the layout of the code will be substantially different if we do
that, so I'll hold off on a more thorough review for now.
