Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC10CC43219
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 17:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKVR6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiKVR6A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 12:58:00 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D2FCDD
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:57:32 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id j12so14393792plj.5
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nlgxr3NhPzoID6upe6OzcVh9vRGjWdvpHxSljX6pK94=;
        b=W72N+JdkRA8tXTgCs+YV3msq9+uRtlYVCY8rTyFJncfpfvUa2WNQnIURyehkWT+uzX
         h6nrFKgqx+D0Qk7ZvM3CGf9KhCfmdmiX/+5e3GFTc66zsVZ7BrrZG1FAPduLy0e3c6EX
         00YlErKCIEifR5lYHSb5ZLE73N/3X2T3VO7TPV7XpWaeZuwaCQKTy4PWonImkojwPKYP
         lwxE4ywzUmjnNL/O7WvIkD8T7Ht8/7ZXbKJWc2JqNXVOJctM9NnSjMyD25AglRH2vGjZ
         6LpoilyxZ6MvLERyZZrc3uQrOSCTmBJm09b9etXefFih5RkDeuTB2F2sZMu3BAtLOq17
         kUuA==
X-Gm-Message-State: ANoB5pmWzwy0dzB9WyoPUf2xtCuVuabIAzMsnpJK9QGwC6XvpKg3RyVS
        0X3+dahRTw7jqaQ09VEEIuylXdZwPS03h4yCKNaYX0NEOv0=
X-Google-Smtp-Source: AA0mqf74JXGRaeAmDTFwzhK8MFWUIB5E2Rl2XeL9bZ1x962oHzIBlq1PDyA3AkiC5IBa62OEba82ACiwsx4cFAvFkrk=
X-Received: by 2002:a17:902:8f96:b0:189:3803:23e6 with SMTP id
 z22-20020a1709028f9600b00189380323e6mr2428377plo.77.1669139851998; Tue, 22
 Nov 2022 09:57:31 -0800 (PST)
MIME-Version: 1.0
References: <CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com>
In-Reply-To: <CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 12:57:21 -0500
Message-ID: <CAPig+cQrXb-YUSzmfgJ2PRoiOP3goVACRCrX9C39kf3oDH+BHg@mail.gmail.com>
Subject: Re: chainlink.pl /proc/cpuinfo regexp fails on s390x
To:     Andreas Hasenack <andreas@canonical.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 12:45 PM Andreas Hasenack <andreas@canonical.com> wrote:
> git commit 29fb2ec384a867ca577335a12f4b45c184e7b642[1], present in
> 2.38.0 and later, introduced a function that gets the number of cores
> from /proc/cpuinfo. It essentially does this on linux:
>
>     do { local @ARGV='/proc/cpuinfo'; return
> scalar(grep(/^processor\s*:/, <>)); } if -r '/proc/cpuinfo';
>
> On s390x, the ^processor lines are like this:
>
> processor 0: version = FF, identification = 148F67, machine = 2964
>
> In other arches (I checked amd64, armhf and arm64), they are like this instead:
>
> processor : 0
>
> As a result, that function is returning 0 on s390x, and that value is
> used for the number of jobs the script should execute. Since it's
> zero, it exits without doing anything, and that breaks the test and
> the build[3] on s390x.

Thanks for the well-described explanation. I think this is the same
problem reported in [1], however, that thread hasn't seen sufficient
diagnostic information yet to figure out what was going on. So, your
report is very helpful.

There is discussion about altogether ditching the code in question
(see the discussion starting at about [2], for instance), but in the
meantime, fixing this would be a good idea.

> This is trivial and I don't think a PR is necessary, but let me know
> if you want one.
>
> That regexp could perhaps be:
>
> /^processor\s*\d*\s*:/
>
> or
>
> /^processor[\s\d]*:/
>
> or something else.

We would be happy to take a patch if you're interested in submitting
one. Otherwise, I can submit a patch to fix this case. Let me know
your preference.

[1]: https://lore.kernel.org/git/f1a5f758-d81f-5985-9b5d-2f0dbfaac071@opensuse.org/
[2]: https://lore.kernel.org/git/221122.86cz9fbyln.gmgdl@evledraar.gmail.com/T/#m7626ed18fa0e93a8b0ada9cf6d2d18b08045cb4b
