Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C47C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 00:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhKXAoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 19:44:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64010 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhKXAoP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 19:44:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED7C015A5B2;
        Tue, 23 Nov 2021 19:41:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nhmh/R8kKEUl3OCsnDsnSfA3OY5ZSS3CfTiuGP
        CmPew=; b=E1qCZUxj7Rf1TnAtbepa3ZVMzeICR/U8shL2rt4pw/Qf4bMBkg9IHT
        BFkMdWtZWHwzMZZurd3loFF4849SVpY3IKbwIza72VfpW9IC60Ui3Ni8NBM8aw+z
        SCYmnvuXeeQG22j3pmxysq1RUcJeParPvgkK2HIQaFyXPYjIV81qs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E5E7D15A5B1;
        Tue, 23 Nov 2021 19:41:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EB96115A5AF;
        Tue, 23 Nov 2021 19:41:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, William Sprent <williams@unity3d.com>
Subject: Re: [PATCH] fast-export: fix surprising behavior with --first-parent
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 16:41:00 -0800
In-Reply-To: <pull.1084.git.1637666927224.gitgitgadget@gmail.com> (William
        Sprent via GitGitGadget's message of "Tue, 23 Nov 2021 11:28:47
        +0000")
Message-ID: <xmqqh7c25qsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3300490C-4CBF-11EC-9EEC-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"William Sprent via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: William Sprent <williams@unity3d.com>
>
> When invoking git-fast-export with the --first-parent flag on a branch
> with merges, fast-export would early-out on processing the first merge
> on the branch. If combined with --reverse, fast-export would instead
> output all single parent commits on the branch.

I do not doubt we would want to make the command behave sensibly
with all options it accepts, but let me first ask a more basic and
possibly stupid question.

What is "git fast-export --first-parent <options>" supposed to do
differently from "git fast-export <options>" (with the same set of
options other than "--first-parent")?  Should it omit merge commits
altogether, pretending that the first single-parent ancestor it
finds on the first parent chain is a direct parent of a
single-parent descendant, e.g. if the real history were with two
single-parente commits A and B, with two merges M and N, on the
mainline, making the resulting commits into a single strand of two
pearls, with A and B before and after the rewrite to have the same
tree objects?

    ---A---M---N---B             ---A---B
          /   /           ==>
         X   Y

Or should it pretend merge commits have only their first parent as
their parents, i.e.

    ---A---M---N---B             ---A---M---N---B
          /   /           ==>
         X   Y

"git fast-export --help" does not even mention "--first-parent" and
pretend that any and all [<git-rev-list-args>...] are valid requests
to make to the command, but I am wondering if that is what we intend
to support in the first place.  In builtin/fast-export.c, I do not
see any attempt to do anything differently when "--first-parent" is
requested.  Perhaps we shouldn't be even taking "--first-parent" as
an option to begin with.

The "--reverse" feels even more iffy.  Are we reversing the history
with such an export, i.e. pretending that parents are children and
merges are forks?

    ---A---M---N---B             B---N---M---A---
          /   /           ==>         \   \
         X   Y                         X   Y

Or are we supposed to produce the same history in the end, just
spewing older commits first in the output stream?  I am not sure
what purpose such a request serves---the "fast-import" downstream
would need the same set of objects before it can create each commit
anyway, so I am not sure what the point of giving "--reverse" is.

If there is no sensible interpretation for some of the options that
are valid in rev-list in the context of "fast-export" command, should
we just error out when we parse the command line, instead of producing
nonsense output stream, I wonder.
