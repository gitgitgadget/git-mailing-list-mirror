From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule operations: tighten pathspec errors
Date: Thu, 26 May 2016 13:00:27 -0700
Message-ID: <xmqqd1o8vbc4.fsf@gitster.mtv.corp.google.com>
References: <1463793689-19496-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 26 22:00:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b61SV-0004Yh-Li
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 22:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbcEZUAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 16:00:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752179AbcEZUAb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 16:00:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3D4F1FCE3;
	Thu, 26 May 2016 16:00:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2cz8dA7Mnh+/W+6ZUXhzykFtQuY=; b=NrD3Ip
	GDlBOBSmmvDHzVynvsG4FEuAapK2kZ4CxyGjLMAXSvZ+lsF7Mcj6AHGDD4InR1Fv
	7WVtQLuNFpIYgaDgxmdKvWL4KnvwSBOUpAZT3dokyo4tMnwBpV/nt1Naj9vCrDGA
	UX0542O5+psyWQLJTCt4vPFapN6Hsq0iiqD9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p+jjccWnnV5CtJLaJk2czcYBLbOX2BjB
	DbExkuiatPuJsW0NQLrEc6ZK3CR/qMLzGZ5dVnmAGWfaL+RivVrJEoj8ixEiKyqc
	fqKXfrH3c4CBRpzE76uc2FqxwzVbKDaxHtiw2LPMC1JQIyUMDOiCeHBH+o8JGDOn
	19ebRN4BGsE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 99BCB1FCE2;
	Thu, 26 May 2016 16:00:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 126F01FCE1;
	Thu, 26 May 2016 16:00:29 -0400 (EDT)
In-Reply-To: <1463793689-19496-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 20 May 2016 18:21:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7EC17D88-237C-11E6-A352-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295688>

Stefan Beller <sbeller@google.com> writes:

> It's a first initial version with no tests (and probably conflicting with
> some topics in flight), but I was curious how involved this issue actually is,
> so I took a stab at implementing it.

I take it to mean "This is s/PATCH/RFC/".

> +--error-unmatch::
> +	If the pathspec included a specification that did not match,
> +	the usual operation is to error out. This switch suppresses
> +	error reporting and continues the operation.

The behaviour described is a total opposite of the option with the
same name "ls-files" has, no?

If there were no default, --error-unmatch would make an unmatching
pathspec an error and --no-error-unmatch would make it a non-error.

If the default is to error out, there is no need for --error-unmatch
to exist, but you do want --no-error-unmatch aka --unmatch-ok.

If the default is not to error out, --error-unmatch should make it
notice and turn it into an error.

I am guessing that you were debating yourself which should be the
default and the patch ended up in an inconsistent state, the
description assuming a more strict default, while the option name
assuming a less strict default.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 5295b72..91c49ec 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -19,7 +19,8 @@ struct module_list {
>  static int module_list_compute(int argc, const char **argv,
>  			       const char *prefix,
>  			       struct pathspec *pathspec,
> -			       struct module_list *list)
> +			       struct module_list *list,
> +			       int unmatch)

What is "unmatch"?  "Catch unmatch errors, please?"  "Do not check
and report unmatch errors?"

My cursory read of a few hunks below tells me that you meant the
latter, i.e. "unmatch_ok".

> @@ -36,10 +37,9 @@ static int module_list_compute(int argc, const char **argv,
>  
>  	for (i = 0; i < active_nr; i++) {
>  		const struct cache_entry *ce = active_cache[i];
> -
> -		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
> -				    0, ps_matched, 1) ||
> -		    !S_ISGITLINK(ce->ce_mode))
> +		if (!S_ISGITLINK(ce->ce_mode) ||
> +		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
> +				    0, ps_matched, 1))
>  			continue;

OK, this is the crucial bit in this patch. pathspec matches are now
done only against gitlinks, so any unmatch is "pattern or path
given, but there was no such submodule".

> @@ -53,7 +53,9 @@ static int module_list_compute(int argc, const char **argv,
>  			i++;
>  	}
>  
> -	if (ps_matched && report_path_error(ps_matched, pathspec, prefix))
> +	if (!unmatch &&
> +	    ps_matched &&
> +	    report_path_error(ps_matched, pathspec, prefix))
>  		result = -1;

If unmatch is not true, then check if ps_matched records "aw, this
pathspec element did not get used" and complain.  If unmatch is
true, we do not do that.

Which confirms my earlier "'unmatch' here means 'unmatch_ok'".

It is tempting to update report_path_error() return "OK" when its
first parameter is NULL.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index fb68f1f..f10e10a 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -391,6 +391,9 @@ cmd_foreach()
>  		--recursive)
>  			recursive=1
>  			;;
> +		--error-unmatch)
> +			unmatch=1
> +			;;

So "--error-unmatch" does pass "--unmatch" which is "please ignore
unmatch errors".  That is a bit strange (see above).

> @@ -407,7 +410,7 @@ cmd_foreach()
>  	# command in the subshell (and a recursive call to this function)
>  	exec 3<&0
>  
> -	git submodule--helper list --prefix "$wt_prefix"|
> +	git submodule--helper list ${unmatch:+--unmatch} --prefix "$wt_prefix"|

For this to work, somebody must ensure that the variable unmatch is
either unset or set to empty unless the user gave --error-unmatch to
us.  There is a block of empty assignments hear the beginning of
this file for that very purpose, i.e. resetting a stray environment
variable that could be in user's environment.

The patch itself does not look too bad.  I do not have an opinion on
which one should be the default, and I certainly would understand if
you want to keep the default loose (i.e. not complaining) with an
optional error checking, but whichever default you choose, the
option and variable names need to be clarified to avoid confusion.
