From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: add --progress option
Date: Fri, 30 Oct 2015 10:04:07 -0700
Message-ID: <xmqq611omgoo.fsf@gitster.mtv.corp.google.com>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 18:04:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsD68-0000uc-In
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 18:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbbJ3REL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 13:04:11 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750971AbbJ3REK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 13:04:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A22F253A3;
	Fri, 30 Oct 2015 13:04:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+fzoBzvDh0QVrk6eMmaSzEIrSdM=; b=EJi864
	DWiW4ezNzOP5qZfq5CckUByZ0hTy4ah5rLeg5HlrcDGTDL/R/oiXKN+mAOgMi6co
	EnIksn1IX6LeQp2pveP5RcGMwD1pmFbfRduA/CTXjNSE2mIwjsknDBtZ/i3knRJN
	dBwhY+5uyLiyHNw7Lh7/oXtS0Rj2jVmqcbsiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p4KIcCecMjQFTOd4BfisEgwfypxR/wtz
	ySOeNBNJ92U9nj2ZSKu7nrNqBuDccqP9sTFCVP0uzN0wAAeqPYEcrGIjQkltJDVW
	8uVWVy7xvrklIfsIkMjzWE/9KaCkdlGLPbTg/jur+mOj4AC4Uqn5/zy492LMKcbF
	bF5k3+dYdxE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70E02253A2;
	Fri, 30 Oct 2015 13:04:09 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E7D47253A1;
	Fri, 30 Oct 2015 13:04:08 -0400 (EDT)
In-Reply-To: <1446168186-4730-1-git-send-email-eantoranz@gmail.com> (Edmundo
	Carmona Antoranz's message of "Thu, 29 Oct 2015 19:23:06 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C2C2034-7F28-11E5-83B4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280496>

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> Under normal circumstances, and like other git commands,
> git checkout will write progress info to stderr if
> attached to a terminal. This option allows progress
> to be forced even if not using a terminal. Also,
> progress can be skipped if using option --no-progress.
>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
>  Documentation/git-checkout.txt |  6 ++++++
>  builtin/checkout.c             | 17 ++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index e269fb1..93ba35a 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -107,6 +107,12 @@ OPTIONS
>  --quiet::
>  	Quiet, suppress feedback messages.
>  
> +--progress::
> +	Progress status is reported on the standard error stream
> +	by default when it is attached to a terminal, unless -q
> +	is specified. This flag forces progress status even if the
> +	standard error stream is not directed to a terminal.
> +

Unlike some other codepaths like pack-objects (hence "fetch"), "git
checkout" uses start_progress_delay() to avoid showing the progress
when the operation finishes quickly.  I do not think the --progress
option should "force" the output in such a case, but the text reads
as if that is what happens.

Probably it is not a big deal, though.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index bc703c0..e28c36b 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -27,6 +27,8 @@ static const char * const checkout_usage[] = {
>  	NULL,
>  };
>  
> +static int option_progress = -1;
> +
>  struct checkout_opts {
>  	int patch_mode;
>  	int quiet;
> @@ -417,7 +419,19 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
>  	opts.reset = 1;
>  	opts.merge = 1;
>  	opts.fn = oneway_merge;
> -	opts.verbose_update = !o->quiet && isatty(2);
> +	/**
> +	 * Rules to display progress:
> +	 * -q is selected
> +	 *      no verbiage

All the other say "progress will be..."; this only confuses readers
if "verbiage" is referring to the same "progress" or it is something
else (and if so at least two important things are left unsaid: (1)
if "progress" is also part of "verbiage", and (2) what kind of
output you are squelching).

And I cannot quite tell which among these possibilities (and there
may be others) you meant.

> +	 * -q is _not_ selected and --no-progress _is_ selected,
> +	 *      progress will be skipped
> +	 * -q is _not_ selected and --progress _is_ selected,
> +	 *      progress will be printed to stderr
> +	 * -q is _not_ selected and --progress is 'undefined'
> +	 *      progress will be printed to stderr _if_ working on a terminal
> +	 */
> +	opts.verbose_update = !o->quiet && (option_progress > 0 ||
> +					   (option_progress < 0 && isatty(2)));
>  	opts.src_index = &the_index;
>  	opts.dst_index = &the_index;
>  	parse_tree(tree);
> @@ -1156,6 +1170,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  				N_("second guess 'git checkout <no-such-branch>'")),
>  		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
>  			 N_("do not check if another worktree is holding the given ref")),
> +		OPT_BOOL(0, "progress", &option_progress, N_("force progress reporting")),
>  		OPT_END(),
>  	};

I see some existing commands say "show progress" and some others say
"force progress reporting".  At some point we may want to pick one
and use it consistently (but that is not on a topic for this change).

Thanks.
