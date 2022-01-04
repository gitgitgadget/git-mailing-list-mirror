Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7594DC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 22:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiADWq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 17:46:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50721 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiADWq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 17:46:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 11B9F1764AF;
        Tue,  4 Jan 2022 17:46:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jPk/2fFVRTfEX4oBEj3tfYVAGTdubYhpgmVTiK
        UH8iM=; b=ensmZtRlHk8YWGge6roYeVWAAF7f3klcpPiMBCLr2ydjqYRdsgsT7E
        uYyFYcbAiu1ss+44qcUBiAwtIKqCuMLvnOH7EzWlJeizofL0t4jPVxwD5h+0ysd/
        Wf6wGurQqvKol4XMMT7ZLB79ZN1rcoF/x9kLdgoYRmyl2/D7FMj6c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09ADE1764AE;
        Tue,  4 Jan 2022 17:46:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 57CB31764AC;
        Tue,  4 Jan 2022 17:46:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     git@vger.kernel.org, "Tilman Vogel" <tilman.vogel@web.de>,
        "Philippe Blain" <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/1] builtin/pull.c: use config value of autostash
References: <20220104214522.10692-1-johncai86@gmail.com>
        <20220104214522.10692-2-johncai86@gmail.com>
Date:   Tue, 04 Jan 2022 14:46:50 -0800
In-Reply-To: <20220104214522.10692-2-johncai86@gmail.com> (John Cai's message
        of "Tue, 4 Jan 2022 16:45:22 -0500")
Message-ID: <xmqqbl0r9l0l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35AB7EC6-6DB0-11EC-BE92-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 100cbf9fb8..fb700c2d39 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -86,7 +86,8 @@ static char *opt_ff;
>  static char *opt_verify_signatures;
>  static char *opt_verify;
>  static int opt_autostash = -1;
> -static int config_autostash;
> +static int rebase_autostash = 0;
> +static int cfg_rebase_autostash;

Do not explicitly initialize statics to '0' (or NULL for that matter).

But more importantly, I have a feeling that you are making a piece
of code that is already hard to read impossible to follow by adding
yet another variable.

> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index 66cfcb09c5..28f551db8e 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -251,5 +251,56 @@ test_expect_success 'git pull --no-verify --verify passed to merge' '
>  	test_commit -C src two &&
>  	test_must_fail git -C dst pull --no-ff --no-verify --verify
>  '
> +test_expect_success 'git pull --rebase --autostash succeeds on ff' '

Missing blank line between tests.


I thought that the root cause of the problem is that run_merge() is
called even when rebase was asked for (either via pull.rebase=true
configuration or "pull --rebase" option), when the other side is a
descendant of HEAD.  The basic idea behind that behaviour may be
sound (i.e. if we do not have any of our own development on top of
their history, rebase vs merge shouldn't make any difference while
fast-forwarding HEAD to their history), except that rebase vs merge
look at different configuration variables.

I wonder if the following two-liner patch is a simpler fix that is
easier to understand.  run_merge() decides if we should pass the
"--[no-]autostash" option based on the value of opt_autostash, and
we know the value of rebase.autostash in config_autostash variable.

It appears to pass all four tests your patch adds.

 builtin/pull.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git c/builtin/pull.c w/builtin/pull.c
index 100cbf9fb8..d459a91a64 100644
--- c/builtin/pull.c
+++ w/builtin/pull.c
@@ -1133,7 +1133,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("cannot rebase with locally recorded submodule modifications"));
 
 		if (can_ff) {
-			/* we can fast-forward this without invoking rebase */
+			/*
+			 * We can fast-forward without invoking
+			 * rebase, by calling run_merge().  But we
+			 * have to allow rebase.autostash=true to kick
+			 * in.
+			 */
+			if (opt_autostash < 0)
+				opt_autostash = config_autostash;
 			opt_ff = "--ff-only";
 			ret = run_merge();
 		} else {
