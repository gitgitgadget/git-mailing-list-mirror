Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCC6EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 20:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGLUty (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 16:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGLUtx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 16:49:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0609C9B
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 13:49:52 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8582A3501C;
        Wed, 12 Jul 2023 16:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PU9gQs1DslWtVlnJTU3aMH66V18uPDjB+UhtWS
        cesTs=; b=aKDfBr6OgzswfxGfn54VHxoDZiRjH5hPlXi6UpJqc5RHzkTu0xal9P
        iUaDRR5KasHBiCvy5ARGDOSNofkacjOv1+dveyRC+tzvy58luYuItpzjdOOHNy89
        ZwxYrO+EhE8QS8s7RlhoPu7bU9kNpaBuDQCzx2C5t+vJPfuGERFQk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B0963501B;
        Wed, 12 Jul 2023 16:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 14B2735017;
        Wed, 12 Jul 2023 16:49:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Soref <jsoref@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [rebase] `fatal: cannot force update the branch ... checkout
 out at ...` is confusing when it isn't active
References: <CACZqfqAB7zyn56+NOL=E8Y3bXNiQnJdmVXgzsnj78C-Anw-h2Q@mail.gmail.com>
        <xmqqbkghw4qd.fsf@gitster.g>
        <CACZqfqDE-SCOqVX9a8KCLAn1zSVbYxuCeU8Y=3-nhj5wbL=AWQ@mail.gmail.com>
Date:   Wed, 12 Jul 2023 13:49:47 -0700
In-Reply-To: <CACZqfqDE-SCOqVX9a8KCLAn1zSVbYxuCeU8Y=3-nhj5wbL=AWQ@mail.gmail.com>
        (Josh Soref's message of "Wed, 12 Jul 2023 16:33:22 -0400")
Message-ID: <xmqq5y6osvmc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A45206CA-20F5-11EE-AFAF-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Soref <jsoref@gmail.com> writes:

> Josh Soref writes:
>> fatal: cannot force update the branch 'main' checked out at
>> '/private/var/folders/r3/n29fz25x72x191fdv6mhhr3m0000gp/T/tmp.fGD64HAf'
>
>> It's true git in the repository does have a pin of sorts for the
>> `main` branch and that `git-rebase` would be very upset if the
>> branch's location were changed, but as an end user, the `main` branch
>> is not checked out, the `next` branch is checked out.
>
> Junio C Hamano wrote:
>> Fair enough.  Perhaps "cannot force update the branch 'main' in use"
>> would alleviate the confusion?
>
> That would be better.
>
> Even better would be to tell me what's using it (rebase). I'm not sure
> how possible that is.

When branch.c:prepare_checked_out() notices which branch is in use
in what way in which worktree, it does check many conditions (e.g.
"in this worktree, is a rebase in progress and if so which branch is
being affected?") but the information is lost there to only record a
mapping from branch names to worktree location.  So "it is in use
over there" with exact location is given, but "how it is used" is
not recorded.

It shouldn't be a rocket surgery to teach the function to leave that
information, but I am not offhand sure how valuable it would be to
do so.  After all, once you learn which worktree of yours is using
the branch you wanted to touch, you'll either know already or it
would be easy for you to find out what you have been doing in that
other worktree anyway, no?

