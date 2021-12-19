Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C9AC433F5
	for <git@archiver.kernel.org>; Sun, 19 Dec 2021 22:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhLSWvY convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 19 Dec 2021 17:51:24 -0500
Received: from elephants.elehost.com ([216.66.27.132]:16778 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhLSWvX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 17:51:23 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BJMpJ9W041359
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 19 Dec 2021 17:51:19 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Sean Allred'" <allred.sean@gmail.com>
Cc:     "'Eric Sunshine'" <sunshine@sunshineco.com>, <git@vger.kernel.org>
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com> <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com> <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com> <003f01d7f51f$f7bb0860$e7311920$@nexbridge.com> <CABceR4aP8BVr10RYS_0PFG7ExRTJ3tB541JGC4DJ7CUsMg9+Jw@mail.gmail.com>
In-Reply-To: <CABceR4aP8BVr10RYS_0PFG7ExRTJ3tB541JGC4DJ7CUsMg9+Jw@mail.gmail.com>
Subject: RE: Bug report - Can create worktrees from bare repo / such worktrees can fool is_bare_repository()
Date:   Sun, 19 Dec 2021 17:51:14 -0500
Organization: Nexbridge Inc.
Message-ID: <004001d7f52a$f0367010$d0a35030$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKeYwgHoGmGxJSEPR+fKunQIMLw7wFeNI06AY9dookBwEmhRwFEfZw5qn38m0A=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 19, 2021 5:23 PM, Sean Allred wrote:
> > what about the comparison code where is_bare_repository_cfg is
> > compared with 1 (it is a boolean and sometimes set to -1). This would
> > not generally pass a code review.
> 
> I'm sorry, I'm afraid I don't completely follow.  Wouldn't the most
> straightforward change be to simply follow the documented
> recommendation when we create the worktree config in `git sparse-
> checkout init`?  Specifically,
> 
>     @@ -374,6 +374,9 @@ static int set_config(enum sparse_checkout_mode
> mode)
>                            "core.sparseCheckoutCone",
>                            mode == MODE_CONE_PATTERNS ? "true" : NULL);
> 
>     +    if (is_bare_repository())
>     +      git_config_set_in_file_gently(config_path, "core.bare", "false");
>     +
>          if (mode == MODE_NO_PATTERNS)
>              set_sparse_index_config(the_repository, 0);
> 
> Are we saying the comparison within is_bare_repository() may not be
> appropriate in this case?

I'm suggesting that:

        worktree->is_bare = (is_bare_repository_cfg == 1) ||
                is_bare_repository();

the == 1 comparison should not be done for boolean-style variables. It is an int, but initialized to -1. Unless -1 and 1 mean different things, but that is not really documented.

