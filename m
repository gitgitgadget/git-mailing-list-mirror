Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3C5C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B8064F67
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbhCDU1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:27:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58611 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbhCDU1U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:27:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CEB0118952;
        Thu,  4 Mar 2021 15:26:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LuRbtYv3sNIPLbOjx7xFCyE8jro=; b=YEs8Ge
        6/V8ukaAWr/BGbPko0Vp9byOhBu0RmCHR2/Kjs99G68vZq9R4O8DqKULpH9VpOY9
        6lLzyGwteeWmV2F3n+qvNMGgSIWPeCZ3A5Wbx8YnrXe6HYu3khnktvoEM43TBYDO
        +pihp7ICJkHxKTeCbR6Ui1ywR/JGozUioO6dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GgiSudWcGfgWW7OKWOfq5MvgJJ/Z0GkO
        tdc0bJRRqLwSM6er4okKZBhi8BUrY7brLEQ/1b9/vSreXfNlaEu9GF5LfGQbhPjl
        wGwZzKNgOcBsiyXi+t04umWV4DoqWA3vhSEO7BRsW+oAARr1RxDZlm5fHSQmf3Kl
        V1x2mmQJRGA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 14E81118951;
        Thu,  4 Mar 2021 15:26:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 574A8118950;
        Thu,  4 Mar 2021 15:26:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1?= =?utf-8?Q?bor?= 
        <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 01/12] pkt-line: eliminate the need for static buffer
 in packet_write_gently()
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <2d6858b1625aa3c96688c6c6a9157c2d2b16f43e.1613598529.git.gitgitgadget@gmail.com>
        <YDihb2Kspbh4FIlW@coredump.intra.peff.net>
        <9304ac66-f493-2150-95e3-15303c914ee3@jeffhostetler.com>
        <xmqq1rcwjacv.fsf@gitster.c.googlers.com>
        <85cd4d20-f68d-ef1d-c95b-f34f61f906b1@jeffhostetler.com>
Date:   Thu, 04 Mar 2021 12:26:35 -0800
In-Reply-To: <85cd4d20-f68d-ef1d-c95b-f34f61f906b1@jeffhostetler.com> (Jeff
        Hostetler's message of "Thu, 4 Mar 2021 08:29:27 -0500")
Message-ID: <xmqqim66ekck.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB88D088-7D27-11EB-8B0C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 3/3/21 2:38 PM, Junio C Hamano wrote:
>
>> I agree with both of you that the code is unnice in its stack usage
>> and we want fix with malloc(), or something like that, but sorry, I
>> think I merged this round by mistake to 'next'.
>> As we won't be merging the topic to the upcoming release anyway, I
>> am willing to revert the merge to 'next' and requeue an updated one,
>> when it appears (I am also OK to see an incremental update, "oops,
>> no, we realize we don't want to have it on the stack" fix-up, if
>> this is the only glitch in the series that need to be fixed).
>
> I'm preparing a follow-on patch series to address Peff's comments
> from Friday/Monday and yours from yesterday.  I thought I'd send
> it as a set of new changes to sit on top of what we have in "next"
> if that would make things easier for you.

Yeah, that is OK, too.  Sorry for the mistake of merging it too
early.

