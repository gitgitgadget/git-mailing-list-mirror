Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E9C1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 16:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfHOQyz (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 12:54:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52399 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbfHOQyy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 12:54:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE8A985357;
        Thu, 15 Aug 2019 12:54:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fm6cNEdEzj8Z
        idp6DmzexR2G1sw=; b=kxBotKI7SnXSdglyCzVr+IfV4sVVEW5eh2vWdexdi4J1
        PINTKoXjWe7gt75s/K+iP3SEGkPzsjm56oX9MVK1p3z7o6BdOWm3j1WnIHDedcCJ
        1p5OidytHVnXZhm3qjN0sy46h4Ffdd+5hm5tqNxZUGYSluSVi57wY0PS61sOcQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mLeP7V
        24+NWeG99TrBnVeT0Z08ioODiWln+17nWBaQRP5UIoIfF/0ICd1dF4NSh3LtNzqF
        3ffcXfYeeZB2aw1ECSjmhhe/T3mLDvwPXpYGp5y6/+xzJjuzFL12U0DRN1AlTbTc
        1WweXbOBzaIUL3im1rF23DztNo1fjtcWWXEEY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6EB585356;
        Thu, 15 Aug 2019 12:54:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C139585355;
        Thu, 15 Aug 2019 12:54:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: minor interactive rebase regression: HEAD points to wrong commit while rewording
References: <20190812175046.GM20404@szeder.dev>
        <2a7d69a9-cb3e-eb84-188f-5713876f6d78@gmail.com>
        <20190814212036.GQ20404@szeder.dev>
        <026d6615-3420-eb31-8c93-a6245f3be503@gmail.com>
        <xmqqpnl64c94.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 15 Aug 2019 09:54:44 -0700
In-Reply-To: <xmqqpnl64c94.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 15 Aug 2019 09:36:07 -0700")
Message-ID: <xmqqlfvu4be3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6339C926-BF7D-11E9-8B13-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> On 14/08/2019 22:20, SZEDER G=C3=A1bor wrote:
>>
>> I changed the sequencer to always commit the cherry-pick and then run
>> 'git commit --amend' for rewords [1]. Running
>>
>> 	time env GIT_EDITOR=3Dtrue GIT_SEQUENCE_EDITOR=3D'sed -i
>> s/pick/reword/' ../bin-wrappers/git rebase -i --root
>>
>> over 100 commits I cannot see any real difference in the timings
>> between master and that branch. Any difference is within the variation
>> of the times of multiple runs. The change also fixes a bug when
>> rewording a re-arranged root commit.
>
> I guess that settles the "efficiency" story; besides, showing a
> wrong intermediate state to users and scripts efficiently is just as
> bad as showing a wrong state less efficiently.

Needless to say, there is no need for us to make things less
efficient when we do not need to.  If there are two back-to-back
"pick"s, and there is no hook and the like that gives an end-user
and/or a script a reliable trigger point that can be used to
"observe" and "utilize" the state immediately after the first
"pick", we do not have to update the HEAD (or update the working
tree for that matter) between these two "pick"s.

The external process being able to observe alone is not an enough
reason to force us go inefficient here---if the triggering event is
like "spawn an editor and wait for it to exit", that gives the
external process to not just "observe" the updated state after the
first pick, but also "utilize" that state (e.g. build, compare with
some other tree, etc.) knowing that the second "pick" does not start
changing the state until it relinquishes the control.

But unless the external process can reliably utilize the updated
state, it is of not much use to just be able to notice the change.
For example, an argument like "constantly monitoring changes in the
$GIT_DIR/rebase-merge directory, we can notice that each 'pick' gets
done" is not a reason to force us to update HEAD every time any
instruction is consumed in the todo file, as the next "pick" cannot
be reliably delayed by somebody who is merely observing the
directory to utilize the updated state.


