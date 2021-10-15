Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AA8C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176906109E
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbhJOQU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:20:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63102 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbhJOQU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:20:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3589815E86E;
        Fri, 15 Oct 2021 12:18:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qJuiGTPgSyag
        1R/tygnJwcIH7iZrKSScj08s57EREls=; b=ncrDqmBqsGWfDXSzRvcQ+hMPeYF1
        sMdoP0SMIKPXaXTufNa3Re++wQNx2q8Qy0ElNZObCpYLbw6CaQywQRZobFfUxWzo
        9hahBW4nfXIlMsF2AjmKig0z+HOVRknwU495Qyvtp2MUqeuMQ0vYbS347Nfwc+u/
        bdKrCQd9mwTq8DE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E94215E86D;
        Fri, 15 Oct 2021 12:18:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 14BC115E86B;
        Fri, 15 Oct 2021 12:18:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/3] commit-graph: don't consider "replace" objects with
 "verify"
References: <cover-0.3-00000000000-20211014T233343Z-avarab@gmail.com>
        <patch-3.3-56bb70518cb-20211014T233343Z-avarab@gmail.com>
Date:   Fri, 15 Oct 2021 09:18:45 -0700
In-Reply-To: <patch-3.3-56bb70518cb-20211014T233343Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 15 Oct
 2021 01:37:16 +0200")
Message-ID: <xmqqr1cm8dne.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 931AE032-2DD3-11EC-A2A3-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Extend the code added in d6538246d3d (commit-graph: not compatible
> with replace objects, 2018-08-20) which ignored replace objects in the
> "write" command to ignore it in the "verify" command too.
>
> We can just move this assignment to the cmd_commit_graph(), it
> dispatches to "write" and "verify", and we're unlikely to ever get a
> sub-command that would like to consider replace refs.
>
> This will make tests added in eddc1f556cd (mktag tests: test
> update-ref and reachable fsck, 2021-06-17) pass in combination with
> the "GIT_TEST_COMMIT_GRAPH" mode added in 859fdc0c3cf (commit-graph:
> define GIT_TEST_COMMIT_GRAPH, 2018-08-29), except that mode is
> currently broken (but is being fixed concurrently). See the discussion
> starting at [1].
>
> 1. https://lore.kernel.org/git/87wnmihswp.fsf@evledraar.gmail.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/commit-graph.c  | 2 +-
>  t/t5318-commit-graph.sh | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 3c3de3a156f..fb8e166a26f 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -263,7 +263,6 @@ static int graph_write(int argc, const char **argv)
>  	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
>  		flags |=3D COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
> =20
> -	read_replace_refs =3D 0;
>  	odb =3D find_odb(the_repository, opts.obj_dir);
> =20
>  	if (opts.reachable) {
> @@ -318,6 +317,7 @@ int cmd_commit_graph(int argc, const char **argv, c=
onst char *prefix)
>  	if (!argc)
>  		goto usage;
> =20
> +	read_replace_refs =3D 0;
>  	save_commit_buffer =3D 0;
> =20
>  	if (!strcmp(argv[0], "verify"))

OK.  The only question I have is if this deserves some kind of a
warning.  If the user has replacement defined and makes an explicit
request to work with the commit-graph, silently ignoring the request
instead of telling them why we are ignoring may lead to confusion.

	Side note.  It is a "question", not "objection".

Other than that, nicely done.

Thanks.

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 88fbe004a38..84d122a7ae7 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -385,6 +385,7 @@ test_expect_success 'replace-objects invalidates co=
mmit-graph' '
>  		git commit-graph write --reachable &&
>  		test_path_is_file .git/objects/info/commit-graph &&
>  		git replace HEAD~1 HEAD~2 &&
> +		graph_git_two_modes "commit-graph verify" &&
>  		git -c core.commitGraph=3Dfalse log >expect &&
>  		git -c core.commitGraph=3Dtrue log >actual &&
>  		test_cmp expect actual &&
