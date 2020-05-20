Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45996C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0502B207C4
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G5rW1GS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgETOhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 10:37:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51851 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETOho (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 10:37:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 049CD5D55F;
        Wed, 20 May 2020 10:37:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IA+LsTxVoQiF7+7zfaIMELfwu5U=; b=G5rW1G
        S43KWEWgLgCXJjOgwEvonquRqsBh4Xi/By9JPtM2VG1ptzjMNp5Swwz8TfihawT9
        e27smsmceP15WqwicDzi/cIfCc6rgv5aXTwmjnvvzwHEd1yxS23Gb048lnxfGsev
        oUEHSBhVmWo0eWdptaeT2esTQywBXDLNPfns0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B/336wYIueHgbGYCBAAK/DGv1m/4MNjg
        PewUm2hA7jBrGsU3HRZnkTvSTtCKCWACxep7/HsGkZrECDh5/fSdEtgJatenuDTn
        JpdiOAZspPjD5fxgCF7LUq1M7+R5VJrsrYV0e0tYFefChrC8Bo9WgeBixHMozU1+
        D3TLxmwl57o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF5C15D55E;
        Wed, 20 May 2020 10:37:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D3075D55D;
        Wed, 20 May 2020 10:37:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        christian.couder@gmail.com, liu.denton@gmail.com,
        git@vger.kernel.org, congdanhqx@gmail.com
Subject: Re: [PATCH v2] submodule: port subcommand 'set-branch' from shell to C
References: <20200519182654.33318-1-shouryashukla.oo@gmail.com>
        <CAPig+cSKFBFdNXA52f5f0q3SetA2btmkXeqyHNw-qwJ5ECq5mQ@mail.gmail.com>
        <20200520121530.GA7992@konoha>
        <b96324d4-04bd-8f64-e334-d3613dc3be6f@gmail.com>
Date:   Wed, 20 May 2020 07:37:38 -0700
In-Reply-To: <b96324d4-04bd-8f64-e334-d3613dc3be6f@gmail.com> (Kaartic
        Sivaraam's message of "Wed, 20 May 2020 18:42:48 +0530")
Message-ID: <xmqqd06yy8nh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7485E290-9AA7-11EA-B0F1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Hi Shourya,
>
> On 20-05-2020 17:45, Shourya Shukla wrote:
>> On 19/05 02:57, Eric Sunshine wrote:
>>> On Tue, May 19, 2020 at 2:27 PM Shourya Shukla
>>> <shouryashukla.oo@gmail.com> wrote:
>>>> +       if (opt_branch && opt_default)
>>>> +               die(_("--branch and --default do not make sense together"));
>>>
>>> A more precise way to say this is:
>>>
>>>      die(_("--branch and --default are mutually exclusive"));
>>
>> Will that be clear to everyone? What I mean is maybe a person from a
>> non-mathematical background (someone doing programming as a hobby maybe)
>> will not grasp at this at one go and will have to search it's meaning
>> online. Isn't it fine as-is?
>>
>
> While "mutually exclusive" might be prominently used in mathematics. I
> don't think it is only understandable by people with a mathematical
> background.
>
> Moreover, I see 183 results in 36 files for "mutually exclusive" in
> git.git (including translation files). So, this isn't anything new.
>
> I agree with Eric's suggestion. It makes the error message concise
> which is a nice side benefit.

Sure.  

But "do not make sense together" is forcing the reader to infer the
implication "... hence cannot use at the same time", so it is one
step detached from what we really want them to know, while giving
half an explanation (it still invites "why don't they make sense
together?") so why not say that conclusion more directly?  i.e.
"... cannot be used together"?  Either way those who need to be told
more would ask "why can't I use them together?" anyway, so half an
explanation would not help all that much.


