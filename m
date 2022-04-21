Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F084AC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 22:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442477AbiDUWco (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 18:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442484AbiDUWce (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 18:32:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4270A4B850
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 15:29:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D124911B983;
        Thu, 21 Apr 2022 18:29:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tCCJJqHbS+eX
        4ngXinGyjO/D3oAly9C/qBUGhNKFh3w=; b=DzQynBC5FW0zjXdqs/BkETsepZi7
        vEvpgYHHLDknqU6NIvhWQtQRsJwcUcCFuHcAgdeCbXnEQOIY06EdWxXFlMVtJv9P
        9Q+3/fpaKZY9wY7QBo2xv/OF4W67dRecn8vfneTBGGFjk8EwEu5EpGQzfti2MW8v
        e4x0b3VoSBtH9sA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C726A11B982;
        Thu, 21 Apr 2022 18:29:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B78211B981;
        Thu, 21 Apr 2022 18:29:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH 3/4] commit-graph.c: don't assume that stat() succeeds
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
        <patch-3.4-fadaa08a3ff-20220421T200733Z-avarab@gmail.com>
Date:   Thu, 21 Apr 2022 15:29:40 -0700
In-Reply-To: <patch-3.4-fadaa08a3ff-20220421T200733Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Apr
 2022 22:14:36 +0200")
Message-ID: <xmqqee1qdq97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 893DE162-C1C2-11EC-98AE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix code added in 8d84097f965 (commit-graph: expire commit-graph
> files, 2019-06-18) to check the return value of the stat() system
> call. Not doing so caused us to use uninitialized memory in the "Bloom
> generation is limited by --max-new-filters" test in
> t4216-log-bloom.sh:
>
> 	+ rm -f trace.event
> 	+ pwd
> 	+ GIT_TRACE2_EVENT=3D[...]/t/trash directory.t4216-log-bloom/limits/tr=
ace.event git commit-graph write --reachable --split=3Dreplace --changed-=
paths --max-new-filters=3D2
> 	=3D=3D24835=3D=3D Syscall param utimensat(times[0].tv_sec) points to u=
ninitialised byte(s)
> 	=3D=3D24835=3D=3D    at 0x499E65A: __utimensat64_helper (utimensat.c:3=
4)
> 	=3D=3D24835=3D=3D    by 0x4999142: utime (utime.c:36)
> 	=3D=3D24835=3D=3D    by 0x552BE0: mark_commit_graphs (commit-graph.c:2=
213)
> 	=3D=3D24835=3D=3D    by 0x550822: write_commit_graph (commit-graph.c:2=
424)
> 	=3D=3D24835=3D=3D    by 0x54E3A0: write_commit_graph_reachable (commit=
-graph.c:1681)
> 	=3D=3D24835=3D=3D    by 0x4374BB: graph_write (commit-graph.c:269)
> 	=3D=3D24835=3D=3D    by 0x436F7D: cmd_commit_graph (commit-graph.c:326=
)
> 	=3D=3D24835=3D=3D    by 0x407B9A: run_builtin (git.c:465)
> 	=3D=3D24835=3D=3D    by 0x406651: handle_builtin (git.c:719)
> 	=3D=3D24835=3D=3D    by 0x407575: run_argv (git.c:786)
> 	=3D=3D24835=3D=3D    by 0x406410: cmd_main (git.c:917)
> 	=3D=3D24835=3D=3D    by 0x511F09: main (common-main.c:56)
> 	=3D=3D24835=3D=3D  Address 0x1ffeffde70 is on thread 1's stack
> 	=3D=3D24835=3D=3D  in frame #1, created by utime (utime.c:25)
> 	=3D=3D24835=3D=3D  Uninitialised value was created by a stack allocati=
on
> 	=3D=3D24835=3D=3D    at 0x552B50: mark_commit_graphs (commit-graph.c:2=
201)
> 	=3D=3D24835=3D=3D
> 	[...]
> 	error: last command exited with $?=3D126
> 	not ok 137 - Bloom generation is limited by --max-new-filters
>
> This would happen as we stat'd the non-existing
> ".git/objects/info/commit-graph" file. Let's fix mark_commit_graphs()
> to check the statu() return value, and while we're at it fix another

"statu" -> "stat".

> case added in the same commit to do the same.
>
> The caller in expire_commit_graphs() would have been less likely to
> run into this, as it's operating on files it just got from readdir(),
> but it could still happen due to a race with e.g. a concurrent "rm
> -rf" of the commit-graph files.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  commit-graph.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 441b36016ba..2b528187316 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2206,7 +2206,8 @@ static void mark_commit_graphs(struct write_commi=
t_graph_context *ctx)
>  		struct stat st;
>  		struct utimbuf updated_time;
> =20
> -		stat(ctx->commit_graph_filenames_before[i], &st);
> +		if (stat(ctx->commit_graph_filenames_before[i], &st) < 0)
> +			continue;
> =20
>  		updated_time.actime =3D st.st_atime;
>  		updated_time.modtime =3D now;

If we think a commit-graph file should exist and it turns out that
the file is gone, we cannot update the file's timestamps, so we need
to do something about it, but is "continue" the most sensible thing,
I have to wonder?

Of course, missing file is not the only reason not being able to
stat(); what I am getting at is if this should be warned to the
user, or perhaps something like "warn unless ENOENT".

> @@ -2247,7 +2248,8 @@ static void expire_commit_graphs(struct write_com=
mit_graph_context *ctx)
>  		strbuf_setlen(&path, dirnamelen);
>  		strbuf_addstr(&path, de->d_name);
> =20
> -		stat(path.buf, &st);
> +		if (stat(path.buf, &st) < 0)
> +			continue;

Ditto about "should we warn".

>  		if (st.st_mtime > expire_time)
>  			continue;

But just "continue" is the change with least impact.  In either of
these codepaths, we blindly continued and ran utime() or unlink()
without checking their return status, but we now refrain from
touching them when we cannot stat().

So, I guess the only actionable thing that needs fixing in this
patch is the "statu" typo.

Thanks.
