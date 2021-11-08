Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF67C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB46613B3
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbhKHXC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:02:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50652 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbhKHXC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 18:02:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DEC316A073;
        Mon,  8 Nov 2021 18:00:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L/433CZIJudf
        cEfvjc5cVrkhzNgISEO53vsh/XdEjL8=; b=sqTcUNbzBEwIFDa5p9D3k2Oj9r14
        qs+9k9L8n7JiU6sGSrvsPI5g9gJ721DWlJ1hVuQKZLNiWKYHeNDsKDkDBSWcZpZl
        +oVbluQqQAcptIXeNyS4mOVmZcKWlKfGh1Zb4Ir9siw5wyRFvZOqRCEdU+Pm65Oc
        9lbiYnK85tH1IL0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36CD016A072;
        Mon,  8 Nov 2021 18:00:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 928FB16A069;
        Mon,  8 Nov 2021 18:00:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v3 1/2] fetch: Protect branches checked out in all
 worktrees
References: <alpine.DEB.2.21.999.2111081514460.100671@scrubbing-bubbles.mit.edu>
Date:   Mon, 08 Nov 2021 15:00:05 -0800
In-Reply-To: <alpine.DEB.2.21.999.2111081514460.100671@scrubbing-bubbles.mit.edu>
        (Anders Kaseorg's message of "Mon, 8 Nov 2021 15:15:27 -0500 (EST)")
Message-ID: <xmqqa6ie5k3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9D86FC3C-40E7-11EC-A3E1-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

> As a side effect of using find_shared_symref, we=E2=80=99ll also refuse=
 the
> fetch when we=E2=80=99re on a detached HEAD because we=E2=80=99re rebas=
ing or bisecting
> on the branch in question. This seems like a sensible change.

True.

> -	if (current_branch &&
> -	    !strcmp(ref->name, current_branch->name) &&
> -	    !(update_head_ok || is_bare_repository()) &&
> +	if (!update_head_ok &&
> +	    (wt =3D find_shared_symref("HEAD", ref->name)) &&
>  	    !is_null_oid(&ref->old_oid)) {

We used to allow "git fetch" into a bare repository to update the
branch that happens to be pointed at by the HEAD symref.  The new
code still allow it, but the way it does so is subtle [*].

    Side note: The new code only works because find-shared-symref
    ignores a bare repository or a bare worktree.  I would not be
    surprised if somebody starts arguing that the behaviour to
    ignore bare worktrees is a bug in that function and may accept a
    patch to correct it, and when I do so, I may not remember that
    this new code depends on that "bug".

I would sleep better if we were one bit more careful, perhaps like
so:

+	if (!update_head_ok &&
+	    (wt =3D find_shared_symref(...)) &&
+	    !wt->is_bare &&
	    !is_null_oid(...)) {

to make sure we do not rely on that particular aspect of how
find_shared_symref() works.  The function asks "please find a
worktree, if any, whose HEAD points at this ref", and it feels
unnatural for the answer to the question is affected by the
bare-ness of the worktree.

>  		/*
>  		 * If this is the head, and it's not okay to update
>  		 * the head, and the old value of the head isn't empty...
>  		 */
>  		format_display(display, '!', _("[rejected]"),
> -			       _("can't fetch in current branch"),
> +			       wt->is_current ?
> +			       _("can't fetch in current branch") :
> +			       _("branch checked out in worktree"),

OK, the former is about this worktree, and the latter is about
worktree somewhere else.  It may clarify if we phrased the latter a
bit differently, e.g. "checked out in another worktree".  Once we
say "check(ed) out", we know we are talking about a branch, and
format_display() would be showing the name of the branch on the same
line anyway, so we could save the 6 letter spaces and tell the user
that it is not happening here, but some other place.

> +test_expect_success 'refuse fetch to current branch of worktree' '
> +	test_commit -C cloned second &&
> +	test_must_fail git fetch cloned HEAD:new-wt &&

This is because at this point in the test sequence, new-wt is the
current branch for the worktree we added in the test immediately
before this one.  And we refuse unless update-head-ok is given.  OK.

> +	git clone --bare . bare.git &&
> +	git -C bare.git worktree add bare-wt &&
> +	test_must_fail git -C bare.git fetch ../cloned HEAD:bare-wt &&

What is being tested here?  We created a bare clone bare.git and
added a worktree bare-wt to it.  And we try to fetch into that bare
repository, which would allow overwriting the branch pointed at by
HEAD (which is new-wt) or any branch if there weren't a worktree
that has a working tree.  But because it has a working tree attached
to it, namely, bare-wt, overwriting the current branch for that
worktree is prevented.  Good.

> +	git fetch -u cloned HEAD:new-wt &&
> +	git -C bare.git fetch -u ../cloned HEAD:bare-wt

These are to ensure that overriding the safety still works fine.
Good.

I cannot shake the feeling that this single test step is testing way
too many things and burden future developers who break one of the
steps to understand which step was broken, but these three are good
things to test.

Overall, looks quite good.

Thanks.


> +'
> +
>  test_done
