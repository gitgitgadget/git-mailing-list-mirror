Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D80CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 12:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378413AbjJLMBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 08:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbjJLMAy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 08:00:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68902189
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 05:00:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e16f076b3so818310a12.0
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 05:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697112037; x=1697716837; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8PjuD/xY8VzOHHLn0pCzzg4elk67gjn3mb/bJ2QEYUE=;
        b=Xp7Yev3oGh/Sdvz1zdETcK4o9eh8sOlBifuv0kvUd77lu31Q9zw47dTgx4WNogWPy6
         GZxKfa3KuB3btb7W0hw7uxcF+2p/eAR6oxD7dtwr5b1j+L3YHyEc1d1JPPSjQoBD7Ok0
         6EO0/N6zWu93RXDuOUqpHSGQV0521kxJKSOsr4sJnwVHKkZjaZeVrhpZB3xmi1cLbcr7
         QK1llfarQS8zroGDBx4XJn7/8yzfWxOCouN6zZydaMqAkbe/D4QC79+s3px2DHljmyKx
         ZgDhwGtTpud2gJR73c+vAXpQdEjADWQpBsqqCSsL5smu3SQONDx/EztkgLq5I8ybvJ4X
         JMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697112037; x=1697716837;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8PjuD/xY8VzOHHLn0pCzzg4elk67gjn3mb/bJ2QEYUE=;
        b=LbEB1EiohQ52Pe2EFp9NAkAhNYcv6rDDQOO3jndr93SM+nArBJ4UgiUSuCyd/chOGJ
         ff5kfmEvlBC3Zjc6mf+UAL+ANjfjI2A5Xes++L3vf3wOA3c9JpyOiKvJAt6SIeHS6VII
         bLgnvXIDEyD3YZFHn00lHXGdUzilo53cTcQs7zDb2+F1LIPaMf3jS5cbAjh7A7tRCU65
         fijPQpagE7UMhuPpkUWyr1mI/xKCS26WUZwKfuqAsXGYUsFExvwqALMQtFNRq5nFbP7w
         ozIRUDiPa1MJGYX8brQzySXoXBAOBCmVth2NEfIJddTUheUQN8ii6Mjl2AH3zPA6VlQX
         UsXg==
X-Gm-Message-State: AOJu0YytXoG7Y7skj5+76xFCuZ1osxXVnwJWXaRwvH+RcztVIzDN11hm
        Iw9bmU7FHQIzv8mrc+npez5Pgr4MwgDH7esWILtHME8HtQydziiT
X-Google-Smtp-Source: AGHT+IGn6dLl8iIOqaVRGr7AABUmbJQUI1vgdQV8djn3UE9J27NLztJGUR30kXtePaCANEZN8rsLBKLau7eb42kibgk=
X-Received: by 2002:a05:6402:2744:b0:536:c20:12d7 with SMTP id
 z4-20020a056402274400b005360c2012d7mr19090686edd.7.1697112037006; Thu, 12 Oct
 2023 05:00:37 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 12 Oct 2023 20:00:25 +0800
Message-ID: <CAOLTT8RzcENBx9NKffHReVKJAho89TCO7W2SPBX8sb2tEU84Gw@mail.gmail.com>
Subject: How to combine multiple commit diffs?
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

Our company wants to design a "small-batch" code review feature.
Simply put, this "small-batch" means being able to treat multiple
related commits within a MergeRequest as an independent "small" code
review.

Let me give you an example: We have five commits: A1, B, A2, C, A3.
Among them, A1, A2, and A3 are multiple commits for the same feature.
So when the user selects these commits, the page will return a
"combine diff" that combines them together.

A1       B A2 A3 C
*--------*----*-----*-------* (branch)
 \ A1'        \ A2'  \ A3'
  *------------*------*------- (small branch code review)

This may seem similar to cherry-picking a few commits from a pile of
commits, but in fact, we do not expect to actually perform
cherry-picking.

Do you have any suggestions on how we can merge a few commits together
and display the diff? The only reference we have is the non-open
source platform, JetBrains Space CodeReview, they support selecting
multiple commits for CodeReview. [1], .

[1]: https://www.jetbrains.com/help/space/review-code.html#code-review-example

Thanks,
--
ZheNing Hu
