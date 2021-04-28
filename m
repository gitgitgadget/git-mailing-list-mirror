Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9A5C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28E6601FC
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbhD1HOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 03:14:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56680 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbhD1HOA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 03:14:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BAAEC96EB;
        Wed, 28 Apr 2021 03:13:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cSRzXrwtK6J8NfK+39aQggETquNsBo7qhnCXEI
        9DC/4=; b=k48mZjUf/pktM5zed3wIj3nbAec1x4zHrD1SmEf6nGA9TeOFbwAIPr
        8zxGxj0nb9YxRJ64P42SZE2cSq20Yz/AyVm/g915nD/2yA1nwgoGjT7f5o8knw9r
        mZq/3dWQEi0uuOp3kTlkaKLzSghVquHDCyJISAcMY6gK9p0EkUebw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 134E6C96EA;
        Wed, 28 Apr 2021 03:13:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96E87C96E9;
        Wed, 28 Apr 2021 03:13:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Faith <jeremy.faith@jci.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug:git-check-ignore exit status is wrong for negative patterns
 when -v option used
References: <CY4P132MB00885C970ACF5A277F06E40385419@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
Date:   Wed, 28 Apr 2021 16:13:14 +0900
In-Reply-To: <CY4P132MB00885C970ACF5A277F06E40385419@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
        (Jeremy Faith's message of "Tue, 27 Apr 2021 16:30:13 +0000")
Message-ID: <xmqqfszac25x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3367D9D2-A7F1-11EB-8F4F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Faith <jeremy.faith@jci.com> writes:

> git version 2.31.1.362.g311531c9de
> git-check-ignore 
> When a negative pattern is the last .gitignore match the -v option causes the exit status to be 0 rather than the expected 1.
> e.g say .gitignore contains  one line: !hello
> git check-ignore hello #outputs nothing
> echo $?  #shows correct exit status=1 i.e None of the provided paths are ignored.
> but
> git check-ignore -v hello #output is next line
> .gitignore:4:!hello	hello
> echo $?  #shows wrong exit status=0 i.e. One or more of the provided paths is ignored

Hmph.  This is kind of understandable given the history of the
command, which was *not* about programatically ask "is this path
ignored?" question at all.  Instead, it was invented to answer this
question: I am puzzled by the fact that Git considers this path is
to be ignored (or "not to be ignored").  Show me which entry in what
exclude file made the final decision to ignore (or "not to ignore")
it to help me debug my ignore file(s).

And the exit code was to signal "yes, I found a relevant entry",
which made sense for the tool's nature as a debugging aid.

So, I suspect that this is working as designed/intended.  I agree
that it is debatable that the way it was designed to work is a good
one, though.

