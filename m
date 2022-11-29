Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A1FC433FE
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 22:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiK2WaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 17:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiK2W34 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 17:29:56 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562CB6F821
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 14:29:52 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y23-20020aa78057000000b00574277cb386so12385048pfm.16
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 14:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vROFBwLGu5DbSb1iWRc+yLlUNVOTcuRQIlpTsWGmzt0=;
        b=Gm+QvQ5cO5Gdq42uKse+9t0hsOLbNfB6lsz6zcfg0vhGIXZpvciHhXaJWoz1QoUJXo
         H9+ahcLCwd4OsE+S3+8AVivXijun4BNC+kKC0QYWZz4erauA/u81Go1Ja+rVNh9BtS6n
         1EwiH+qPdsml8LQ+d0nPGAbasX1Hy245dLSR13hM5VBJF8tbWhKuLcFM4bqKn8vNLx96
         Ok7HOchkFu1C/ypGJJXWvOMDq3yoZRwTnQ9PAXbCHbuZnKSaB94cKklzqnpJHnEDYn3+
         ZvRCgUxxFhmE19cdRzU9OVfgNwlNhPi0TyOQWbhca0ebylMdZTW5wJSxvT36du7aCr7a
         MPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vROFBwLGu5DbSb1iWRc+yLlUNVOTcuRQIlpTsWGmzt0=;
        b=7NAVXKcvkMxsPoKRUm7NDqr4Bpf4ZpKe9XaS43ZO4Ea0iYqEllAjLcfFLiggns959/
         ErI+lLmhYUxx+k15uexSdmDF0DX3AyeIHzxeZkE6QNcuTLrOlXqSHccDSSZbI6Yutxje
         NJl4Mqbge78bLt2eT6WX4GQ+snSqpL76FPmWeMaOP/JqOsoqF7yoKLjP33QUmElMgrG/
         Jj1RvibGjx83sQAYp61Jy4llHyvyqsUQIb+J8MwyS8E1lympjFaHtzzmK6xZ1wFRTV0i
         iW2Uu69NKJx7Lfj3/cFa1gVkVyX10gK4wlHa4htWGt7fjAVfVX4k7nHyI1u3tKK8dvPj
         DokQ==
X-Gm-Message-State: ANoB5pk4+CJXz239B6I6WCD+7BcTWgOUBOnK3A+7aVcFipf0+16z3Dpd
        Ay4r+WQ/rod2Z1j8jyfFcEN0lAHthXbQgA==
X-Google-Smtp-Source: AA0mqf61wfpBibgrRpUxHedPho92nZ6Hbr2hibd7P0VhVLfBRQGmhhm8GS+IeZ+rTHKk3c/diYjnHSMqdhcTwA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:298d:b0:561:5d08:761 with SMTP
 id cj13-20020a056a00298d00b005615d080761mr42290132pfb.14.1669760991856; Tue,
 29 Nov 2022 14:29:51 -0800 (PST)
Date:   Tue, 29 Nov 2022 14:29:43 -0800
In-Reply-To: <20221128210125.2751300-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20221128210125.2751300-1-jonathantanmy@google.com>
Message-ID: <kl6lr0xlqtrc.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 5/5] diff-lib: parallelize run_diff_files for submodules
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Calvin Wan <calvinwan@google.com> writes:
>>  submodule.c                        | 154 +++++++++++++++++++++++++++++
>
> I think the way to implement this is to have a parallel implementation,
> and then have the serial implementation call the parallel implementation's
> functions, or have a common set of functions that both the parallel
> implementation and the serial implementation call. Here, it seems that
> the parallel implementation exists completely separate from the serial
> implementation, with no code shared. That makes it both more difficult to
> review, and also makes it difficult to make changes to how we diff submodules
> in the future (since we would have to make changes in two parts of the code).

It seems that most of the code is copied from is_submodule_modified(),
so a possible way to do this would be:

- Split is_submodule_modified() into 2 functions, one that sets up the
  "git status --porcelain=2" process (named something like
  setup_status_porcelain()) and one that parses its output (this is
  parse_status_porcelain() in Patch 2). The serial implementation
  (is_submodule_modified()) uses both of these and has some extra logic
  to run the child process.

- Refactor get_next_submodule_status() (from this patch) to use
  setup_status_porcelain().
