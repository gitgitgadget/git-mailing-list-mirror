Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96063C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 21:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbjFBVXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 17:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjFBVXH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 17:23:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7141CE45
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 14:23:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96fab30d1e1so547419466b.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1685740984; x=1688332984;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MWVvjv2yQwYeCrjKKrnGrorKd0NPqCiS3w4I7nXNlYk=;
        b=gnPUqefkPffdeAQgvsHmJFfSXATbc5cZDCg/yWOFqCSd8uvmbOQROTaNg4AstfQ4se
         b9SGg6aVhJmv2yAZdO/W5np4X1q79gmSvriTGqLZKplk8LM5ZM1oE3W8Yjfk1NwBwrJA
         aFHi2Tc9H1d94RU2nqe44lf7my3FzUKymO+6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685740984; x=1688332984;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWVvjv2yQwYeCrjKKrnGrorKd0NPqCiS3w4I7nXNlYk=;
        b=W243xf4Fo2Pn/8lLAuEYfA3jUZOYwC8GRoMPHp6RlGwGyRxFH8JyDWDAYLJMYIQrVL
         rIg8rSTJuPKQgiHFC534oKdeRGLLAfa3kv3/37dpYeRA+GBxywydDAiWOWAYKb8lwOPV
         pLGKolqok/E/AAqquXTk02RJjRlKDw46F37C4ETC0zhxr4dSv0Fzj4seW+HlimmG7KQf
         pWbZNeLUEoY+SnMnP0eWSxJZSaVRYCzlBt3Z7tPGnEhraJ/+KHb7HgLu5hpFjACxj8wx
         LOt9VusHbo+La5KVfeY3kqyuij5vgQY9/ooETEtv/D7Be70BNDM5nisY2jNXjVlPwYsi
         UFjg==
X-Gm-Message-State: AC+VfDwbQFHiKD68+WGNVIhn75jW2hIag0ujBTug3Z7AH0Dw8zFrDdDc
        YKXq/WPC3IjbVw0LEfZyh26KRFUDiSkDmzKyxoMP8VXiRHL9k+/XIjvAMw==
X-Google-Smtp-Source: ACHHUZ7GskYPk+PEu2NJ8bGbqWBy48O8VHyEf9K2DShVeFBBkBZVUzApnbzlgbY6AqKs3At1TrdLJXzG9xUSYQLalVQ=
X-Received: by 2002:a17:907:161e:b0:973:70a8:483 with SMTP id
 hb30-20020a170907161e00b0097370a80483mr6538978ejc.24.1685740984441; Fri, 02
 Jun 2023 14:23:04 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 2 Jun 2023 23:22:53 +0200
Message-ID: <CAPMMpoiJ4cNcAR9gO5d-749N3YW-88p1gMnX8ySGgz84Mr9coA@mail.gmail.com>
Subject: "git fetch --refetch" and multiple (separate/orphan) branches
To:     git <git@vger.kernel.org>
Cc:     Robert Coup <robert@coup.net.nz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I just recently noticed that "--refetch" was added in 2.36, and I got
pretty excited - the ability to "fill in" missing blobs after a
too-filtered clone is something that I've wanted a number of times, as
I mentioned in 2021 in thread
https://public-inbox.org/git/CAPMMpohOuXX-0YOjV46jFZFvx7mQdj0p7s8SDR4SQxj5hEhCgg@mail.gmail.com/
.

When I first ran "git fetch --refetch" today however (git 2.38.1,
against server git/2.38.4.gl1), with a configured blob filter of
"blob:1100M", a much higher size than any blob in the history, it only
got a *relatively* small number of objects - 3GB of data rather than
the 18GB that a new unfiltered fetch would have retrieved.

After some more testing I tried again, and got the expected outcome
that time. The relevant difference between the two attempts is that in
the first case, when I only got some of the objects I expected, there
was an updated tag as a result of the fetch. The second time, when I
got everything, there were no updated refs.

In this repository there are several "independent" sets of branches,
and the tag updated in that first fetch belongs to one of the
smaller-history branches.

What I believe is happening is that *if* there are refs to be updated
(or new refs, presumably), *then* the objects returned to the client
are only those required for those refs. If, on the other hand, there
are no updated refs, then you get what is advertised in the doc: "all
objects as a fresh clone would [...]".

I've tested a couple of different scenarios and the behavior seems
consistent with this explanation.

In a repo where all branches are derived from the same history, this
probably isn't very noticeable; in the repo I'm working on it makes a
huge difference, so the only way I can imagine getting "correct"
behavior would be to always to a "git fetch" right before the "git
fetch --refetch".

Is this a bug, or expected behavior that should be noted in the doc,
or do we consider the multiple-independent-branches usecase to be
edge-casey enough to be an easter egg for people like me?

Thanks,
Tao
