From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] fetch/pull: recurse into submodules when necessary
Date: Wed, 23 Feb 2011 17:07:13 -0600
Message-ID: <20110223230713.GB6819@elie>
References: <4D656F25.5090007@web.de>
 <4D656F4D.6080401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:07:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsNnq-0002zF-7x
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597Ab1BWXHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:07:21 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63212 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278Ab1BWXHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:07:20 -0500
Received: by vws12 with SMTP id 12so3574108vws.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 15:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TiSoaP4/YghcnUT7+DedvMENZTemBniEzthwVUgbFis=;
        b=BPrzsHvUER2N7k4JT84pVmOSppfpXpkq0pPwUckcJ6eJOPRKUZZ8KKu+3ed+nBfiwr
         2tnHhGUwj+LJE+JM3xF9fZfIlC9rcszaSundKNN/9gdci8WwNS05MaY4rlkn0BJ2HYn5
         RwGKf7y3pN+mXU0E2NunO8CMKIsKHmtNz042A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qRl+HHtDDcf/HLEZDlWB9E/RpT7+KTRgRTIHQUF89vVHyAcTP3zJ1qCo4LKLIwJWUQ
         /MSFtKcnuqhE/grAEiAJlhWltp6wmWqIIWyXsVI9N06SCXNZKuSSo9XVzhlRn2kgGaW2
         7MX1Ybu8ZPmtJFvTl8lINbwqkpL8aPMzCRaPg=
Received: by 10.52.166.226 with SMTP id zj2mr237548vdb.80.1298502439250;
        Wed, 23 Feb 2011 15:07:19 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id e10sm3846594vch.19.2011.02.23.15.07.16
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 15:07:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D656F4D.6080401@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167733>

Jens Lehmann wrote:

> To be able to access all commits of populated submodules referenced by the
> superproject it is sufficient to only then let "git fetch" recurse into a
> submodule when the new commits fetched in the superproject record new
> commits for it.

Exciting stuff.  This would use the default refspec rather than fetching
the bare minimum of commits in submodules, right?

> There is currently no infrastructure for storing deleted and new
> submodules in the .git directory of the superproject. Thats why fetch and
> pull for now only fetch submodules that are already checked out and are
> not renamed.

Ah.

> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -73,6 +73,14 @@ ifndef::git-pull[]
>  	Prepend <path> to paths printed in informative messages
>  	such as "Fetching submodule foo".  This option is used
>  	internally when recursing over submodules.
> +
> +--submodule-default=[yes|on-demand]::
> +	This option is used internally to set the submodule recursion default
> +	to either a boolean configuration value representing "true" (for
> +	unconditonal recursion) or to "on-demand" (when only those submodules
> +	should be fetched of which new commits have been fetched in its
> +	superproject).
> +	Using the "--[no-]recurse-submodules" option ignores this setting.

Could this be combined with the --recurse-submodules, with a "last instance
of the option wins" rule?  Something like:

 --recurse-submodules[=(yes | no | changed)]::
 --no-recurse-submodules::

> +++ b/submodule.c
[...]
> @@ -248,11 +263,73 @@ void set_config_fetch_recurse_submodules(int value)
[...]
> +static void submodule_collect_changed_cb(struct diff_queue_struct *q,
[...]
> +		if (S_ISGITLINK(p->one->mode)) {
> +			/* NEEDSWORK: We should honor the name configured in
> +			 * the .gitmodules file of the commit we are examining
> +			 * here to be able to correctly follow submodules
> +			 * being moved around. */

Hmm, a sort of variant on rename detection.  Does "git submodule update" /
"git checkout --recurse-submodules" use .gitmodules to move pre-populated
subrepositories?

> +			/* Submodule is new or was moved here */
> +			/* NEEDSWORK: When the .git directories of submodules
> +			 * live inside the superprojects .git directory some
> +			 * day we should fetch new submodules directly into
> +			 * that location too when config or options request
> +			 * that so they can be checked out from there. */
> +			continue;

Maybe this can be mentioned in a BUGS section on the git-fetch(1)
manpage to give readers a warning and clue about the intended
meaning of --recurse-submodules?

I'm afraid a certain kind of person might get used to the "don't fetch
new submodules" behavior (e.g., if upstream is including unneeded
convenience copies of libraries right and left in addition to some
useful submodules).

> +void check_for_new_submodule_commits(unsigned char new_sha1[20])
> +{
> +	struct rev_info rev;
> +	struct commit *commit;
> +	int argc = 5;
> +	const char *argv[] = {NULL, NULL, "--not", "--branches", "--remotes", NULL};

Nit: maybe

	const char *argv[] = ...;
	int argc = ARRAY_SIZE(argv) - 1;

?

> +
> +	init_revisions(&rev, NULL);
> +	argv[1] = xstrdup(sha1_to_hex(new_sha1));

Maybe:

	char *new_rev;
	...
	argv[1] = new_rev = xstrdup(...);
	...
	free(new_rev);

> +	setup_revisions(argc, argv, &rev, NULL);
> +	if (prepare_revision_walk(&rev))
> +		die("revision walk setup failed");
> +

Maybe a comment so the reader doesn't have to delve deeper?

	/*
	 * Collect checked out submodules that have changed upstream
	 * in "changed_submodule_paths".
	 */

> +	while ((commit = get_revision(&rev))) {
[...]
> +++ b/t/t5526-fetch-submodules.sh
> @@ -192,4 +192,113 @@ test_expect_success "--no-recurse-submodules overrides config setting" '
[...]
> +	echo "Fetching submodule submodule" > expect.out.sub &&
> +	echo "From $pwd/." > expect.err.sub &&
> +	echo "   $head1..$head2  master     -> origin/master" >> expect.err.sub

I wonder if we should be testing the output in this much detail.

Wouldn't it be nicer to check the remote-tracking refs to make sure
the lasting effects were correct, rather than the detailed output
format?

So: aside from the option name, nothing but nits.  Thanks; that was
fun.
