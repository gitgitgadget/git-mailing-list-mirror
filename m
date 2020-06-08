Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE27C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA552076C
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bGaq6rbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgFHV7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:59:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64710 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgFHV7d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 17:59:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C282ACC06C;
        Mon,  8 Jun 2020 17:59:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o4dVWq2rCoDoJI8OWRZ6vPLoZoI=; b=bGaq6r
        bftWBtPRok6V7JLtr8AHIAkL4xM1nZUS2eYtzOI9XP6sntCW5WIWZcM9UVrkEyfJ
        lC7qevdw9ZE4RGoxGVzzuNKIMhwi0HwtC861kG64OKqtR7v03X7rf0tOne7csBC1
        RsqPmJYobZZmpswq3oK04SHVtk1bqAov8Pysk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fhsbmcFjYF7fTAzsn1H/iTCA3C1jO1Hg
        CAILHBilKg/cTQIMQ8rIQVYvQLlIrZhlo95Y8qiEses1McmcqBMWySsqhXRZyfB1
        vUPTWdPQH5PXmjEuILrMkAbXgeLjqhkMCl3vFwANmHHHMUhG6+0YOTCqlXLqGDxq
        b+rS4758ysw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B9DF5CC06B;
        Mon,  8 Jun 2020 17:59:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07127CC06A;
        Mon,  8 Jun 2020 17:59:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jonathan =?utf-8?Q?M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH 6/8] worktree: prune linked worktree referencing main worktree path
References: <20200608062356.40264-1-sunshine@sunshineco.com>
        <20200608062356.40264-7-sunshine@sunshineco.com>
Date:   Mon, 08 Jun 2020 14:59:27 -0700
In-Reply-To: <20200608062356.40264-7-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 8 Jun 2020 02:23:54 -0400")
Message-ID: <xmqqmu5djk1s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53639A2C-A9D3-11EA-9AC4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 2cb95f16d4..eebd77c46d 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -153,6 +153,11 @@ static int prune_cmp(const void *a, const void *b)
>  
>  	if ((c = fspathcmp(x->string, y->string)))
>  	    return c;
> +	/* paths same; main worktee (util==0) sorts above all others */

missing 'r'.  "util ==NULL" or "!util"?  Is the "main worktree has
NULL in util" an invariant enforced by prune_worktrees()?

> +	if (!x->util)
> +		return -1;

If x->util and y->util are both NULL, shouldn't they compare equal?

Or is there something that enforces an invariant that there is only
one such x whose util is NULL?  Yes, that is the case...

> +	if (!y->util)
> +		return 1;
>  	/* paths same; sort by .git/worktrees/<id> */
>  	return strcmp(x->util, y->util);
>  }
> @@ -171,6 +176,7 @@ static void prune_dups(struct string_list *l)
>  static void prune_worktrees(void)
>  {
>  	struct strbuf reason = STRBUF_INIT;
> +	struct strbuf main = STRBUF_INIT;
>  	struct string_list kept = STRING_LIST_INIT_NODUP;
>  	DIR *dir = opendir(git_path("worktrees"));
>  	struct dirent *d;
> @@ -190,6 +196,10 @@ static void prune_worktrees(void)
>  	}
>  	closedir(dir);
>  
> +	strbuf_add_absolute_path(&main, get_git_common_dir());
> +	/* massage main worktree absolute path to match 'gitdir' content */
> +	strbuf_strip_suffix(&main, "/.");
> +	string_list_append(&kept, strbuf_detach(&main, 0));

... of course, it is done here.

The existing loop picks up all <id> from .git/worktrees/<id>/ and
they always have xstrdup(<id>) that cannot be NULL.  But the string
list item created here, whose util is NULL, is thrown into &kept and
there is nobody who adds a string list item with NULL in util.  So
yes, there is only one "main" prune_cmp() needs to worry about.

And the reason why prune_cmp() tiebreaks entries with the same .string
(i.e. "path") so that the primary worktree comes early is because ...

>  	prune_dups(&kept);

... deduping is done by later entries with the same path as an
earlier one, keeping the earliest one among the ones with the same
path.  We want the primary worktree to survive, or we'd be in deep
yoghurt.

That reason is more important to comment in prune_cmp() than the
hint that !util is for primary worktree.  IOW, "why do we sort the
primary one early?" is more important than "by inspecting .util
field, we sort primary one early" (the latter lacks "why").

>  	string_list_clear(&kept, 1);
>  
> diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
> index 7694f25a16..5f3db93b31 100755
> --- a/t/t2401-worktree-prune.sh
> +++ b/t/t2401-worktree-prune.sh
> @@ -114,4 +114,16 @@ test_expect_success 'prune duplicate (linked/linked)' '
>  	! test -d .git/worktrees/w2
>  '
>  
> +test_expect_success 'prune duplicate (main/linked)' '
> +	test_when_finished rm -fr repo wt &&
> +	test_create_repo repo &&
> +	test_commit -C repo x &&
> +	git -C repo worktree add --detach ../wt &&
> +	rm -fr wt &&
> +	mv repo wt &&
> +	git -C wt worktree prune --verbose >actual &&
> +	test_i18ngrep "duplicate entry" actual &&
> +	! test -d .git/worktrees/wt
> +'
> +
>  test_done
