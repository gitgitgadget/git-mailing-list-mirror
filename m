Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3011C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC47361B2A
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhKPFwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:52:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60914 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbhKPFwL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 00:52:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DCE5F5548;
        Tue, 16 Nov 2021 00:49:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=VR+swJI+TtPnhZbgJJtTM5PPY
        dFA+AeOTQViBtDTYyA=; b=sDndrEfsJwnnlkerAn7lRR+PrePvkGASSKOWGcKIF
        rgYz4tSrsL4uvzGphlfOb0KxvuJEvuYjYU1N3+Sp3n4B/phUlynrU/Zf/FGijj87
        kkpXTKoYiOoKF/wFuJpng7GBH0/0VrulvhVr8yau1y5ie/POMvanom5DaSXslU7s
        DY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63FE9F5546;
        Tue, 16 Nov 2021 00:49:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B995CF5545;
        Tue, 16 Nov 2021 00:49:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 5/8] fetch: protect branches checked out in all
 worktrees
References: <20211113033358.2179376-1-andersk@mit.edu>
        <20211113033358.2179376-6-andersk@mit.edu>
Date:   Mon, 15 Nov 2021 21:49:08 -0800
Message-ID: <xmqq1r3gd50r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EB48FD3A-46A0-11EC-881A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

> Refuse to fetch into the currently checked out branch of any working
> tree, not just the current one.
>
> Fixes this previously reported bug:
>
> https://public-inbox.org/git/cb957174-5e9a-5603-ea9e-ac9b58a2eaad@mathe=
ma.de
>
> As a side effect of using find_shared_symref, we=E2=80=99ll also refuse=
 the
> fetch when we=E2=80=99re on a detached HEAD because we=E2=80=99re rebas=
ing or bisecting
> on the branch in question. This seems like a sensible change.

Indeed.

> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  builtin/fetch.c       | 75 +++++++++++++++++++++++--------------------
>  t/t5516-fetch-push.sh | 18 +++++++++++
>  2 files changed, 58 insertions(+), 35 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index e5971fa6e5..f373252490 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -28,6 +28,7 @@
>  #include "promisor-remote.h"
>  #include "commit-graph.h"
>  #include "shallow.h"
> +#include "worktree.h"
> =20
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
> =20
> @@ -840,14 +841,13 @@ static void format_display(struct strbuf *display=
, char code,
> =20
>  static int update_local_ref(struct ref *ref,
>  			    struct ref_transaction *transaction,
> -			    const char *remote,
> -			    const struct ref *remote_ref,
> -			    struct strbuf *display,
> -			    int summary_width)
> +			    const char *remote, const struct ref *remote_ref,
> +			    struct strbuf *display, int summary_width,
> +			    struct worktree **worktrees)
>  {
>  	struct commit *current =3D NULL, *updated;
>  	enum object_type type;
> -	struct branch *current_branch =3D branch_get(NULL);
> +	const struct worktree *wt;
>  	const char *pretty_ref =3D prettify_refname(ref->name);
>  	int fast_forward =3D 0;

Having to pass the parameter down to here through the

    ->do_fetch()
      ->backfill_tags() (or do_fetch() itself)
        ->consume_refs()
          ->store_updated_refs()
            ->update_local_ref()

callchain makes the "damage to the code" by the patch look larger
than it actually is.  The real change is ...

> @@ -862,16 +862,17 @@ static int update_local_ref(struct ref *ref,
>  		return 0;
>  	}
> =20
> -	if (current_branch &&
> -	    !strcmp(ref->name, current_branch->name) &&
> -	    !(update_head_ok || is_bare_repository()) &&
> -	    !is_null_oid(&ref->old_oid)) {
> +	if (!update_head_ok &&
> +	    (wt =3D find_shared_symref(worktrees, "HEAD", ref->name)) &&
> +	    !wt->is_bare && !is_null_oid(&ref->old_oid)) {

... this part, which looks very sensible.

>  		 * If this is the head, and it's not okay to update
>  		 * the head, and the old value of the head isn't empty...
>  		 */
>  		format_display(display, '!', _("[rejected]"),
> -			       _("can't fetch in current branch"),
> +			       wt->is_current ?
> +				       _("can't fetch in current branch") :
> +				       _("checked out in another worktree"),
>  			       remote, pretty_ref, summary_width);
>  		return 1;
>  	}

> @@ -1643,7 +1647,7 @@ static int do_fetch(struct transport *transport,
>  				  "you need to specify exactly one branch with the --set-upstream =
option"));
>  		}
>  	}
> - skip:
> +skip:
>  	free_refs(ref_map);

;-)

I count 30 hits of "^ [a-z0-9]*:" and 255 hits of "^[a-z0-9]*:" in
our codebase.  It must be some developers used to subscribe to
"don't place the label abut the left edge" school but no longer, or
something like that.

The code changes all look good to me.

Thanks.

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 4db8edd9c8..36fb90f4b0 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1770,4 +1770,22 @@ test_expect_success 'denyCurrentBranch and workt=
rees' '
>  	git -C cloned push origin HEAD:new-wt &&
>  	test_must_fail git -C cloned push --delete origin new-wt
>  '
> +
> +test_expect_success 'refuse fetch to current branch of worktree' '
> +	test_when_finished "git worktree remove --force wt && git branch -D w=
t" &&
> +	git worktree add wt &&
> +	test_commit apple &&
> +	test_must_fail git fetch . HEAD:wt &&
> +	git fetch -u . HEAD:wt
> +'
> +
> +test_expect_success 'refuse fetch to current branch of bare repository=
 worktree' '
> +	test_when_finished "rm -fr bare.git" &&
> +	git clone --bare . bare.git &&
> +	git -C bare.git worktree add wt &&
> +	test_commit banana &&
> +	test_must_fail git -C bare.git fetch .. HEAD:wt &&
> +	git -C bare.git fetch -u .. HEAD:wt
> +'
> +
>  test_done
