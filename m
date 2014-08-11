From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] prepare_revision_walk: Check for return value in all places
Date: Mon, 11 Aug 2014 12:09:38 -0700
Message-ID: <xmqq1tsm7si5.fsf@gitster.dls.corp.google.com>
References: <1407706406-30455-1-git-send-email-stefanbeller@gmail.com>
	<1407706406-30455-2-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:09:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGuyg-0007x2-JE
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 21:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbaHKTJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 15:09:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59589 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbaHKTJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 15:09:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C1B430961;
	Mon, 11 Aug 2014 15:09:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fBdLVn+8rp55OD2ULJC7VY+eRUE=; b=mVkW5d
	zQX/84pcwWEb2khLkwWG+gYbN0ZKxXoBr4pxF82QaAmRdiJbvxBmtqTVQYX1tXDX
	r7UBJB0YHjpZnrlc5QAAwcBKM2kscNOzMxry/mqUrCKi+Pg9qPZjDGNA1b0+Bg8v
	yJv/ffuNrrIJIkbkUiS/eIZ83WyIA/CB990z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f0YQ2B7bp0/mHCTqi8EjHAlVMWNrL8Qr
	cVG0hbWlFOJmBSWiSoERbqzPSS1K0C64yNQYMDKvV0f2nMb7oHkH41RADLtpgib+
	5rzaoSP3QfRVv+/AZ3pWp0NAE9GbfjePHeEIbwsY7+YDVv2XGDwcY6CyuiUcY5RU
	g+wqwlDXd5A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 929EC30960;
	Mon, 11 Aug 2014 15:09:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AE7FC30945;
	Mon, 11 Aug 2014 15:09:40 -0400 (EDT)
In-Reply-To: <1407706406-30455-2-git-send-email-stefanbeller@gmail.com>
	(Stefan Beller's message of "Sun, 10 Aug 2014 23:33:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0BA0F56C-218B-11E4-9914-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255132>

Stefan Beller <stefanbeller@gmail.com> writes:

> Even the documentation tells us:
> 	You should check if it
> 	returns any error (non-zero return code) and if it does not, you can
> 	start using get_revision() to do the iteration.
>
> In preparation for this commit, I grepped all occurrences of
> prepare_revision_walk and added error messages, when there were none.

Thanks.  One niggling thing is that I do not seem to find a way for
the function to actually return an error without dying in it, but
these are independently good changes.

>
> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> ---
>  builtin/branch.c | 4 +++-
>  builtin/commit.c | 3 ++-
>  remote.c         | 3 ++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 0591b22..ced422b 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -653,7 +653,9 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>  		add_pending_object(&ref_list.revs,
>  				   (struct object *) filter, "");
>  		ref_list.revs.limited = 1;
> -		prepare_revision_walk(&ref_list.revs);
> +
> +		if (prepare_revision_walk(&ref_list.revs))
> +			die(_("revision walk setup failed"));
>  		if (verbose)
>  			ref_list.maxwidth = calc_maxwidth(&ref_list);
>  	}
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 7867768..bb84e1d 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1055,7 +1055,8 @@ static const char *find_author_by_nickname(const char *name)
>  	revs.mailmap = &mailmap;
>  	read_mailmap(revs.mailmap, NULL);
>  
> -	prepare_revision_walk(&revs);
> +	if (prepare_revision_walk(&revs))
> +		die("revision walk setup failed");
>  	commit = get_revision(&revs);
>  	if (commit) {
>  		struct pretty_print_context ctx = {0};
> diff --git a/remote.c b/remote.c
> index 894db09..112e4d5 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1893,7 +1893,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
>  
>  	init_revisions(&revs, NULL);
>  	setup_revisions(rev_argc, rev_argv, &revs, NULL);
> -	prepare_revision_walk(&revs);
> +	if (prepare_revision_walk(&revs))
> +		die("revision walk setup failed");
>  
>  	/* ... and count the commits on each side. */
>  	*num_ours = 0;
