From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] revision.c: introduce --min-parents and --max-parents
Date: Fri, 18 Mar 2011 15:48:54 -0500
Message-ID: <20110318204854.GA23331@elie>
References: <cover.1300459016.git.git@drmicha.warpmail.net>
 <7f2a7d979cd8f6b9fce577994c82f50421575d58.1300459017.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 21:49:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0gbh-0003VF-VU
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 21:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757330Ab1CRUtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 16:49:09 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34731 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756949Ab1CRUtG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 16:49:06 -0400
Received: by gyf1 with SMTP id 1so1735838gyf.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 13:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=eBMm2MyMV/o3rZkwF+TXnH5YbsT7zMHVguENDmAat8M=;
        b=xB5hHw22UeAz7eRQmIaa9SO9pyBSnuqzMxK+rkGoCGbm4d74lhwkXZniYHrTtifkWz
         bmjkE4Ua8wmfTfvVpKoOFxfgQFU6pQ0V0/ml2/+qcAPUb51DMzXecDJAHUnCO939a9mi
         dxAkCepBs7bZApAa5PQUoZ1cVcrnFtSQOLHyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZSD3eR3Dlxy7dEtriEyAVVag/zYagkdiZ/w0wjsqh9bhNuQ6rGuRgFbb2P30ieAINT
         3sfNHn+g7dWRcv6t6LLbirtKXKINpHEOlqHt9V8Wy4bsXJgt4Nz+6PG4IBDaa0wvxgWO
         AYxLp4zfecxu0Sk1NfYHgJMwTui7oobMR4/LQ=
Received: by 10.236.20.131 with SMTP id p3mr2204894yhp.189.1300481345961;
        Fri, 18 Mar 2011 13:49:05 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id 46sm1373729yhl.60.2011.03.18.13.49.04
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 13:49:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7f2a7d979cd8f6b9fce577994c82f50421575d58.1300459017.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169357>

Hi,

Michael J Gruber wrote:

> --max-parents=1: no merges
> --min-parents=2: merges only
> --max-parents=0: only roots
> --min-parents=3: only octopusses

This is growing on me.  Thanks for inventing it.

> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1061,7 +1061,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	rev.commit_format = CMIT_FMT_EMAIL;
>  	rev.verbose_header = 1;
>  	rev.diff = 1;
> -	rev.no_merges = 1;
> +	rev.max_parents = MAX_PARENTS(1);

Is there a reason not to choose a convention for which

	rev.max_parents = 1;

works?

What does --no-merges --merges do?  I would find it most intuitive to
error out (since some people would want the last choice to win and
others want --merges-only --nonmerges-only to select the empty set),
but this patch does the backward-compatible thing, which is to show
zero commits.  Maybe it deserves a test case?

> --- a/revision.c
> +++ b/revision.c
> @@ -1277,9 +1277,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--remove-empty")) {
>  		revs->remove_empty_trees = 1;
>  	} else if (!strcmp(arg, "--merges")) {
> -		revs->merges_only = 1;
> +		revs->min_parents = MIN_PARENTS(2);

Why not "revs->min_parents = 2;"?

>  	} else if (!strcmp(arg, "--no-merges")) {
> -		revs->no_merges = 1;
> +		revs->max_parents = MAX_PARENTS(1);
> +	} else if (!prefixcmp(arg, "--min-parents=")) {
> +		revs->min_parents = MIN_PARENTS(atoi(arg+14));
> +	} else if (!prefixcmp(arg, "--max-parents=")) {
> +		revs->max_parents = MAX_PARENTS(atoi(arg+14));

It would be nicer to error out for malformed numbers.  That's
a separate topic, though --- you have plenty of company.

> @@ -2029,10 +2033,15 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
>  		return commit_ignore;
>  	if (revs->min_age != -1 && (commit->date > revs->min_age))
>  		return commit_ignore;
> -	if (revs->no_merges && commit->parents && commit->parents->next)
> -		return commit_ignore;
> -	if (revs->merges_only && !(commit->parents && commit->parents->next))
> -		return commit_ignore;
> +	if (revs->min_parents || revs->max_parents) {
> +		int n = 0;
> +		struct commit_list *p;
> +		for (p = commit->parents; p; p = p->next)
> +			n++;
> +		if ((MIN_PARENTS(n) < revs->min_parents) ||
> +		    (MAX_PARENTS(n) < revs->max_parents)) /* max is inv. */
> +			return commit_ignore;

Sane.  If we feared enormous parent lists we could do

	for (p = commit->parents; p && n <= 7 - revs->max_parents; p = p->next)
		n++;

but I suspect that's slower.

> --- a/revision.h
> +++ b/revision.h
> @@ -20,6 +20,11 @@
>  #define DECORATE_SHORT_REFS	1
>  #define DECORATE_FULL_REFS	2
>  
> +/* limit to used range */
> +#define MIN_PARENTS(m)	({ unsigned int __n = (m); (__n < 0) ? 0 : (__n > 7) ? 7 : __n; })
> +/* invert fox MAX so that default = 0 -> infinity */
> +#define MAX_PARENTS(m)	({ unsigned int __n = (m); (__n < 0) ? 7 : (__n > 7) ? 0 : 7 - __n;})

Statement expressions don't work in most non-gcc compilers (but
inline functions do).

Hope that helps,
Jonathan
