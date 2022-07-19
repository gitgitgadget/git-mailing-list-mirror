Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3BBC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 19:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbiGSTs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 15:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGSTsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 15:48:25 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6C491DC
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 12:48:23 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2ef5380669cso152153457b3.9
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 12:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBQm7xK70RkgT5oHim+hgRd99MHGSlaowhHJaWHmuB0=;
        b=KqUoG2RHgGEAITNg0e9nye4WEXka622/IrSpvhE3BlxQEiMarXWJqXXyd7hdacie1c
         7eZkjSE/Yn70sPc0X8HhVbMQ1cjBIpjZJSMxsEI/ScjPYRNzvaMpY9VH+tLYIdNaF8v2
         BBUXq7+eJthnDzin67Xui9Mm5HfK7UrxK5nXC8O588oS/p9Nl/odqbfQD9eL455Qre7E
         VaNVU+FpX7putBupmcAa8q5YSIV7IrQFAy+Yf/XJ0Mo/gkp5fWG//0cImLdJTEzSJrZ/
         VCr4pJNIfQl+3zgyT+lvC6b9DQv0Mt7jGicpYRCC124oN+7O2q8+UdtemY+qGMA4rEeK
         OpAw==
X-Gm-Message-State: AJIora+N18dvEgpTu8cjImQL+EDvt+qqS2kiIwi9n0OkOv+v/GS9VAkC
        MGMCPa+C3mJljhlduMIAIDi1tyAmrd2eeqG9jC0=
X-Google-Smtp-Source: AGRyM1v95zEGOxKXLErWGxo90QE5yvZJvpMhsnSLvO1LmQuLBmDoRu+r5+dJA9qQ3TsbtL8aS/OKGbvvXv0phQkMUww=
X-Received: by 2002:a81:7589:0:b0:31e:620b:e75 with SMTP id
 q131-20020a817589000000b0031e620b0e75mr3331526ywc.482.1658260103006; Tue, 19
 Jul 2022 12:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1294.git.1658256354725.gitgitgadget@gmail.com>
In-Reply-To: <pull.1294.git.1658256354725.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Jul 2022 15:48:12 -0400
Message-ID: <CAPig+cSPnQnw82DsDHhMP12sYW_XHUb6+MYt17V=0sWrW4j2iw@mail.gmail.com>
Subject: Re: [PATCH] compat/win32: correct for incorrect compiler warning
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 19, 2022 at 2:48 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The 'win build' job of our CI build is failing with the following error:
>
> compat/win32/syslog.c: In function 'syslog':
> compat/win32/syslog.c:53:17: error: pointer 'pos' may be used after \
>                                     'realloc' [-Werror=use-after-free]
>    53 |                 memmove(pos + 2, pos + 1, strlen(pos));
>     CC compat/poll/poll.o
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compat/win32/syslog.c:47:23: note: call to 'realloc' here
>    47 |                 str = realloc(str, st_add(++str_len, 1));
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Removing the unrelated "CC compat/poll/poll.o" line would help make
this output less confusing.

> However, between this realloc() and the use we have a line that resets
> the value of 'pos'. Thus, this error is incorrect. It is likely due to a
> new version of the compiler on the CI machines.
>
> Instead of waiting for a new compiler, create a new variable to avoid
> this error.

If possible, it is a good idea to mention the actual compiler version
in the commit message as an aid to future readers who might want to
know if this sort of workaround is still needed.

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
