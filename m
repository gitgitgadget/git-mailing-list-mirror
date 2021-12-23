Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DB1C433FE
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 18:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349842AbhLWSfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:35:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58317 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbhLWSfx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 13:35:53 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36089EDDB1;
        Thu, 23 Dec 2021 13:35:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UNRvr1AUGZd9Ll9xTg1XYBdydHZGaHc2tPe5gA
        FFo/U=; b=jgFl0B6zyfTIx3xqYNTqJ0Wy01MqcwuCWdcPuhhxS4iVOkNAJUPJ1j
        L2UZwCO06ZcGPW5Oa9WkW0aPFBSjzxSAyz84v/T0Xik02heAO6Ta3fdLXRe4yt0Q
        rme7RqQMQCXP+i3dH7I56UsN2RBYSauNrj/uwfvnXIsPCMvVzB4jU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E032EDDB0;
        Thu, 23 Dec 2021 13:35:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CD15EDDAF;
        Thu, 23 Dec 2021 13:35:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Vicarel <shundra8820@gmail.com>
Cc:     Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
Subject: Re: Why does "merge --continue" expect no arguments?
References: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
        <CAFOYHZC0r35mfOVUExHsBP5=URKFAt_wDTZ51pTc=XkXyogqKQ@mail.gmail.com>
        <CALRdAfcKSsct1gD87Pkjugttr3pFbXnh0W=kVa95G+9ZpNtLnA@mail.gmail.com>
Date:   Thu, 23 Dec 2021 10:35:51 -0800
In-Reply-To: <CALRdAfcKSsct1gD87Pkjugttr3pFbXnh0W=kVa95G+9ZpNtLnA@mail.gmail.com>
        (Daniel Vicarel's message of "Thu, 23 Dec 2021 01:07:56 -0500")
Message-ID: <xmqq1r23cgoo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 286231DC-641F-11EC-95C1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Vicarel <shundra8820@gmail.com> writes:

> Thanks for the input, all.
>
> Junio C Hamano <gitster@pobox.com> writes:
>> perhaps the doc update would be the quickest one that offers the most to learn from
>
> Sounds good! Now by "doc update" do you mean updating docs in the
> Documentation/ folder, or adding a warning to the CLI output of `git
> merge --continue`?

The former.  The current text says "... you can conclude the merge
by running `git merge --continue`" without giving a clue that this
is another way to say "git commit" that is longer to type.

The way it rejects extra arguments happens to work as a safety valve
that is not very end-user friendly; as you found out, it rejects
options and arguments (like pathspec).  So "--continue" is more than
a mere synonym to "git commit".

> Junio C Hamano <gitster@pobox.com> writes:
>> coming up with a sensible list of allowed options and arguments [to `git merge --continue`] would be quite hard.
>
> Chris Packham <judge.packham@gmail.com> writes:
>> I think it'd be a good idea to allow [--no-edit on `git merge --continue`] as long as it's the only other option allowed with --continue.
>
> Based on these two pieces of feedback, it sounds like adding _just_
> the `--no-edit` option at this point to `git merge --continue` is
> worthwhile, and hopefully approachable for a newb. For now I'll put a
> pin in it though, and focus on the documentation task above.

Well, I don't know about Chris, but I didn't mean to suggest that by
saying that deciding which ones to allow and which ones to reject is
hard.  Knowing that there are other options that deserve the same
attention as `--no-edit` to be supported now makes a patch to only
add support for `--no-edit` an incomplete one.  If we need to add
support for more in the future, at least the mechanism used to add
the first one should be something we can reuse in the future for
these other ones.

The way "git commit" is internally invoked from "git merge --continue"
happens to work with the current "we only pass no arguments, and we
exit once the command is done" usage, but it fundamentally is wrong.
No cmd_foo() functions should be called from anything but the
run_builtin() function in git.c, as they are not prepared to be
called twice, and they are not prepared to be called in an
environment where other things (like reading configuration files)
have already happened.  If we were to extend what is passed when
"git merge --continue" calls "git commit", we should first clean up
the (ab)use of cmd_commit() call from the code path, before adding
new features.

So, no, I do not think it is a welcome change to just allow passing
"--no-edit" in a way that is "approachable for a newb".

Thanks.


