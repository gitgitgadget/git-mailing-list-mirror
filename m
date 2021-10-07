Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1002C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 23:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41C760F57
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 23:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhJGXia (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 19:38:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53461 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbhJGXiD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 19:38:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB9FE164F7B;
        Thu,  7 Oct 2021 19:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ue1XhvL1slqvDeoJwEaFZbt79YGs7rfM3crJyn
        3mGMQ=; b=bPZeGk7orMMVsho/PkqjuqjiHw1R1ykcFhTXay1Kq2U+HsahQ6D3Ib
        OMaFWyFZLyZngvGZGMmCJwR4jTn0HPO8WzrkzfAGU2EJv9bVpZYsord1DtQoAIOn
        kSuatQ3yvSzNV6W9zEHwIXISPZznw1fsa+TR9B6JyORUfuFVgy10g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E5A31164F7A;
        Thu,  7 Oct 2021 19:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 542F4164F79;
        Thu,  7 Oct 2021 19:36:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 1/2] remote: move static variables into struct
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
        <f7639a20fcd437d5f50665b5c6f5318c1245b9b5.1633633635.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 16:36:05 -0700
In-Reply-To: <f7639a20fcd437d5f50665b5c6f5318c1245b9b5.1633633635.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Thu, 07 Oct 2021 19:07:14
        +0000")
Message-ID: <xmqq8rz4o1ay.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 579DDABC-27C7-11EC-96DC-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> remote.c only works with the_repository because it stores its state as
> static variables. To support non-the_repository, we can use a
> per-repository struct for the remotes subsystem.

OK, so eventually we can hook the struct this patch introduces as a
member in the repository structure, so that we can have one such
struct per in-core repository instances?

Will some of the component of this new structure have to be aware of
the containing structure, even the repository instance the
containing structure belongs to?

For example, the apply_push_cas() function (there is nothing special
about it---just a random example near the end of file) takes "struct
remote *" which will be passed to underlying apply_cas() and the
control flow eventually need to reach read_ref() via
remote_tracking().  In a future world where we keep multiple in-core
repositories and interact with multiple repositories in-process,
this read_ref() must know in which repository it is asked to read
the value of the ref.  Do we expect to plumb "struct repository *"
throughout the callchain, or will some of the struct types gain a
backpointer to "struct remote_state", and "struct remote_state" will
in turn have a backpointer to the containing repository, so that
remote_tracking() can learn the ref_store it needs to use when
making a call to refs_read_ref_full() to replace the current call it
makes to the read_ref() function?

As to the name, I do not think "remote state" is not too bad, but
the word "remote" there certainly does not mean "state of a remote
repository", and in that sense, it might be confusing.

But It is still a seemingly random "collection of data that we need
to interact with remote repositories", so in that sense, the word
"remote" fits its purpose.  There are pieces of information needed
for a branch to interact with a remote repository, and the branches
variable serves as a caching mechanism for that, for example.
