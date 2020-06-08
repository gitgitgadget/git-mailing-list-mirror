Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A8CC433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0836C206D5
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hle0yCcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgFHVXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:23:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64363 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgFHVXz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 17:23:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 572AACB3B9;
        Mon,  8 Jun 2020 17:23:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Norz0vv1ifLlxPS9BC3bCG0D5YY=; b=Hle0yC
        cL+W3P1V6Mj2Sv+nbobdRk8/kxL5TxxYF6/N9LgwXTgz9Z26LN4Dhy6JUG8kJvd1
        1P1vXWfrU6eJ+x0UjJe6qW1XVAd+jy8Rsc9JibDxhzaCclNp50H7NF9rNADJTQ3Q
        YKtJw3oYV2za4G6qAD+3j7USn4xItuAh5yV+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cr5OFo8JNNzVBPwyDI+6AstSoCFRP6K9
        sbFVV9IJdsbZWJW0MkLfNTGUcdMXNupwpTT+v2fNkwbk74XVCqh6eJ6wwwKehZ8/
        cSPv4Su229ZctM0s3fdSWZnm4OOQCsB7v5UuVzWy19Dmwsnd5dPaIiQtSk7Dyl4W
        FdoaNTKjuhw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FD78CB3B8;
        Mon,  8 Jun 2020 17:23:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9215DCB3B7;
        Mon,  8 Jun 2020 17:23:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jonathan =?utf-8?Q?M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH 2/8] worktree: prune corrupted worktree even if locked
References: <20200608062356.40264-1-sunshine@sunshineco.com>
        <20200608062356.40264-3-sunshine@sunshineco.com>
Date:   Mon, 08 Jun 2020 14:23:44 -0700
In-Reply-To: <20200608062356.40264-3-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 8 Jun 2020 02:23:50 -0400")
Message-ID: <xmqqzh9djlpb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56663A22-A9CE-11EA-B3DE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The .git/worktrees/<id>/locked file created by "git worktree lock" is
> intended to prevent a missing worktree -- which might reside on a
> removable device or network share -- from being pruned. It is not meant
> to prevent a corrupt worktree from being pruned, yet it short-circuits
> almost all "git worktree prune" corruption checks.

The '.git/worktrees/<id>/locked' file is what 'It' in "It is not
meant to" refers to, but the 'it' in "yet it short-circuits" cannot
refer to the same thing---my reading hiccuped there.

"Its presence causes most of the corruption checks skipped by 'git
worktree prune'", perhaps.

> This can make it
> impossible[1] to prune a worktree which becomes corrupt after the lock
> is placed since "git worktree prune" won't prune it, and it may not even
> be possible to unlock it with "git worktree unlock", depending upon the
> nature of the corruption.

The latter is because... "worktree unlock" does not skip corruption
check and refuses to unlock a corrupted worktree, or something?

> Therefore, delay the check for .git/worktrees/<id>/locked until after
> all forms of corruption have been checked so that it behaves as
> originally intended (to wit: preventing pruning of a missing worktree
> only).

An alternative could be to allow unlocking a worktree even if it is
corrupt, and with that, such an unprunable corrupt worktree can
first be unlocked and then pruned?  A naive first thought is that
might make it slightly safer, but the reason why this approach was
taken is because the end user already said 'prune' so that should
trump whatever ".git/worktrees/<id>/" has?

But the intent of locking a worktree is "make sure that the end user
is aware of the fact that it is locked before allowing the worktree
to be pruned", isn't it?  Unless there is a way for a corruption to
add the "locked" file the end-user did not intend to have, if we
sense the "locked" file given to a worktree, shouldn't we honor that
existing "locked" file's intent?

I am growing skeptical about the approach taken by this step.  There
must be something missing that I may become aware of after reading
the remainder of the series.

	... goes back and digs a bit ...

This came from 23af91d1 (prune: strategies for linked checkouts,
2014-11-30) which explains:

    To prevent `git prune --worktrees` from deleting a
    $GIT_DIR/worktrees entry (which can be useful in some
    situations, such as when the entry's working tree is stored on a
    portable device), add a file named 'locked' to the entry's
    directory.

Notice that "in some situations, such as" gives just one example,
and it is clear that it is the only envisioned use case.

It therefore feels more sensible to honor the "locked" file whether
the actual worktree (or just a part of it) is accessible or not when
"prune" gets exercised.  After all, if some parts of the actual
worktree gets moved to removal media when not in use, such a partial
removal may make the worktree appear as if it is "corrupt".  We do
not want to declare that it is corrupt and we ignore the locked
state, or do we?

Thanks.

> [1]: Impossible, that is, without manually mucking around with
>      .git/worktrees/<id>/ administrative files.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  builtin/worktree.c        |  4 ++--
>  t/t2401-worktree-prune.sh | 14 ++++++++++++--
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 9b15f19fc5..f7351413af 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -79,8 +79,6 @@ static int prune_worktree(const char *id, struct strbuf *reason)
>  		strbuf_addstr(reason, _("not a valid directory"));
>  		return 1;
>  	}
> -	if (file_exists(git_path("worktrees/%s/locked", id)))
> -		return 0;
>  	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
>  		strbuf_addstr(reason, _("gitdir file does not exist"));
>  		return 1;
> @@ -121,6 +119,8 @@ static int prune_worktree(const char *id, struct strbuf *reason)
>  	path[len] = '\0';
>  	if (!file_exists(path)) {
>  		free(path);
> +		if (file_exists(git_path("worktrees/%s/locked", id)))
> +			return 0;
>  		if (stat(git_path("worktrees/%s/index", id), &st) ||
>  		    st.st_mtime <= expire) {
>  			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
> diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
> index b7d6d5d45a..9be8e97d66 100755
> --- a/t/t2401-worktree-prune.sh
> +++ b/t/t2401-worktree-prune.sh
> @@ -69,13 +69,23 @@ test_expect_success 'prune directories with gitdir pointing to nowhere' '
>  '
>  
>  test_expect_success 'not prune locked checkout' '
> -	test_when_finished rm -r .git/worktrees &&
> -	mkdir -p .git/worktrees/ghi &&
> +	test_when_finished rm -fr .git/worktrees ghi &&
> +	git worktree add ghi &&
>  	: >.git/worktrees/ghi/locked &&
> +	rm -r ghi &&
>  	git worktree prune &&
>  	test -d .git/worktrees/ghi
>  '
>  
> +test_expect_success 'prune corrupt despite lock' '
> +	test_when_finished rm -fr .git/worktrees ghi &&
> +	mkdir -p .git/worktrees/ghi &&
> +	: >.git/worktrees/ghi/gitdir &&
> +	: >.git/worktrees/ghi/locked &&
> +	git worktree prune &&
> +	! test -d .git/worktrees/ghi
> +'
> +
>  test_expect_success 'not prune recent checkouts' '
>  	test_when_finished rm -r .git/worktrees &&
>  	git worktree add jlm HEAD &&
