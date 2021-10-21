Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E4EC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D5060FD8
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhJUWtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:49:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60357 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhJUWtf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 18:49:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEF15150BEF;
        Thu, 21 Oct 2021 18:47:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J1SPInpyxbyVQ4un7lKpG4TJJXGM8qAblZxP9Q
        0pLrM=; b=t3SNG+phUfA4Mr6yFCtEW7wVdGg/2I/IjxCiCtMUAaqS/FXS6o3aZs
        q43d15dmBtt5KnY1R5ExQt5lt8skESm34IleAe1xpHIu3O1O+Z4/+epjuco8cz4w
        o4j6alK4W2DtsvmPH132kdjkfW1hhcoMhk3vCqlzg6LVu7KPALbII=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C5C7150BEE;
        Thu, 21 Oct 2021 18:47:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF72E150BED;
        Thu, 21 Oct 2021 18:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Kalyan Sriram <kalyan@coderkalyan.com>, git@vger.kernel.org
Subject: Re: Git submodule remove
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com>
        <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net>
Date:   Thu, 21 Oct 2021 15:47:14 -0700
In-Reply-To: <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Thu, 21 Oct 2021 21:36:41 +0000")
Message-ID: <xmqqbl3ihu6l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6C4C270-32C0-11EC-90ED-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-10-21 at 17:25:38, Kalyan Sriram wrote:
>> Hello,
>> 
>> I was curious why git-submodule does not have an `rm` command. Currently
>> I have to manually delete it from .gitmodules, .git/config,
>> .git/modules/, etc. See [0].
>> 
>> I'd like to contribute my first patch to this project by adding this
>> feature, but wanted to check first with the community if there's any
>> particular reason it was chosen not to not be implemented, or if it's
>> simply that nobody has gotten around to it - it seems to be a relatively
>> common feature someone might want.
>> 
>> Anyway, please let me know if this is something that would be accepted,
>> or if anyone has any comments or suggestions.
>
> I think the reason it hasn't been implemented is that nobody's gotten
> around to it yet.  I certainly would find this useful and have wanted
> the same thing myself, so I can't see a reason why the right series
> wouldn't be accepted.

I tend to agree that nobody felt the need strongly enough.  Code
tends to accumulate without ever getting removed, and removal of a
file, removal of a directory, or removal of a submodule is a much
rarer event compared to other changes people would need to make.
Adding such a feature would have been much more work for those who
faced such a rare occasion to want to use it than just doing it by
hand and committing the result.

I'd imagine that the happy-case implementation should be fairly
straight-forward.  You would:

 - ensure that the submodule is "absorbed" already;

 - run "git rm -f" the submodule to remove the gitlink from the index
   and remove the directory from the working tree; and

 - remove the .gitmodules entry for the submodule.

and you'd leave the final "record the state of the index as a
commit" to the user, simply because the user would want to have
other changes related to the removal of the submodule in the same
commit (like changes to files in the superproject that refer to the
submodule contents or removal of other submodules).

The hard part is unhappy-cases.  There are too many things that can
go wrong and you need to handle all the error cases correctly so
that you do not leave the user's repository in an uncontrollably
messy state.

Thanks.
