From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] push: Add support for pre-push hooks
Date: Mon, 14 Jan 2013 09:39:24 -0800
Message-ID: <7vsj63ekab.fsf@alter.siamese.dyndns.org>
References: <1358054224-7710-1-git-send-email-aaron@schrab.com>
 <1356735452-21667-1-git-send-email-aaron@schrab.com>
 <1358054224-7710-3-git-send-email-aaron@schrab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 18:40:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuo0v-0005mX-8o
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 18:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757535Ab3ANRjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 12:39:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757005Ab3ANRj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 12:39:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BF4BC835;
	Mon, 14 Jan 2013 12:39:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MHvJA9wo4HwHjHEywWyJt1y9+7s=; b=U8cOCF
	r4sjodXFc9X3p0xiW/13Jq9wFaTsEy7D4eQuMIiAmx/uMjJkx15oOxNJkAjB9/j8
	qgz2xG2yjvLf6uSJ+nHWOd0vQMvsKuo38SNUFlVw/Avz7l4gGMr+zvnx/le7hCDw
	/H9zqB+E1LebXj4CmUlNhyHiZZ2mpUSYPOln8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EqN7ipC3xZJegoDcdLj90nUAjgJJMCLK
	NiEaHzphLS1rnl4yqtd1UB5KYThLqMhchVksN0wBtImM1EYoiguRSwafgBzXwXtd
	LJ41Iy4HiSklzzA97YKVFZU9laVP1AfRJjpHeeSNeSRT0V0nS/L151vlP0StqFW2
	lhU3Q/epo24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B68BC834;
	Mon, 14 Jan 2013 12:39:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A821EC82E; Mon, 14 Jan 2013
 12:39:25 -0500 (EST)
In-Reply-To: <1358054224-7710-3-git-send-email-aaron@schrab.com> (Aaron
 Schrab's message of "Sun, 13 Jan 2013 00:17:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56E9208C-5E71-11E2-895E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213504>

Aaron Schrab <aaron@schrab.com> writes:

> Add support for a pre-push hook which can be used to determine if the
> set of refs to be pushed is suitable for the target repository.  The
> hook is run with two arguments specifying the name and location of the
> destination repository.
>
> Information about what is to be pushed is provided by sending lines of
> the following form to the hook's standard input:
>
>   <local ref> SP <local sha1> SP <remote ref> SP <remote sha1> LF
>
> If the hook exits with a non-zero status, the push will be aborted.
>
> This will allow the script to determine if the push is acceptable based
> on the target repository and branch(es), the commits which are to be
> pushed, and even the source branches in some cases.
>
> Signed-off-by: Aaron Schrab <aaron@schrab.com>
> ---
>  Documentation/githooks.txt |  29 ++++++++++
>  builtin/push.c             |   1 +
>  t/t5571-pre-push-hook.sh   | 129 +++++++++++++++++++++++++++++++++++++++++++++
>  transport.c                |  60 +++++++++++++++++++++
>  transport.h                |   1 +
>  5 files changed, 220 insertions(+)
>  create mode 100755 t/t5571-pre-push-hook.sh
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index b9003fe..d839233 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -176,6 +176,35 @@ save and restore any form of metadata associated with the working tree
>  (eg: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
>  for an example of how to do this.
>  
> +pre-push
> +~~~~~~~~
> +
> +This hook is called by 'git push' and can be used to prevent a push from taking
> +place.  The hook is called with two parameters which provide the name and
> +location of the destination remote, if a named remote is not being used both
> +values will be the same.
> +
> +Information about what is to be pushed is provided on the hook's standard
> +input with lines of the form:
> +
> +  <local ref> SP <local sha1> SP <remote ref> SP <remote sha1> LF
> +
> +For instance, if the command +git push origin master:foreign+ were run the

Just being curious, but why use +monospace text+ here?  Most of the
new text use `monospace text literally` instead in this patch.

> +hook would receive a line like the following:
> +
> +  refs/heads/master 67890 refs/heads/foreign 12345
> +
> +although the full, 40-character SHA1s would be supplied.

Perhaps ellipses are called for here?

    refs/heads/master 67890... refs/heads/foreign 12345...

 (the above abbreviates full 40-hexdigits for illustration purposes only)

> +If the foreign ref
> +does not yet exist the `<remote SHA1>` will be 40 `0`.  If a ref is to be
> +deleted, the `<local ref>` will be supplied as `(delete)` and the `<local
> +SHA1>` will be 40 `0`.  If the local commit was specified by something other
> +than a name which could be expanded (such as `HEAD~`, or a SHA1) it will be
> +supplied as it was originally given.
> +
> +If this hook exits with a non-zero status, 'git push' will abort without
> +pushing anything.  Information about why the push is rejected may be sent
> +to the user by writing to standard error.

s/standard error/& of the hook/; perhaps?  It is unclear who does
the writing and it can be misunderstood that git-push will write to
standard error upon seeing your hook that silently exits.

> diff --git a/builtin/push.c b/builtin/push.c
> index 8491e43..b158028 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -407,6 +407,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
>  		OPT_BIT(0, "prune", &flags, N_("prune locally removed refs"),
>  			TRANSPORT_PUSH_PRUNE),
> +		OPT_BIT(0, "no-verify", &flags, N_("bypass pre-push hook"), TRANSPORT_PUSH_NO_HOOK),
>  		OPT_END()
>  	};

So to countermand this, you have to say --no-no-verify?  Wouldn't it
be more natural to introduce a --verify option that turns the bit
on, which automatically gives you --no-verify to turn it off?  A
bit in a flag word can be initialized to true before the flag word
is given to the parse_options() machinery to make the field default
to true, no?
