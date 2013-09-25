From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/2] checkout: allow dwim for branch creation for "git
 checkout $branch --"
Date: Wed, 25 Sep 2013 15:33:34 -0700
Message-ID: <20130925223334.GB9464@google.com>
References: <1380137471-26972-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	jc@sahnwaldt.de
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 26 00:33:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOxeR-0001nB-Qp
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 00:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab3IYWdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 18:33:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47246 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab3IYWdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 18:33:38 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so268798pbb.19
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 15:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cAwnInkH1D+PeNi7nYzyCI+xEim/ryvOI98nRYHfzDA=;
        b=U5aKRAUOh0cCQN33ZAhtW2A3+Z0P6R5lo58+HtoI1INVpFyWP/RkcPj4fb2dawcE0E
         gVUuYisDeQVAShw0MZfFM7VwYH+y+kKxwWIepF7lFWxNfOyCobw5LyBCVzcGJ8jC83tY
         FE8Q32+eVUfqOOOlhxeu0/hf0ALhlIO0pYA7l3CPYYuaR1/5/2WOk/zYMn4d+nKMZFWE
         wcKtGUqZHWHKkMhh0qVZU8mTtIaHuYPrbA0njybtmpep1Xh65vwmpV8Uq12fi+VOVsQ5
         TYMGoBYH7uZm5q4Fkx2nJWz1rLH4Cu8qbqgInh1iBpC9Rlvam3DvTks+HHdI2g9Cv79t
         2bkA==
X-Received: by 10.68.182.3 with SMTP id ea3mr20050529pbc.124.1380148418123;
        Wed, 25 Sep 2013 15:33:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sy10sm341387pac.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 15:33:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1380137471-26972-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235376>

Hi,

Matthieu Moy wrote:

> The "--" notation disambiguates files and branches, but as a side-effect
> of the previous implementation, also disabled the branch auto-creation
> when $branch does not exist.

Hm.  I am not sure that was just an implementation side-effect.

Normally 'git checkout <branch> --' means "Check out that branch,
and I mean it!".  'git checkout -- <pattern>' means "Check out
these paths from the index, and I mean it!"  'git checkout <blah>'
means "Do what I mean".

On the other hand, if I want to do 'git checkout <branch> --'
while disabling the "set up master to track origin/master" magic,
I can use 'git checkout --no-track <branch> --'.  So I think this
is a good change.

[...]
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -863,6 +863,14 @@ static const char *unique_tracking_name(const char *name, unsigned char *sha1)
>  	return NULL;
>  }
>  
> +static int error_invalid_ref(const char *arg, int has_dash_dash, int argcount)
> +{
> +	if (has_dash_dash)
> +		die(_("invalid reference: %s"), arg);
> +	else
> +		return argcount;
> +}

Style: I'd leave out the 'else'

	if (has_dash_dash)
		...
	return argcount;

More importantly, what's the contract behind this function?  Is there
a simpler explanation than "If argument #2 is true, print a certain
message depending on argument #1; otherwise, return argument #3?".
If not, it might be clearer to inline it.

[...]
> @@ -881,6 +889,12 @@ static int parse_branchname_arg(int argc, const char **argv,
>  	 *   <ref> must be a valid tree, everything after the '--' must be
>  	 *   a path.
>  	 *
> +	 *   A sub-case of (1) is "git checkout <ref> --". In this
> +	 *   case, checkout behaves like case (3), except that it does
> +	 *   not attempt to understand <ref> as a file (hence, the
> +	 *   short-hand to create branch <ref> works even if <ref>
> +	 *   exists as a filename).

Maybe simpler to explain as a separate case?

	case 1: git checkout <ref> -- <paths>
	case 2: git checkout -- [<paths>]
	case 3: git checkout <something> [--]

	  If <something> is a commit, [...]

	  If <something> is _not_ a commit, either "--" is present or
	  <something> is not a path, no -t nor -b was given, and [...]

	  Otherwise, if "--" is present, treat it like case (1).

	  Otherwise behave like case (4).

	case 4: git checkout <something> <paths>

	  The first argument must not be ambiguous.
	  - If it's *only* a reference, [...]


[...]
> @@ -916,20 +930,28 @@ static int parse_branchname_arg(int argc, const char **argv,
>  	if (!strcmp(arg, "-"))
>  		arg = "@{-1}";
>  
> -	if (get_sha1_mb(arg, rev)) {
> +	if (get_sha1_mb(arg, rev)) { /* case (1)? */

The check means that we are most likely not in case (1), since arg isn't
a commit name, right?

> -		if (has_dash_dash)          /* case (1) */
> -			die(_("invalid reference: %s"), arg);
> -		if (dwim_new_local_branch_ok &&
> -		    !check_filename(NULL, arg) &&
> -		    argc == 1) {
> -			const char *remote = unique_tracking_name(arg, rev);
> -			if (!remote)
> -				return argcount;
> +		int try_dwim = dwim_new_local_branch_ok;
> +
> +		if (check_filename(NULL, arg) && !has_dash_dash)
> +			try_dwim = 0;
> +		/*
> +		 * Accept "git checkout foo" and "git checkout foo --"
> +		 * as candidates for dwim.
> +		 */
> +		if (!(argc == 1 && !has_dash_dash) &&
> +		    !(argc == 2 && has_dash_dash))
> +			try_dwim = 0;
> +
> +		if (try_dwim) {
> +			const char *remote = unique_tracking_name(arg, rev);
> +			if (!remote)
> +				return error_invalid_ref(arg, has_dash_dash, argcount);

This could be simplified by eliminating try_dwim local.

We are trying case (3) first:

		if (dwim_new_local_branch_ok &&
		    (argc == 1 || (argc == 2 && has_dash_dash)) &&
		    (has_dash_dash || !check_filename(NULL, arg))) {
			...

Then can come the "invalid reference" check for case (1):

		} else if (has_dash_dash)	/* case (1) */
			die(...);

Then case (4).

		else	/* case (4) */
			return argcount;

[...]
> --- a/t/t2024-checkout-dwim.sh
> +++ b/t/t2024-checkout-dwim.sh
> @@ -164,4 +164,26 @@ test_expect_success 'checkout of branch from a single remote succeeds #4' '
>  	test_branch_upstream eggs repo_d eggs
>  '
>  
> +test_expect_success 'checkout of branch with a file having the same name fails' '
> +	git checkout -B master &&
> +	test_might_fail git branch -D spam &&
> +
> +	>spam &&
> +	test_must_fail git checkout spam &&
> +	test_must_fail git checkout spam &&

Why twice?

> +	test_must_fail git rev-parse --verify refs/heads/spam &&
> +	test_branch master
> +'
> +
> +test_expect_success 'checkout <branch> -- succeeds, even if a file with the same name exists' '
> +	git checkout -B master &&
> +	test_might_fail git branch -D spam &&
> +
> +	>spam &&
> +	git checkout spam -- &&
> +	test_branch spam &&
> +	test_cmp_rev refs/remotes/extra_dir/repo_c/extra_dir/spam HEAD &&
> +	test_branch_upstream spam repo_c spam

Nice.

Do we check that "git checkout --no-track spam --" avoids Dscho's
DWIM?

Thanks, and hope that helps,
Jonathan
