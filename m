Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC49EC433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 19:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB5E9206B5
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 19:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHITfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:35:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53064 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgHITfK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 15:35:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id x5so5910545wmi.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2020 12:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UE1JR9JD8eyFUQOr4pHvA12VRJo7i4NLBL2TD09g4Bw=;
        b=qGhA0HeO/Z6gczjrjp8qRDxrtGdMEo/TInm0JpZbyqOvZTI692K8BpilQUeoxLN38k
         Cq15Gds0JHy8T9wq2xbVIELymDku5/rYIq3FcOQ0I5ebJBjk5awHcyeB+Qrr7njEUIbf
         PD5KDM/9lNjGDImGEW/v2xxHj8ZkLA5cWsuT7Ealu+s/6qr9ZjRPxrKHOMrp/sjxWBnA
         NyqPL8HwXFepatPa3ODxF3+7gkTgLwuY1rxPqYHFuWs6+FO+eq/kKE52tLyGj/m4WjF5
         wOYzSlHRo5Ef+E/f7fOVg7DjqVAQM//oLWTLGQ0/ionG/jvtoLTUhf6oKfYxZckWA8Ku
         lniw==
X-Gm-Message-State: AOAM532QkrYm0g+FPOTaWBlr+Qj01NG5/u5Zs+89JkzMhPbyvgjPT7Ww
        nmuing6Vo6MLvZgThHZIEkfmUbQYsr9UCeECDtA=
X-Google-Smtp-Source: ABdhPJz7gfXUwpova9za/PTWX8WunkEI3WRKtUv98aVQyRAy+B9mEgN/z5VzDrBndWSgPV3zL06NAg6NBftHZk4odNo=
X-Received: by 2002:a1c:39d4:: with SMTP id g203mr22742169wma.107.1597001707966;
 Sun, 09 Aug 2020 12:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200809060810.31370-1-sunshine@sunshineco.com>
 <20200809174209.15466-1-sunshine@sunshineco.com> <xmqq7du7eiqi.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7du7eiqi.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 9 Aug 2020 15:34:57 -0400
Message-ID: <CAPig+cTA_BVz-bGcGY++g2RV-Zd3Gv_yTGjv=VeMeqhP4eZZrw@mail.gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 9, 2020 at 3:12 PM Junio C Hamano <gitster@pobox.com> wrote:
> The motivation makes quite a lot of sense.
>
> I suspect that it is a bug to use "-", i.e. "read from the standard
> input", for "$2", because
>
>  (1) if it is used for the expected output, we got the comparison in
>      the wrong direction;

I had the same concern that it didn't necessarily make sense to allow
"-" for $2, but eventually thought of a case such as:

    sed '...' actual | test_cmp expect - &&

which massages 'actual' before test_cmp() sees it. True, we don't
actually have such callers, but it theoretically is legitimate.

>  (2) if it is used for the actual output, we have a command whose
>      output we are interested in on the upstream side of a pipe to
>      discard its exit status.

If the command upstream is a Git command, that could indeed be a
reason for concern, but, as illustrated above, it could just be a
system command.
