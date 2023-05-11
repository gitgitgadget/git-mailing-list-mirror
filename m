Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25C9C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 13:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbjEKNpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 09:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbjEKNpV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 09:45:21 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF85E704
        for <git@vger.kernel.org>; Thu, 11 May 2023 06:45:09 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-75776686671so277293185a.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 06:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683812709; x=1686404709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0W9poFvmBzc2K5P99Ogveg/XaoRDil+hJvU6KMXmFM=;
        b=WUG/nbwnKB6j6QKNt8uEd43pXTP2xVaS5Tr1gTbmVYVjlGEaUszhHRJ2o6FVfpk9ue
         EqxNoGDKP9ovvZan6h22uT7+EU0vMLA2HlOBhqjHapLoU0SybrUJQwiwYUP5L15TBquI
         K/heqDThICJLcmoQM/A0clDVrIoDbU2QoxvR9hF3R988kEWBupN0tqKGBdJ6jc8+dMTH
         gimU417+CL0cyeNNGlSB5zDWtt7f9ARex/lGP/29At8z3NmRrIU9XRCmGfhRy4S83pnh
         RIMWI3U5X7EOZMPxfLpRYkcdfyS8awOz5c2lHkPHK1yLlTxqnqgBqNaKxXUIM85GJxVt
         6DeA==
X-Gm-Message-State: AC+VfDyczOyYVLo9CFgoGelxp4Cf7pg6jbbQkxXsRkZ7jA8a2tPLjU8w
        Fy4GlLNqrLKLcRjdUkBavRRruuJ1Hdd9pGnfRDJC3EnpOmw=
X-Google-Smtp-Source: ACHHUZ7K0zwKEj+/SA552sq57A24DybGEREjgvh9rjJBkrI/kRgqgXZKdmA0vsDhfbvJLfFyhNPMVXBIm8gqhDIJtlo=
X-Received: by 2002:a05:622a:285:b0:3f3:8a0a:f1a8 with SMTP id
 z5-20020a05622a028500b003f38a0af1a8mr24023279qtw.61.1683812708747; Thu, 11
 May 2023 06:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com>
 <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net> <CA+JQ7M-1YvZFzE_CtBQa5_eEXa1sPqK4xsTxdwpAQo_YcmW+-A@mail.gmail.com>
 <91dab444-5f65-31ae-c0c6-0b84313bcd94@game-point.net> <CA+JQ7M_Lv1acopOpPoHxp7mPwWMFj-7wwwDPpV7KUbwFsjpoxA@mail.gmail.com>
 <6446d78fbbe82_cd61294e5@chronos.notmuch> <c7bb292d-903b-692e-885b-524b6bb113ee@intel.com>
 <xmqqwn1yqsx7.fsf@gitster.g>
In-Reply-To: <xmqqwn1yqsx7.fsf@gitster.g>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 11 May 2023 15:44:32 +0200
Message-ID: <CA+JQ7M_3jLCXHokbeHB=DyphFO605GE0BTu-cqZsF1ZNExL=kg@mail.gmail.com>
Subject: Re: Proposal: tell git a file has been renamed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeremy Morton <admin@game-point.net>,
        Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another example of where the current implementation isn't working great

  A - B - C

commit A makes changes to foo
commit B changes the name of foo to bar
commit C symlinks foo => bar

Rebasing the commits and reordering them

  commit B changes the name of foo to bar
  commit C symlinks foo => bar
  commit A makes changes to foo

is going to result in merge conflicts. The best way to achieve this
ordering is actually doing multiple rebases.

  commit B changes the name of foo to bar
  commit A makes changes to foo
  commit C symlinks foo => bar

followed by

  commit B changes the name of foo to bar
  commit C symlinks foo => bar
  commit A makes changes to foo

I guess the difficulty that arises from reordering commits like this
isn't unique to renames but it arguably results in a more hostile user
experience. It requires an unusual amount of discipline and
understanding of what is going on to resolve as well as how to avoid
it.
