Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29916C433E9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32FE65171
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhCDB2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:28:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60381 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhCDB2V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 20:28:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1078BF4B3;
        Wed,  3 Mar 2021 20:27:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QK9Qp3qgSw5xnF7gAQ1msFPwka0=; b=mPfibG
        lz+0prcpzOjcL9rmLqr1FM3gdcLt7UKp8MPSMijyjCvpeniKMk3RzG7uKpLxmenM
        hhFDE63WkyHAVMtbizqi6CUBR9AAoZU6/8WX8CGC46ngzs7CeN5wwbbSlqaGwF1/
        4GRGhFdGYr7dOMzkGirDzAmmZX1V//fhcm2mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xRqdi/C1Rse/VXRzx9saBfB11jtor86B
        HijjXmnLf1lAhKj6LnweMtDVj2UdsIh3BcYrWYCWYCbtsXvKin5d9G/uWk46tmor
        viDpULlSVDiictTL/uy21M7PrFEouLMmDwsr5qACNPsUIXJw4W9moFn+2WbLQU98
        QQZ1APEGpPw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C983BBF4B2;
        Wed,  3 Mar 2021 20:27:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34B1FBF4B1;
        Wed,  3 Mar 2021 20:27:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Josh Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Hunt <joshua.hunt@berkeley.edu>,
        Josh Hunt <johunt@akamai.com>
Subject: Re: [PATCH] branch: return error when --list finds no matches
References: <pull.892.git.1614793491538.gitgitgadget@gmail.com>
Date:   Wed, 03 Mar 2021 17:27:38 -0800
In-Reply-To: <pull.892.git.1614793491538.gitgitgadget@gmail.com> (Josh Hunt
        via GitGitGadget's message of "Wed, 03 Mar 2021 17:44:51 +0000")
Message-ID: <xmqqr1kvemid.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CED4680C-7C88-11EB-90BB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Josh Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Josh Hunt <johunt@akamai.com>
>
> Currently git branch --list foo always returns an exit status of 0 even
> when the branch being searched for does not exist. Now an error is printed
> and returns a non-zero exit status.

Explaining what happens in the current code upfront is a good thing
and is in line with the convention used in our project, which is
good.  But drop "currently" from there.

Strictly speaking, it is not "always".  In a corrupt repository, it
is likely to show a proper error message and die.

Also explaining what you want to happen before the end of the log
message is good.

But the proposed log message lacks why it is a good idea to make
such a change, which is the most important part.

If you ask me, I would say that the command was asked to show any
branches, if exist, that match the given pattern, and did what it
was asked to do without encountering any error---it just happened to
have seen 0 branch that matched.  So I think returning non-zero
status would be a bug.

Thanks.



