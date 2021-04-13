Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DC1C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC53061131
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhDMUiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 16:38:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59940 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbhDMUiX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 16:38:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1529512365F;
        Tue, 13 Apr 2021 16:38:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iUvPbKU53hyhTgJOB4m0asQh68g=; b=CzXfR9
        Pqo6REOUvOj1xUWnuUjyXXf4Sx0xvCaO49EofPkyJD4wNUuAFhxMF0WdDKyXx3bX
        eh3AHZqoPrf3ho+OwRubfoyjlZlDCRDBV7op4vRuje9bb/dbQs/45fpT1Aigl82S
        tGT2tzF3QVy/EhBMy/ezCcXmFvmD4JYxTkBQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EZEzqx9StyX7uvLyKWhzyH/0uTOT9NGM
        D8YkTL8HZVFpxGqObwtN+Cdr8jBUV5dAzeWUsBa+gnNtAiTl7Gxqj6xmZhQpWoY7
        GXiAwfkjDORosGd8KQru9CP1TM50ZWyWvQeT9PJcykq4m5euNIEt0JIJfa3YdRAH
        EnAaZWAEYOI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D11B12365D;
        Tue, 13 Apr 2021 16:38:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2AFB1123658;
        Tue, 13 Apr 2021 16:38:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sam Bostock <sam.bostock@shopify.com>
Cc:     git@vger.kernel.org
Subject: Re: `git fetch` not updating 'origin/HEAD' after branch rename
References: <CAHwnEogvmTZ-VS5GksoGEiyo3EHO+At+xeWa3frXUESD3HicnQ@mail.gmail.com>
Date:   Tue, 13 Apr 2021 13:37:58 -0700
In-Reply-To: <CAHwnEogvmTZ-VS5GksoGEiyo3EHO+At+xeWa3frXUESD3HicnQ@mail.gmail.com>
        (Sam Bostock's message of "Tue, 13 Apr 2021 16:25:32 -0400")
Message-ID: <xmqqlf9lly3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 230C55AE-9C98-11EB-9D8B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sam Bostock <sam.bostock@shopify.com> writes:

> Hopefully I followed the instructions on https://git-scm.com/community
> correctly to report this bug.
>
> Long story short, it seems to me that `git fetch` should update
> "refs/remotes/origin/HEAD" when the upstream HEAD changes, but it
> doesn't. See my filled out bug report below.

That is working as intended.

Since its inception, refs/remotes/origin/HEAD has been designed to
mean "the branch, which the owner of the repository considers the
most interesting for his/her purpose to keep track in the 'origin'
remote repository".  It is perfectly OK to repoint origin/HEAD to
point at another branch you are interested in after you make a
clone.

The origin/HEAD happens to be primed by noticing what the remote
repository sets HEAD to point to their branch upon cloning, but that
is purely for convenience (i.e. HEAD branch of a repository offered
for cloning points at a branch the owner of the repository being
cloned considers the primary branch in his/her repository, and that
often coincides with the earlier definition of origin/HEAD for those
who clone such a repository).  It would be a bug to update it to
something other than you set (either passively by keeping what
"clone" gave you initially, or actively by updating it to point at
another branch) upon "git fetch" from the remote.

There was an idea floated to use the same mechanism used by "git
clone" to prime origin/HEAD upon "git fetch" when origin/HEAD is
missing, and I do not think there were many objections against the
idea, so that may happen sometime in the future.  It may also be
possible to add "git fetch --reset-remote-tracking-HEAD" option to
make "fetch" overwrite existing origin/HEAD but somebody has to
propose such a change, argue for its benefit and get it accepted by
the community.

Thanks.



