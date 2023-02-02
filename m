Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D8FC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 23:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjBBXTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 18:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjBBXT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 18:19:27 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FA85D12A
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 15:19:26 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id d3so3504479plr.10
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 15:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1FoO3H1R+Oqq1sgXrLYtpaWUnZsqjfP2NR45RPu8Wk=;
        b=XspoIOB+PwQ0BUJ7JGc1bd8IBEksBXED1Q3bzr88Ynrq+6ZGXzCxnTWQI/4EppX3Xu
         CKGky5kDCs4xHZ7f6J0Zc+3UWT0MBoeDXHDige5q8vAuvdpvBqDssOSZwoxFvgFsLAPt
         sTR/OFW10h0Ij7W7GuRn/zt7s50DlXaSghqonbCVPGAyl8Z21unttYhzFVSwi491xDnF
         D6WN8sk9aDjJnljOn/NOE7+lUlg1+9e8PSafv1crny/BQApdpzjTJIfm7rMbm5BSDKxE
         Ze75nct5BnR9Qbiadxqz6RMZuoYBCuDaW7A4qPkuxnr4am3SKFRswtE+5O0wVulh2zG1
         OnTg==
X-Gm-Message-State: AO0yUKXxo/fLc6Ekc+Mw/qeHQVdGWDlvabUmf26X3AkfkimmTjANRGje
        dogDxrhH7/fU/15//Gij4+DtTdFp0J2jyCfpT9w=
X-Google-Smtp-Source: AK7set+TEeJ8zIMfOL/ASsgK8kJv/stNMCYoSMrez7jDeBLJn1gcEI1mh1TCXn3PbUDFkXTbGLw7IcqlHsG4GWhq08Q=
X-Received: by 2002:a17:903:243:b0:196:4e61:b6b5 with SMTP id
 j3-20020a170903024300b001964e61b6b5mr2268983plh.2.1675379965594; Thu, 02 Feb
 2023 15:19:25 -0800 (PST)
MIME-Version: 1.0
References: <20230202202557.19297-1-kostya.farber@gmail.com>
 <xmqqa61vsniy.fsf@gitster.g> <CAPig+cTC4TUK2NXFmP6ymEYYjYAmCSd53dzFhKn0ido8x6uh1Q@mail.gmail.com>
In-Reply-To: <CAPig+cTC4TUK2NXFmP6ymEYYjYAmCSd53dzFhKn0ido8x6uh1Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Feb 2023 18:19:14 -0500
Message-ID: <CAPig+cR+1bxgitSmJ47PxD=CPxJjMh5Vm+zRdVU8iEo9pvtutw@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t/t5000-tar-tree: add helper function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kostya Farber <kostya.farber@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2023 at 6:09 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> So, t5000 seems to be one of those relatively rare cases in which the
> raw "test" command is more correct than the higher-level helper
> functions.

By the way, although the change made by this patch is probably
undesirable, if you would like to try a different submission, there is
a bit of modernization that could be applied to t5000. In particular,
the "archive and :(glob)" test does not match present-day style
guidelines:

        git archive -v HEAD -- ":(glob)**/sh" >/dev/null 2>actual &&
        cat >expect <<EOF &&
    a/
    a/bin/
    a/bin/sh
    EOF
        test_cmp expect actual

These days, we would use `<<-EOF` rather than `<<EOF` to allow the
here-doc body to be indented to the same depth as the `cat` command
itself. Furthermore, we would use `\EOF` to indicate to the reader
that no interpolation is expected within the body. Taken together, the
final result would be:

    git archive -v HEAD -- ":(glob)**/sh" >/dev/null 2>actual &&
    cat >expect <<-\EOF &&
    a/
    a/bin/
    a/bin/sh
    EOF
    test_cmp expect actual

Both cleanups can be done via a single patch; the commit message
should mention both modernizations.
