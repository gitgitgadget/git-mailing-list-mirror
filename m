Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDD5C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4806144E
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhGHPOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:14:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50714 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHPOw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 11:14:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9679113D1F2;
        Thu,  8 Jul 2021 11:12:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nkME8vH8C+MabqUQS8ADxKuRJPvFiTXGiXtBPQ
        EqtiA=; b=jm65lz8TnDhuIZoLXGRSdTMzk0MaVIM1fdtCxlN3+kDUSt/l0yChlf
        uOZJJZOll/jbfekucxi0aokGwFYsaiV2hwT6tHIDGsowbPKQjdjiLRYcRoIJMfRE
        l24JTVotTqmA1JFat7OkwAfdffrYGnVfB0/p0n2IKhk0ON1m9sZPM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E5D613D1F1;
        Thu,  8 Jul 2021 11:12:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2EEB13D1F0;
        Thu,  8 Jul 2021 11:12:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH resend] help: convert git_cmd to page in one place
References: <20210626163219.4137317-1-rybak.a.v@gmail.com>
        <20210704153912.2742106-1-rybak.a.v@gmail.com>
        <87tul9706u.fsf@evledraar.gmail.com> <xmqqfswri4o6.fsf@gitster.g>
        <93578e5a-c09b-14c2-8f87-eb354f4b576c@gmail.com>
Date:   Thu, 08 Jul 2021 08:12:05 -0700
In-Reply-To: <93578e5a-c09b-14c2-8f87-eb354f4b576c@gmail.com> (Andrei Rybak's
        message of "Thu, 8 Jul 2021 10:07:31 +0200")
Message-ID: <xmqqsg0oc01m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC7D3A72-DFFE-11EB-A82A-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Is reusing "argv[0]" one more time instead of introducing the variable
> "page" is a good idea? It could either be:
>
> 	argv[0] = cmd_to_page(check_git_cmd(argv[0]));
>
> or
>
> 	argv[0] = check_git_cmd(argv[0]);
> 	argv[0] = cmd_to_page(argv[0]);
>
> That way, the quoted hunk above (touching calls to show_*_page) wouldn't
> be in the patch.

It is a bad idea.  It gives readers a false impression that there
are users of information other than show_$fmt_page() functions that
do not want the original argv[0] but the variant massaged by the
cmd_to_page() function later in the code after these functions
return, and more importantly, it would make it impossible to recover
the original value of argv[0] if the code later wants to.

To be perfectly honest, I do not see much value in the patch being
discussed (I am not saying "I see no value"---just "not much")
[*1*].  The patch under discussion may not be making things worse,
but overwriting argv[0] WILL make it worse than the current code, I
would think.


[Footnote]

*1* This is because I see nothing wrong in the original code before
    applying this patch.  How the manual pages are named after the
    actual command name may happen to be the same across all three
    show_$fmt_page() backends (and that is why they happen to all
    call cmd_to_page() helper function), but there is no strong
    reason why that has to stay that way.  E.g. "man git-cat-file"
    is used by the man backend only because cmd_to_page() yields one
    'git-cat-file' string, but "man 1 git-cat-file" would equally be
    a good way to drive the "man" viewer.  Other format backends may
    not have good use for the section information---it is more
    natural to allow each of show_$fmt_page() to use their own way
    to derive where the documentation is found for each command.
