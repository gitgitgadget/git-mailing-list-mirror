Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1179C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJTSFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJTSEe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:04:34 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1531E8B94
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:04:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C17A81CA128;
        Thu, 20 Oct 2022 14:03:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z0TaFX/p5FOomlgXyVMkyufaq0ZYMRUCRXGchy
        pzf6s=; b=RMOeKp2/F9zNH2f/1mQlu2u0nAcNS4yu3Y5lQzlKZdOl4HZw/0PDki
        9HYf7ObLXRt/dDGk7XGlwuBnZhd7sGxtvTY/xKdyhp0pZxDtHN1wky9WO6GJoK8J
        vUiyMFmCzv18jnewV631w1gmT6/ENDHy+KxMt77nj1an/ah/hboWQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A98591CA127;
        Thu, 20 Oct 2022 14:03:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB0541CA125;
        Thu, 20 Oct 2022 14:03:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Mat=C4=9Bj?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
Subject: Re: git-send-email with GPG signed commits?
References: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
        <Y1GJAart+/yFc5MR@coredump.intra.peff.net>
        <xmqqr0z2s7w4.fsf@gitster.g>
Date:   Thu, 20 Oct 2022 11:03:52 -0700
In-Reply-To: <xmqqr0z2s7w4.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        20 Oct 2022 10:48:59 -0700")
Message-ID: <xmqqk04us77b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F05D03C-50A1-11ED-A9EC-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I think you would need some kind of "author-sig" header that signs the
>> commit object bytes _without_ the commit header at all. And that assumes
>> the maintainer's workflow is to never modify a patch in transit, and to
>> apply it at the exact same spot that you wrote it (so that the parent
>> and tree ids remain the same).
>
> Doesn't it immediately break down once you send a 2-patch series?

Ah, if you did not mean "without the committer header", but "without
any of the header fields of the commit object", then it would
probably work.  But then that loses the context to apply the patch
completely, so I can apply a patch you author-signed to a place
where it wouldn't work and end up with a broken commit.  

Start from the original commit object, remove the committer, the
author, the tree, and the parent headers, add a parent-tree header
that records the tree object of the first parent, and call that a
"modified commit object".  Then compute the signature over it and
the patch text.  The e-mailed patch now needs to carry the value of
the parent-tree header and the signature.

At the receiving end, the reverse operation can be done and the
resulting commit may have two new headers (author-sig and
parent-tree).  In the resulting commit, parent-tree does not have to
match the tree of its first parent, if the integrator chose to apply
it on a different commit, and as long as the patch text matches,
things should verify.

So, some kind of "author-sig" is certainly possible, but is it
practically useful?  I am not sure.  It still does not even allow
typofixes on the receiving end.

