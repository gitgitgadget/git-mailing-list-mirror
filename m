Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2839EC001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 22:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjGMWQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 18:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGMWQv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 18:16:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D75211B
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 15:16:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53B861ABEFE;
        Thu, 13 Jul 2023 18:16:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oMuqibFVe2UpnTQ2fQyhoO0va4HiMAn92M1G0e
        UMoWg=; b=Cj3aXz29mfP9LrF4X3LLJlC2v7Ra+uZl0znxDA7aGZRR1SN1hW63IO
        LthXMJ9AziQpZ0oSGOY0Rm7Wu7HKsfclxJFTaD7CEm0wcu7dgGfURWtRPdzg+ORU
        kVkUcsYloBHLT680FxK+9ccf9SpLOAIv8xhhI458aQ1zwBCVjV+es=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B6DC1ABEFD;
        Thu, 13 Jul 2023 18:16:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 954801ABEFC;
        Thu, 13 Jul 2023 18:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 0/4] Changed path filter hash fix and version bump
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1689283789.git.jonathantanmy@google.com>
Date:   Thu, 13 Jul 2023 15:16:46 -0700
In-Reply-To: <cover.1689283789.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 13 Jul 2023 14:42:07 -0700")
Message-ID: <xmqqlefjlanl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5D18932-21CA-11EE-AE55-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I did not implement the mitigation of not using the Bloom filters when
> a high-bit path is sought because, as Stolee says, this is useful only
> when mixing Git implementations and will slow down operations (without
> any increase in correctness) in the absence of such a mix [1].

Sensible, I guess.

>     @@ Commit message
>          This commit does not change the behavior of writing (Git writes changed
>          path filters when explicitly instructed regardless of any config
>          variable), but a subsequent commit will restrict Git such that it will
>     -    only write when commitgraph.changedPathsVersion is 0, 1, or 2.
>     +    only write when commitgraph.changedPathsVersion is a recognized value.

This is nicer.

>          Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     @@ Documentation/config/commitgraph.txt: commitGraph.maxNewFilters::
>      -	If true, then git will use the changed-path Bloom filters in the
>      -	commit-graph file (if it exists, and they are present). Defaults to
>      -	true. See linkgit:git-commit-graph[1] for more information.
>     -+	Deprecated. Equivalent to changedPathsVersion=1 if true, and
>     ++	Deprecated. Equivalent to changedPathsVersion=-1 if true, and
>      +	changedPathsVersion=0 if false.

I forgot to comment on this part earlier, but does the context make
it clear enough that these `changedPathsVersion` references are
about `commitGraph.changedPathsVersion` configuration variable
without fully spelled out?  They sit next to each other right now,
so it may not be too bad.  If they appeared across more distance,
I would be worried, though.

>      +commitGraph.changedPathsVersion::
>      +	Specifies the version of the changed-path Bloom filters that Git will read and
>     -+	write. May be 0 or 1. Any changed-path Bloom filters on disk that do not
>     ++	write. May be -1, 0 or 1. Any changed-path Bloom filters on disk that do not
>      +	match the version set in this config variable will be ignored.

So, any time the user configures this to a different value, we will
start to ignore the existing changed-path-filters data in the
repository, and when we are told to write commit-graph, we will
construct changed-path-filters data using the new version?

>      ++
>     -+Defaults to 1.
>     ++Defaults to -1.
>     +++
>     ++If -1, Git will use the version of the changed-path Bloom filters in the
>     ++repository, defaulting to 1 if there are none.

OK, that was misleading.  The configuration can say "-1" and it does
not mean "I'll ignore anything other than version -1"---it means
"I'll read anything".  The earlier statement should be toned down so
that we do not surprise readers, perhaps

    When set to a positive integer value, any changed-path Bloom
    filters on disk whose version is different from the value are
    ignored.

to signal that 0 and negative are special.  Then the readers can
anticipate that special cases are described next.

    When set to -1, then ...
    When set to 0, then ...
    Defaults to -1.
    
When set to the special value -1, what version will we write?

>      +If 0, git will write version 1 Bloom filters when instructed to write.

And we will only read 0 and refuse to read 1?  Or we will read both
0 and 1?

Thanks.
