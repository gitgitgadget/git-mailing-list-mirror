From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] branch: not report invalid tracking branch
Date: Wed, 14 Aug 2013 08:21:04 -0700
Message-ID: <7vfvucuwm7.fsf@alter.siamese.dyndns.org>
References: <CANYiYbFGBRV+EP8oV_chKvBsHLAAZeKmt0395_z9QD-bBZtErQ@mail.gmail.com>
	<96e0ed4f67eaf058466ead9228cad0dcfe1b5c6a.1376369554.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 17:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9ct9-0002rp-7w
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 17:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab3HNPV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 11:21:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab3HNPVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 11:21:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AB0E362C2;
	Wed, 14 Aug 2013 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7qmUqAAXxfiuavyPtJ/8k5mDdG4=; b=QKiNvz
	86XPIjOQE3YHdRlaKqzOrAcKp73tHBli9J+N2zk8qr8yA7KSz3yP4BHeeWK0JLMM
	gNgdFiatZkUw+D/gLeuleRkVYcIe+WpxrbHNAfGdSHNPOuc8wfAqvUYXZIlvg1Cu
	1U+yisf9JfBHHNJ/CCHiqR5Nt6ZNz8F2k7b1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sm6PeE0Brmatpbk+QD2vuVyQpLXr0wph
	EUaz6+XmIJPerrlgs0oZgHUHwgucFwaRHi7JJ5qfNhEXDpiKSgLFKjKOEVITKqc9
	alHV2lsig8Ox1QHxFuIR/p+Z1wGBhnhmflgGnj2cMfoYfZzPIRkd3j7NzAPwkgRN
	K4dVu2BAQrg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16D34362C0;
	Wed, 14 Aug 2013 15:21:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8795E36290;
	Wed, 14 Aug 2013 15:21:11 +0000 (UTC)
In-Reply-To: <96e0ed4f67eaf058466ead9228cad0dcfe1b5c6a.1376369554.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Tue, 13 Aug 2013 12:53:48 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26CBFFB6-04F5-11E3-ACC6-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232287>

Jiang Xin <worldhello.net@gmail.com> writes:

