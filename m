Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CCBC433EF
	for <git@archiver.kernel.org>; Sun, 24 Jul 2022 14:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiGXOYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 10:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiGXOYU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 10:24:20 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8457EE0C7
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 07:24:19 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id k3so5055333vsr.9
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ramkQyBEZBm8QPi40ZPaBddti/eIcP0DZBsUXqxeuIc=;
        b=k+SoZJjo8dI0D87RO9bv+79LqZZVjXyyzwk8w+xa9cRp68hUmelPur+ZW8nuqAneTD
         W7BZosrlICmhZjZHUo7bmQFdUdRfY3l5t3g+kl7WK3Q1kuuc7Ml9zfdfSNfgSg28Aqm4
         yXDgpEyqfWHsDG1FRmETdB0k7qXuKyVrSjQo2ShF7C2XZMzGI+h23oh4n7LRzsrapgY+
         RU0h4NrJFq/l+DcXL5L4yoTnwUU0gycP1XWXGTEWT2MmCZ9qBN9erpPtalL34hMoMFsb
         sdJuK0WMt3N4tI6QymatTovQ7IvoK70Nu3qhhq1GWo8Pk2DJDmaaeTpoblqByMH7a2f2
         kE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ramkQyBEZBm8QPi40ZPaBddti/eIcP0DZBsUXqxeuIc=;
        b=JWLkTXjKdIeRYy63BxZy5QbIu1yUDYo+Ok/dZ9m7iB1RYgxeXoo6uYJ47dpsPciJf+
         xWZKevwZcScH3VNAiLyQQIzsBSjXSKTfilLQ9hMlq0b4imBqbrISQoEf0N5RD07U3Y5z
         VgFUHkyGo/CRzJxrSFslZVzOJklwlsOhyOcVNWbubvCELRirwTr5U++jMO2KZvHMIZEa
         DCQwvvDVqj06qNS8kkVihvCf2X00FblJOfR5mU4qAwOKReMncT5KkNnBapktI53Y1QnB
         AF2ywyvWwd5TQMVtYck6gWBdCAJmpWN1R+7C+HcDvkiMZf06hYu9qc4GS6J5MvFjBB32
         4kzg==
X-Gm-Message-State: AJIora9Clp1Mfwy3YPbdGX4+yY/8//BDVg/5UYsifnALdkN8p5FuNQcW
        pYFqMSEvWvEIo4nQ8YY6TDJtIjLj3b7B+q5rx2f/RQ7cWCSI3A==
X-Google-Smtp-Source: AGRyM1tTCQ9FM0EMjBCXd0I3k9eN9Ewzk0hI2YLDxkCGnlXVwCiW322/oZcHA7bjdCe0dWcdqNHUWeZMJyXhivcQwAQ=
X-Received: by 2002:a05:6102:3346:b0:358:4fb0:ab58 with SMTP id
 j6-20020a056102334600b003584fb0ab58mr1217732vse.15.1658672658101; Sun, 24 Jul
 2022 07:24:18 -0700 (PDT)
MIME-Version: 1.0
From:   Philip <philip.c.peterson@gmail.com>
Date:   Sun, 24 Jul 2022 10:23:41 -0400
Message-ID: <CAJ6X7_UNOMusKKbFzS12DRhrOkVXAEgED8djA2kxjfFmbv4GwA@mail.gmail.com>
Subject: Pre-computed similarity indexes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I noticed that Git LFS-tracked files cannot correctly detect renames,
probably because Git is not doing a similarity check on the content.
Doing so would require having the content (instead of just the LFS
pointer), and that would require running the smudge filter, which
could take a very long time due to network requests, very expensive if
done on every file in the repo. When doing a `git log` for example, it
would need to run the smudge filter on all LFS files in all revisions,
potentially pulling down all the content from the LFS server, just to
decide if there were any renames.

I wonder if there has been any thought given to whether a similarity
index can be pre-computed somewhere? (Maybe upon commit with each of
the commit's ancestors.) Or if this limitation has been discussed
before here.

Thank you,
Philip Peterson
