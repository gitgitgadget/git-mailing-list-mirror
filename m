Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284231F454
	for <e@80x24.org>; Wed,  6 Nov 2019 10:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfKFKQ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 05:16:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52199 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfKFKQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 05:16:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3B5627136;
        Wed,  6 Nov 2019 05:16:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rQNwtL/WKpo78+0MLVCxoEuqzBs=; b=UzaohG
        URdeRMzgYsq2HaYQGZog65CEVpVIm1z+MPQ6BEMqxVuWAowNGqX+Jd4+NZ3HCMTQ
        rk47mZ/ke3xa/ZuBVK7jhVN+kZ7MInmPa0o+AxcGEoAYtWYhmvcFQnQ0oiDQFXSX
        ELUVZiIJ6uOuLb+CuDV2DS1lWzLhGr9hbsPn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hEyfW1rkeqRoAhtBBlPIpjXGi3ufInYw
        z/8eEyG8cR6ebwDq/ZBnlZZaHBOyzIFvEFrE8KZW4+8CVMIy7o1vWX6qgk9uefyy
        BfB4VyyB4lrPsNVjYinSfzh+LrrZXUDQK6Ctkscd76qIUlEvqLauRnnXFyZO2iEB
        i9IuTS9bzSg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB49F27135;
        Wed,  6 Nov 2019 05:16:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DD8127134;
        Wed,  6 Nov 2019 05:16:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Utsav Shah <ukshah2@illinois.edu>
Subject: Re: [PATCH v3 0/1] unpack-trees: skip stat on fsmonitor-valid files
References: <pull.424.v2.git.1572967644.gitgitgadget@gmail.com>
        <pull.424.v3.git.1573016055.gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 19:16:22 +0900
In-Reply-To: <pull.424.v3.git.1573016055.gitgitgadget@gmail.com> (Utsav Shah
        via GitGitGadget's message of "Wed, 06 Nov 2019 04:54:14 +0000")
Message-ID: <xmqqk18dtimh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BF8C646-007E-11EA-94D2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The index might be aware that a file hasn't modified via fsmonitor, but
> unpack-trees did not pay attention to it and checked via ie_match_stat which
> can be inefficient on certain filesystems. This significantly slows down
> commands that run oneway_merge, like checkout and reset --hard.
>
> This patch makes oneway_merge check whether a file is considered unchanged
> through fsmonitor and skips ie_match_stat on it. unpack-trees also now
> correctly copies over fsmonitor validity state from the source index.
> Finally, for correctness, we force a refresh of fsmonitor state in
> tweak_fsmonitor.
>
> After this change, commands like stash (that use reset --hard internally) go
> from 8s or more to ~2s on a 250k file repository on a mac.

If the above is verbatim copy of what you wrote in 1/1, that is very
much unappreciated X-<.  A cover letter for a topic serves primarily
just one purpose:

   It is a good place to present a birds-eye-view of a multi-patch
   topic; a high level description of the problem (e.g. how the
   issue manifests to the end users), an explanation of division of
   the problem into subproblems you made (if applicable), and
   interesting highlights of the solution would all be good things
   to have in there.

And as a topic goes through iterations, it gives you a good place to
summarize what changed since the previously reviewed iterations.  It
could be just a single liner "addressed all the review comments for
the previous iteration".  A well-written multi-patch topic also uses
the same after-three-dash technique used for a single-patch topic
(see below) to summarize what changed since the corresponding patch
in the series in the previous iteration (or just says "no changes
since the previous round"---that helps the reviewers a lot).
   
For a single-patch topic, there is no place for "here is an overall
birds-eyes-view picture because the changes described in the
proposed log message of individual patches are so big and complex".
A single-patch topic has one patch, that solves one problem and only
that problem well.  When you want to summarize the changes since the
previous iteration, you would write it between the three-dash-line
(which appears after your sign-off) and the diffstat.

Thanks.
