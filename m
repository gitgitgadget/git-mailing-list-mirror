Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B9C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9DC60F5B
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243052AbhHZQnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:43:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51759 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhHZQnV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 12:43:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F87414A493;
        Thu, 26 Aug 2021 12:42:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+lxCIDDbYsAb
        QHrXVxTc/XWnEL6ruFqM0WGPG4gi6r0=; b=rrjTUjO89TdQp8MXy6ST1oi4w9Fb
        ezjkCJp+9nzg/hXx8I3wbIr+LeAid84WwhzS9xi8rAumj8ckh1Zm7WZFIOO+ZfFh
        PiD32IDxBrefMScUQ3AO07sAwzJaOpHLkfGv/B/CTnEO5SbWBSuQvpZX8hAdmON5
        MCi/5PylyilDPvs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8833A14A492;
        Thu, 26 Aug 2021 12:42:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D093514A491;
        Thu, 26 Aug 2021 12:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/6] tr2: fix memory leak & logic error in 2f732bf15e6
References: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
        <patch-v2-4.6-1aa0dbc394e-20210826T121820Z-avarab@gmail.com>
Date:   Thu, 26 Aug 2021 09:42:29 -0700
In-Reply-To: <patch-v2-4.6-1aa0dbc394e-20210826T121820Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 26 Aug
 2021 14:22:22
        +0200")
Message-ID: <xmqqeeagf98q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9B152DB0-068C-11EC-BCB5-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Subject: Re: [PATCH v2 4/6] tr2: fix memory leak & logic error in 2f732=
bf15e6

Please remember to write your commit titles to help readers of "git
shortlog".  This commit fixes get_ancestry_names() function.

    get_ancestry_names(): leave the parent list empty upon failure

or something like that.  The rest of the proposed log message looks
perfect and so do the changes to the code.

> In a subsequent commit I'll be replacing most of this code to log N
> parents, but let's first fix bugs introduced in the recent
> 2f732bf15e6 (tr2: log parent process name, 2021-07-21).
>
> It was using the strbuf_read_file() in the wrong way, its return value
> is either a length or a negative value on error. If we didn't have a
> procfs, or otherwise couldn't access it we'd end up pushing an empty
> string to the trace2 ancestry array.
>
> It was also using the strvec_push() API the wrong way. That API always
> does an xstrdup(), so by detaching the strbuf here we'd leak
> memory. Let's instead pass in our pointer for strvec_push() to
> xstrdup(), and then free our own strbuf. I do have some WIP changes to
> make strvec_push_nodup() non-static, which makes this and some other
> callsites nicer, but let's just follow the prevailing pattern of using
> strvec_push() for now.
>
> We'll also need to free that "procfs_path" strbuf whether or not
> strbuf_read_file() succeeds, which was another source of memory leaks
> in 2f732bf15e6, i.e. we'd leak that memory as well if we weren't on a
> system where we could read the file from procfs.
>
> Let's move all the freeing of the memory to the end of the
> function. If we're still at STRBUF_INIT with "name" due to not haven
> taken the branch where the strbuf_read_file() succeeds freeing it is
> redundant, so we could move it into the body of the "if", but just
> handling freeing the same way for all branches of the function makes
> it more readable.
>
> In combination with the preceding commit this makes all of
> t[0-9]*trace2*.sh pass under SANITIZE=3Dleak on Linux.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  compat/linux/procinfo.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
> index 62f8aaed4cc..bd01f017bc7 100644
> --- a/compat/linux/procinfo.c
> +++ b/compat/linux/procinfo.c
> @@ -18,12 +18,14 @@ static void get_ancestry_names(struct strvec *names=
)
> =20
>  	/* try to use procfs if it's present. */
>  	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
> -	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
> -		strbuf_release(&procfs_path);
> +	if (strbuf_read_file(&name, procfs_path.buf, 0) > 0) {
>  		strbuf_trim_trailing_newline(&name);
> -		strvec_push(names, strbuf_detach(&name, NULL));
> +		strvec_push(names, name.buf);
>  	}
> =20
> +	strbuf_release(&procfs_path);
> +	strbuf_release(&name);
> +
>  	return;
>  }
