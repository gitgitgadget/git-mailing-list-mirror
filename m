Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5FBC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 16:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiJYQzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 12:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiJYQza (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 12:55:30 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA9F2F038
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 09:55:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 203931BF20B;
        Tue, 25 Oct 2022 12:55:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oJXvHZs140yzlmjgjpxHtucdxUiYTW0hURsxEm
        hSYKk=; b=dv8C0C1SOsJ4abML0CIKovG8DfzoCNSWb445g86F18nlDWfqtwid6L
        SGnYHcf1p+zSWvSBAa4+VLS9gB/DyRM3p9qzRGSmDiCKajKy0ZkWub0MXBIpoU/F
        Ndw7o6uzuc5p3VjD49/2eE6P6hDcdr8ygF6sszGu1cfgwPahXZJY8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 18F861BF20A;
        Tue, 25 Oct 2022 12:55:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 662A71BF204;
        Tue, 25 Oct 2022 12:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julien Moutinho <julm+git@sourcephile.fr>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: FORCE_DIR_SET_GID denied inside nix's build sandbox
References: <20221025163024.uutqv7w24yi4eo5i@sourcephile.fr>
Date:   Tue, 25 Oct 2022 09:54:59 -0700
In-Reply-To: <20221025163024.uutqv7w24yi4eo5i@sourcephile.fr> (Julien
        Moutinho's message of "Tue, 25 Oct 2022 18:30:24 +0200")
Message-ID: <xmqq7d0nonbw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C36B8F0A-5485-11ED-96FE-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julien Moutinho <julm+git@sourcephile.fr> writes:

> While running public-inbox's tests inside nix's build sandbox
> I've noticed that when core.sharedRepository is set to 0600
> git still tries in adjust_shared_perm()
> to set the g+s bit on directories.
> https://github.com/git/git/blob/1fc3c0ad407008c2f71dd9ae1241d8b75f8ef886/path.c#L901-L905
> ...
> So, on meta@public-inbox.org we were wondering whether
> git should maybe strip S_ISGID and retry to chmod() if it hits EPERM?

But that can leave the repository unusable when the files and
directories has to be owned by the same group as its containing
directory.

It does sound like we are bit too aggressive when setting the g+s
bit.

Is g+s only necessary if the directory is group writable?  Not
necessarily.  When I am the only writer (and owner) with memberships
in multiple groups, a shared repository that I intend to give read
(but not write) permission bit to members of a specific group must
be owned by that group, and setting g+s is how we ensure it.  So it
is insufficient to give when new_mode says it is group writable.  We
also should do g+s if it is readable by the group.

But if you use 0600, then the group ownership should not matter, so

    /* Copy read bits to execute bits */
    new_mode |= (new_mode & 0444) >> 2;
    if (new_mode & 060)
	new_mode |= FORCE_DIR_SET_GID;

might be what you want?
