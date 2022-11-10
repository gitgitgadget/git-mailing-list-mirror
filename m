Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7E4C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 03:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiKJDhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 22:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKJDhd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 22:37:33 -0500
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0B8167F3
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 19:37:28 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id z9so434580ilu.10
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 19:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rh9yjUSSmyD7XWsIVGO9HqCdJc041Y0LSUVeux1G9vk=;
        b=XX0OTPu6I2d+84RPwhxkvcjJTeDqo4scKiQJcjkzAO9ULbwSIFylGg0B2hA1yIgSyD
         /rQHEKqQyIywR8gVx/hRxjqQVKiJFMcJd90F2Iymj0PR8NNqKqAX/odbmtTR8W0fPsel
         Qsq7i43I+iLFoxkCoL3L4KN966rVLEj6FGAXdpjhETNopHI0V329PswNRasZcpwS8H+h
         VKkUrJIXsVkA0vCquZgj/ZJ4islid3z14YSC3vsvK3AvYZM8aLKGccwy2Xvym1vfARXp
         ey+0w0xJzw+4Yhr8teOWQMP6Jg3+WWT9vZBzLZRaklATen7H1JkEgJNseCpeqn7qop/1
         nMYg==
X-Gm-Message-State: ACrzQf1xMskuwiBuopflr93m3nQwTLeF+KQPz0pwMCRD1+ibVfysauyj
        gR/v7ZFuIuvD22ZZo3DKmhhxZwCiRcnGmY8lzlDJanYm
X-Google-Smtp-Source: AMsMyM4owGwaATxX25IssNzIuJU0l/KaaxFKlmo+mIU8OFkBE+HLkxgBoC//VbhCF40T9r39YrgImgheZov2lhBB+pE=
X-Received: by 2002:a92:d2c2:0:b0:2f9:4023:d5e9 with SMTP id
 w2-20020a92d2c2000000b002f94023d5e9mr2501348ilg.249.1668051448046; Wed, 09
 Nov 2022 19:37:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
 <b85b28e5a6beea97c149f0b9de6ba8d0a4a7c1f9.1668013114.git.gitgitgadget@gmail.com>
 <Y2xkpJj4jLqfsggL@tapette.crustytoothpaste.net>
In-Reply-To: <Y2xkpJj4jLqfsggL@tapette.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 9 Nov 2022 22:37:16 -0500
Message-ID: <CAPig+cTL4x45E2a0RbpO2ntPo08K8hQ2wxcXm=QesqtYqxpvaw@mail.gmail.com>
Subject: Re: [PATCH 1/3] chainlint: sidestep impoverished macOS "terminfo"
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2022 at 9:40 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2022-11-09 at 16:58:32, Eric Sunshine via GitGitGadget wrote:
> > Sidestep this Apple problem by imbuing get_colors() with specific
> > knowledge of "xterm" capabilities rather than trusting "terminfo" to
> > report them correctly. Although hard-coding such knowledge is ugly,
> > "xterm" support is nearly ubiquitous these days, and Git itself sets
> > precedence by assuming support for ANSI color codes. For non-"xterm",
> > fall back to querying "terminfo" via `tput` as usual.
>
> Given the regex below, I think the question here is actually whether
> XTerm itself supports these in all its variants (my Debian system lists
> approximately 90 of them), many of which are quite old.  While I don't
> expect most of them to see common use, given the interest some people
> have in retrocomputing, I don't think we can exclude the possibility of
> seeing people use esoteric xterm variants over an SSH (or, perhaps less
> pleasantly, telnet) connection.

I get your drift, but I have to wonder if the retrocomputing crowd is
really going to be crafting Git tests directly on their retrohardware.
(appropriate emoji here)

> Terminal.app actually has its own set of terminal types, nsterm*, which
> are properly used here instead, although I realize that most people
> prefer the xterm* options for compatibility and ease of use.

Hmm, on my machine "nsterm" also lacks the "dim" capability. I see
that Neovim docs recommend "nsterm" with Terminal.app, so perhaps that
ought to be handled specially here, as well. Do you think any
variations other than base "nsterm" are worth special-casing?

> Perhaps, instead of auditing all 90 terminal types, we should tighten
> this to xterm, xterm-256color, and xterm-direct[0]?  That should cover
> the vast majority of use cases in the real world today, including most
> users of macOS and Terminal.app, while avoiding breaking some older
> variants (e.g., xterm-old lacks setaf).

I don't mind tightening which terminal types are handled specially.
"xterm-direct" doesn't exist on my old macOS. Is it present on newer
macOS? If so, does it require special-casing (i.e. does it lack
"dim")? If we don't special-case "xterm-direct", it will fall back to
using `tput` interrogation, which should be fine as long as the
"xterm-direct" terminfo entry is accurate.

I notice that the iTerm2 FAQ also recommends "xterm-new" on macOS, and
that one lacks "dim", as well on my machine. So, it seems that it
should be special-cased too.

Taking all the above into account, perhaps this regex?

    /xterm|xterm-.*color|xterm-new|nsterm/

Of course, the other option is to follow Git's own lead by not
worrying about TERM and `tput` and just assume everyone understands
ANSI color codes. I'm too old-school to feel entirely comfortable with
that approach, but I would entertain it if others feel it is safe
enough.
