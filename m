Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E980CC433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 23:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B05F761418
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 23:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhD2X2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 19:28:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57873 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD2X2S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 19:28:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D0A3D7024;
        Thu, 29 Apr 2021 19:27:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mA4dJdOpZxAp0OC9xDTn+JtPcFL8QnlrOLfw/S
        H541s=; b=YbyMcGg4DaWFQ9CiCzmJgB7Ir1ojW6GhQaHDeFi+WbN7mQtjpr/ODi
        Kcn4keF15XKj7vYZjr2TKt+ar0UGIDtSq9n1f/cLtch1kRTiK2saf6V8xQg+YE83
        xLM65u9cOkCtTd37ZcYU4CUBfVC5dMY7rjJ/BtMbwdKvUpjZv806o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D45ED7023;
        Thu, 29 Apr 2021 19:27:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A5D12D7020;
        Thu, 29 Apr 2021 19:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
Date:   Fri, 30 Apr 2021 08:27:29 +0900
In-Reply-To: <87im45clkp.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        29 Apr 2021 15:38:30 +0300")
Message-ID: <xmqqmttgfz8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77C19E54-A942-11EB-8959-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Yep, but --diff-merges=m doesn't imply -p either, though it does produce
> diff output without -p, for merge commits only.

I misspoke without thinking it through.  It is absolutely wrong for
the "-m" option (or "--diff-merges=m" for that matter) to imply
"-p".

$ git log --stat --summary

would show "diff", but the kind of "diff" requested is not a textual
patch but just diffstat and the summary of new/removed files, and
the "diff" is shown only for single-parent commits, and it omits
"diff" for merge commits.  Adding "-m" to this command line is *not*
a request to show the textual patch.  It is to ask "diff" to be
shown pairwise with each of the parent.

$ git log -m --stat --summary

It is probably OK to special case "-m" given alone without any other
option [*1*] that specifies what kind of "diff" is requested and
make it imply "-p".  But unconditionally flipping "-p" on only
because you saw "-m" (or "--diff-merges=m" for that matter) is just
wrong.


[Footnote]

*1* They are not limited to "-p", "--stat" and "--summary", but
you'd need to also pay attention to "--raw", "--name-only", etc.)
