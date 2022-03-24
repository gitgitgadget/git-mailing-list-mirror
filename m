Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845C4C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 17:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350416AbiCXRkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiCXRkp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 13:40:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE00075E5B
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:39:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B94F71038DD;
        Thu, 24 Mar 2022 13:39:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=N+lTVeGLrGQh
        xyawo1FnxSO8kqiC3SJDg88Oh95wTWg=; b=kf7yo2yN++XOCwXz3kPFdMTjVFfY
        gWio8SNhKyJ+5+FfAaJPTEjfzGI+6WLx2XXRglcA0D7sg9xv4YLQaLSUnD+iPfg3
        P+TdvDWeCzKa/HPgxBOPcBksGkbJ4lplZK4y0zV0HrBaB6kLrNtfnRAKaO852Uev
        XbZRSzwq3zdEOL0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF2301038DC;
        Thu, 24 Mar 2022 13:39:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17BF81038DB;
        Thu, 24 Mar 2022 13:39:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 08/27] revisions API users: use release_revisions()
 needing "{ 0 }" init
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-08.27-42ad1208934-20220323T203149Z-avarab@gmail.com>
        <xmqqy210kl3i.fsf@gitster.g>
        <220324.868rszmga6.gmgdl@evledraar.gmail.com>
Date:   Thu, 24 Mar 2022 10:39:09 -0700
In-Reply-To: <220324.868rszmga6.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 24 Mar 2022 18:04:34 +0100")
Message-ID: <xmqqwngji72a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5089346E-AB99-11EC-91D1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Mar 23 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Use release_revisions() to various users of "struct rev_list" which
>>> need to have their "struct rev_info" zero-initialized before we can
>>> start using it. In all of these cases we might "goto cleanup" (or equ=
ivalent),
>>
>> I didn't look at the bisect code, but the bundle one looks iffy from
>> the point of view of API cleanliness.  If we have not yet called
>> repo_init_revisions() on a revs, we should refrain from calling
>> release_revisions() on it in the first place, no?
>
> It could be avoided, but I'd really prefer not to for this series.
>
> repo_init_revisions() is a non-trivial function, and changing the
> various bits in this series that can easily have a "goto" pattern
> because we assume that { 0 }-init'd is safe to pass to
> release_revisions() would be a larger change...
>
> We assume that in a lot of other destructors throughout the codebase, I
> figured we could leave this for later.
>
> Is that OK with you?

Not really.  If you introduce "#define REV_INFO_INIT { 0 }",
perhaps, though.

Without such a mechanism to clearly say "here is what we initialize
a rev_info", the first call to repo_init_revisions() looks like the
place that initializes a rev_info, and call to release_revisions()
on a rev_info that did not go through repo_init_revisions() looks
like a call to free() of a pointer that hasn't been assigned the
result from an allocation from the heap.  That is where my "iffy
from the API cleanliness POV" comes from.

