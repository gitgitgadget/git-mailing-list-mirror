Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E89FC433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 22:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiI2W0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 18:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiI2W0J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 18:26:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A07B121E6F
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 15:26:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C20641B4529;
        Thu, 29 Sep 2022 18:26:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yHBYJkRiAQ/e
        1emRE7jUtf96R2Zd9grt0XFVfzSNFJA=; b=b1uWaFLlK0PnXDROBs17YlAE0WH8
        056hyYIvp6eMdAGlSOXyoAwzJWctwl/ALDWtef4HkBcc7amztxgTqdVtepuPJzIZ
        c0O+I2HJTAFpT/odGoSSW2fUs9hlz0aNrbrUrmjl2em7RFppQZtuhcxnheN47ItF
        XnZ9i6CfXJuYdBk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB8B11B4527;
        Thu, 29 Sep 2022 18:26:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 71CF71B4525;
        Thu, 29 Sep 2022 18:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: do not fail a no-op --edit-desc
References: <xmqqczbftina.fsf@gitster.g>
        <ba8a503b-76e2-5de9-1082-3b4c6ecd0cc3@gmail.com>
Date:   Thu, 29 Sep 2022 15:26:01 -0700
In-Reply-To: <ba8a503b-76e2-5de9-1082-3b4c6ecd0cc3@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Thu, 29 Sep 2022 23:49:50 +0200")
Message-ID: <xmqq7d1lom12.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B3618E06-4045-11ED-B16D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Let me try again, I think my review was not good :-)
>
> On 28/9/22 21:15, Junio C Hamano wrote:
>> In a repository on a branch without branch description, try running
>
> It is a bit confusing the construction "a repository on a branch
> without branch description" as "branch" have "repository" inherent.
> So "On a branch without description.." holds the same meaning with less
> distracting words.

Ah, no, I did not mean a repository is on any branch.  I meant

    Go into a repository and be on a branch.  That branch has to be
    without branch description set.  Now, try running these...

I think the easiest clarification is to drop "In a repository"
altogether.

> But.. do we want to implement this this way? Maybe we will have to
> implement on purpose this feature in some future refactorization?

Absolutely.  It is simpler and there is not much downside.

> And.. the message does not make it clear the situation: if there is
> a previous description, will clear; if not, will keep.

If there is a previous description, then we use the behaviour we
have had for ages (i.e. will remove).  If there is not a previous
description, then we use the new behaviour (i.e. not attempt to
remove and hence we do not show an error).  Either way, the end
result is "the user indicated they do not want description by giving
us an empty edit result.  After the command exits, the branch has no
description". =20

> If we want that feature, should we test for it? (do not take
> the snippet as tested...):

Notice the air-quotes around "feature" ;-)=20

The official stance is "if it hurts, do not do it then".  The side
discussion about TOCTOU was to see how much hurt we are making the
user responsible for, and explaining that it is not that much.
