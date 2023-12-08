Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EcZGuLOu"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7730BD
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 13:00:12 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C49B51C8A53;
	Fri,  8 Dec 2023 16:00:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=b52TXXM/NFapGjRlH0AOThs/BqNKELI/cNmchi
	7+11I=; b=EcZGuLOuOeU6MqVaa+UEs08+6kt6I696kiIrU+Frm7mDWh0m45JIJT
	o/O+HBNYDmnCCoOhingri07ebiRBAT3KbStGvDLzp1pRDEuo/6jQ3HOUT7GxVGEY
	a34wLBld+xqTk2YPWvgichH6RJVvHuTYw3HGCDDcv1FRzrpLacaqw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B928F1C8A52;
	Fri,  8 Dec 2023 16:00:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06BB21C8A4E;
	Fri,  8 Dec 2023 16:00:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Achu Luma <ach.lumap@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org
Subject: Re: [Outreachy][PATCH v3] t2400: avoid using pipes
In-Reply-To: <20231204153740.2992-1-ach.lumap@gmail.com> (Achu Luma's message
	of "Mon, 4 Dec 2023 16:37:40 +0100")
References: <CAP8UFD0KDdwoJw6AzLUpqos=bLumcmDax59_MfQ9TUFqmmpcoA@mail.gmail.com>
	<20231204153740.2992-1-ach.lumap@gmail.com>
Date: Sat, 09 Dec 2023 06:00:09 +0900
Message-ID: <xmqqr0jw1kbq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C694D6B8-960C-11EE-816B-25B3960A682E-77302942!pb-smtp2.pobox.com

Achu Luma <ach.lumap@gmail.com> writes:

> Subject: Re: [Outreachy][PATCH v3] t2400: avoid using pipes

"avoid using pipes" is a means to an end.  And it is more important
to tell readers what that "end" is.  With this patch, what are we
trying to achieve?  Cater to platforms that lack pipes?  Help
platforms that cannot run two processes at the same time, so let one
run and store the result in a file, and then let the other one run,
to reduce the CPU load?

If we run a "git" command, especially a command we are testing, on
the upstream side of a pipe, we lose information.  We cannot tell
what exit status the command exited with.  That is what we care
about.

So, it is better to say that in the title, e.g.,

    Subject: [PATCH] t2400: avoid losing exit status to pipes

> The exit code of the preceding command in a pipe is disregarded,
> so it's advisable to refrain from relying on it.

It is unclear what "it" refers to here.  We cannot rely on the exit
code of the command on the upstream side of a pipe, obviously.

> Instead, by
> saving the output of a Git command to a file, we gain the
> ability to examine the exit codes of both commands separately.

Surely.  I personally think that the title that says what the
purpose of the patch is clearly should be sufficient without any
further description in the body, though.
>
> Signed-off-by: Achu Luma <ach.lumap@gmail.com>
> ---
>  Since v2 I don't send a cover  letter anymore, and I changed 
>  my "Signed-of-by: ..." line so that it
>  contains my full real name and I added "Outreachy" to the subject.

Nicely done.

>
>  t/t2400-worktree-add.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index df4aff7825..7ead05bb98 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -468,7 +468,8 @@ test_expect_success 'put a worktree under rebase' '
>  		cd under-rebase &&
>  		set_fake_editor &&
>  		FAKE_LINES="edit 1" git rebase -i HEAD^ &&
> -		git worktree list | grep "under-rebase.*detached HEAD"
> +		git worktree list >actual && 
> +		grep "under-rebase.*detached HEAD" actual
>  	)
>  '
>  
> @@ -509,7 +510,8 @@ test_expect_success 'checkout a branch under bisect' '
>  		git bisect start &&
>  		git bisect bad &&
>  		git bisect good HEAD~2 &&
> -		git worktree list | grep "under-bisect.*detached HEAD" &&
> +		git worktree list >actual && 
> +		grep "under-bisect.*detached HEAD" actual &&
>  		test_must_fail git worktree add new-bisect under-bisect &&
>  		! test -d new-bisect
>  	)
