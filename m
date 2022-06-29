Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574F4C433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 16:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiF2Q4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiF2Q4I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 12:56:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E2023164
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 09:56:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i25so17871754wrc.13
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=iDreK55iP4bkDnwgtvuD+dZC3/lvyEPgpCLkf1Oo4SQ=;
        b=GfLXzga+jZ5gjeMV98Ez+7L54fCmNGkWPGoFJC6n2TcPCourbGD5Gr+NLmqy+J7Rja
         /Wfp09oVAXuZNUbpnssrHFLU7ZyS7Hp3iGXVUzsg1n1d+sbfa9q8Y3MZrgWClaCw4uCi
         oT/AS/C/YXGK5/UMdtJUfDtDJoq9wk4VKG656dE3o3UgLa5wAe/YuvOo4V2s79yF7/dB
         pyCL9wdJaEaCOaYI3mR7Q99b1zWK7kP6VrDkXlTuj4TS6graPFb0uqhL4YZMIWoDNoGQ
         Vmj2NgZcEPmX8Hp9tNymRPAXADqPlvKgOtkBSO7Cc/y60bMbkDnMaJH6KCxzC8UC07Fr
         Pklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iDreK55iP4bkDnwgtvuD+dZC3/lvyEPgpCLkf1Oo4SQ=;
        b=v2zQqmtqHDAvx6HC2WQoKcGS3hKRAVZyrpFsdujayy6Yikb8iu5Qvunbk+DBwWJYUX
         MphDUV3ImUf3fqJSD8g7grL43haILL0CY7U/qgC1GRevlFmKRTAyX22hldmVmVCFbTjY
         FKL0LARZ/mAu4vL0KWLHPEzinUxdhTmBdUMhSAZ4NsyCEURuDPLY90xwrPsGelCbxegO
         10N2XMcgAw7yGQD8BxOSxMiJVeRL9cY/fGzU0w86Sv6aRkV7eKsGqDS88EjcsHOCw5GC
         xrl7MOJbBzqIcnYD0v47HxAqFPrB/8VdlgTytfqCauxq1yoqkH4eGFjA3vwSaQb3FH58
         3mbA==
X-Gm-Message-State: AJIora+Ffsh+JN6byk3FRZN1cmkJEyUyyfoNSpr8zmeKlXs7V//fvyZX
        UZwG+0PmL0McXGLHppx79pyrQCYkj0YnGtDd7nrJ9VsWEpo=
X-Google-Smtp-Source: AGRyM1tr1TFLINIihDebwKDeWY0ardZR8CTjHq/q/VWfP4XdgiaXI7XOP5is0AsgkbSwdHqws7WfqfjDk89EyIJ4JTU=
X-Received: by 2002:adf:fb10:0:b0:207:af88:1eb9 with SMTP id
 c16-20020adffb10000000b00207af881eb9mr4112774wrr.238.1656521766140; Wed, 29
 Jun 2022 09:56:06 -0700 (PDT)
MIME-Version: 1.0
From:   Gregory Szorc <gregory.szorc@gmail.com>
Date:   Wed, 29 Jun 2022 09:55:54 -0700
Message-ID: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
Subject: Race condition between repack and loose-objects maintenance task
To:     git@vger.kernel.org, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git repack -A` (such as invoked by `git gc`) loosens unreachable
objects from packfiles.

`git maintenance`'s `loose-objects` task consolidates loose objects
into a packfile.

As neither process takes a lock or is otherwise aware of the existence
of the other, there is a race condition:

1. `git repack -A` creates loose objects
2. `git maintenance`'s `loose-objects` task deletes those loose objects
3. `git repack -A` fails to find the loose objects it just created and
aborts with `fatal: unable to add recent objects`

I see this failure with regularity in a custom environment where high
mutation volume repositories invoke `git maintenance run` with
regularity (effectively in reaction to repo mutations). We have a Git
housekeeping strategy that frequently invokes `git maintenance` with
all but the `gc` task. On a ~daily frequency, we invoke `git gc` to
purge accumulated garbage. This `git gc` frequently fails due to the
aforementioned race condition since the long wall time of `git gc`
practically guarantees a `git maintenance` would have been triggered
since the repo is mutated with such high frequency.

In my scenario, I believe we have a workaround by omitting
`--task=loose-objects` from the frequent `git maintenance` invocation
if there exists a `gc.pid` file. However, this is only a partial
solution, as `git repack` and the `loose-objects` task aren't aware of
each other. (I suppose running the `gc` maintenance task and relying
on the maintenance lock file could also work. However, we're invoking
`git gc` explicitly since `git maintenance` doesn't allow passing
custom arguments through to `git gc`.)

Gregory
