Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB753C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 00:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244554AbiBDAmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 19:42:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62085 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiBDAmf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 19:42:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36E6711B011;
        Thu,  3 Feb 2022 19:42:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=omrg+TXvdhSX
        wpVxhHdpjaaBzZd5UzrYBDQF5a1uzWE=; b=KpjfL1KsJijtkKpue+4+SZTYpoJb
        aGXOwkQ6LxbJDu/hZSV6/Q2ZNB1YnTZbkDQQe80Sd6myQp7xO4nwI0S+y05UuZAg
        WuZeBIL7nsqDz8Upv6R4YZktUvu/XLx+jk+bDX+y+rEgJ46ULGYzHvOKG1NtJ0qB
        wjt1qPLWwZEe4Os=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C3ED11B010;
        Thu,  3 Feb 2022 19:42:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 795A911B00F;
        Thu,  3 Feb 2022 19:42:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Christian Couder <christian.couder@gmail.com>,
        "Miriam R." <mirucam@gmail.com>
Subject: Re: [PATCH v2 4/4] bisect--helper: double-check run command on exit
 code 126 and 127
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
        <xmqqilus3ctf.fsf@gitster.g>
        <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
        <20987dc6-e0c7-6ca2-19fd-2b323b3f6d9f@web.de>
Date:   Thu, 03 Feb 2022 16:42:33 -0800
In-Reply-To: <20987dc6-e0c7-6ca2-19fd-2b323b3f6d9f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 18 Jan 2022 13:46:32 +0100")
Message-ID: <xmqqa6f7pime.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57E75270-8553-11EC-AB4D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> When a run command cannot be executed or found, shells return exit code
> 126 or 127, respectively.  Valid run commands are allowed to return
> these codes as well to indicate bad revisions, though, for historical
> reasons.  This means typos can cause bogus bisect runs that go over the
> full distance and end up reporting invalid results.
>
> The best solution would be to reserve exit codes 126 and 127, like
> 71b0251cdd (Bisect run: "skip" current commit if script exit code is
> 125., 2007-10-26) did for 125, and abort bisect run when we get them.
> That might be inconvenient for those who relied on the documentation
> stating that 126 and 127 can be used for bad revisions, though.

I think the basic idea is sound and useful.  How happy are we who
was involved in the discussion with this result?

> +static int get_first_good(const char *refname, const struct object_id =
*oid,
> +			  int flag, void *cb_data)
> +{
> +	oidcpy(cb_data, oid);
> +	return 1;
> +}

OK, this iterates and stops at the first one.

> +static int verify_good(const struct bisect_terms *terms,
> +		       const char **quoted_argv)
> +{
> +	int rc;
> +	enum bisect_error res;
> +	struct object_id good_rev;
> +	struct object_id current_rev;
> +	char *good_glob =3D xstrfmt("%s-*", terms->term_good);
> +	int no_checkout =3D ref_exists("BISECT_HEAD");
> +
> +	for_each_glob_ref_in(get_first_good, good_glob, "refs/bisect/",
> +			     &good_rev);
> +	free(good_glob);
> +
> +	if (read_ref(no_checkout ? "BISECT_HEAD" : "HEAD", &current_rev))
> +		return -1;

 * Could the current_rev already be marked as "good", in which case
   we can avoid cost of rewriting working tree files to a
   potentially distant revision?  I often do manual tests to mark
   "bisect good" or "bisect bad" before using "bisect run".

 * Can we have *no* rev that is marked as "good"?  I think we made
   it possible to say "my time is more valuable than machine cycles,
   so I'll only tell you that this revision is broken and give you
   no limit on the bottom side of the history.  still assume that
   there was only one good-to-bad transition in the history and find
   it" by supplying only one "bad" and no "good" when starting to
   bisect.  And in such a case, ...

> +	res =3D bisect_checkout(&good_rev, no_checkout);

... this would feed an uninitialized object_id to bisect_checkout.

Thanks.
