Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC318C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 05:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjBNFRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 00:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjBNFRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 00:17:25 -0500
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF92E1CF6C
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 21:16:28 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id s8so9518990pgg.11
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 21:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnZybVEu4OfFPxPrOzZfynwbs8yaqbFUip3JcQZMMXQ=;
        b=3tG2GDCFzOZ1cu0BL6QyH6lmUKbgfOaHkI8RAVXnZJ//jxOEE1aaf90o27bIPYhHWG
         0scn6CaGRVVmAOqBHyu2/eGnk916wgDsaZb9O0wDG7AG3RMD4nYACJvORqeIaGPRR4SF
         5923SbUVhg3SAu5rdDsHlzYMlC/CwOPgTo6SbuMDOcnfceQLl/JsYdvL4fmp9rXHr7vx
         ad9kkU45wPBMuGS/gC2PbmVAjPtt+6YcmXEMMy0x63oLJueKb9mTqvJ/RnTr1SGsTRtx
         o8rEZk8Zj22gXZEdeYahN31p4JcIp8TyiMJRivwqprB1fpOY3sn/j2GWIqwlWa5VIAm7
         tjxw==
X-Gm-Message-State: AO0yUKXLx0j4k7u/6zqZBSeDnm3q3NJhFM6Fd6PHv/SOC2L8Z/nGpM4/
        XGHvYhO7/BX0dCGV30EDUEm40v8Bk9uVpGz9bn0qYHwIpVo=
X-Google-Smtp-Source: AK7set9eNRnyn08PAEVgX6EGdb7XfS2X7kT51RGvcSOGpJr2vwyjRXozOdDakB5ZS9M0yKeNzThcWg/ZSxLIVYpqdRo=
X-Received: by 2002:a63:745e:0:b0:4fb:9825:c64e with SMTP id
 e30-20020a63745e000000b004fb9825c64emr84123pgn.115.1676351733436; Mon, 13 Feb
 2023 21:15:33 -0800 (PST)
MIME-Version: 1.0
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
 <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net> <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
 <Y+rmNvfjIA/u81em@coredump.intra.peff.net>
In-Reply-To: <Y+rmNvfjIA/u81em@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 00:15:22 -0500
Message-ID: <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2023 at 8:39 PM Jeff King <peff@peff.net> wrote:
> On Mon, Feb 13, 2023 at 05:58:06PM -0500, Eric Sunshine wrote:
> > I am able to reproduce the broken behavior on maOS 10.13.
>
> If you do something like the patch below:
>
> -       short_name = xstrdup(refname);
> +       warning("strlen(refname) = %d", (int)strlen(refname));
> +       short_name = xcalloc(1, 2*strlen(refname));
>
>                 short_name_len = strlen(short_name);
> +               warning("strlen(short_name) = %d", (int)short_name_len);
>
> Does it help at all? And if so, is short_name_len longer than we might
> expect it to be (I get 39 for the full refname and 28 for the scanf'd
> name).  I'm having trouble coming up with a reason that the scanf value
> _would_ be unexpectedly long, but just trying to rule things out.

I get results different from yours:

  warning: strlen(refname) = 39
  warning: strlen(short_name) = 9
