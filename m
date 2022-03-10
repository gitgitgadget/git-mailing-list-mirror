Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10CCC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 01:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbiCJBMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiCJBMb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 20:12:31 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71D211B5EF
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 17:11:31 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8CA0125F50;
        Wed,  9 Mar 2022 20:11:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Q2UOg/xiCLNY
        jr19ELhAHlWPk9Aokew0nci6LWfrdsI=; b=gvVtcUXJZEd9AWPPjTT6gCBGUjVm
        7l1mjVGokVpGrZrYKiTTeoFvtDNwfgieZm/LGiI63p4cD+PjDAFLscOk/waRGuMS
        h4mO+pRk4TsQc+iCi6jGHeVmpUWgJ8OrgiolkCwKFh25ZVAlbFJIaAPx1Y94WgcW
        UKc82D04CLBbDsA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD843125F4F;
        Wed,  9 Mar 2022 20:11:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BDC7125F4E;
        Wed,  9 Mar 2022 20:11:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 05/24] revision.[ch]: provide and start using a
 release_revisions()
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <patch-05.24-b89dcadcc22-20220309T123321Z-avarab@gmail.com>
        <xmqqmthylonj.fsf@gitster.g>
        <220310.864k46lk7x.gmgdl@evledraar.gmail.com>
Date:   Wed, 09 Mar 2022 17:11:28 -0800
In-Reply-To: <220310.864k46lk7x.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 10 Mar 2022 01:28:04 +0100")
Message-ID: <xmqqee3aipbz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 03F9D03A-A00F-11EC-82C3-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> So I'd prefer to keep this part of the general structure as-is,
> i.e. even if we do nothing with "diffopt" *yet* we can assert ...

Please don't.

It will become hard to tell during the patch progression if "we can
do so even though we do not need to do so *yet*" is correct
(e.g. diffopt---which does not have a separate allocation to be
released), or if "pretending that the field is cleared by _release()
function is premature and will lead to a new leak" (e.g. if you lost
separate clearing of .prune_data at this step, that would be an
incorrect change because it does hold on to an allocated resource).
