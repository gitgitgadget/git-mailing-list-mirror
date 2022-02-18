Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C9AC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 20:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbiBRUWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:22:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbiBRUWI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 15:22:08 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E87F3DDCE
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:21:51 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C37C118E65;
        Fri, 18 Feb 2022 15:21:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FuNMGo+Zvdm/vE/1Tw8Aq2TJVU0iKmpZQaFsZ1
        pyRYo=; b=k6oiQqwL7ufMtqjLDIOXF5udhZUxe6KZsUVmOwM2w/AWzXd2s02SNo
        6gNehZZSUAM6NrzSoqCZNttrt6RuBIOmSRrOjbpbmpLUK0zAPSFREM8Wl5JKWKWl
        RT5Qd0fQTtapTXjfQyn4beKcs6E+ytU7hPfZADIHE7Okurdv4/MGU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34214118E64;
        Fri, 18 Feb 2022 15:21:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DF82118E63;
        Fri, 18 Feb 2022 15:21:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] reflog: libify delete reflog function and helpers
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
        <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
Date:   Fri, 18 Feb 2022 12:21:48 -0800
In-Reply-To: <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Fri, 18 Feb 2022 18:40:45
        +0000")
Message-ID: <xmqqk0dsylgj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6709C764-90F8-11EC-B429-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Currently stash shells out to reflog in order to delete refs. In an
> effort to reduce how much we shell out to a subprocess, libify the
> functionality that stash needs into reflog.c.
>
> Add a reflog_delete function that is pretty much the logic in the while
> loop in builtin/reflog.c cmd_reflog_delete(). This is a function that
> builtin/reflog.c and builtin/stash.c can both call.

I do not quite get this step.  Yes, eventually cmd_reflog_delete()
and cmd_stash() can both call the new reflog_delete() function, but
at this step, cmd_reflog_delete() should ALREADY be able to call it,
but I see duplicated code.

Why?

> @@ -726,6 +320,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  	int i, status = 0;
>  	unsigned int flags = 0;
>  	int verbose = 0;
> +
>  	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
>  	const struct option options[] = {
>  		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),

In other words, why the only change this step makes to
cmd_reflog_delete() is a style change here, instead of replacing the
logic inside its "while loop" with a call to the new helper
function, which is introduced ...

> diff --git a/reflog.c b/reflog.c
> new file mode 100644
> index 00000000000..227ed83b3da
> --- /dev/null
> +++ b/reflog.c
> ...
> +int reflog_delete(const char *rev, int flags, int verbose)
> +{

... here?

> +	struct cmd_reflog_expire_cb cmd = { 0 };
> +	int status = 0;
> +	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
> +	const char *spec = strstr(rev, "@{");
> +	char *ep, *ref;
> +	int recno;
> +	struct expire_reflog_policy_cb cb = {
> +		.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
> +	};
> +
> +	if (verbose)
> +		should_prune_fn = should_expire_reflog_ent_verbose;
> +
> +	if (!spec) {
> +		status |= error(_("not a reflog: %s"), rev);
> +	}

If this were "we moved one iteration of an existing loop to a
separate function, while trying to keep what the existing code
looked like as pristine as possible", then it is fine, but it does
not look like that is what is going on (and I do not think it is
feasible to do so, as the original being an interation in a loop,
it has "continue" here, instead you'd need to arrange to return an
error from here to allow the caller to work in a similar way).

So, if the patch is adding an adjusted implementation by removing
"continue;" that is not suitable in the context of this helper, it
should remove the now-unnecessary {braces} around the single-statement
block.

But I think you should keep {braces} around, because the "if spec is
NULL" case should not be a single-statement block.  You'd need to
return or this code is buggy.

> +	if (!dwim_log(rev, spec - rev, NULL, &ref)) {
> +		status |= error(_("no reflog for '%s'"), rev);
> +	}

I already hinted that the previous "if spec is NULL" code is buggy
because it does not return to allow the original caller to keep
working as before.  Because you lack an early return there, you'll
end up calling dwim_log with spec==NULL here, which does not end
well.

