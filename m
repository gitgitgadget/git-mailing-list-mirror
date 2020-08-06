Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B80C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 04:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115722076E
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 04:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgHFEKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 00:10:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41133 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgHFEKW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 00:10:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id r2so37521681wrs.8
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 21:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=O+vkAeHw6+jF03lbhS/BhUsNijbn7nNSumK9Y0T/0e0=;
        b=SpnvAnpZb87S90oNTVMPUrPwGT9rKsrJU6yYtceSs0XXJki4/VI/hs5G2a7AvTFF8v
         IMR3Mje3P7+hLtuiCKvZcyzugqo/ab/EEUhpPxLYItg5sRb+hnCnwbIQx1tEqAJfGSCD
         LA+ofnHnhVsSad0ln5tC6dI2ePJt3Du93bymsUHxFi0YWEaxNwejwgAZ4ZqeWVKE6A9L
         +/P/kUP5IQooMjn/COvJMjPnZa8CVsji9A0OmfTB7wwM0IWoiIiNn/VIyo95Vy0o+Y7a
         1gh03YXO2FR0IU0n/JS2zP9nj8bH8hV/x07d998slwzJAuelFMgaNHyNINzNGRaw32Nf
         SRKg==
X-Gm-Message-State: AOAM531SnrJ5H3N/vyIM8mcsE9e3VgAuI17LciP8uldyh/p0Ix77dlzT
        oTqNHFPd2HACCypFZV8yecOphwfKCWDgEKT33c0=
X-Google-Smtp-Source: ABdhPJyH78u0g3ZElDGJXfNPLtZIQXJAW2oqzPU1SnkREpPGL4sCl5y+yWrX33ExdHdNV0P+/oyfYY+GmiXCSuuFBHs=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr5478654wrn.415.1596687020607;
 Wed, 05 Aug 2020 21:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
 <1f63b4fc7c2ae1970d7226bbf0b66901528fb9d8.1596675905.git.gitgitgadget@gmail.com>
 <20200806021354.GS6540@camp.crustytoothpaste.net>
In-Reply-To: <20200806021354.GS6540@camp.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Aug 2020 00:10:09 -0400
Message-ID: <CAPig+cRe2OUeHXE3XELtkS7b2GrZVxLm0pzduojDB97uLnBZKQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] Use $(SHELL_PATH) instead of sh in Makefile.
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        lufia via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "KADOTA, Kyohei" <lufia@lufia.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 5, 2020 at 10:14 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2020-08-06 at 01:05:01, lufia via GitGitGadget wrote:
> > In the not POSIX environment, like Plan 9, sh might not be looked up
> > in the directories named by the $PATH.
>
> I think Git's editor handling assumes that sh is somewhere in the PATH,
> so it might be fine for us to just ask the user to adjust PATH
> appropriately before running make.  I don't have a strong preference; if
> this works on a standard Unix machine, which it looks like it should
> (although I haven't tested), I'm fine with it.

This does, however, have a bit of a chicken-and-egg feel to it. The
results of the "uname_FOO" assignments in config.mak.uname are
consulted later in the file to _assign_ a value to SHELL_PATH on a
number of platforms. So, making the "uname_FOO" assignments themselves
depend upon SHELL_PATH is rather circular and confusing.
