Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181BEC433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiDNRNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344575AbiDNRNV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 13:13:21 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E900EDF44
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 10:04:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56C5D10DB89;
        Thu, 14 Apr 2022 13:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ctro5lm4wlmq
        vd05bgp7L4xYzSIbeD+BDzixrbY5Clo=; b=FcOAnQ0FJBRKVnohIYRRDQSM6qYv
        gCrhfzmjspoxixHsraiWVxqyTWIEFHPQyx6oUcPbekKq5rMExpF9VJpJ5aK67CCO
        OlbTOCxOeBDE4akdcjXSlAvcMymKFB/n4Ua80vRmaYlbRciZYpjtprCdTqZsNhdW
        g+GXcqkW744QYwc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E2DC10DB88;
        Thu, 14 Apr 2022 13:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0CAA10DB87;
        Thu, 14 Apr 2022 13:04:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] http API: fix dangling pointer issue noted by GCC 12.0
References: <patch-v2-1.1-777838267a5-20220225T090816Z-avarab@gmail.com>
        <patch-v3-1.1-69190804c67-20220325T143322Z-avarab@gmail.com>
        <Yj4FwuyEW0b5ImEC@nand.local> <xmqqy20x7eqv.fsf@gitster.g>
        <220414.86h76vd69t.gmgdl@evledraar.gmail.com>
Date:   Thu, 14 Apr 2022 10:04:27 -0700
In-Reply-To: <220414.86h76vd69t.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 14 Apr 2022 17:27:30 +0200")
Message-ID: <xmqqo8131tr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F1FB4CCA-BC14-11EC-A149-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Having spelunked in the GCC docs, source, commits involved & in their
> bugtracker I don't think they'd consider this broken. It's working as
> designed.
>
> Now, of course as with any new compiler warning you might argue that
> it's too overzealous, but in this case it's included it a -Wall in GCC
> 12.0.

Whatever.  I do not care if this is a broken or wai from GCC's point
of view.

I care more about the correct operation of the production code of
ours, than a workaround to squelch a warning, overzealous or not, by
a compiler, and if it is not clear that the workaround is obviously
free of negative side effect, we do not want to deliberately introduce
potential breakage in our code base just for that.

And I still do not see how it is safe to unconditionally clearing
the pointer in the slot instance to NULL.  It was asked late January
in https://lore.kernel.org/git/xmqqv8y52g3a.fsf@gitster.g/

In other words, what we should have been spelunking is *not* in the
GCC docs and code, but the http codepath in our code that depends on
the slot not being cleared when we didn't set up the pointer in the
current recursion of that function.  With a clear description on how
this change is safe, with a clear understanding on why the pointer
member "finished" was added in the first place to avoid the same
mistake as an earlier round of this patch [*1*], it would become an
acceptable patch, with or without GCC warning.

Namely, the finding in this part of a review comment [*2*]

    The only way the separation could make a difference is while
    step_active_slots(), the current slot is completed, our local
    "finished" gets marked as such thanks to the pointer-ness of the
    finished member, and then another pending request is started
    reusing the same slot object (properly initialized for that new
    request).  In such a case, the while loop we want to see exit
    will see that slot->in_use member is _still_ true, even though
    it is true only because it is now about a separate and unrelated
    request that is still waiting for completion, and the original
    request the caller is waiting for has already finished.

that was made to explain why the pointer member is there, and a
possible case that the code before the introduction of the pointer
would misbehave and today's code would behave better, worries me the
most, as unconditionally assigning NULL there like this patch does
without any guard would mean that we are breaking the code exactly
in such a case, I would think.

In short, I do not care who takes the credit, I care more about the
correctness of the code than a warning by a version of a compiler, I
do not care at all if the compiler writers considers the warning a
bug, and I worry that the change proposed, while it may certainly
squelch the bug, may break the code that has been working happily,
and I haven't seen a clear explanation why it is not the case.

As long as the same slot is never passed to run_active_slot()
recursively, clearing the member unconditionally when the control
leaves the function should not break the code.  Nobody seems to have
explained how it is the case.


[References]

*1* https://lore.kernel.org/git/patch-1.1-1cec367e805-20220126T212921Z-av=
arab@gmail.com/
*2* https://lore.kernel.org/git/xmqqczkengsg.fsf@gitster.g/
