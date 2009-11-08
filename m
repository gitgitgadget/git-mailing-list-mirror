From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Let 'git <command> -h' show usage without a git dir
Date: Sun, 08 Nov 2009 01:21:25 -0800
Message-ID: <7vvdhlfk2y.fsf@alter.siamese.dyndns.org>
References: <20080125173149.GA10287@edna.gwendoline.at>
 <20091108071152.GA20741@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gerfried Fuchs <rhonda@debian.at>,
	462557@bugs.debian.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 10:21:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N73xy-0002lk-7U
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 10:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbZKHJVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 04:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbZKHJVe
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 04:21:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbZKHJVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 04:21:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 787FA96C8F;
	Sun,  8 Nov 2009 04:21:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SZFcQG8KhGCdec0myF++sjFYXkY=; b=E2Iqsi
	STF4crgyha6MwBL3+8Rors4TmVmeYnBMAqoTzEhCI41Y3/wQUzxsGmXDi+CJk3mS
	Cgl6Gq4w5VzXHqXTvf1E9icIzBCbJTnaEoQ6mDbBRZqgocj4nzcPDpyOb2x6qk84
	TDDJhrEp0XZGNXzObSa7i82OSxBY5C1oQzDBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ef6a0FA+RxxqSo+wLLj5yD39C0esVQt3
	tAz36vPgnRSAIdUbjRfI1qPWnIPYMASo2qwu2IUoBR2Pl2iAq3uP6pByArIUQn+9
	y321A7U96VpzEcDIxYGgbwY//5kY7PIfnIckUyv6R3lTvEM1YPzHgYdqtbodi6eG
	fUB7dsgnowg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3BC0396C8E;
	Sun,  8 Nov 2009 04:21:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 97F3596C8D; Sun,  8 Nov 2009
 04:21:27 -0500 (EST)
In-Reply-To: <20091108071152.GA20741@progeny.tock> (Jonathan Nieder's message
 of "Sun\, 8 Nov 2009 01\:11\:52 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1B18D99E-CC48-11DE-9086-D595BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132389>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/git.c b/git.c
> index bd2c5fe..bfa9518 100644
> --- a/git.c
> +++ b/git.c
> @@ -220,6 +220,11 @@ const char git_version_string[] = GIT_VERSION;
>   * RUN_SETUP for reading from the configuration file.
>   */
>  #define NEED_WORK_TREE	(1<<2)
> +/*
> + * Let RUN_SETUP, USE_PAGER, and NEED_WORK_TREE take effect even if
> + * passed the -h option.
> + */
> +#define H_IS_NOT_HELP	(1<<3)

Yuck.  Let's think of a way to avoid this ugliness.

> @@ -278,7 +287,8 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "annotate", cmd_annotate, RUN_SETUP },
>  		{ "apply", cmd_apply },
>  		{ "archive", cmd_archive },
> -		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE },
> +		{ "bisect--helper", cmd_bisect__helper,
> +			RUN_SETUP | NEED_WORK_TREE },

Besides, this hunk is totally unwarranted.

Here are the relevant parts (some of your H_IS_NOT_HELP are not visible
because you needlessly wrapped the lines):

> +		{ "cherry", cmd_cherry, RUN_SETUP | H_IS_NOT_HELP },
> +		{ "commit-tree", cmd_commit_tree, RUN_SETUP | H_IS_NOT_HELP },
> +		{ "fetch--tool", cmd_fetch__tool, RUN_SETUP | H_IS_NOT_HELP },
> +		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER | H_IS_NOT_HELP },
> +		{ "merge-ours", cmd_merge_ours, RUN_SETUP | H_IS_NOT_HELP },
> +		{ "merge-recursive", cmd_merge_recursive,
> +		{ "merge-subtree", cmd_merge_recursive,
> +		{ "show-ref", cmd_show_ref, RUN_SETUP | H_IS_NOT_HELP },

Except for "grep" and "show-ref", none of these have a valid -h option
that means something else.

Considering that this niggle is strictly about "git cmd -h", and not about
"git cmd --otheropt -h somearg", we can even say that "git grep -h" is
asking for help, and not "do not show filenames from match", as there is
no pattern specified.

So I think the right approach is something like how you handled http-push;
namely, check if the sole argument is "-h", and if so show help and exit.

	Clarification. the following description only talks about "cmd -h"
	without any other options and arguments.

Such a change cannot be breaking backward compatibility for...

 * "cherry -h" could be asking to compare histories that leads to our HEAD
   and a commit that can be named as "-h".  Strictly speaking, that may be
   a valid refname, but the user would have to say something like
   "tags/-h" to name such a pathological ref already, so I do not think it
   is such a big deal.

 * "commit-tree -h" is to make a root commit that records a tree-ish
   pointed by a tag whose name is "-h".  Same as above.

 * The first word to "fetch--tool" is a subcommand name, so "fetch--tool -h"
   is an error and there cannot be any existing callers.  Besides, is it
   still being used?

 * "grep -h" cannot be asking for suppressing filenames as there is no
   match pattern specified.

 * "merge-*" strategy backends take the merge base (or "--") as the first
   parameter; it cannot sanely be "-h". The callers are supposed to run
   rev-parse to make it 40-hexdigit and the command won't see a refname
   anyway.

That leaves "show-ref -h".  It shows all the refs/* and HEAD, as opposed
to "show-ref" that shows all the refs/* and not HEAD.

Does anybody use "show-ref -h"?  It was in Linus's original, and I suspect
it was done only because he thought "it might be handy", not because "the
command should not show the HEAD by default for such and such reasons".
So I think it actually is Ok if "show-ref -h" (but not "show-ref --head")
gave help and exit.
