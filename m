Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DACC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391451AbiDUSjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391425AbiDUSjg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:39:36 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC53915C
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:46 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57D8D194FD6;
        Thu, 21 Apr 2022 14:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YNgIAgSovcbC
        UMnAvgrlLgnmPcj0fSW2PAhDYZ258Pw=; b=ZuOz4vx5aUSd6p2tOTfXhWyO4q4p
        sAJLQ8SK3bb84ecdZin9w3YyG19VXqDtZomLHQ4kmlJNpDDdetEjtITF7KharmSz
        IPqnArBvgAEuN5r7OuJBpSGC3ZTUq4KUlAIlruqXs6sL7LHFHVqnrVrSBqu5/owR
        4tCwVZ4mfk+zjg8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 501BA194FD5;
        Thu, 21 Apr 2022 14:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC8E5194FD4;
        Thu, 21 Apr 2022 14:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Gregory David <gregory.david@p1sec.com>,
        ptm-dev <ptm-dev@p1sec.com>
Subject: Re: [PATCH v3 2/2] show-branch: fix SEGFAULT when `--current` and
 `--reflog` together
References: <225b410d-2d98-8c0b-c289-22f753c175d4@p1sec.com>
        <cover-v3-0.2-00000000000-20220421T152704Z-avarab@gmail.com>
        <patch-v3-2.2-396c3338533-20220421T152704Z-avarab@gmail.com>
Date:   Thu, 21 Apr 2022 11:36:40 -0700
In-Reply-To: <patch-v3-2.2-396c3338533-20220421T152704Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Apr
 2022 17:33:48
        +0200")
Message-ID: <xmqqczhai8qv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FCE72748-C1A1-11EC-8A2D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> From: Gregory David <gregory.david@p1sec.com>
>
> If run `show-branch` with `--current` and `--reflog` simultaneously, a
> SEGFAULT appears.
>
> The bug is that we read over the end of the `reflog_msg` array after
> having `append_one_rev()` for the current branch without supplying a
> convenient message to it.
>
> It seems that it has been introduced in:
> Commit 1aa68d6735 (show-branch: --current includes the current branch.,
> 2006-01-11)
>
> Signed-off-by: Gregory DAVID <gregory.david@p1sec.com>
> Thanks-to: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/show-branch.c  | 13 +++++++++++++
>  t/t3202-show-branch.sh | 43 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 499ef76a508..50c17fb5c31 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -821,6 +821,19 @@ int cmd_show_branch(int ac, const char **av, const=
 char *prefix)
>  		}
>  		if (!has_head) {
>  			const char *name =3D head;
> +			struct object_id oid;
> +			char *ref;
> +			char *msg;
> +			timestamp_t ts;
> +			int tz;
> +
> +			if (!dwim_ref(*av, strlen(*av), &oid, &ref, 0))
> +				die(_("no such ref %s"), *av);
> +			read_ref_at(get_main_ref_store(the_repository), ref,
> +				    flags, 0, i, &oid, &msg, &ts, &tz, NULL);

Do we really mean to pass 'i', which is the number of other things we hav=
e added,
to read_ref_at()?  Does that mean

    git show-branch -g4 --current

shows the 4th entry from the current branch while

    git show-branch -g2 --current

shows the second?

> +			reflog_msg[ref_name_cnt] =3D fmt_reflog(msg, ts, tz,
> +							      "(%s) (current) %s");

This unconditionally reads reflog and adds to reflog_msg[], without
even seeing if we are actually showing reflog entries.  Is that
sensible?

I am wondering if we should have factored out a bit more in the
previous step.  Instead of "here is what we read from read_ref_at(),
format it", I wonder if the interface should be "here is a ref and
the offset N; format the Nth entry".  And then this part can become
something like (I do not know about 'i', but that is meant to be the
reflog offset, i.e. "HEAD@{i}").

	if (!has_head) {
		if (reflog) {
			dwim_ref to learn ref;
			reflog_msg[ref_name_cnt] =3D new_helper(ref, i);
		} else {
			skip_prefix(name, "refs/heads/", head);
			append_one_rev(name);
		}
	}

In any case, I am not sure if it even makes sense to allow the
reflog listing mode with "current" in the first place, and a simpler
option may be to just forbid the combination.  After all, when I
adeed "--current" to "git show-branch" in 1aa68d67 (show-branch:
--current includes the current branch., 2006-01-11), it was clearly
meant to be used with "other branches"---"I would list branches I
care about and I use as anchoring points on the command line, and I
may or may not be on one of these main branches. Please make sure I
can view the current one with respect to these other branches" is
what "--current" is about, and mixing it with "how do recent reflog
entries relate to each other" does not make much sense.
