Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC553E7737C
	for <git@archiver.kernel.org>; Sat, 30 Sep 2023 17:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjI3RRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Sep 2023 13:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjI3RRq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2023 13:17:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E7E3
        for <git@vger.kernel.org>; Sat, 30 Sep 2023 10:17:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD9391B9A49;
        Sat, 30 Sep 2023 13:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=nz4LNFGeCEWHiVD/NnQkDltLhtTSreJu+T8bk2
        QIuW8=; b=oVPxnZbHVia9zQFxeAWQVPHzn+I/9yVQ1X3o4xf7ufGFb0oPaySvUa
        f2y1fAj2aDiZpsDnwkagxAJT82vsMCKADh0GtgYFYIl8sRPr5MKwVF60+KNb2Sa7
        cCsX8U8ibQceFH4Xhnk74hyhydFNcdP0Vc0YaS6oEUYVxzsI+kDZk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C50471B9A48;
        Sat, 30 Sep 2023 13:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 321DD1B9A47;
        Sat, 30 Sep 2023 13:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jesse Hopkins <jesse.hops@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible to update-ref remote repository?
In-Reply-To: <CAL3By--HowOL1ffKBPfmwnfUdJd4KXcnkpS2BgkbO=9E2WnHKw@mail.gmail.com>
        (Jesse Hopkins's message of "Sat, 30 Sep 2023 10:34:41 -0600")
References: <CAL3By--HowOL1ffKBPfmwnfUdJd4KXcnkpS2BgkbO=9E2WnHKw@mail.gmail.com>
Date:   Sat, 30 Sep 2023 10:17:40 -0700
Message-ID: <xmqqo7hjfumj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 438F4196-5FB5-11EE-A7A0-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jesse Hopkins <jesse.hops@gmail.com> writes:

> Wondering if it's possible to do the equivalent of the update-ref
> command remotely.  Or I guess another way of putting it would be to
> git-push to a remote repository without needing a local clone of the
> repo.
>
> Trying do something like:
>
> git push <remote-repo-url>  <sha1>:refs/heads/mybranchtoupdate
>
> where I know that <sha1> already exists on the remote.  I'd like to
> avoid the need to clone a local copy of the repo.  Wondering if there
> might be some plumbing command(s) that could accomplish this?

There is no such command shipped with Git.  I do not think anybody
ever proposed to add such a feature, as it won't be generally useful
in contexts other than one-shot surgery.

But that is different from that it is impossible to do.  At the
protocol level, as long as the receiving end is convinced that such
a push, which does not transfer any object but proposes to update a
ref to a new value, does not corrupt the resulting repository state
after acceptingit, the receiving end does not care if the sending
end has what object, or even any repository---the receiving end
cannot even know what the sending end actually has.

The devil however is in the details of ensuring the "as long as the
receiving end is convinced" part.  If you know that an object whose
object name is X is sitting at the tip of branch A at the remote,
and you try to update the tip of branch B to the same object, it is
likely [*] that the remote would notice that such an update after
receiving no new objects is safe.  But if the object X is not
sitting at the tip of any branch or ref (it may be a few commits
behind an existing ref, or it may be dangling ahead of all refs), it
would depend on how the receiving end determines that it has object
chains necessary to complete the new DAG that has X.  The official
versions of Git client historically have done a thorough job in
check_connected() to even discover fully connected object chains
that allows us to resurrect such a dangling tip of a DAG, but we
cannot complain if third-party Git implementations misses less
obvious cases.

Having said all that, writing a specialized "push lookalike" that
sends the required protocol message that would have been spewed by a
real "git push" client operating in the right environment (i.e., it
has a repository that is a good clone of the receiving repository at
the <remote-repo-url>, the receiving repository has <sha1> and all
the objects that are reachable from it, refs/heads/mybranchtoupdate
points at a commit that is an ancestor of <sha1> right now) should
not be brain surgery, and with such a program you can

 $ git-push-empty <remote-repo-url> <sha1>:refs/heads/mybranchtoupdate

and fool the receiving end to do what you want it to do, as it
cannot tell if it is talking to a real "git push" client or to your
"push-empty" program from what is coming over the wire.



