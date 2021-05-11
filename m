Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E042C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 05:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E1461430
	for <git@archiver.kernel.org>; Tue, 11 May 2021 05:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhEKFY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 01:24:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52268 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhEKFY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 01:24:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BAB621379BF;
        Tue, 11 May 2021 01:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PjqdF7LjXKkxAZ/mZbdHQakUHqRbgLxttm26lv
        b6788=; b=lDpuFWEZJhhiGYKMNDjOSVe79ItYCiVDDFOe7IpyHpwCo91YXpFPWD
        nDcTygLxvPWmbfdQpnaV9wOFPBrskf9lFgYPoEJ9/ZXSSfUhVWUCCtiBQ3GQTCMB
        k05kG8KwJ9cKW6QQcYtrbP5emDvkRX780+EjjvMGhlJRMDy1vcq+g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A67C41379BE;
        Tue, 11 May 2021 01:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE2DF1379BD;
        Tue, 11 May 2021 01:23:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/6] diff-merges: move specific diff-index "-m" handling
 to diff-index
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-3-sorganov@gmail.com>
        <xmqqwns5oqrm.fsf@gitster.g>
Date:   Tue, 11 May 2021 14:23:46 +0900
In-Reply-To: <xmqqwns5oqrm.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        11 May 2021 13:09:33 +0900")
Message-ID: <xmqqfsytonbx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1013EE80-B219-11EB-A65E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This change is risky, as the loop below (which this patch moves to
> parse_distinct_options()) has no knowledge of other options that
> setup_revisions() helper is prepared to handle and that takes an
> argument.  When parsing "git cmd --opt --cached A", setup_revisions()
> may know that --opt takes an argument and eat both (i.e. the
> "--cached" is not an option but an arg given to "--opt"), but the
> new parse_distinct_options() helper does not; it will happily skip
> "--opt" and leave it in, mistake "--cached" as an option and remove,
> and instead make "A" the arg given to "--opt".

The above is not theoretical.  The series breaks

    $ git checkout master
    $ git diff-index -S --cached maint

IOW, what I predicted in the previous message with s/--opt/-S/
happens with this step.

> Picking up the remnant _after_ setup_revisions() ate what it
> understands would not have such a downside, as long as none of our
> "distinct options" take any argument.
>
> Can't we make "-m means something special for diff-index" without
> butchering the command line processing in this step?  diff-index
> does not care about --diff-merges, so letting setup_revisions()
> remember only the fact that "-m" was given while parsing, and then
> postprocess what "-m" means depending on the command (i.e. everybody
> else would treat it as a short-hand for "--diff-merges=m" plus "we
> need some form of diff output, while allowing "diff-index" to treat
> it differently) should not be rocket science.
>
> Thanks.
