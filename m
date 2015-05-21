From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/14] remote.c: introduce branch_get_upstream helper
Date: Thu, 21 May 2015 12:16:52 -0700
Message-ID: <xmqqtwv5ivvf.fsf@gitster.dls.corp.google.com>
References: <20150521044429.GA5857@peff.net> <20150521044528.GG23409@peff.net>
	<xmqqbnhdkdne.fsf@gitster.dls.corp.google.com>
	<20150521181429.GA6684@peff.net> <20150521183500.GA8988@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 21:17:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvVxk-0005Ic-Ge
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 21:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbbEUTQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 15:16:55 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38009 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbbEUTQy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 15:16:54 -0400
Received: by igcau1 with SMTP id au1so16501700igc.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 12:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Vaoqi8Y6KfRQu3A2HUG5ltzZoHyLrtmb94xOPe7gfII=;
        b=zDtiu/nU72eaYHwSsQQWGcK1HbOclS72qMTUfre+x4ZymWd5oTz0egyzOH4uvUbf3z
         GUe1ynHszODDt9635FwBpHQzu1a6KgjBTmFsqSGfia6Nx6q0Lw3+d4WLtNi/CyYpuvYe
         YUnU5VV1NzNzTklTbtzEy+GMeizvUs5OLxWQY6sXz6keZEYVPkW0fmY0ZVL/zkoSg/q+
         fVW37vboAXRDxDO9wYi8DRtf9buOjLjtOxyb/AyFQGc9vC1qwQDRBxh+6grq0Gd6IAOs
         1A+W67e+7H9E84F8Efnp+3olGDjkRhyhchrvUB4udTkFkeUGTUxz5ZZ80rz6rVuhV3mp
         ChjQ==
X-Received: by 10.42.238.14 with SMTP id kq14mr231215icb.23.1432235814258;
        Thu, 21 May 2015 12:16:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id f126sm15548768ioe.21.2015.05.21.12.16.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 12:16:53 -0700 (PDT)
