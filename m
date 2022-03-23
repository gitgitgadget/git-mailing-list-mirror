Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28559C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 10:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbiCWKYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 06:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbiCWKYu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 06:24:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170785BD0E
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 03:23:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bt26so1904231lfb.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=y2aGZplX4AcK5hDtzXcJYsl8RQ6z0godxvniHQvIp+s=;
        b=m2niU7cO4HuJ+cJvne7rgaXXsPuOv4rr1TVirqYZr9A2dFAWGukLDtPhtXZz9bt92L
         ViHoy5wOOeYvVYyS535ReaKSAaVf9vZoz6M6taMREg9FXqjofEQivBiTAWL+ujUkkQ5F
         JDrhJb/b0fM0fQW7k3+eqG73/e7RmjZT9ZLmG/KuHliA2xr2lp0WgOW1cy5TZRFSqOOJ
         8AbfN3NJnkQa04qVvwR0Cu+1SQtDkk2k2cfHVJX3YvRhrGKCYov0CH4Q1KDhwjKCRWF+
         V2IkmNvJtHn+dqV8kRPXGRysBpa2glGM5+cpCo0DeuajQxyhLYAZ0VQofFmd/6vLyGHc
         juPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=y2aGZplX4AcK5hDtzXcJYsl8RQ6z0godxvniHQvIp+s=;
        b=5wSvLmj/ZF4cnKT3pdxWe1NI2xHmezRbgLociMEHcraCGVl5HabfWSTPYW9FAjyVKW
         J+vvK8sQCPLoSlRkfuJiud51nPqpi0N6EZ81wmJjN7wlvjjUs1HFOGJBkf7YENNMXpGd
         LkQhe5mH79cU51glmGbX17lJ9EwQC7hVuNWUI3yOdSVUlYtpSsPAS6SA4uWGD/N6qy9V
         Rnv57RrmG/USm5z+r0zXPF4mBzJrwg0PwSbGlazv8xUcqX/OyJwf3Q4PbuIxv75kDEji
         8uhKsIqfGBAazM/SZMAPUm1GZubTtFVsrn3s93Cd7i9rHLd6IzCl7G/SmyzSRWYM/Zzf
         q16w==
X-Gm-Message-State: AOAM531BM7iqbaDyfPWiTUvWj6OYuLE3g8em4jYyllHJeqfA0GV0zySZ
        xzExg8q4SHi4bQCbdAHtyLQj3gu9uvUxTdfQxt0/gRGm0+A=
X-Google-Smtp-Source: ABdhPJy8sROWjp45/WFoVZ1e9IvXAV9mUMpHSjUhY8EL3Mi3ULBqREiWpFrMC5YSRVcuih4IQxaAYUqq3iz5n4BkTe4=
X-Received: by 2002:a05:6512:3b0a:b0:44a:2e21:ef25 with SMTP id
 f10-20020a0565123b0a00b0044a2e21ef25mr9320659lfv.333.1648030998330; Wed, 23
 Mar 2022 03:23:18 -0700 (PDT)
MIME-Version: 1.0
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Wed, 23 Mar 2022 11:23:07 +0100
Message-ID: <CAHGBnuPavzr_gq0ake6bOQETmHBnU2XOWdDz-UtkBP_+rRdYfA@mail.gmail.com>
Subject: How to determine the number of unique recent committers on a branch?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm trying to determine the number of unique committers who have
recently committed to a branch. "Recently" should be configurable, but
for my example I'll use a period of 3 months.

At first, I thought the [<refname>]@{<date>} syntax [1] in conjunction
with git "shortlog -s" could be helpful here, like

$ git shortlog -s main@{3.months.ago} | wc -l

But then I realized that just like with the --since option, the <date>
counts relative to the current date, not relative to the date of the
last commit on the given branch. To me, that's rather counterintuitive
for the [<refname>]@{<date>} syntax.

So, what would be a good way to achieve what I want with only
Git-means (and maybe `wc`), but without any awk / Perl scripting
magic?

Thanks in advance!

[1]: http://git-scm.com/docs/gitrevisions#Documentation/gitrevisions.txt-emltrefnamegtltdategtemegemmasteryesterdayememHEAD5minutesagoem

-- 
Sebastian Schuberth
