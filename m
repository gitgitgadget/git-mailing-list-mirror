Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C94C6379D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FF36115B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376672AbhGSW0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:26:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53937 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359278AbhGSVnF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 17:43:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2684AE05BE;
        Mon, 19 Jul 2021 18:23:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J3Qjg6Vi+fj2B3xfApRQ9p8SHqNowfDIlzxJt6
        tdluM=; b=ydyQMtJiCcdY/AnXWSnhmlrXUCkCY+nZWA6rBDHojoVEw94uoB3CbK
        A7TWFmO+gOfVsuoUsqjhAonV0QT1i/cilmNWnKO/jWl16T5sQwpt5TLn0Ma9TvJf
        OfErROBpqTxGzDuog0u9lN3gr1BG/TCGTCSy+XgV2k6dzk1JqQwQU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EB62E05BD;
        Mon, 19 Jul 2021 18:23:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 991B2E05BC;
        Mon, 19 Jul 2021 18:23:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Zhang <zhgdrx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: why "git rebase" searching the duplicate patches in <upstream
 branch> rather than in <new base branch>?
References: <CAJcwCMPU9EhRkqeei_LnYyTJRZUQgHCvomrBbW0Qn+Jp1yhQfQ@mail.gmail.com>
        <CAJcwCMPHFNHi5i=xRg=GAJL5HiUfKu_KUPwYwELofLLtOAK1bg@mail.gmail.com>
Date:   Mon, 19 Jul 2021 15:23:18 -0700
In-Reply-To: <CAJcwCMPHFNHi5i=xRg=GAJL5HiUfKu_KUPwYwELofLLtOAK1bg@mail.gmail.com>
        (Andy Zhang's message of "Tue, 20 Jul 2021 01:45:01 +0800")
Message-ID: <xmqqmtqij63t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB3584A4-E8DF-11EB-9693-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Zhang <zhgdrx@gmail.com> writes:

> why "git rebase" searching the duplicate patches in <upstream
> branch> rather than in <new base branch>?
>
> hi, all:
>
>  I am reading the help of "git rebase", it says:
>     "If the upstream branch already contains a change you have made
> (e.g., because you mailed a patch which was applied upstream), then
> that commit will be skipped. "
>
>  But, because we are applying commits to <new base branch> rather than
> to <upstream branch>, I really don't understand why we are searching
> the duplicate patches in <upstream branch> rather than in <new base
> branch>?

It is either a design bug or a documentation bug, or both ;-)

I do think it makes sense to skip commits from the branch we are
rebasing that have equivalent commits in the upstream, as it is
expected that upstream might have already applied/cherry-picked some
of the changes you are rebasing, and you do not want to use the same
change twice.

When we are transplanting a series of commits from an old base to
totally unrelated base using the --onto option, e.g. when replaying
the contents of 'topic' relative to 'next' down to 'master' in your
topology, however,

> Old tree is:
>
> o---o---o---o---o  master
>     \
>      o---o---o---o---o  next
>                       \
>                        o---o---o  topic

it is not necessarily obvious where to stop digging back at.  In the
above picture where 'master' and 'next' have ancestry relationship,
we could try to see if the three commits on 'topic' branch being
replayed match any of the commits in next..master range, but when
using the --onto option, there does not have to be any relationship
between the <upstream> and <new base> (they do not have to share a
root commit).  So from that point of view, it probably makes sense
to default to --no-reapply-cherry-picks when --onto is used, while
defaulting --reapply-cherry-picks when --onto is not used.


