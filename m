From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] git submodule update: Have a dedicated helper for cloning
Date: Wed, 21 Oct 2015 13:47:58 -0700
Message-ID: <xmqqd1w8uewx.fsf@gitster.mtv.corp.google.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
	<1445381030-23912-9-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:48:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp0Iv-0006jl-DN
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 22:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251AbbJUUsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 16:48:07 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755151AbbJUUsD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 16:48:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E26A024F35;
	Wed, 21 Oct 2015 16:48:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kmdZqvpOwzXDm+ahPoEl9UelDgc=; b=w9v6NI
	UouC66P49YWdTGhjf454qRe/sSMP9fZ9icAunNbbWgIXAA2iSOAtRYP/BKT8khvQ
	fa4Fv50uAJdsS3suJtBZSwTM/XTWACvLK30zE4LUFNyfeHVxiaSWuHSngr2dZxQW
	nmUGMVtp/oSQLoQYDaTCB1HnbA8gKbtowG70w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ax2x40Wigy6RBKfWImHNBgxOkLDMOSvY
	8hSi8ZSStd2UQ7y/0EMRS+SvB11HCFT13SuTn8KTdUv6uObT0d1FlkDd1Po7i/HY
	7fEbGU3PfaPudeXajJ/oMY/XN7P4QIdDpGOpemDwvEsxf2ArIenWi1D0KCk4dVMA
	rKpNf90/9Mg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09A4924F30;
	Wed, 21 Oct 2015 16:48:00 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BCBBB24F2D;
	Wed, 21 Oct 2015 16:47:59 -0400 (EDT)
In-Reply-To: <1445381030-23912-9-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 20 Oct 2015 15:43:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 03E3ADEA-7835-11E5-92FA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280018>

Stefan Beller <sbeller@google.com> writes:

> This introduces a new helper function in git submodule--helper
> which takes care of cloning all submodules, which we want to
> parallelize eventually.
>
> Some tests (such as empty URL, update_mode==none) are required in the
> helper to make the decision for cloning. These checks have been moved
> into the C function as well. (No need to repeat them in the shell
> script)
>
> As we can only access the stderr channel from within the parallel
> processing engine, so we need to reroute the error message for
> specified but initialized submodules to stderr. As it is an error
> message, this should have gone to stderr in the first place, so a
> bug fix along the way.

The last paragraph is hard to parse; perhaps it is slightly
ungrammatical.

It would be a really good idea to split the small bit to redirect
the output that should have gone to the standard error to where it
should as a preparatory step before showing this patch.

I sense that this one is still a WIP/RFC, so I'll only skim it in
this round (but I may come back and read it again later with finer
toothed comb).

> +static int get_next_task(void **pp_task_cb,
> +			 struct child_process *cp,
> +			 struct strbuf *err,
> +			 void *pp_cb)

Will you have only one caller of the parallel run-command API in
this file, or will you be adding more to allow various different
operations run in parallel as more things are rewritten?  I am
guessing that it would be the latter, but if that is the case,
perhaps the function wants to be named a bit more specificly for
this first user, no?  Same for start_failure and task_finished.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8b0eb9a..ea883b9 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -655,17 +655,18 @@ cmd_update()
>  		cmd_init "--" "$@" || return
>  	fi
>  
> -	cloned_modules=
> -	git submodule--helper list --prefix "$wt_prefix" "$@" | {
> +	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
> +		${wt_prefix:+--prefix "$wt_prefix"} \
> +		${prefix:+--recursive_prefix "$prefix"} \
> +		${update:+--update "$update"} \
> +		${reference:+--reference "$reference"} \
> +		${depth:+--depth "$depth"} \
> +		"$@" | {
>  	err=
> -	while read mode sha1 stage sm_path
> +	while read mode sha1 stage just_cloned sm_path
>  	do

I wonder if you really want this to be upstream of a pipe.  When the
downstream loop needs to abort, what happens to the remainder of the
"clone" part of the processing that is still ongoing in the upstream
of the pipe?  I would imagine that the "update-clone" network
accessing phase is the more human-time consuming part, so I suspect
that it would be much better to let the cloning part go and finish
first (during which time the human-user can spend time for other
things, like getting cup of coffee or filling expense reports) and
before moving to the loop that can stop and ask the human-user for
help.

The fix for the above could be trivial (do not pipe, just take the
output to a temporary file, and then feed the "while read" loop from
that temporary file), and I suspect it would make a big difference
for usability.

Thanks.
