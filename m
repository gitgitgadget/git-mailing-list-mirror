Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB664C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 23:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFA520732
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 23:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=schrab.com header.i=@schrab.com header.b="q/56EL2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgIHXZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 19:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgIHXZq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 19:25:46 -0400
X-Greylist: delayed 530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Sep 2020 16:25:46 PDT
Received: from pug.qqx.org (pug.qqx.org [IPv6:2600:3c02:e000:5::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6DCC061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 16:25:45 -0700 (PDT)
Received: by pug.qqx.org (Postfix, from userid 1000)
        id D67BC2B30B; Tue,  8 Sep 2020 19:16:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schrab.com; s=mail;
        t=1599607012; bh=/OhI4YiDeH5hPPkP/sw5Li1aBd3qTtRn99HHbOdFmvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/56EL2YkvjjIVyBglFRiU5+mz+P3R5mUyoU3kiGh4ddXXvyM6jh5gzIY4A2pkK3B
         6c/Fy8t3ikeo/nyd8B9ezUDVlUhfsfAh7ALq9LrP1+JuIybCl9fpYpAt55cI8cMWFp
         oLFn4u6C1KHXWSo0xjVXuKdAW+0UTuWBzuBMZ3hRFo58/eaJDWWVcQMP9cTP05znjt
         45vdxUFEL1hj4HpEqhSv5O06MEKwwuIGwzJWuEbTos1a4Uddftc2r6FknHIQD8ywE3
         aT+gQBI5h/ti18V8NX53hBZz1Z8wCFvxYZL0zpML2gwOd5Jk1jhqf+SEGeaf12JBnM
         OY+CeqxVJ9nMg==
Date:   Tue, 8 Sep 2020 19:16:52 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ash Holland <ash@sorrel.sh>, git@vger.kernel.org
Subject: Re: `git describe --dirty` doesn't consider untracked files to be
 dirty
Message-ID: <20200908231652.GC1014@pug.qqx.org>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
        Ash Holland <ash@sorrel.sh>, git@vger.kernel.org
References: <CAHJUbDg2KA9Xo_CAO=cgrZewOH0zfEhOVydhMN8fLvVDmji4sQ@mail.gmail.com>
 <xmqqh7s8z0qw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqh7s8z0qw.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 09:33 -0700 08 Sep 2020, Junio C Hamano <gitster@pobox.com> wrote:
>Ash Holland <ash@sorrel.sh> writes:
>
>> There seems to be a discrepancy between how `git describe --dirty` is
>> documented and how it actually behaves. The documentation describes
>> the --dirty flag like this:
>>
>>> If the working tree has local modification "-dirty" is appended to it.
>
>Not limited to what "describe" does, whenever we mention "local
>modification", we only mean modification to tracked contents,
>because by definition we do not detect or track "modifications" to
>anything that is not tracked.  Untracked paths may have been
>modified multiple times, but since they are not even added, we do
>not notice nor care.

It's perhaps worth noting that submodules are already considered dirty 
when untracked files are added:

$ git diff vim/bundle/fugitive

$ echo foo >vim/bundle/fugitive/foo

$ git diff vim/bundle/fugitive
diff --git i/vim/bundle/fugitive w/vim/bundle/fugitive
--- i/vim/bundle/fugitive
+++ w/vim/bundle/fugitive
@@ -1 +1 @@
-Subproject commit caf3b1d5696e8d39a905e48f1e89d8c0c565168c
+Subproject commit caf3b1d5696e8d39a905e48f1e89d8c0c565168c-dirty
