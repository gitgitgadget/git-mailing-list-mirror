Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783FA1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 18:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbcFUS3H (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 14:29:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752413AbcFUS3G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 14:29:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AF052584C;
	Tue, 21 Jun 2016 14:14:32 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ErrhKP0tXFvmjULKZdUfjRy3POc=; b=aSW/oq
	FYb9VqcoXkgAkUJYHaasByGk3hpniFzSu/u7XP0Ri93eeqIgpmLTZZYtW/S43HH+
	Jk/bBen/Sk/0u8A+MbCqdAdXanByIXlVwexZDzvCpBHTGqvZoTQ1oR0VYFtZED5H
	+D+jUNHzfFyOHe7Cbh5sUWZSbl686BAza5w0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gLWwXDec9QtfBbXhht/xSKKnLRRCwLCa
	PwW9rl4l7+eQ/5+6A8O2prJ4AX3KzRT7qoj60h2EcrCF8/TVo/HrVm2nGcsCgh6M
	1qndBizkCL3ifCklYVs56W264V6rXYj6FfnXkbO7vdlHMUymhfei5OqO7Tb8H99z
	k0jyz4zbQ4Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 63C892584B;
	Tue, 21 Jun 2016 14:14:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5BC42584A;
	Tue, 21 Jun 2016 14:14:31 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 2/9] Disallow diffopt.close_file when using the log_tree machinery
References: <cover.1466420060.git.johannes.schindelin@gmx.de>
	<cover.1466505222.git.johannes.schindelin@gmx.de>
	<973f9f676225aa98377f607ced1ff474f39b863f.1466505222.git.johannes.schindelin@gmx.de>
Date:	Tue, 21 Jun 2016 11:14:29 -0700
In-Reply-To: <973f9f676225aa98377f607ced1ff474f39b863f.1466505222.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 21 Jun 2016 12:34:54 +0200
	(CEST)")
Message-ID: <xmqqfus6quii.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0058A7CC-37DC-11E6-8A0B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We are about to teach the log_tree machinery to reuse the diffopt.file
> setting to output to a file stream different from stdout.
>
> This means that builtin am can no longer ask the diff machinery to
> close the file when actually calling the log_tree machinery (which
> wants to flush the very same file stream that would then already be
> closed).

Sorry for being slow, but I am not sure why the first paragraph has
to mean the second paragraph.  This existing caller opens a new
stream, sets .fp to it, and expects that the log_tree_commit() to
close it if told by setting .close_file to true, all of which sounds
sensible.

If a codepath wants to use the same stream for two or more calls to
log_tree by pointing the stream with .fp, it would be of course a
problem for the caller to set .close_file to true in its first call,
as .fp will be closed and no longer usable for second and subsequent
call, and that would be a bug, but for a single-shot call it feels
entirely a sensible request to make, no?

Obviously you have looked at the codepaths involved a lot longer
than I did, and I do not doubt your conclusion, but I cannot quite
convince myself with the above explanation.

The option parser of "git diff" family sets ->close_file to true
when the --output option is given.

Wouldn't this patch break "git log --output=foo -3"?

> To stave off similar problems in the future, report it as a bug if
> log_tree_commit() is called with a non-zero diffopt.close_file.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/am.c | 6 ++++--
>  log-tree.c   | 3 +++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 0e28a62..47d78aa 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1437,6 +1437,7 @@ static int write_commit_patch(const struct am_state *state, struct commit *commi
>  {
>  	struct rev_info rev_info;
>  	FILE *fp;
> +	int res;
>  
>  	fp = fopen(am_path(state, "patch"), "w");
>  	if (!fp)
> @@ -1453,10 +1454,11 @@ static int write_commit_patch(const struct am_state *state, struct commit *commi
>  	DIFF_OPT_SET(&rev_info.diffopt, FULL_INDEX);
>  	rev_info.diffopt.use_color = 0;
>  	rev_info.diffopt.file = fp;
> -	rev_info.diffopt.close_file = 1;
>  	add_pending_object(&rev_info, &commit->object, "");
>  	diff_setup_done(&rev_info.diffopt);
> -	return log_tree_commit(&rev_info, commit);
> +	res = log_tree_commit(&rev_info, commit);
> +	fclose(fp);
> +	return res;
>  }
>  
>  /**
> diff --git a/log-tree.c b/log-tree.c
> index 78a5381..dc0180d 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -864,6 +864,9 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
>  	struct log_info log;
>  	int shown;
>  
> +	if (opt->diffopt.close_file)
> +		die("BUG: close_file is incompatible with log_tree_commit()");
> +
>  	log.commit = commit;
>  	log.parent = NULL;
>  	opt->loginfo = &log;
