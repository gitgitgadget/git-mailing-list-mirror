Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43BEE202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 19:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbdCOTuh (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 15:50:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50501 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751416AbdCOTug (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 15:50:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74431790C4;
        Wed, 15 Mar 2017 15:50:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=no4E39+kkI3Q9WCpuypN5lGB0oc=; b=j2eY8z
        ueAoY3vQUwbvi9ynuq5j2aAcM0YIFA5IZKdihVIApB08Rst5GTg0TWL7xcwjfQNn
        VLi4Un61dpVuq1wWQbyaDOkjPnK2porScRH6xAOr5YLiK/Thpaz7h6w7rssXxyjJ
        +Gybh/s4su/9vmK2YU7uFWHZfEaKfE6Whi2uY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x8646Zs4M/MY1M9y8/ewl5667Bw2pfgl
        +BumQzflJfkYWv/qd+BV/UiVd+Q1xn5tvfwRqJ0q3HrOSHwIbtqi+GAl6fsHKfap
        IVVyRyEsWV1C6gmmB7aLAD1AIlsPLC/rmC1TrKFyRyiMR6juhn/ejgk+RW+y+EQm
        TkE9PVkO/2c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D6CE790C3;
        Wed, 15 Mar 2017 15:50:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAF8F790C2;
        Wed, 15 Mar 2017 15:50:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFD PATCH 3/3] name-rev: Allow lightweight tags and branch refs
References: <cover.1489581340.git.git@drmicha.warpmail.net>
        <db54f291407ef34080fe9e8c9dbdd482b4b3698d.1489581340.git.git@drmicha.warpmail.net>
Date:   Wed, 15 Mar 2017 12:50:32 -0700
In-Reply-To: <db54f291407ef34080fe9e8c9dbdd482b4b3698d.1489581340.git.git@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Wed, 15 Mar 2017 14:15:10 +0100")
Message-ID: <xmqqlgs6e2uv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6FF539C-09B8-11E7-AEEE-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I'm wondering whether I'm overlooking any side-effects that our test
> suite doesn't cover, though. In any case, we may want to have
> lightweight tags allowed based on an extra flag (like the
> existing --tags for describe, which means something else for name-rev).
>
>  builtin/name-rev.c     | 2 ++
>  t/t9903-bash-prompt.sh | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 8bdc3eaa6f..75ba7bbad5 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -207,6 +207,8 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
>  	if (o && o->type == OBJ_COMMIT) {
>  		struct commit *commit = (struct commit *)o;
>  
> +		if (taggerdate == ULONG_MAX) /* lightweight tag */
> +			taggerdate = commit->date;
>  		path = name_ref_abbrev(path, can_abbreviate_output);
>  		name_rev(commit, xstrdup(path), taggerdate, 0, 0, deref);
>  	}

I think this comment indicates where this change will bite us ;-)  

This could have been an invocation of "name-rev" without "--tags",
where _any_ tip of ref can be used to name a revision, and in such a
case, retaining commit->date may still be valuable, but it is
probably wrong to use it for nothing more than tie-breaking.

In an extreme case, imagine that your repository does not have any
tag and you have a commit that can be reached from both 'maint' and
'master' branches.  Because the current code assigns the same
useless taggerdate for these tips of refs, the commit is described
solely based on the distance from the tip of 'maint' or 'master'
with today's code.

If you assign commit date to taggerdate variable here, that date is
used to trump the distance when deciding whether to name the commit
based on 'maint' and 'master', and I doubt it is what you want.
Perhaps I regularly advance 'master', but still add a few selected
fixes to 'maint' every few days---when these two branches both are
active like that, do you want the same commit that is topologically
much closer to 'maint' than 'master' to be described in terms of
'maint' on some days (i.e. those days I added fixes to it) and
'master' on some other days?

I think the expectation by end-users who do not use "--tags" is that
they still prefer a commit to be named in terms of the oldest tag
that is fewer number of hops away, and the naming to fall back to
non-tag refs only when there is no tags that reach the commit.  And
between two or more non-tag tips that are _known_ to be still active
(iow, branch tips), they want "fewer number of hops away" to be the
primary deciding factor to choose among them.  The ULONG_MAX setting
the code currently uses is very suitable for that purpose.  It
penalizes the non-tag refs, and it disables the use of timestamp for
deciding among these tips and uses only the topological distance.

I think you can do this change _ONLY_ when we are operating under
the "--tags" option.  That would place unannotated tags at a better
location in the timestamp order than the current code does, without
introducing issues with refs that are actively moving.
