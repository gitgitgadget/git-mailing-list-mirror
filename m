Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAB5C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 21:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244269AbhKXVYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 16:24:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64688 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhKXVYM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 16:24:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 07E13167461;
        Wed, 24 Nov 2021 16:21:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0vsBZHqFf/amMM0VwZ1Hgf3+KLL34eNnBn8UtA
        7NvOQ=; b=r5G4VXAUNORUGELnxaZMxrV38F60S8nSHwGi34dT+c+Q9nZTpkU5sL
        24QA6opVVJWouGtO5o0VfjBSmJWS/DSgLUYMrubneQ8FhW7kiMmWxcgmbegST/DG
        /iLgHjInHmzc7wEMO7FXP+D0R29V0ZvUSofidVUtq7BLoW3p7jYkY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3CB4167460;
        Wed, 24 Nov 2021 16:21:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E99D16745C;
        Wed, 24 Nov 2021 16:20:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin von Zweigbergk <martinvonz@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Letting tools partially resolve conflicts in a file
References: <CANiSa6iNpm6--qHpUFYhPfSi+ounGttA8=TAsep18A-=iyoFEQ@mail.gmail.com>
Date:   Wed, 24 Nov 2021 13:20:58 -0800
In-Reply-To: <CANiSa6iNpm6--qHpUFYhPfSi+ounGttA8=TAsep18A-=iyoFEQ@mail.gmail.com>
        (Martin von Zweigbergk's message of "Wed, 24 Nov 2021 08:31:19 -0800")
Message-ID: <xmqqmtltz1vp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B5289FC-4D6C-11EC-BFCA-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> I've searched the list and not found anything about this topic, but I
> figured I'd ask to be sure. The question is not specific to Git, but
> this seems like a forum where it might have been brought up.
>
> You could imagine having a merge tool that was specialized for some
> purpose and only able to resolve a particular kind of conflict. An
> example would be a tool that resolves conflicts in `#include` lines or
> `import` lines. It could be useful to have such tools run as part of a
> chain of merge tools, where the final merge tool is what users
> normally have configured (such as `meld`, or the internal "attempt
> merge, or leave conflict markers" tool).
>
> Has this problem come up before?

I do not recall seeing such a topic, but I am not sure how practical
your idea is to implement from the Git side.

As a zeroth order approximation, instead of such a half-auto-merge
tool, while resolving a conflicted merge with two conflicted hunks
in a file, if you hand edit one conflicted hunk and then run "git
mergetool", is your "half resolution by hand" seen by the mergetool
backend correctly?

I tried to follow from git-mergetool.sh::main() what happens.  Each
path is given to merge_file() helper function, and three temporary
files, $BASE, $LOCAL, and $REMOTE, are prepared from the blob object
registered in the index at stages #1, #2 and #3.  A mergetool
backend, e.g. mergetools/meld, looks at these three files in its
merge_cmd() function.

Notice that the contents in the working tree file after a conflicted
auto-merge does not even get looked at by the mergetool backend in
the above picture?  I am not sure if replacing the contents of LOCAL
with your half-resolved contents would give us the behaviour you
want.  If it were the case, perhaps vanilla "git mergetools" would
have fed the current file in the working tree, which was half
resolved by "git merge" with conflict markers, as LOCAL to the
mergetool backend even before we started discussing this topic, so I
am not that optimistic.

I assume that your idea is that various small "I know how to resolve
only this kind of conflicts" tools can plug into a larger merge
helper framework to improve end-user experience, and I find the idea
intriguing.  I would be surprised if such an idea has never been
discussed by folks in projects that develop and maintain merge
helpers, like meld and kompare.  But I am not convinced if it is a
good idea to do that on our side, before we spawn these mergetool
backends.


