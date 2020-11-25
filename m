Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C9EC56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C53A206D9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EGN5SRr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbgKYWOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:14:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65006 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730459AbgKYWOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:14:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FD118DE0A;
        Wed, 25 Nov 2020 17:14:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ybEIlGJJcaCpu2bmzwo1/TenTlc=; b=EGN5SR
        r75+Q8EWDGO7JiDUN3q6DTO5eNY2Zh80+CIRiQtCPqZEN2mhGZS/dDAYw4ehBcw6
        eKav+8G6LD56W7+HhN9geTZr03BnIUf9NpgfCIwYTeVXchajmHp95vEEY3dicZ/d
        OQ1KGhZuRelS8+xvy0N7Iu1Dz7p5EO+YlYmbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hhbnIDSj1wUf7L6vVSJlYShQsnpTzVhl
        toAOKCwhvHnd7xjjtA9aTfsjwyv0dei9yGTxHgYxrBh42wI3PvMGsn2TBab68GDR
        wV0AARSCx9h/4OXTybc5DyCLjnB3hga03RGSQp34KkCoSG2csm/TPUJxo2pbcyml
        XXzwNVBW/eQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6350D8DE09;
        Wed, 25 Nov 2020 17:14:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C217B8DE08;
        Wed, 25 Nov 2020 17:14:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        dstolee@microsoft.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] Fix stash apply in sparse checkouts (and a
 submodule test)
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
Date:   Wed, 25 Nov 2020 14:14:05 -0800
In-Reply-To: <pull.919.git.git.1605891222.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Fri, 20 Nov 2020 16:53:39
        +0000")
Message-ID: <xmqqlfepcceq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88CDF70C-2F6B-11EB-9D93-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Heavier usage of sparse-checkouts at $DAYJOB is commencing. And an issue
> with git stash apply was found.
>
> git stash's implementation as a pipeline of forked commands presents some
> problems, especially when implemented atop of three commands that all behave
> differently in the presence of sparse checkouts. Add a testcase
> demonstrating some issues with git stash apply in a repository with a
> different set of sparse-checkout patterns at apply vs create time, clean up
> the relevant section of git stash code, and incidentally fix a submodule
> testcase unrelated to sparse checkouts. Provide some detailed commit
> messages explaining the issues along the way.
>
> NOTE: I found a couple minor issues with other commands in sparse checkouts
> while debugging this issue, but I don't yet have fixes for them and I can
> submit them separately.

Any comments on this from reviewers?  The second patch is a but too
busy looking and I am having a bit of trouble convincing myself that
it is doing the right thing.

Thanks.