> Command "git branch -vv" will report tracking branches, but invalid
> tracking branches are also reported. This is because the function
> stat_tracking_info() can not distinguish whether the upstream branch
> does not exist, or nothing is changed between one branch and its
> upstream.
>
> This patch changes the return value of function stat_tracking_info().
> Only returns false when there is no tracking branch or the tracking
> branch is invalid, otherwise true. If the caller does not like to
> report tracking info when nothing changed between the branch and its
> upstream, simply checks if num_theirs and num_ours are both 0.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  builtin/branch.c | 18 +++++-------------
>  remote.c         | 24 ++++++++++++------------
>  wt-status.c      | 13 +++++++++++--
>  3 files changed, 28 insertions(+), 27 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 0836890..359e75d 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -424,19 +424,8 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
>  	struct branch *branch = branch_get(branch_name);
>  	struct strbuf fancy = STRBUF_INIT;
>  
> -	if (!stat_tracking_info(branch, &ours, &theirs)) {
> -		if (branch && branch->merge && branch->merge[0]->dst &&
> -		    show_upstream_ref) {
> -			ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
> -			if (want_color(branch_use_color))
> -				strbuf_addf(stat, "[%s%s%s] ",
> -						branch_get_color(BRANCH_COLOR_UPSTREAM),
> -						ref, branch_get_color(BRANCH_COLOR_RESET));
> -			else
> -				strbuf_addf(stat, "[%s] ", ref);
> -		}
> +	if (!stat_tracking_info(branch, &ours, &theirs))
>  		return;
> -	}
>  
>  	if (show_upstream_ref) {
>  		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
> @@ -448,7 +437,10 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
>  			strbuf_addstr(&fancy, ref);
>  	}
>  
> -	if (!ours) {
> +	if (!ours && !theirs) {
> +		if (ref)
> +			strbuf_addf(stat, _("[%s]"), fancy.buf);

Mental note: the updated stat_tracking_info() says "something to
report exists" when the current branch and its @{u} are the same,
and we report the branch here.

> +	} else if (!ours) {
>  		if (ref)
>  			strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);

This is not a fault of your change, but the logic to show the
upstream ref is unnecessarily unclear due to variable cascading.
The master switch "show_upstream_ref" is what is used to ask this to
fill the name of the upstream ref, and "ref" is made non-NULL only
when "show_upstream_ref" is true.  Also "fancy" would be non-empty
only in that case, so this "if (ref)" could be any one of these:

        if (show_upstream_ref)
	if (ref)
        if (fancy.len)

It is disturbing that the middle one is used.  If you take the
stance that the code should reflect the logic, the first one
(i.e. "we were asked to show upstream ref, so we show it here")
makes the most sense.  If you take the stance that the code should
be safe with the low-level implementation, the last one (i.e. "we
are showing what is in fancy, if we have prepared something to show
in that buffer") makes sense.  The middle one is the least logical
thing to base the decision on.

> diff --git a/remote.c b/remote.c
> index 2433467..c747936 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1729,7 +1729,8 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
>  }
>  
>  /*
> - * Return true if there is anything to report, otherwise false.
> + * Return false if cannot stat a tracking branch (not exist or invalid),
> + * otherwise true.
>   */
>  int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
>  {
> @@ -1740,18 +1741,12 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
>  	const char *rev_argv[10], *base;
>  	int rev_argc;
>  
> -	/*
> -	 * Nothing to report unless we are marked to build on top of
> -	 * somebody else.
> -	 */
> +	/* False unless we are marked to build on top of somebody else. */

Aren't these saying the same thing?  I'd rather see the comment say
"nothing/something to report", instead of "false/true".  The latter
can be read from the value returned in the code, and writing that in
the comment is redundant.  The former tells the reader what that
"false" _means_, which is the whole point of adding a comment.

>  	if (!branch ||
>  	    !branch->merge || !branch->merge[0] || !branch->merge[0]->dst)
>  		return 0;
>  
> -	/*
> -	 * If what we used to build on no longer exists, there is
> -	 * nothing to report.
> -	 */
> +	/* False if what we used to build on no longer exists */
>  	base = branch->merge[0]->dst;
>  	if (read_ref(base, sha1))
>  		return 0;

Likewise.

> +	*num_theirs = 0;
> +	*num_ours = 0;
> +
>  	/* are we the same? */
>  	if (theirs == ours)
> -		return 0;
> +		return 1;

Shouldn't these zero assignments belong to this condition?  I.e.

	if (theirs == ours) {
        	*num_theirs = *num_ours = 0;
                return 1;
	}

> @@ -1786,8 +1784,6 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
>  	prepare_revision_walk(&revs);
>  
>  	/* ... and count the commits on each side. */
> -	*num_ours = 0;
> -	*num_theirs = 0;
>  	while (1) {
>  		struct commit *c = get_revision(&revs);
>  		if (!c)
> @@ -1815,6 +1811,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
>  	if (!stat_tracking_info(branch, &num_ours, &num_theirs))
>  		return 0;
>  
> +	/* Nothing to report if neither side has changes. */
> +	if (!num_ours && !num_theirs)
> +		return 0;

As far as I can tell, all callers of stat_tracking_info() pass
non-NULL pointers to these two parameters, with or without your
patch.  Can this ever trigger?

The changes you made to builtin/branch.c seems to expect that
returned *num_ours and *num_theirs could both be 0, so it does not
look like the above is a typo of

	if (!*num_ours && !*num_theirs)
        	return 0;

even though the comment "neither side has changes" seems to indicate
that was what was meant.

I am puzzled by this incoherence between the callers and the callee.

> diff --git a/wt-status.c b/wt-status.c
> index ff4b324..0c6a3a5 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1380,15 +1380,24 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>  	branch = branch_get(s->branch + 11);
>  	if (s->is_initial)
>  		color_fprintf(s->fp, header_color, _("Initial commit on "));
> +
> +	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
> +
> +	/*
> +	 * Not report tracking info if no tracking branch found
> +	 * or no difference found.
> +	 */
>  	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
> -		color_fprintf(s->fp, branch_color_local, "%s", branch_name);
> +		fputc(s->null_termination ? '\0' : '\n', s->fp);
> +		return;
> +	}
> +	if (!num_ours && !num_theirs) {
>  		fputc(s->null_termination ? '\0' : '\n', s->fp);
>  		return;
>  	}
>  
>  	base = branch->merge[0]->dst;
>  	base = shorten_unambiguous_ref(base, 0);
> -	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
>  	color_fprintf(s->fp, header_color, "...");
>  	color_fprintf(s->fp, branch_color_remote, "%s", base);
