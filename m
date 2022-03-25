Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18CFC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiCYT04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiCYT0o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:26:44 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBD9149244
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 11:59:41 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80DE51102A3;
        Fri, 25 Mar 2022 14:53:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=yja858t1AOswPXA8y0061Ti9z
        j6Exe209n2HaHZhypc=; b=FTr721Cl/mBoq+TvRYYzZecFVi++J/tJgqHOmvxO+
        z9jUAHHERGjL0p/tFwmAbuLdgOgDCiHhBcmLA0yCm2JKQmGwxnkoyQnsYooaSTLA
        hkG81AZh7Kewe6diLMmXNdEHzfOm9iTAWiJKsaBt8dMSzBaW7wRSboouDBHeeFK+
        JM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76B5E1102A2;
        Fri, 25 Mar 2022 14:53:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC9661102A1;
        Fri, 25 Mar 2022 14:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] pack-objects: lazily set up "struct rev_info", don't leak
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
        <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
Date:   Fri, 25 Mar 2022 11:53:05 -0700
Message-ID: <xmqqmthdampa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CEDB8884-AC6C-11EC-9038-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In the preceding [1] (pack-objects: move revs out of
> get_object_list(), 2022-03-22) the "repo_init_revisions()" was moved
> to cmd_pack_objects() so that it unconditionally took place for all
> invocations of "git pack-objects".
>
> We'd thus start leaking memory, which is easily reproduced in
> e.g. git.git by feeding e83c5163316 (Initial revision of "git", the
> information manager from hell, 2005-04-07) to "git pack-objects";
> ...
> Narrowly fixing that commit would have been easy, just add call
> repo_init_revisions() right before get_object_list(), which is
> effectively what was done before that commit.
>
> But an unstated constraint when setting it up early is that it was
> needed for the subsequent [2] (pack-objects: parse --filter directly
> into revs.filter, 2022-03-22), i.e. we might have a --filter
> command-line option, and need to either have the "struct rev_info"
> setup when we encounter that option, or later.
>
> Let's just change the control flow so that we'll instead set up the
> "struct rev_info" only when we need it. Doing so leads to a bit more
> verbosity, but it's a lot clearer what we're doing and why.

Is this about "we take it as given that the use of rev_info leaks
until we fix revisions API, so let's keep its use limited to avoid
unnecessary leaks"?

If so, it sort-of makes sense, but smells like a roundabout way to
address the issue.  An obvious alternative is to wait until both the
topic and the "plug revision API" topic graduate and then add a
"release" call to release the resource in the same sope as the
unconditional call to init_revisions at the end.  I do not quite get
what on-demand lazy set-up buys us.  What we need to lazily set-up,
when we do lazily set-up, needs to be released either way, no?

