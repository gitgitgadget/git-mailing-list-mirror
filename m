Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB72C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 22:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF63610C7
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 22:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbhDQW1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 18:27:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56644 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbhDQW1X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 18:27:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD772D038B;
        Sat, 17 Apr 2021 18:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GL13oBf3k5/0wcnHjW9pNCB3hgE=; b=o1vZMe
        o34WRRePkKjh6yPfxBzywFCQDg8QCAMAJLKde9MCfVt+7pYEr6b8klN0u+7VOaEr
        2Jj+GawVghTEDMJT2dDt3FlnxHoMTDnb91awPL7mFZLkTgFHT/iin5iSD+Z/tbiP
        pRr7vKqH29gmfm40UStMTldqwy10F/FlS2HeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rLgpOHXdT+6xTbvwH9RIJOjwa/8pIR09
        6KuEYGybP7ZduvFMG3zElauQ9Nl2t9b6eZH2FpVhLxHboIbPUEYb3d7hlT+5nFbE
        fkF7BWVlXNoq3QUF14SDJeJ/oDuq9RBz/+lBxnhIghIsDWNfIAWVWIisdk3Dja/b
        wiEKMbXJ97U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4809D038A;
        Sat, 17 Apr 2021 18:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C592D0389;
        Sat, 17 Apr 2021 18:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v11 0/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
        <pull.913.v11.git.1618672417.gitgitgadget@gmail.com>
Date:   Sat, 17 Apr 2021 15:26:54 -0700
In-Reply-To: <pull.913.v11.git.1618672417.gitgitgadget@gmail.com> (ZheNing Hu
        via GitGitGadget's message of "Sat, 17 Apr 2021 15:13:35 +0000")
Message-ID: <xmqq5z0kbl8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03FC24E6-9FCC-11EB-A41B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In https://lore.kernel.org/git/xmqqv99i4ck2.fsf@gitster.g/ Junio and
> Christian talked about the problem of using strbuf_replace() to replace
> $ARG:
>
>  1. if the user's script has more than one $ARG, only the first one will be
>     replaced, which is incorrected.
>  2. $ARG is textually replaced without shell syntax, which may result a
>     broken command when $ARG include some unmatching single quote, very
>     unsafe.
>
> Now pass trailer value as $1 to the trailer command with another
> trailer.<token>.cmd config, to solve these above problems.
>
> We are now writing documents that are more readable and correct than before.

Here is a good spot to summarize what changed since the previous
round.

It seems that this now has "exit non-zero to tell the caller not to
add the trailer for this execuation".  Is that the only change you
made?

I was hoping that we'd declare victory with what was in v10 (with
possibly typos and minor stylistic fixes if needed---I no longer
remember details), let it go through the usual course of cooking in
'next' and merged down to 'master', and then after the dust settles,
we'd be adding this "by exiting with non-zero status, scripts can
signal a trailer not to be added for a particular invocation" as a
new feature, if it turns out to be necessary.

But let's see what's new in this iteration.


>       +#!/bin/sh
>      -+test -n "$1" && git shortlog -s --author="$1" HEAD || true
>      ++if test "$#" != 1
>      ++then
>      ++	exit 1
>      ++else
>      ++	test -n "$1" && git shortlog -s --author="$1" HEAD || true
>      ++fi

I find this dubious.  Why not

	if test "$#" != 1 || test -z "$1"
	then
		exit 1
	else
		git shortlog -s --author="$1" HEAD
	fi

That is, if you happened to give an empty string, your version gives
"" to <value> and returns success, letting a trailer "cnt:" with
empty value.  Is that what we really want?

>       +$ git config trailer.cnt.key "Commit-count: "
>       +$ git config trailer.cnt.ifExists "addIfDifferentNeighbor"
>       +$ git config trailer.cnt.cmd "~/bin/gcount"
>       +$ git interpret-trailers --trailer="cnt:Junio" --trailer="cnt:Linus Torvalds"<<EOF
>       +> subject
>      -+> 
>      ++>
>       +> message
>      -+> 
>      ++>
>       +> EOF
>       +subject
>       +
>      @@ Documentation/git-interpret-trailers.txt: subject
>       +------------
>       +$ cat ~/bin/glog-grep
>       +#!/bin/sh
>      -+test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
>      ++if test "$#" != 1
>      ++then
>      ++	exit 1
>      ++else
>      ++	test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
>      ++fi

Ditto.

>      + 	if (capture_command(&cp, &buf, 1024)) {
>      +-		error(_("running trailer command '%s' failed"), cmd.buf);
>      + 		strbuf_release(&buf);
>      +-		result = xstrdup("");
>      ++		if (!conf->cmd || arg) {
>      ++			error(_("running trailer command '%s' failed"), cmd.buf);

I am not sure about this part.  If .cmd (the new style) exits with a
non-zero status for user-supplied --trailer=<token>:<value> (because
it did not like the <value>), is that "running failed"?  The script
is expected to express yes/no with its exit status, so I would say it
is not failing, but successfully expressed its displeasure and vetoed
the particular trailer from getting added.  IOW, "|| arg" part in
the condition feels iffy to me.

>      ++			result = xstrdup("");
>      ++		} else
>      ++			result = NULL;
>      + 	} else {
>      + 		strbuf_trim(&buf);
>      + 		result = strbuf_detach(&buf, NULL);

OK.
