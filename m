Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AAFC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 18:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjBCSTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 13:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjBCSTO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 13:19:14 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B45EA9121
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 10:19:13 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id me3so17651180ejb.7
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 10:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+VWhsqJzt1lr6dz5vim+iI3VYE6+Iwu2O8Qtf/b8w8g=;
        b=IMLYp2jdiDTm57t5q6uv4wWyB2pZeuNigpzvPudnxSKvruocERlLGSahUDU62SOYKn
         js1/LkU0CTvIC/PHVW7qnPKOMMa7nveQ2Wf0bVv2HoBHZelWzfcZ/OvkBo0czrnT14Eg
         z2ctUuQhwVFTrpArg8ncSXltNG1Fu4Vo1vGmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+VWhsqJzt1lr6dz5vim+iI3VYE6+Iwu2O8Qtf/b8w8g=;
        b=ggOCsoNoj0FCW7QHNsTP5GPei712kgvt73f1ym0+TFbtRSBg6RgoTLCewDx4a+SIEZ
         5Oirszc+geJwlMIyye8QTNsL+B5LzbW9E6m3vnIjeoyvMf9cE/Z+Kl+MN3iEAzfmzuO0
         WIBaXM6EhqloK5f9I2FOUlbcZz6HOksWPc2uD2MmgbRN8/bV8uCX6OQSzCJvmPowVRd0
         T8ogVHNKWBbCAA4LaQGF9GeeAaPJgb5krWdLjAyJJb9BvTPisUkr6aHxql+z2TeK4RCp
         vEQ+bM6gLphhnUFABuEF42XuJT7je089WYQMT1+h1DH5lLGWafheYaYuvLodS2Pd20I3
         qwwA==
X-Gm-Message-State: AO0yUKUDY6uCpi+O7G7fGEQCqZKuy0GYzf7LcwhvMWBrH1skpJdAn3Mk
        /IaiEk54Ar49TpHjBp54e05bORchbY2nNaF+F7evWlDMHZAIrDQFrGo=
X-Google-Smtp-Source: AK7set+8FP9xWVSlgUEA29BYg2Vrq3JXEZakD3Uyqav/aU3wEdh6SABl7g3G96hwfJUiMypbJ6MQYO9HyVyu+R47sRQ=
X-Received: by 2002:a17:906:4f10:b0:887:f6c3:9ac7 with SMTP id
 t16-20020a1709064f1000b00887f6c39ac7mr2942143eju.196.1675448351331; Fri, 03
 Feb 2023 10:19:11 -0800 (PST)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 3 Feb 2023 19:19:00 +0100
Message-ID: <CAPMMpoj6E-85a59EaHD2aR_oKA=_u78qRV+wp8mqXkR39KctmA@mail.gmail.com>
Subject: Defaulting --rebase-merges overall?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I've had a couple of users recently be bitten by "git rebase"'s
default handling of merge commits:

* One user had selected the "git config pull.rebase true" option from
the "Need to specify how to reconcile divergent branches" pull
conflict hint text, without understanding enough about what that
meant: that if they do a "pull" right after having done a (non-ff)
"merge", their commit history would get mangled with a set of
duplicated commits.

* The other was using a GUI (Intellij IDEA), which offered to rebase
when there was a push conflict, but didn't mention or do anything
special about the fact that the single commit to be rebased on a push
conflict was a merge commit (same consequences)

In terms of "quick wins" to help these users avoid the trap they fell
into, I can think of two "quick wins":
1. Change the "Need to specify how to reconcile divergent branches"
pull conflict hint text to offer "git config pull.rebase merges"
instead of "git config pull.rebase true"
2. Offer a global "--rebase-merges by default" config option (I know
there is already a per-branch option, but that's really not very
effective when people are creating new branches all the time)

I've scanned the archives of the last year or two and can't find any
chatter or activity around this - does anyone have an opinion
regarding either of these approaches?

Ideally I'd like to do both. The hint change for people who follow the
hint without understanding the dangers, and the global config option
for people who understand this historical weirdness of rebase and
would rather see the back of it, now that "--rebase-merges" exists and
improves rebase behavior for most users under most circumstances.
Presumably with such a global config option we would also need a
"--no-rebase-merges" option to counter its effect on-demand?

As I think about it, the global option sounds like it might be hard to
prove the correctness of (and compatibility with the hosts of other
options), so I probably won't be qualified to do this. Is there any
objection to the simple hint change, at least?

Thanks,
Tao
