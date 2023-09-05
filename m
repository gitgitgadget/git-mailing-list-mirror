Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7F6CA0FF3
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjIEQAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354869AbjIEPNr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 11:13:47 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E672F18D
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 08:13:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17D2C1A8B54;
        Tue,  5 Sep 2023 11:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=9P9+gLRmsZYfT9uU1MK/wtg2a8fMIprfNurSKg
        ATIOs=; b=BezAW04r8EdkQuzHYF2AQtFojEwyhL736MXodfUxDooozRfhvL7ktb
        BpOu0M1x/0BrmX6HLO04woW+lQmUKNTlD280tD1jxyXGMeU40rXb9BWDm+BneFQx
        Oxwr65ai/upA713pSeWj7b0pU5CpcSm/U3ozaoAho1WxwTrbG2Cms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 100941A8B53;
        Tue,  5 Sep 2023 11:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 713D61A8B52;
        Tue,  5 Sep 2023 11:13:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird?
 Bitmap error in git gc.
In-Reply-To: <CAPig+cRJhrGmnBRm2dporcXiRr4SzRmpM2LTMm0S7wo0XbOU9Q@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 5 Sep 2023 01:43:54 -0400")
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
        <CAPig+cTeQDMpWQ-zCf6i9H-yhrdCndX6gs67sypuqmHZZcHm7w@mail.gmail.com>
        <xmqqedjdtoh5.fsf@gitster.g>
        <CAPig+cRJhrGmnBRm2dporcXiRr4SzRmpM2LTMm0S7wo0XbOU9Q@mail.gmail.com>
Date:   Tue, 05 Sep 2023 08:13:41 -0700
Message-ID: <xmqqmsy0slei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCCCDA06-4BFE-11EE-9250-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> All correct.  The per-worktree part of the repository data does live
>> in a subdirectory of the ".git" directory and that was probably what
>> Tao had in mind, though.
>
> That could be. I read Tao's explanation as meaning that people do this:
>
>     git clone foo.git foo
>     cd foo
>     git worktree add bar
>     git worktree add baz
>
> rather than (perhaps) this:
>
>     git clone foo.git foo
>     cd foo
>     git worktree add ../bar
>     git worktree add ../baz

Ah, that reading does totally make sense.

But I am not sure it would lead to "we need to carefully protect the
primary worktree", because it is rather obvious, especially if you
bypass "git worktree remove" and use "rm -fr", you would lose
everybody underneath if you remove the "foo" in the "worktrees are
subdirectories of the primary" variant in the above examples.

Even though deriving the worktree(s) from a separate and protected
bare repositories does protect you from total disaster caused by
removing "rm -fr" and bypassing "git worktree remove", it still
should be discouraged, as the per-worktree states left behind in the
repository interfere with the operations in surviving worktrees.
Teaching folks not to do "rm -fr" would be the first step to a more
pleasant end-user experience, I would think.

Thanks.

