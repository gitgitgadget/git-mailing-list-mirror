Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA81EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 05:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGHFss (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 01:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGHFsn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 01:48:43 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A553C1BEE
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 22:48:41 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF65419C3C7;
        Sat,  8 Jul 2023 01:48:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LqlekdtAEDv8MMK47M74M0wjSoz/VFI+CdTzT9
        y0mSg=; b=kLxTnEV+HkRXd3wEgfil0pN5DbY4sb5M+uYN/EtMlLca+ASup2hm7t
        dwXXUFxOe8kXtXRpisCqHvWY+zHXqjHTNYaWIGingMg3sbxQvR3R/Q+C1XtbvF7e
        Q59fkzlGnqdemYTPxLo+5FTrN5sTw91cnt4GgxMAvNQfbzaxhBxTE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6A1A19C3C6;
        Sat,  8 Jul 2023 01:48:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3CCC519C3C5;
        Sat,  8 Jul 2023 01:48:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 4/5] SubmittingPatches: remove confusing guidance about
 base branches
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
        <55bed55cb8859ac7b5b4f464232258f410b4d202.1688778359.git.gitgitgadget@gmail.com>
Date:   Fri, 07 Jul 2023 22:48:39 -0700
In-Reply-To: <55bed55cb8859ac7b5b4f464232258f410b4d202.1688778359.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Sat, 08 Jul 2023 01:05:58
        +0000")
Message-ID: <xmqqa5w76jig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17225A70-1D53-11EE-A4E2-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> For these reasons, remove the guidance _without_ preserving the meaning
> of the underlying principle, and instead add an overview of the four
> named branches.

Meaning that this rewrites the guidance and changes the meaning of
the underlying principle?

> -In general, always base your work on the oldest branch that your
> -change is relevant to.
> +The following branches are the typical starting points for new work:
> +
> +* maint
> +* master
> +* next
> +* seen
> +
> +These branches are explained in detail in linkgit:gitworkflows[7].
> +Choose the appropriate branch depending on the following scenarios:

Please never suggest to build anything on 'next' or 'seen'.  They
are inappropriate to base your work on, if your topic wants to have
a realistic chance to graduate to 'master'.

If you are making tree-wide changes, while somebody else is also
making another tree-wide changes, your topic may have severe overlap
with the other person's topic.  In which case, you may be tempted to
build on 'next' that has the other person's topic, but doing so would
mean you'll not just depend on the other topic, but with all the
other topics that are already in 'next'.

That would make the basic choices simpler.

 * If you are fixing bugs in the released version, build on 'maint'
   (which may mean you have to fix things without using new API
   features on the cutting edge that recently appeared in 'master'
   but were not available in the released version).

 * If you are adding new features, build on 'master'.

Under exceptional circumstances that you need to depend on a
selected few topics that are already in 'next' but not in 'master',
you may want to fork your base-branch from 'master', merge these
selected few topics to it, and call that your base-branch (which
nobody else has).  And then you build on top of it.  When sending
patches out, because your synthetic base-branch is something only
you have, you'd need to communicate how you created it in your cover
letter to allow others to recreate it.

Thanks.
