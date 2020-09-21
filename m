Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5497C4727C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 21:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD7523A60
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 21:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R1zZamlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgIUVvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 17:51:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52654 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUVvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 17:51:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC8D08FE28;
        Mon, 21 Sep 2020 17:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SmDGLpH2USb03SeWMmDKvNupbl0=; b=R1zZam
        ltYfvEAz0lD2RFJKpsu580+l5PFsmkGaYTpvvz0g5ETAtITRkAolCGJeYhsY+BGZ
        IP2bSGP5FeZe4T+qKCKxLivs5Gd5+Jlw879ElAE8zTQC51ZrV+iGVtINnRsi7ZBx
        2s1CI9Ft5yYYwDQdwG28w6j1T48sa8IeSx8Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RCBn4kWVSiCJDf8qS/RjbGLhn5xqMXsE
        HEAz0QviEpjhywplGR2IHIn61liUaqS7GZKdsW76EoXG1zdyDXbyfe2IHDzJzOO7
        OOvnB1dhuGlax567Xi6QfV4nkApmj1cM/SePrWbXrDV4QhT0eQIyrpgzxsbn1FdD
        107DfsS7+uA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D506B8FE27;
        Mon, 21 Sep 2020 17:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6295A8FE25;
        Mon, 21 Sep 2020 17:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        dermoth@aei.ca
Subject: Re: [PATCH v2] diff: Fix modified lines stats with --stat and
 --numstat
References: <20200918113256.8699-2-tguyot@gmail.com>
        <20200920130945.26399-1-tguyot@gmail.com>
        <20200920153915.GB2726066@nand.local>
        <xmqqlfh4gt5z.fsf@gitster.c.googlers.com>
        <20200921192630.GA2399334@coredump.intra.peff.net>
Date:   Mon, 21 Sep 2020 14:51:21 -0700
In-Reply-To: <20200921192630.GA2399334@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 21 Sep 2020 15:26:30 -0400")
Message-ID: <xmqqft7aer3a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96B6B826-FC54-11EA-B0C9-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For diffstat, though, it seems like a waste of time; we don't care what
> the object hash is. I.e., if we were to do this:
>
> diff --git a/diff.c b/diff.c
> index 16eeaf6645..1934af29a5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4564,9 +4564,6 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
>  	if (o->prefix_length)
>  		strip_prefix(o->prefix_length, &name, &other);
>  
> -	diff_fill_oid_info(p->one, o->repo->index);
> -	diff_fill_oid_info(p->two, o->repo->index);
> -
>  	builtin_diffstat(name, other, p->one, p->two,
>  			 diffstat, o, p);
>  }
>
> then everything seems to work fine _except_ a "git diff --stat
> --no-index", exactly because it hits this "same_contents" check we've
> been discussing. And once that is fixed properly (to handle any case
> where we have no oid, not just when the stdin flag is set), then perhaps
> it is worth doing.

> Or perhaps not. Even if we have to memcmp sometimes in
> builtin_diffstat(), it would be faster than computing the individual
> hashes. But it may not be measurably so, and it would be no difference
> for the common case of filespecs for which we do know the oid for free.
> I also suspect we'd need to be a little smarter about combined formats
> (e.g., "--stat --patch" might as well compute the oid as early as
> possible, since we'll need it eventually for the patch; but we'd hit the
> call in builtin_diffstat() before the one in run_diff()).
>
>> But there are paths for which oid cannot be computed without
>> destroying their contents.  Such paths are marked by the function
>> with null_oid.
>
> I'm not clear how computing the oid destroys the contents. We have them
> in an in-memory buffer at this point, don't we? So we _could_ generate
> an oid even for stdin, like this:

Yes, yes yes.  That is the "best" (which later retracted) approach I
suggested in the same message, but it would end up filling a
real-looking object name for working tree side of diff-files, which
has a far larger consequence we need to think about and consumes
more brain cycles than warranted here, I would think.

>> Summarizing the above, I think the second best fix is this (which
>> means that the posted patch is the third best):
>> 
>> 	/*
>> 	 * diff_fill_oid_info() marked one/two->oid with null_oid
>> 	 * for a path whose oid is not available.  Disable early
>> 	 * return optimization for them.
>> 	 */
>> 	if (oideq(&one->oid, &null_oid) || oideq(&two->oid, &null_oid))
>> 		same_contents = 0; /* could be different */
>> 	else if (oideq(&one->oid, &two->oid))
>> 		same_contents = 1; /* definitely the same */
>> 	else
>> 		same_contents = 0; /* definitely different */
>
> This is the direction I was getting at in my earlier emails, except that
> I imagined that first conditional could be checking:
>
>   if (!one->oid_valid || !two->oid_valid)
>
> but I was surprised to see that diff_fill_oid_info() does not set
> oid_valid. Is that a bug?

I do not think so.  oid_valid refers to the state during the
collection phase (those who called diff_addremove() etc.) and
updating it in diff_fill_oid_info() would lose information.  Maybe
nobody looks at the bit at this late in the processing chain these
days, in which case we can start flipping the bit there, but I
offhand do not know what consequences such a change would trigger.

> I also imagined that we'd have to determine right then whether the
> contents are actually different or not with a memcmp(), to avoid
> emitting a "0 changes" line, but we do handle that case within the
> "!same_contents" conditional. See the comment starting with "Omit
> diffstats..." added recently by 1cf3d5db9b (diff: teach --stat to ignore
> uninteresting modifications, 2020-08-20).

Yes, we are essentially on the same page---same_contents bit is
merely an optimization to decide cheaply when we do not have to do
xdl, but the codepath that does the xdl must be prepared to deal
with the "we thought they are different, but after all they turn out
to be equivalent" case.  Therefore false positive to declare two
different things as same cannot be tolerated, but false negative to
declare two things that are the same as !same_contents is fine.
