Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2F0C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 05:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhKXFtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 00:49:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64427 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhKXFtY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 00:49:24 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC85615C237;
        Wed, 24 Nov 2021 00:46:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ysM4lec4xLqQwylxfcM54vib8aQs8pMOoWobAmcqB6Q=; b=Eszx
        NibvNeuxNr1hwldXCleUXxnJoBQni6RR5k6WO0bFggPFj3aLVHaZZ03PhTopao7+
        G499k16gdmjdPs+xqlPkYk7Tkw7jzaO2a7FOGy6sSinJprQGfGXioNr2HLmJYsuH
        UJx5wpPfYyDqYTM3N37cDV3731Iv3bvLfD0Hn6g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4F8C15C236;
        Wed, 24 Nov 2021 00:46:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1161915C229;
        Wed, 24 Nov 2021 00:46:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
        <20211123003958.3978-1-chooglen@google.com>
        <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
        <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
        <kl6lzgputxxw.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqv90i7cxd.fsf@gitster.g>
        <CABPp-BHUj=3b8xZhD3weBPYuWaVR5MrrM8+KCwhtcB8diZcJyg@mail.gmail.com>
Date:   Tue, 23 Nov 2021 21:46:11 -0800
Message-ID: <xmqqa6hu3y3g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D545E8B4-4CE9-11EC-8D05-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Nov 23, 2021 at 1:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Glen Choo <chooglen@google.com> writes:
>>
>> > This doesn't sound like a typical definition of 'emptiness' to me, but I
>> > can accept it if others also find it compelling. IOW if your definition
>> > of 'emptiness' is compelling enough, then I'll be convinced that there
>> > is no mixing of concerns and there would be no objection.
>>
>> FWIW, I do not find it compelling.  I can grant that it might be
>> convenient, but I do not think it is a good idea to explain the
>> reason why the directory is protected is because it is "not empty".
>
> Is the objection to my hand-wavy explanation?  If so, point taken.

The objection is against the definition of 'emptiness' Glen
perceived in your explanation ;-)

A directory is empty when there is no filesystem entity hangs below
it.  A process can have any directory as its cwd, even an empty one,
but the presense of such a process does not make an empty directory
suddenly non-empty.  That is the objection.

> However, I'm curious if you're also objecting to my commit message
> and/or the patch as well.
>
> If your objection also includes my commit message, but not the patch,
> would the following suit your taste better? :
>
> """
> remove_path() was added in 4a92d1bfb784 (Add remove_path: a function to
> remove as much as possible of a path, 2008-09-27) to, as it says, remove
> as much of a path as possible.  Why remove as much as possible?  Well,
> at the time we probably would have said something like:
>
>   * removing leading directories makes things feel tidy
>   * removing leading directories doesn't hurt anything so long as they
>     had no files in them.

I think you meant trailing, but I do not think you need to say it
twice---they say pretty much the same thing.  We are removing as
many directories that contain no files (i.e. non-directories)
underneath to make things tidy, as such a directory serves no useful
purpose.

I am not saying that an empty directory should not be protected even
when the current process sits there.  I just do not think it is a
good idea to call the protection "we protect a non-empty directory".
It is something else.
