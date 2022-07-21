Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB026C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 07:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiGUHYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiGUHYH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 03:24:07 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A413F33E
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 00:24:05 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h18so555555qvr.12
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=qe52Tem2aea0TriQhC6qS1AzOruFCZzRWlJbbNbpU9I=;
        b=cywWpSpHU4p4Qsw2+qRUScQiazpA07k5mB7mZ0MQf1WmVf/GbJHGknQWGN4eHuk9Hi
         zP0ZytrAoq8i8EVbFx+/KT+cv9v8dlz300k+bl5dmNb/QuVx9dYb0tbrHKPeyMquAzi6
         ZDXsuZYJs5SXg4tg3Mkd8pNp9swTqaXBPvy6om5rIUvd8HKis4f3+fHRiDFrO7LtmfOi
         ylVzzpoFnW7dqFEwjEz6Eu2AEYSbePnM+nxmrh8CdaLSbLjTBQdtbVSMBie+5i6b6Ewx
         zK1YsGj/JW9BApHby7TZPmMu5sy/flndpNk2QeVip0irUZSBVRR+tyH9v8ZqO/3Wbswm
         R7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qe52Tem2aea0TriQhC6qS1AzOruFCZzRWlJbbNbpU9I=;
        b=xHJsTAa5I5ELcSzM5XEI0SHecV4F0ml5vZQ/xYSQ3r+D8UGS7B80leQglLpOf2RNQ/
         BT0dPAiCedZTuRcwbZUNkei189wokQmSL3cl2WQAoCINF7C9D7YfS0KpDZpUMsT6VA3l
         wAn2UQB3tfySbeA7Y0GBSSC851tVo4DaWzP+TjfFXyu5YG3gD35i3Cgj/+z9eE84WnJp
         YuLBqWetmDdc6KXtuOEqr/Iha4jAkInP14pP8w0mdBqGOnThAyehUJxrJ4eee+LZKc/i
         OcxAYdbJuTqpMkePp47eGw0yZisyHB45w+OgFDg6QbpvVherUEG1mqprRZi3PJoK4BGy
         /J8A==
X-Gm-Message-State: AJIora9ZABnd5YNzFxUV23mt7oo0uVvRt8ciRyEmqz5SLksGNfy19N/P
        +orEZdUliL2mkC33x3qlV0cbZPH56gQhJuHr05Llm9mPtcquFA==
X-Google-Smtp-Source: AGRyM1uK6+8/UgRi2A2Djea/AgrNvn3tj/KGrRo+EON2zC1XcDc4kpVv2hjbWDvKGZw4wgPE6PLz/qX339ThgqCnDto=
X-Received: by 2002:ad4:5b8b:0:b0:473:5895:d6fe with SMTP id
 11-20020ad45b8b000000b004735895d6femr32457554qvp.39.1658388244362; Thu, 21
 Jul 2022 00:24:04 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jul 2022 00:23:53 -0700
Message-ID: <CABPp-BEK+SJh2uF=rrM-f1u9diMQJ7D3H0fJLdzWpyOww=ys+w@mail.gmail.com>
Subject: Question: How to find the commits in the ancestry path of seen down
 to _and_ including a given topic?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A simple question that I'm spinning out of [1]: How can I get `git
log` to show the commits in the ancestry path from seen, back to *and
including* a given topic (but not commits from unrelated topics)?

   git log --ancestry-path $TOPIC..seen

doesn't work, because that excludes $TOPIC.  (It does get me the merge
of $TOPIC into seen, as well as all merges into seen following that
merge, which I want, but it's missing the topic itself.)

  git log --ancestry-path $BASE_OF_TOPIC..seen

usually doesn't work, because $BASE_OF_TOPIC is usually a commit from
"main" or "master", and this results in pulling in hundreds of commits
from unrelated topics that also happen to be based on a version of
"main" or "master" at or after $BASE_OF_TOPIC.

Is there some magic that does what I want, or is this just not
possible currently?

Thanks,
Elijah


[1] https://lore.kernel.org/git/CABPp-BHARfYcsEM7Daeb7+vYxeB9Awo8=qbrOMXG6BQ0gX1RiA@mail.gmail.com/
