Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6A381D8
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R2mKMUPa"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC0A1
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 15:08:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 84ACB332EA;
	Mon, 16 Oct 2023 18:08:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Sf6Sjsj6oTFf
	Mh7jx9zdfMzXR7mk82c65BVPlTwHHW4=; b=R2mKMUPaMDpcXLo0Il3tDWD+aKxl
	IrDWRoDSsqpcUHLar6IpRvSTLm6DHOkdF2yGumkfqrLMjwKPJbTRC/1lRsSTseTC
	lwKceRJPcUi8bd/5vmXRM4pnFCwJVegNhP8JVN/jvxaKJFh1G9NnS0st01+1XxLw
	EKN8M7RfZRemzmk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D4B2332E9;
	Mon, 16 Oct 2023 18:08:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0484F332E8;
	Mon, 16 Oct 2023 18:08:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] status: fix branch shown when not only bisecting
In-Reply-To: <2e24ca9b-9c5f-f4df-b9f8-6574a714dfb2@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sat, 9 Sep 2023 22:12:47 +0200")
References: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>
	<2e24ca9b-9c5f-f4df-b9f8-6574a714dfb2@gmail.com>
Date: Mon, 16 Oct 2023 15:08:32 -0700
Message-ID: <xmqqil76kyov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8C41ED4A-6C70-11EE-9533-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> In 83c750acde (wt-status.*: better advice for git status added,
> 2012-06-05), git-status received new informative messages to describe
> the ongoing work in a worktree.
>
> These messages were enhanced in 0722c805d6 (status: show the branch nam=
e
> if possible in in-progress info, 2013-02-03), to show, if possible, the
> branch where the operation was initiated.
>
> Since then, we show incorrect information when several operations are i=
n
> progress and one of them is bisect:
>
>    $ git checkout -b foo
>    $ GIT_SEQUENCE_EDITOR=3D'echo break >' git rebase -i HEAD~
>    $ git checkout -b bar
>    $ git bisect start
>    $ git status
>    ...
>
>    You are currently editing a commit while rebasing branch 'bar' on '.=
..'.
>
>    You are currently bisecting, started from branch 'bar'.
>
>    ...
>
> Note that we erroneously say "while rebasing branch 'bar'" when we
> should be referring to "foo".
>
> This must have gone unnoticed for so long because it must be unusual to
> start a bisection while another operation is in progress.  And even les=
s
> usual to involve different branches.
>
> It caught my attention reviewing a leak introduced in 8b87cfd000
> (wt-status: move strbuf into read_and_strip_branch(), 2013-03-16).
>
> A simple change to deal with this situation can be to record in struct
> wt_status_state, the branch where the bisect starts separately from the
> branch related to other operations.
>
> Let's do it and so we'll be able to display correct information and
> we'll avoid the leak as well.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
>
> ---
>
> Let's try again.

Sigh... nobody seems to be interested in making sure this correctly
improves the system X-<.

After a quick re-read, I didn't find anything glaringly wrong, so
let's see if anybody complains after the patch gets merged to
'next'.

Thanks.
