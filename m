From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for merging from upstream by default.
Date: Sun, 06 Feb 2011 17:59:29 -0800
Message-ID: <7vaai8wqny.fsf@alter.siamese.dyndns.org>
References: <m2k4he23z6.fsf@whitebox.home>
 <1296912681-4161-1-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 02:59:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmGOI-0006UD-Is
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 02:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253Ab1BGB7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 20:59:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223Ab1BGB7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 20:59:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F5564F01;
	Sun,  6 Feb 2011 21:00:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o2mlxhoi983bz+MeZe5ZmK4vjSM=; b=hv7NvL
	lsgY2H4UTnBYOP+W5iP1GcnRykzVsmLkFzhDmifVfhMwfIBnuDk5TSu6Qx/O0t3v
	GIzN+lWm/qlaQZLDRmlC7AuUx5Y/fch3PFrCxWp6jgnBoaZ2XJ9x9mCxqw9PXn/v
	J3CkAoKjAsMnRfBXnrleIISgUNhQorXFvQA/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XjQ9BQI6Ev4OeaQkENVmliBSNh9qRvjD
	fxCS60CUKmAzTXFYYQoWqlIWdjHoKqdp/NDDBXCVzAfNX2sHtPXV9d8V6YsJ78Gm
	NtY6OJ3gNySSCoexRCPMHF/WxUefn089VDXzxNp94L26cTIkYH2fa0ZhvwDUrgQ6
	FRA9rKgcJLI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D5CA4EFE;
	Sun,  6 Feb 2011 21:00:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ED46E4EFC; Sun,  6 Feb 2011
 21:00:28 -0500 (EST)
In-Reply-To: <1296912681-4161-1-git-send-email-jaredhance@gmail.com> (Jared
 Hance's message of "Sat\,  5 Feb 2011 08\:31\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0B6836F2-325E-11E0-AC61-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166220>

Jared Hance <jaredhance@gmail.com> writes:

> Adds the option merge.defaultupstream to add support for merging from the
> upstream branch by default. The upstream branch is found using
> branch.[name].upstream.
> ---

Sign off?

The patch (rather your code before getting handed to your MUA) seems
severely whitespace damaged.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 42fff38..596febe 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -37,7 +37,7 @@ struct strategy {
>  };
>  
>  static const char * const builtin_merge_usage[] = {
> -	"git merge [options] <remote>...",
> +	"git merge [options] [<remote>...]",
>  	"git merge [options] <msg> HEAD <remote>",
>  	NULL
>  };
> @@ -58,6 +58,8 @@ static int option_renormalize;
>  static int verbosity;
>  static int allow_rerere_auto;
>  static int abort_current_merge;
> +static int default_upstream;
> +static const char *upstream_branch;
>  
>  static struct strategy all_strategy[] = {
>  	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
> @@ -519,8 +521,15 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  			      builtin_merge_usage, 0);
>  		free(buf);
>  	}
> -
> -	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
> +        else if(branch && !prefixcmp(k, "branch.") &&
> +                !prefixcmp(k + 7, branch) &&
> +                !strcmp(k + 7 + strlen(branch), ".upstream")) {
> +                return git_config_string(&upstream_branch, k, v);
> +        }

Shouldn't this be inside a single large if block that is guarded by

	if (branch && !prefixcmp(k, "branch.") && !prefixcmp(k + 7, branch))

with a small refactoring of the existing code in git_merge_config(), the
first if statement?  It probably is a good idea to hand that off to a
small helper function as well, i.e. the first if statement in
git_merge_config() becomes something like:

	status = per_branch_config(k, v, cb);
        if (status <= 0)
		return status;

and then a new helper function is defined right in front of it, perhaps

	static int per_branch_config(const char *k, const char *v, void *cb)
	{
        	const char *variable;
        	if (!branch || prefixcmp(k, "branch.")
                    || prefixcmp(k + 7, branch))
			return 1; /* ignore me */
		variable = k + 7 + strlen(branch);
                if (strcmp(variable, ".mergeoptions")) {
                	...
                        return 0; /* done */
		}
                if (strcmp(variable, ".upstream")) {
                	...
                        return 0; /* or -1 if you see an error */
		}
                return 1; /* not what I handle */
	}
