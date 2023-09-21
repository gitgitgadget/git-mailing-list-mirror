Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09324E7D0A2
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 18:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjIUSOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 14:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjIUSOr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 14:14:47 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEE25BB2
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 10:08:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB0CD1AF32;
        Thu, 21 Sep 2023 04:52:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=xGSF+N2Faw6CUMEgLfEzqrDJ2V08QYVLtZNAgO
        ceSpk=; b=qQyUhMM7Fpg8+JJ/6LGYOEML4mDigR7E/RBzoQM/ah9hTzZBDnC6cu
        f1TmsmW2ogPhnyxcvAAJlV0wNDOQA2CHnUpfv2xwoL/X32HoMZhVMBYjt6ENEPUi
        mD5iOjItk2ksp03v6eSS88yo2PJR1WwDLHJ7+MT97ZQ4rYKb2io6Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94C501AF31;
        Thu, 21 Sep 2023 04:52:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1894D1AF30;
        Thu, 21 Sep 2023 04:52:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] attr: attr.allowInvalidSource config to allow invalid
 revision
In-Reply-To: <20230921041545.GA2338791@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 21 Sep 2023 00:15:45 -0400")
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
        <xmqqfs38akx5.fsf@gitster.g>
        <20230921041545.GA2338791@coredump.intra.peff.net>
Date:   Thu, 21 Sep 2023 01:52:52 -0700
Message-ID: <xmqq1qer7vrv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40B8F918-585C-11EE-B3FD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In an empty repository, "git log" will die anyway. So I think the more
> interesting case is "I have a repository with stuff in it, but HEAD
> points to an unborn branch". So:
>
>   git --attr-source=HEAD diff foo^ foo

This still looks like a made-up example.  Who in the right mind
would specify HEAD when both of the revs involved in the operation
are from branch 'foo'?  The history of HEAD may not have anything
common with the operand of the operation 'foo' (or its parent), or
worse, it may not even exist.

But your "in this repository we never trust attributes from working
tree, take it instead from this file or from this blob" example does
make a lot more sense as a use case.

> And there you really are saying "if there are attributes in HEAD, use
> them; otherwise, don't worry about it". This is exactly what we do with
> mailmap.blob: in a bare repository it is set to HEAD by default, but if
> HEAD does not resolve, we just ignore it (just like a HEAD that does not
> contain a .mailmap file). And those match the non-bare cases, where we'd
> read those files from the working tree instead.

"HEAD" -> "HEAD:.mailmap" if I recall correctly.

And if HEAD does not resolve, we pretend as if HEAD is an empty
tree-ish (hence HEAD:.mailmap is missing).  It becomes very tempting
to do the same for the attribute sources and treat unborn HEAD as if
it specifies an empty tree-ish, without any configuration or an
extra option.

Such a change would be an end-user observable behaviour change, but
nobody sane would be running "git --attr-source=HEAD diff HEAD^ HEAD"
to check and detect an unborn HEAD for its error exit code, so I do
not think it is a horribly wrong thing to do.

But again, as you said, --attr-source=<tree-ish> does not sound like
a good fit for bare-repository hosted environment and a tentative
hack waiting for a proper attr.blob support, or something like that,
to appear.

> But what is weird about this patch is that we are using a config option
> to change how a command-line option is interpreted. If the idea is that
> some invocations care about the validity of the source and some do not,
> then the config option is much too blunt. It is set once long ago, but
> it can't distinguish between times you care about invalid sources and
> times you don't.
>
> It would make much more sense to me to have another command-line option,
> like:
>
>   git --attr-source=HEAD --allow-invalid-attr-source

Yeah, if we were to make it configurable without changing the
default behaviour, I agree that would be more correct approach.  A
configuration does not sound like a good fit.

> ... And I really think attr.blob is a better match for what GitLab
> is trying to do here, because it is set once and applies to all
> commands, rather than having to teach every invocation to pass it
> (though I guess maybe they use it as an environment variable).

True, too.

Thanks.
