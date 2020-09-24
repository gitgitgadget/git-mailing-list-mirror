Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD84C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 20:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D9122208
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 20:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kNx8Y8iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIXUx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 16:53:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59361 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgIXUx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 16:53:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBDE7E3589;
        Thu, 24 Sep 2020 16:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IcH4lKuiK8Nl/GID5+xZdv2AczM=; b=kNx8Y8
        iwyuTGlx1cJO4oaLG6Cmi9fD+EZ/O4b5vAzeENumdUJKZVvDdFmxg5ygGng8xl1a
        1/vuzlEWPwtZD/si8OerOO2b8OsxRilImcv/4my1jGXanZBxCJzc2lqN3kW1kLGX
        mjNtzX8u/pVblZzoJgkYNo/MF53J3E3eNmYrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wlz6n+Uag1v5tm2y4/60etsLsnocKfc1
        YX1cpBB/lslPMuP6Vq77WD2D4OMM4u5sirVdbM0aiI/6p9LgV4q+j1soTSQZ02+8
        3Gu78QOlcCd7LM7G6JlgcPwGBxN3YIfilMbarXIvN8t8XbQMrWOiHbCpgSXeiVpz
        puIChNpIw2I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B482BE3588;
        Thu, 24 Sep 2020 16:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 08252E3586;
        Thu, 24 Sep 2020 16:53:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect: don't use invalid oid as rev when starting
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
        <20200924060344.15541-1-chriscool@tuxfamily.org>
        <xmqqsgb7m2bq.fsf@gitster.c.googlers.com>
        <xmqqk0wjlzj8.fsf@gitster.c.googlers.com>
Date:   Thu, 24 Sep 2020 13:53:50 -0700
In-Reply-To: <xmqqk0wjlzj8.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 24 Sep 2020 12:56:11 -0700")
Message-ID: <xmqqd02anbfl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D5EF6F0-FEA8-11EA-AC9C-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I didn't audit the following hits of get_oid_committish().  There
> might be a similar mistake as you made in v2, or there may not be.
>
> I am undecided if I should just move on, marking them as
> left-over-bits ;-)
>
>
>
> builtin/blame.c:		if (get_oid_committish(i->string, &oid))

This one throws the object name of revs to be skipped to a list, and
because revision traversal works on commit objects, if the user
gives an annotated tag and expects the underlying commit is ignored,
it may appear as a bug.  But in the same function a list of revs to
be ignored is read from file using oidset_parse_file() that in turn
uses parse_oid_hex() without even validating if the named object
exists, I would say it is OK---after all, if it hurts, the user can
refrain from doing so ;-)

But it would be nice to fix all issues around this caller.  After
collecting the object names to an oidset, somebody should go through
the list, peel them down to commit and make sure they exist, or
something like that.  A possible #leftoverbits.

> builtin/checkout.c:		repo_get_oid_committish(the_repository, branch->name, &branch->oid);

This one is probably OK as branch refs are supposed to point at
commits and not annotated tags that point at commits.

> builtin/rev-parse.c:	if (!get_oid_committish(start, &start_oid) && !get_oid_committish(end, &end_oid)) {

This one handles "rev-parse v1.0..v2.0" which gives "^v1.0 v2.0" but
using the (unpeeled) object name.  It is fine and should not be
changed to auto-peel.

> builtin/rev-parse.c:	if (get_oid_committish(arg, &oid) ||

This is immediately followed by lookup_commit_reference() to peel as
needed.  OK.

> commit.c:	if (get_oid_committish(name, &oid))

This is part of lookup_commit_reference_by_name(), which peels and
parses it down to an in-core commit object instance.  OK.


> revision.c:	if (get_oid_committish(arg, &oid))

This is followed by a loop to peel it as needed.  OK.

> sequencer.c:		    !get_oid_committish(buf.buf, &oid))

This feeds the contents of rebase-merge/stopped-sha file.  I presume
that the contents of this file (which is not directly shown to the
end users) is always a commit object name, so this is OK.  Use of
_committish() may probably be overkill for this internal bookkeeping
file.  If we stop make_patch() from shortening then probably we can
change it to parse_oid_hex() to expect and read the full object
name.

> sha1-name.c:		st = repo_get_oid_committish(r, sb.buf, &oid_tmp);
> sha1-name.c:	if (repo_get_oid_committish(r, dots[3] ? (dots + 3) : "HEAD", &oid_tmp))

Since I know those who wrote this old part of the codebase knew what
they were doing, I do not have to comment, but these are fine.  They
are all peeled to commit as appropriate by calling
lookup_commit_reference_gently() before feeding the result to
get_merge_bases().

> sha1-name.c:int repo_get_oid_committish(struct repository *r,

This is the implementation ;-)

> t/helper/test-reach.c:		if (get_oid_committish(buf.buf + 2, &oid))

This peels afterwards, so it is OK.


The true reason I went through all the callers was to see if _all_
the callers want to either ignore the resulting object name (i.e.
they want to make sure that the arg given can be peeled down to an
appropriate type) or wants the object name to be peeled to the type.
If that were the case (and from the above, it clearly isn't), we
could change the semantics of get_oid_*ish() so that the resulting
oid is already peeled down to the wanted type and that could simplify
the current callers that are peeling the result themselves.

But because some callers do not want to see the result peeled, we
shouldn't touch what get_oid_*ish() functions do.


