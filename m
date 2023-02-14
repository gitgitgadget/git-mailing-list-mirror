Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725E6C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 23:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBNXvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 18:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBNXuw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 18:50:52 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198A71A1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 15:50:51 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id ja21so11058174plb.13
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 15:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmNyHD94n4wxiQPLkVesp2GYNmDPsA4uB9D1ev2MntU=;
        b=umtKE5kSJxRW2OI1AqxcOiocj74SBKNh/qlLAHjU9QFWUcDb5a0yjnhy/MEf6dAkfz
         NNv0Ta4a9b0uGY0Z+SN/xzuzUGOckgJyHtHClXSJ9CGxbXcktPQPg5po7pt1B02ueAPV
         nLLEXNIHohSqFKVHIsUEddLr9LfbFHAmxbAp0MZv1r/A55/6I/HPQHp6qghzJyJNV8iL
         5g7AiMZuBGNe7DRZIVolkXwGdWYtLbyYitg89l7zuvFYq3/4sAD1pdulzo8TWoRUU6v0
         yt2/XO8YMZt5uzR1/791cQX3yFLjRhD4xM15RzAqnBI71Lpzg+75sDrEa/D9QNMOse7N
         Cymg==
X-Gm-Message-State: AO0yUKXF21gFEMNAbbozxWKWK5h23Tq+Y6ztLi4qFKfqskmK/th//Vil
        UhVwDzGhkkenwCaLbfISCYc6RGI+Ws5ES0NKU3EgAjrf
X-Google-Smtp-Source: AK7set+ZdM7wSq8MdmcMs+fMrV5vcfOuSNRBsrUGD9XLOZxAf1JHIXf3sBqvfqjipkrkha/G7FqdWNdaycK9Vu8ia/c=
X-Received: by 2002:a17:902:c412:b0:19a:9ba6:6521 with SMTP id
 k18-20020a170902c41200b0019a9ba66521mr116212plk.5.1676418650464; Tue, 14 Feb
 2023 15:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20230209164552.8971-1-vinayakdev.sci@gmail.com>
 <CAPig+cT1EtPO2FLvTsw3SjgCgk=ovNwY77hsX6p7ETKiq8aNog@mail.gmail.com> <CADE8NappDSaZrMLeqak4is59oL=X1wJOj2eCLLjaCKyrnoK9PQ@mail.gmail.com>
In-Reply-To: <CADE8NappDSaZrMLeqak4is59oL=X1wJOj2eCLLjaCKyrnoK9PQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 18:50:39 -0500
Message-ID: <CAPig+cT4TS0jn8LgjuV+N-aK+U0X6NW02gjMi=mi_9D204KHmg@mail.gmail.com>
Subject: Re: [GSoC][PATCH] {apply,alias}: convert pre-processor macros to enums
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2023 at 6:20 AM Vinayak Dev <vinayakdev.sci@gmail.com> wrote:
> On Fri, 10 Feb 2023 at 16:15, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Thu, Feb 9, 2023 at 12:00 PM Vinayak Dev <vinayakdev.sci@gmail.com> wrote:
> > This is a much better selling point for why such a change would be
> > desirable. Unfortunately, though, the real situation is more
> > complicated. The stated argument is only true if these enum values are
> > assigned to variables of the enum type. However, this patch only
> > defines the new enumeration type but never actually uses it to declare
> > variables, so the benefit for the debugger is never seen. For
> > instance, this patch defines:
> >
> >   enum binary_type_deflated {
> >     BINARY_DELTA_DEFLATED = 1,
> >     BINARY_LITERAL_DEFLATED
> >   };
> >
> > but then the code only ever assigns the enum value to an 'int' variable:
> >
> >   int patch_method;
> >   ...
> >   patch_method = BINARY_DELTA_DEFLATED;
> >
> > at which point the enum value's type is lost; it's an `int` and that's
> > how the debugger sees it, just as an `int`, so the debugger
> > can't/won't show it as an actual enum value.
>
> This is something that I missed, but shouldn't have. I will change the
> type of the
> variable to enum and run the tests again, as you have mentioned.

This is what the review process is for. Review comments are not saying
"you should have caught this yourself"; the intention of review
comments is to help you improve the patch. Even well-seasoned
contributors make mistakes, but fortunately many of those mistakes get
caught while the patch is still in the review phase.

> > Finally, please wrap the commit message so it fits in 72 columns.
>
> I am really sorry for this error, I was looking to be more descriptive
> in the commit
> message, but it does seem unnecessary to be this verbose.

No need to apologize. As mentioned above, review comments are meant to
help you improve the patch; they are not meant to place blame.

It's good to write descriptive commit messages. My comment about "72
columns" was merely asking you to word-wrap the commit message so it
fits nicely on a page.

> > If we look at the code which utilizes these values, we see several
> > instances like this:
> >
> >   return -SPLIT_CMDLINE_BAD_ENDING;
> >
> > which means that the value being returned from the function is not a
> > valid enum value since it has been negated. Thus, in this case,
> > converting the #defines to an enum makes the code less valid and less
> > clear. Moreover, these constants are only used in `return` statements
> > from the function, are always negated, and are always returned as the
> > exit code of the program itself; they are never stored in variables.
> > Thus, the debugger-related benefit mentioned in the commit message can
> > never materialize.
> >
> > So, all in all, I'd say that this is one of those unfortunate cases in
> > which conversion from #define to enum is unwanted since it makes the
> > code less clear and less valid, and provides no benefit. If you reroll
> > the patch, I'd suggest dropping these modifications to "alias.c".
>
> OK, I will do so. These technical specifications related to changes in alias.c
> are things that I did study about in C, but never actually saw them in
> practice, so
> I guess I just lowered my guard for such mistakes.

The review process is about sharing knowledge. Hopefully my
explanation of why this change is unwanted made sense.
