Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE99C433ED
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 01:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2463B61358
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 01:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbhDDBCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 21:02:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54733 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbhDDBCj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 21:02:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6653713736A;
        Sat,  3 Apr 2021 21:02:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uNIRjQF2u14cwWS2hM92J8669SE=; b=VBdN/L
        K0uWDLbCEPV+1zr//D6V5GUlaMzPaoKw4On6+DzSmiAEuNgCUblmoRvRJq+6Y4Qj
        +gHYEN5wfmUX5xIx1nTKVob5wGeUBJO0oQkE6EoHNAZv7VoISm4qCu0qjzjwPYXd
        Bj1KqIParClXTnsxjwXpS3r9Yx9j7mp5gj9+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j2hvVUljlqzOhT+AFu0H5bkNB7R4QshI
        Ce1Cvbl/yuUf8rK3GT7G63Dwj5asQinPmZV/cXIpLi0vTBi+OytoHj3WZWRHgYjp
        mQxoifLu4z7Rih8ziQZrg2JYUNI2HHPqKZ1YWGF0WkLUZ2DwSiZIfBBzki6oYMNZ
        7HLkv9t0Iz8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FD89137369;
        Sat,  3 Apr 2021 21:02:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9695A137368;
        Sat,  3 Apr 2021 21:02:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jerry Zhang <jerry@skydio.com>,
        Git Mailing List <git@vger.kernel.org>, ross@skydio.com,
        abe@skydio.com, brian.kubisiask@skydio.com,
        Jerry Zhang <jerryxzha@googlemail.com>
Subject: Re: [PATCH 1/1] git-apply: Allow simultaneous --cached and --3way
 options
References: <20210403013410.32064-1-jerry@skydio.com>
        <20210403013410.32064-2-jerry@skydio.com>
        <CABPp-BGhvQF9k1Jw9NPbZWMkNSffqR777-4S-y-Sh=Etvw-SAA@mail.gmail.com>
        <xmqqy2e00zaf.fsf@gitster.g>
Date:   Sat, 03 Apr 2021 18:02:31 -0700
In-Reply-To: <xmqqy2e00zaf.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        02 Apr 2021 21:26:00 -0700")
Message-ID: <xmqq1rbq276g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 703A284C-94E1-11EB-A7B1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It might be OK to only allow the combination when everything auto
> resolves cleanly and fail the operation without touching either the
> index or the working tree.  Pretending there was no delete/modify
> conflicts or adding contents with unresolved conflicts as if nothing
> bad happened as stage 0 entries would never be acceptable.
>
> Perhaps
>
>  * Error out if the index does not match HEAD.
>
>  * Try applying to the contents in the index.  If there are any
>    structural conflicts, leave these paths at higher stage and do
>    not touch their contents.
>
>  * For paths without structural conflict but need content merges,
>    attempt ll-merge of the contents.  If autoresolves cleanly,
>    register the result at stage 0.  Otherwise, discard the failed
>    conflicted merge, and leave stages 1, 2 and 3 as they are.
>
>  * Exit with status 0 if and only if everything has resolved
>    cleanly.  Otherwise, exit with non-zero status.
>
> would be the minimally-acceptably-safe behaviour.

Note that, while a lot unsatisfactory than the above, the following
would also be acceptable.

  * Error out if the index does not match HEAD.

  * Try applying to the contents in the index.  If there are any
    structural conflicts, abort without touching the index (or the
    working tree --- but that is best left unsaid as we all know we
    are talking about '--cached').

  * For paths without structural conflict but need content merges,
    attempt ll-merge of the contents.  If ALL SUCh PATHS autoresolve
    cleanly, register their result at stage 0.  Otherwise, abort
    without touching the index (or the working tree).

  * Exit with status 0 if and only if everything has resolved
    cleanly.  Otherwise, exit with non-zero status (and never touch
    the index or the working tree).

The version I earlier gave would give a good starting point to
manually resolve the conflicts in the index and when resolved fully,
it is safely recorded as the result of applying the patch on top of
HEAD, because the non-final results are all in higher stages, and
all the paths at stage 0 are either from the HEAD and unaffected by
the merge, or the ones that cleanly resolved.  The "the index must
match HEAD" upfront is to ensure that.  Otherwise it would make it
very tempting, after spending all that time to resolve the conflicts
only in the higher stages of the index, to commit the index as-is to
make a child commit of HEAD and record that it is the result of
applying the patch.  But if the starting condition had a change
unrelated to the change the patch brings in already in the index,
the resulting commit would be _more_ than what the patch did to the
codebase.

The simplified version would let the user proceed only when the
conflicts can mechanically resolved, but it still has the "make sure
what is recorded is only from the incoming patch" safety.

Of course, if the user is trying to cherry-pick parts of multiple
patches and combine them to create a new single commit, the second
and subsequent applycation of the patches would be thwarted by the
"the index must match HEAD" rule, but it is far safer to make each
step into its own snapshot commit during such a workflow to combine
multiple patch pieces and then squash them together after finishing,
than carrying an intermediate result only in the index and risk
losing work you did in the previous step(s) to incorrect resolution
in later step(s).
