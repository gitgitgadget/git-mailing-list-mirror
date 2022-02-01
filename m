Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9910C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 22:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiBAWvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 17:51:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51371 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiBAWvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 17:51:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD69E1761AF;
        Tue,  1 Feb 2022 17:51:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SudAz5rjhXLPIu86vBin/qp9rMJhZjzRHOhwoR
        t2fzs=; b=FvD8aUJU9egSoWldLCWVbOE2TCBzb5Epx8Xh9ArRdzK6j+URu0IrEW
        IYPoSCETckF6wJpZRYPCB5YySl5FhU332XzRfqpaj6HA2rczOLZX6c6yLep4vNq4
        TT4squz2as7k2/phEiXWOuzZrgS0htHKm7+M+zhoy+v8oI0sAPwXM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0EEB1761AE;
        Tue,  1 Feb 2022 17:51:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3E2FC1761AD;
        Tue,  1 Feb 2022 17:51:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chen BoJun <bojun.cbj@gmail.com>
Cc:     git@vger.kernel.org, Chen Bojun <bojun.cbj@alibaba-inc.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v2] receive-pack: purge temporary data if no command is
 ready to run
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
        <20220129063538.24038-1-bojun.cbj@gmail.com>
Date:   Tue, 01 Feb 2022 14:51:26 -0800
In-Reply-To: <20220129063538.24038-1-bojun.cbj@gmail.com> (Chen BoJun's
        message of "Sat, 29 Jan 2022 14:35:38 +0800")
Message-ID: <xmqqczk6b3pt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DAED0E4-83B1-11EC-81FF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chen BoJun <bojun.cbj@gmail.com> writes:

> From: Chen Bojun <bojun.cbj@alibaba-inc.com>
>
> When pushing a hidden ref, e.g.:
>
>     $ git push origin HEAD:refs/hidden/foo
>
> "receive-pack" will reject our request with an error message like this:
>
>     ! [remote rejected] HEAD -> refs/hidden/foo (deny updating a hidden ref)
>
> The remote side ("git-receive-pack") will not create the hidden ref as
> expected, but the pack file sent by "git-send-pack" is left inside the
> remote repository. I.e. the quarantine directory is not purged as it
> should be.

I was puzzled by the reference to "pushing a hidden ref" at the
beginning of the proposed log message, as it wasn't quite clear that
it was merely an easy-to-reproduce recipe to fall into such a
situation where all ref updates are rejected.

But the code change makes the function leave before the object
migration out of the quarantine when no ref updates are done for any
reason, andit makes perfect sense.  The title reflects it very well.

> Add a checkpoint before calling "tmp_objdir_migrate()" and after calling
> the "pre-receive" hook to purge that temporary data in the quarantine
> area when there is no command ready to run.

OK.

I wondered how this should interact with the "proc_receive_ref"
stuff, but existing code makes proc_receive_ref ignored when
pre-receive rejects, so doing the same would be OK.

> index 9f4a0b816c..a0b193ab3f 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1971,6 +1971,15 @@ static void execute_commands(struct command *commands,
>  		return;
>  	}

With the new logic, "return;" we see above becomes unnecessary.  I
wonder if it is a good idea to keep it or remove it.

> +	/*
> +	 * If there is no command ready to run, should return directly to destroy
> +	 * temporary data in the quarantine area.
> +	 */
> +	for (cmd = commands; cmd && cmd->error_string; cmd = cmd->next)
> +		; /* nothing */
> +	if (!cmd)
> +		return;
> +
>  	/*
>  	 * Now we'll start writing out refs, which means the objects need
>  	 * to be in their final positions so that other processes can see them.
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 2f04cf9a1c..da70c45857 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1809,4 +1809,12 @@ test_expect_success 'refuse fetch to current branch of bare repository worktree'
>  	git -C bare.git fetch -u .. HEAD:wt
>  '
>  
> +test_expect_success 'refuse to push a hidden ref, and make sure do not pollute the repository' '
> +	mk_empty testrepo &&
> +	git -C testrepo config receive.hiderefs refs/hidden &&
> +	git -C testrepo config receive.unpackLimit 1 &&
> +	test_must_fail git push testrepo HEAD:refs/hidden/foo &&
> +	test_dir_is_empty testrepo/.git/objects/pack
> +'
> +
>  test_done
