Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B03EC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56832415A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sFd/nAk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505483AbgJUUlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:41:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56978 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439419AbgJUUlb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 16:41:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC5BF903C9;
        Wed, 21 Oct 2020 16:41:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q/BU3O+A5x+fDNmSUr15xf0BdK0=; b=sFd/nA
        k/L/l/tP6m5uqqInOY/zyfVRr3+SkJO/bdIt6bVgFfXRFXhfAj1echt9/WOym8HJ
        673m3JE7/D4LnPo4HpVewtjj+OJx+yfB5IFOfE4NwrmHgG0ogbxAuYsY5Ro/fKiy
        zycVS//Dw22iph8j1GYjqasLeAkJDZ7v2bPng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j8sB4RG5xtvFQDZMeLYPoQeORV768Wkj
        GnrHO6ddgMfk1ZNdoEZGSVw/24J+SwtzhCsh5QmK31KUMcX5NWOkcZf1KSIdDtaS
        9btHIMwlH7mx0VgxI7/iZgm63bV4SlMwx0lIgSBA0bL1Q3fA5+22+8zqeAmoxkrB
        D2PB41aRnQI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF3E1903C8;
        Wed, 21 Oct 2020 16:41:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6570F903C7;
        Wed, 21 Oct 2020 16:41:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] sequencer: allow metadata to be saved if using
 cherry-pick --no-commit
References: <20201021062430.2029566-1-eantoranz@gmail.com>
        <xmqqv9f37476.fsf@gitster.c.googlers.com>
Date:   Wed, 21 Oct 2020 13:41:28 -0700
In-Reply-To: <xmqqv9f37476.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 21 Oct 2020 12:46:05 -0700")
Message-ID: <xmqqa6wf71mv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBE35E8C-13DD-11EB-AD15-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Before dismissing the idea totally, let's see what potential use
> cases this change _could_ benefit, and see if there are already ways
> to satisfy these use cases without making this change.  For example,
> if the user wants to examine the result before actually "committing"
> to move the target branch forward with this change, keeping it an
> option to back out if the result of cherry-picking turns out to be
> bad, the "--no-commit first, examine, and --continue or --abort"
> sequence may help such a workflow.
>
> But the user can already do so without this change:
>
>     $ git checkout target_branch^0 ;#detach
>     $ git cherry-pick source_branch
>     ... examine the result ...
>     ... and if it is satisfactory ...
>     $ git checkout -B target_branch
>     ... or if it is not, then discard ...
>     $ git checkout target_branch
>
>> With this patch, we allow sequencer to save the metadata from the original
>> cherry-pick operation so that 'git cherry-pick --continue' can be called.

And if the user wants to do the inspection while on the target
branch, "commit -c/-C" is the perfect choice.

    $ git cherry-pick --no-commit source_branch
    ... examine the result ...
    ... and if it is satisfactory ...
    $ git commit -c source_branch
    ... or if it is not, then discard ...
    $ git reset --hard