In-Reply-To: <20150521183500.GA8988@peff.net> (Jeff King's message of "Thu, 21
	May 2015 14:35:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269648>

Jeff King <peff@peff.net> writes:

> On Thu, May 21, 2015 at 02:14:29PM -0400, Jeff King wrote:
>
>> There is a related cleanup I resisted, which is that several call-sites
>> will call stat_tracking_info, then later look directly at
>> branch->merge[0]->dst without a check for NULL (fill_tracking_info is
>> such a site).
>> 
>> This works because stat_tracking_info's return value tells us that we
>> did indeed find an upstream to compare with. But it feels a little leaky
>> to me. One solution is for stat_tracking_info to pass out the name of
>> thte upstream, making the caller side something like:
>
> So just for fun, here is what a whole patch, with the refactoring of the
> return value, would look like.

It looks much nicer and reads better, at least to me.

Nice.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index cc55ff2..8ecabd1 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -425,25 +425,19 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
>  	int ours, theirs;
>  	char *ref = NULL;
>  	struct branch *branch = branch_get(branch_name);
> +	const char *upstream;
>  	struct strbuf fancy = STRBUF_INIT;
>  	int upstream_is_gone = 0;
>  	int added_decoration = 1;
>  
> -	switch (stat_tracking_info(branch, &ours, &theirs)) {
> -	case 0:
> -		/* no base */
> -		return;
> -	case -1:
> -		/* with "gone" base */
> +	if (stat_tracking_info(branch, &ours, &theirs, &upstream) < 0) {
> +		if (!upstream)
> +			return;
>  		upstream_is_gone = 1;
> -		break;
> -	default:
> -		/* with base */
> -		break;
>  	}
>  
>  	if (show_upstream_ref) {
> -		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
> +		ref = shorten_unambiguous_ref(upstream, 0);
>  		if (want_color(branch_use_color))
>  			strbuf_addf(&fancy, "%s%s%s",
>  					branch_get_color(BRANCH_COLOR_UPSTREAM),
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 6847400..05dd23d 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -730,7 +730,7 @@ static void populate_value(struct refinfo *ref)
>  				char buf[40];
>  
>  				if (stat_tracking_info(branch, &num_ours,
> -						       &num_theirs) != 1)
> +						       &num_theirs, NULL))
>  					continue;
>  
>  				if (!num_ours && !num_theirs)
> @@ -753,7 +753,7 @@ static void populate_value(struct refinfo *ref)
>  				assert(branch);
>  
>  				if (stat_tracking_info(branch, &num_ours,
> -							&num_theirs) != 1)
> +							&num_theirs, NULL))
>  					continue;
>  
>  				if (!num_ours && !num_theirs)
> diff --git a/remote.c b/remote.c
> index be45a39..6765051 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2016,12 +2016,15 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
>  
>  /*
>   * Compare a branch with its upstream, and save their differences (number
> - * of commits) in *num_ours and *num_theirs.
> + * of commits) in *num_ours and *num_theirs. The name of the upstream branch
> + * (or NULL if no upstream is defined) is returned via *upstream_name, if it
> + * is not itself NULL.
>   *
> - * Return 0 if branch has no upstream (no base), -1 if upstream is missing
> - * (with "gone" base), otherwise 1 (with base).
> + * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
> + * upstream defined, or ref does not exist), 0 otherwise.
>   */
> -int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
> +int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
> +		       const char **upstream_name)
>  {
>  	unsigned char sha1[20];
>  	struct commit *ours, *theirs;
> @@ -2032,8 +2035,10 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
>  
>  	/* Cannot stat unless we are marked to build on top of somebody else. */
>  	base = branch_get_upstream(branch, NULL);
> +	if (upstream_name)
> +		*upstream_name = base;
>  	if (!base)
> -		return 0;
> +		return -1;
>  
>  	/* Cannot stat if what we used to build on no longer exists */
>  	if (read_ref(base, sha1))
> @@ -2051,7 +2056,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
>  	/* are we the same? */
>  	if (theirs == ours) {
>  		*num_theirs = *num_ours = 0;
> -		return 1;
> +		return 0;
>  	}
>  
>  	/* Run "rev-list --left-right ours...theirs" internally... */
> @@ -2087,7 +2092,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
>  	/* clear object flags smudged by the above traversal */
>  	clear_commit_marks(ours, ALL_REV_FLAGS);
>  	clear_commit_marks(theirs, ALL_REV_FLAGS);
> -	return 1;
> +	return 0;
>  }
>  
>  /*
> @@ -2096,23 +2101,17 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
>  int format_tracking_info(struct branch *branch, struct strbuf *sb)
>  {
>  	int ours, theirs;
> +	const char *full_base;
>  	char *base;
>  	int upstream_is_gone = 0;
>  
> -	switch (stat_tracking_info(branch, &ours, &theirs)) {
> -	case 0:
> -		/* no base */
> -		return 0;
> -	case -1:
> -		/* with "gone" base */
> +	if (stat_tracking_info(branch, &ours, &theirs, &full_base) < 0) {
> +		if (!full_base)
> +			return 0;
>  		upstream_is_gone = 1;
> -		break;
> -	default:
> -		/* with base */
> -		break;
>  	}
>  
> -	base = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
> +	base = shorten_unambiguous_ref(full_base, 0);
>  	if (upstream_is_gone) {
>  		strbuf_addf(sb,
>  			_("Your branch is based on '%s', but the upstream is gone.\n"),
> diff --git a/remote.h b/remote.h
> index 3326f2b..312b7ca 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -249,7 +249,8 @@ enum match_refs_flags {
>  };
>  
>  /* Reporting of tracking info */
> -int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
> +int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
> +		       const char **upstream_name);
>  int format_tracking_info(struct branch *branch, struct strbuf *sb);
>  
>  struct ref *get_local_heads(void);
> diff --git a/wt-status.c b/wt-status.c
> index 38cb165..7c8ae57 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1532,21 +1532,15 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>  
>  	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
>  
> -	switch (stat_tracking_info(branch, &num_ours, &num_theirs)) {
> -	case 0:
> -		/* no base */
> -		fputc(s->null_termination ? '\0' : '\n', s->fp);
> -		return;
> -	case -1:
> -		/* with "gone" base */
> +	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base) < 0) {
> +		if (!base) {
> +			fputc(s->null_termination ? '\0' : '\n', s->fp);
> +			return;
> +		}
> +
>  		upstream_is_gone = 1;
> -		break;
> -	default:
> -		/* with base */
> -		break;
>  	}
>  
> -	base = branch->merge[0]->dst;
>  	base = shorten_unambiguous_ref(base, 0);
>  	color_fprintf(s->fp, header_color, "...");
>  	color_fprintf(s->fp, branch_color_remote, "%s", base);
