Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEA4C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 17:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjBURde (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjBURdd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 12:33:33 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7992F13DCD
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:33:31 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id i24so2085026ila.7
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKu46Icb5qRpCWDdrOtzc1Aw0VihqI5Zub3gCfYqcMQ=;
        b=FWt1ktHdoBsLz7nVI3Vyg1sHxbrNqTY98Mg1y2vXKdM0R6OOWG2aBYA6wx/RrwcjfD
         2iTIV8mKotqX0abwGdMAs6+ywgfQTUgdMKlECNv5Pi7K0EEsClenMuB2heofzbC9ltMh
         mw2Wg8+JnJG0LWAgWM0n8OQQp7oOmW0eAaJqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKu46Icb5qRpCWDdrOtzc1Aw0VihqI5Zub3gCfYqcMQ=;
        b=EMmu2BRZnjGy38aMhzH5HU7M4YLNuu4xcwe9jF8rnYePvcpijJxvpn0ANv1UBGJ9Be
         W5d6ZbEBWxWUtaIjNTw9JBEwrm6Q6yi5E7qzVlrhI3OQLUuUNKEHMKYEwWNbXj4N5zPC
         S0oRSkZ5y4GilYDh5LLQpWANZLlRieF0TYMxMj7RbaY/tUClW403DtxW7UrmserteHzy
         Myf/kXTn/2pXK8hM5a7roEYlZSqaU+x4o8ki5u+Ci+fti5s8y0YMaMGf4YSd+w5PQ3y5
         NZFlJJ12tZytAxh9CUBaFf92z1/BTu4+r4RHGyRl3wKXC4Xw/otl4+8jSYIpW2XSnZb1
         UAHg==
X-Gm-Message-State: AO0yUKWYApO2UvrjBrURuzFjWLtucdSfGtpE3qs00JnFtbcvukwAoQd3
        LpNNURpKDAy6E8/O5N65BEca/IVy+EeU05vj
X-Google-Smtp-Source: AK7set8eLoN6q5ldUox6evIS7Y3cPttbItOQmXnljvEZwNcvRGw5kxIVTICn5nlUkHVs0oAsxw8Utg==
X-Received: by 2002:a05:6e02:164b:b0:316:4d84:1d0 with SMTP id v11-20020a056e02164b00b003164d8401d0mr3562846ilu.12.1677000810576;
        Tue, 21 Feb 2023 09:33:30 -0800 (PST)
Received: from google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id g14-20020a056e021a2e00b00313d86cd988sm1704678ile.49.2023.02.21.09.33.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:33:30 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:33:28 -0700
From:   Raul E Rangel <rrangel@chromium.org>
To:     git@vger.kernel.org
Subject: Parallel worktree checkouts result in index.lock exists
Message-ID: <Y/UAaC4oBPIby4kV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I'm trying to extract multiple trees in parallel so I can create a
tarball of the trees. I can't use `git archive` since it doesn't
currently produce hermetic output, and I need to support older git
versions.

In essence what I'm trying to do is:

    git --work-tree ~/tmp/bob1 checkout ff27f5415797ead8bc775518a08f3a4ab24abd53 -- . &
    git --work-tree ~/tmp/bob2 checkout e70ebd7c76b9f9ad44b59e3002a5c57be5b9dc12 -- . &

When I do this though, I get the following error:
    [1] 4027482
    [2] 4027483
    fatal: Unable to create '/home/rrangel/cros-bazel/.repo/project-objects/chromiumos/platform/vboot_reference.git/./index.lock': File exists.
    
    Another git process seems to be running in this repository, e.g.
    an editor opened by 'git commit'. Please make sure all processes
    are terminated then try again. If it still fails, a git process
    may have crashed in this repository earlier:
    remove the file manually to continue.

Is this expected? I'm not sure why the index is coming into play here.
Is there another method I should be using to extract a tree into a
directory?

If the index.lock isn't actually protecting me from anything, I was
thinking of creating a symlink clone of the .git directory for each
parallel invocation. This way the each index.lock gets written to its
own directory:

    mkdir ../vboot_reference.git.1
    find . -mindepth 1 -maxdepth 1 -exec echo ln -s '../vboot_reference.git/{}' ../vboot_reference.git.1/ \;
    
    mkdir ../vboot_reference.git.r2
    find . -mindepth 1 -maxdepth 1 -exec echo ln -s '../vboot_reference.git/{}' ../vboot_reference.git.2/ \;

    git -C ../vboot_reference.git.1 --work-tree ~/tmp/bob1 checkout ff27f5415797ead8bc775518a08f3a4ab24abd53 -- . &
    git -C ../vboot_reference.git.2 --work-tree ~/tmp/bob2 checkout e70ebd7c76b9f9ad44b59e3002a5c57be5b9dc12 -- . &

Though if there is another way to handle this it would be great.

Thanks,
Raul
