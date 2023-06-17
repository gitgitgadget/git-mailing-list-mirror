Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB81CEB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 11:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjFQLWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 07:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFQLWH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 07:22:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDF0AF
        for <git@vger.kernel.org>; Sat, 17 Jun 2023 04:22:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17BC31A7794;
        Sat, 17 Jun 2023 07:22:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=aDXyJ1gQ+dG0DcnVhShCjsSs2/QyaqgUv1FCvL3uYnI=; b=qkiB
        hhU0hE2soMxxU4GlJQ8923WLddBaCm29/Ymy4LR7nvIH6PO/K+Q80Hv/hL2LjFbo
        YTYgVIpgsM+0rQgZlPG/ZqcB77+Lcb5kfqi88QyC0COXCme7s5KKV4P2Rzfk5BAV
        yExFHfsX/SfiwPsmA38nbm1OFYP227Uv6fKnWfg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10B831A7793;
        Sat, 17 Jun 2023 07:22:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19A831A7791;
        Sat, 17 Jun 2023 07:22:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nadav Goldstein <nadav.goldstein96@gmail.com>
Subject: Re: [PATCH] Add 'preserve' subcommand to 'git stash'
References: <pull.1528.git.git.1686913210137.gitgitgadget@gmail.com>
        <xmqqjzw3qry6.fsf@gitster.g> <ZIzALOe8GBsNGIhR@ugly>
        <xmqqv8fnrwtt.fsf@gitster.g> <ZI1xLwemOs9Vxorf@ugly>
Date:   Sat, 17 Jun 2023 04:21:59 -0700
Message-ID: <xmqqwn02qqp4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DF4C010-0D01-11EE-9D6E-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> i may be totally wrong about it (because i don't understand the
> motivation behind this feature, either), but i think the _intent_ of
> nadav's patch is to merely expose the first half of "stash push" (the
> other half is the implicit "reset --hard"). it may not be a
> sufficiently good one, but there is clearly an analogy here.

I do agree that it would be reasonable to want to expose the first
half (the other half is "now the local mod got saved in a stash,
adjust the working tree and/or the index"), but then that means the
code should cover the various operating modes we have, and let the
users perform their first half, so that the second half (which by
the way needs to be exposed by another series later) can be used on
top of the result to emulate as if the combined two (i.e. "stash
save/push") have been run, for the feature to be complete, no?

Lack of the second half can be excused away with "let's do these one
step at a time", but the analogy fails to hold with an incomplete
coverage of even the first half, I am afraid.

But as you said, I think the lack of concrete "here is how this
feature is expected to be used and why it is useful because it
allows us to do X that we haven't been able to before" is the
largest first issue in the posted patch, as that leaves reviewers
guessing without feeling they "understand the motivation behind" the
feature.  Such an understanding would help us to tell where to stop
(maybe in certain modes doing only the "first half" does not make
sense because the corresponding "second half" inherently does not
exist for some reason, in which case it is fine not to support such
a mode that is supported by "stash push").


