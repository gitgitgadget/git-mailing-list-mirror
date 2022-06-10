Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69203C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 16:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349925AbiFJQxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 12:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350044AbiFJQxg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 12:53:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABBE193E2
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 09:53:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD9EC192437;
        Fri, 10 Jun 2022 12:53:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CdZA1BGSjRthOS8wFbv/v1L1LBR/uEsBo49/XX
        PvC9Y=; b=dgz0ifvPSilP0tAQcxvlx6PtcVKE343siejb1hLo9+fxaqTwO1J3Yv
        BE66dxGgv4incpME+fQu7GHs+Uzkhp/3+SWX+JW8NqaioypeY9F6ark1y5HFZSh7
        SvEVEzZAu6T4oP5DNYIIwUvoGen90YRYW3q706V5MO8GVI2XiLh4I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B65A8192435;
        Fri, 10 Jun 2022 12:53:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 62283192430;
        Fri, 10 Jun 2022 12:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug in merge-ort (rename detection can have collisions?)
References: <kl6lee006mle.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CABPp-BEW2WF5AJeKqCiL2zhcPwPH-u6p=myoX_GkU6tbV=+TZA@mail.gmail.com>
Date:   Fri, 10 Jun 2022 09:53:28 -0700
In-Reply-To: <CABPp-BEW2WF5AJeKqCiL2zhcPwPH-u6p=myoX_GkU6tbV=+TZA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 9 Jun 2022 23:41:06 -0700")
Message-ID: <xmqqczfgfojb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA936E50-E8DD-11EC-9EDA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jun 7, 2022 at 5:11 PM Glen Choo <chooglen@google.com> wrote:
>>
>> (I'm not 100% what the bug _is_, only that there is one.)
>>
>> = Report
>>
>> At $DAYJOB, there was a report that "git merge" was failing on certain
>> branches. Fortunately, the repo is publicly accessible, so I can share
>> the full reproduction recipe:
>> ...
> Thanks for the detailed report; very cool.  Interestingly, if you
> reverse the direction of the merge (checkout origin/upstream-master
> and merge origin/master) then you get a different error:
> ...
> Anyway, long story short...I don't have a fix yet, but just thought
> I'd mention I saw the email and spent some hours digging in.

Thanks for continued support for the ort strategy.  From the very
beginning, I was hesitant to make our tools try to be too clever
with excessive heuristics, but at least we are not making a silent
mismerge in this case, so it is probably OK, especially with "-s
recursive" still left as an escape hatch.
