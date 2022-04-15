Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB844C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 16:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351569AbiDOQuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 12:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiDOQut (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 12:50:49 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9134CDD97F
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 09:48:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAFF511A0A8;
        Fri, 15 Apr 2022 12:48:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lLSrNUyShETvhegZO1u+MlgPcGRVNnXT3o9i5v
        RmtlI=; b=JRLi9X6heLNPhdJkWpqNT6vBpxu9yEm6OBAdvJPHL9srnt9NN+osQB
        WpjWoaASHhi67PL6eI1N75bdVaa2Xs3RnU2f1T6CJXrew3Ilhfs04n4PN40ttDVm
        M0+oPlRx5ItS0WPfQ9Ns5twvKIvcADr3LepOjW+vC6ElboqyPwB0I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2E1111A0A7;
        Fri, 15 Apr 2022 12:48:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D24A11A0A5;
        Fri, 15 Apr 2022 12:48:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danny Lin <danny0838@gmail.com>
Cc:     git develop <git@vger.kernel.org>
Subject: Re: Arguments for git update-index --refresh
References: <CAMbsUu7fqECH1b7-POot0mD4kwmT0pzAMJrXznSPgv9wfv1OwA@mail.gmail.com>
Date:   Fri, 15 Apr 2022 09:48:18 -0700
In-Reply-To: <CAMbsUu7fqECH1b7-POot0mD4kwmT0pzAMJrXznSPgv9wfv1OwA@mail.gmail.com>
        (Danny Lin's message of "Fri, 15 Apr 2022 18:21:54 +0800")
Message-ID: <xmqqv8vae1il.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA8A4704-BCDB-11EC-8466-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danny Lin <danny0838@gmail.com> writes:

> According to the manual of git-update-index
> (https://git-scm.com/docs/git-update-index), --ignore-submodules must
> be passed before --refresh to take effect. However, a real test shows
> that -q and --ignore-missing also don't take effect when passed after
> --refresh. I wonder if --refresh must be passed after all other
> arguments, and the documentation may need a revision. I also wonder
> what is the reason that --refresh must be passed after, and can't we
> make it more flexible?

For backward compatibility reasons, it is unlikely we can change it,
so it is a moot point to ask why.  But anyway.

The "update-index" plumbing subcommand predates the philosophy
behind our modern option parsing infrastructure; it was designed
to process each option as it parse it from left to right.  We do not
advertise this in the documentation or help text, but we do even a
strange things like this:

    git update-index fileA --add fileB

where "we allow a new path to be added to the index" option ONLY
applies to fileB (in other words, if fileA is not yet added to the
index, the command would barf, but fileB is allowed to be a "new"
file).  --remove is also the same way.

With the understanding of "each option is processed as it is parsed
from left to right", you should be able to "explain" [*1*] the
behaviour you observed, better than relying on the description in
the document, e.g. "only respected when passed before" [*2*], which
is not technically wrong but does not tell you the real reason.


[Footnote]

*1* You should be able to explain, but you do not have to agree with
    it.  Within the context of the modern Git command set, I do not
    agree with it, but unfortunately it is too late to change it, as
    scripts people wrote over time do agree with and depend on the
    behaviour X-<.

*2* Update to remove these haphazard mention of the ordering and to
    place more stress on the "processed as it is read" nature of the
    options in the documentation may help users.
