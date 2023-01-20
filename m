Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E847FC38159
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 05:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjATFmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 00:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjATFl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 00:41:57 -0500
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FBF659B
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 21:40:35 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id c26so3186518pfp.10
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 21:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnN9c2qMWddO9F4K1ifXjUBANUwyDKJGakoQVdbbpqE=;
        b=bwFeob4pPs2hcq8E2/8pkclh5jPJ2GSD4cLc8icwPiz1/oUGM1dE2SezvGdwn2Bqsl
         MeasuO7nvEfliIznogc9qs+aoFHrQ6S1fjboJOfper/BEIvm12K1QYsqSgoA5zjlNo1y
         xlf8VTxysUwlOtLlTBirbdB2d4P/3OuIoYGPcWvPxSOc+dZVF2X96cRtsr14i1nyHTxJ
         g4BBBTqIL5NbPxBaq03xFAx/tq92M0JJEfh8RqB3ax03HLPdW9IxL8k8R0y/sW0XOZMG
         hqQOrUPT708DLvLSvAJSsYlkU8Sf2j1pq3SILC1QZBh9kxahmXYGSuVdtaB/RGvipVj9
         EE2Q==
X-Gm-Message-State: AFqh2kov97t1K1IhUWGaIaS9poah4Rtde9EoP7SfeSPrSRTQQJVlrhgn
        ol76zVG9FyehxVBOPa9A5HWCmPrTilGdW3QH5bA=
X-Google-Smtp-Source: AMrXdXuwMdkBz8sFssXoL8z0S8aqCREzeSksKaUk1iU7zj/09zPOa58PLrOEC4XatNjLv/4lYFQxTRyBF1zRzizSDsU=
X-Received: by 2002:a63:fb08:0:b0:4cf:9942:a7c1 with SMTP id
 o8-20020a63fb08000000b004cf9942a7c1mr1143177pgh.20.1674193230400; Thu, 19 Jan
 2023 21:40:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
 <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com> <a0f8f5fac1c3f79cd46b943e95636728677dffef.1674190573.git.gitgitgadget@gmail.com>
In-Reply-To: <a0f8f5fac1c3f79cd46b943e95636728677dffef.1674190573.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Jan 2023 00:40:19 -0500
Message-ID: <CAPig+cQj4Gi+ikkPz3wffqGZVz5uALGzYV25nio3k4+cthP9Uw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rebase: remove completely useless -C option
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 12:14 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The `-C` option to rebase was introduced with 67dad687ad ("add -C[NUM]
> to git-am", 2007-02-08).  Based on feedback on the patch, the author
> added the -C option not just to git-am but also to git-rebase.  But did
> it such that the option was just passed through to git-am (which passes
> it along to git-apply), with no corresponding option to format-patch.
>
> As per the git-apply documentation for the `-C` option:
>     Ensure at least <n> lines of surrounding context match...When fewer
>     lines of surrounding context exist they all must match.
>
> The fact that format-patch was not passed a -U option to increase the
> number of context lines meant that there would still only be 3 lines of
> context to match on.  So, anyone attempting to use this option in
> git-rebase would just be spinning their wheels and wasting time.  I was
> one such user a number of years ago.
>
> Since this option can at best waste users time and is nothing more than
> a confusing no-op, and has never been anything other than a confusing
> no-op, and no one has ever bothered to create a testcase for it that
> goes beyond option parsing, simply excise the option.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Is there a chance that this patch could break some existing tooling or
someone's workflow or alias? If so, perhaps it would be better to
continue recognizing it, but as a proper no-op? That is:

(1) continue accepting the option but mark it PARSE_OPT_HIDDEN or some such

(2) completely ignore the option

(3) in case someone runs across it in some existing script or example
and wants to know what it does, leave one mention of it in the
documentation, such as:

    -C<n>
        Does nothing. This option is accepted for backward compatibility
        only. Do not use.
