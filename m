From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/6] fetch/pull: recurse into submodules when necessary
Date: Thu, 24 Feb 2011 00:43:46 +0100
Message-ID: <4D659BB2.3020805@web.de>
References: <4D656F25.5090007@web.de> <4D656F4D.6080401@web.de> <20110223230713.GB6819@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:45:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsOOc-0005m0-CA
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743Ab1BWXpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:45:21 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:60465 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab1BWXpU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:45:20 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1001F189C168E;
	Thu, 24 Feb 2011 00:43:47 +0100 (CET)
Received: from [93.240.119.189] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PsON0-0006D9-00; Thu, 24 Feb 2011 00:43:46 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110223230713.GB6819@elie>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19L2a1wXHkzFt95uW2bQjAkjKYYmOoc0XMLScMp
	LyyvG0GnGIX07eNEqSGYzgOSYkWjaoLoyL5Q/8lm1DLU7HjZ5q
	t8tO3cMK/QNNj/mCkmdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167744>

Am 24.02.2011 00:07, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
> 
>> To be able to access all commits of populated submodules referenced by the
>> superproject it is sufficient to only then let "git fetch" recurse into a
>> submodule when the new commits fetched in the superproject record new
>> commits for it.
> 
> Exciting stuff.  This would use the default refspec rather than fetching
> the bare minimum of commits in submodules, right?

Yup, AFAIK I have no means right now to tell "git fetch" to only fetch
certain commits. But we were talking at the GitTogether that this might
be useful and with a bit of tweaking the code would support that too.

>> --- a/Documentation/fetch-options.txt
>> +++ b/Documentation/fetch-options.txt
>> @@ -73,6 +73,14 @@ ifndef::git-pull[]
>>  	Prepend <path> to paths printed in informative messages
>>  	such as "Fetching submodule foo".  This option is used
>>  	internally when recursing over submodules.
>> +
>> +--submodule-default=[yes|on-demand]::
>> +	This option is used internally to set the submodule recursion default
>> +	to either a boolean configuration value representing "true" (for
>> +	unconditonal recursion) or to "on-demand" (when only those submodules
>> +	should be fetched of which new commits have been fetched in its
>> +	superproject).
>> +	Using the "--[no-]recurse-submodules" option ignores this setting.
> 
> Could this be combined with the --recurse-submodules, with a "last instance
> of the option wins" rule?  Something like:
> 
>  --recurse-submodules[=(yes | no | changed)]::
>  --no-recurse-submodules::

Nope, as this only sets the default. "--recurse-submodules" overrides
anything configured, which is not what we want here. This option should
only set the default.

>> +++ b/submodule.c
> [...]
>> @@ -248,11 +263,73 @@ void set_config_fetch_recurse_submodules(int value)
> [...]
>> +static void submodule_collect_changed_cb(struct diff_queue_struct *q,
> [...]
>> +		if (S_ISGITLINK(p->one->mode)) {
>> +			/* NEEDSWORK: We should honor the name configured in
>> +			 * the .gitmodules file of the commit we are examining
>> +			 * here to be able to correctly follow submodules
>> +			 * being moved around. */
> 
> Hmm, a sort of variant on rename detection.  Does "git submodule update" /
> "git checkout --recurse-submodules" use .gitmodules to move pre-populated
> subrepositories?

Not yet ;-)

>> +			/* Submodule is new or was moved here */
>> +			/* NEEDSWORK: When the .git directories of submodules
>> +			 * live inside the superprojects .git directory some
>> +			 * day we should fetch new submodules directly into
>> +			 * that location too when config or options request
>> +			 * that so they can be checked out from there. */
>> +			continue;
> 
> Maybe this can be mentioned in a BUGS section on the git-fetch(1)
> manpage to give readers a warning and clue about the intended
> meaning of --recurse-submodules?
> 
> I'm afraid a certain kind of person might get used to the "don't fetch
> new submodules" behavior (e.g., if upstream is including unneeded
> convenience copies of libraries right and left in addition to some
> useful submodules).

I'm not sure I understand what you mean by this, right now this can
only work for populated submodules. I hope this will change soon, but
I'm not quite there yet ;-)

>> +void check_for_new_submodule_commits(unsigned char new_sha1[20])
>> +{
>> +	struct rev_info rev;
>> +	struct commit *commit;
>> +	int argc = 5;
>> +	const char *argv[] = {NULL, NULL, "--not", "--branches", "--remotes", NULL};
> 
> Nit: maybe
> 
> 	const char *argv[] = ...;
> 	int argc = ARRAY_SIZE(argv) - 1;
> 
> ?

Fine by me!

>> +
>> +	init_revisions(&rev, NULL);
>> +	argv[1] = xstrdup(sha1_to_hex(new_sha1));
> 
> Maybe:
> 
> 	char *new_rev;
> 	...
> 	argv[1] = new_rev = xstrdup(...);
> 	...
> 	free(new_rev);

I'm not sure I get what the extra variable gains us ...

>> +	setup_revisions(argc, argv, &rev, NULL);
>> +	if (prepare_revision_walk(&rev))
>> +		die("revision walk setup failed");
>> +
> 
> Maybe a comment so the reader doesn't have to delve deeper?

?

> 	/*
> 	 * Collect checked out submodules that have changed upstream
> 	 * in "changed_submodule_paths".
> 	 */
> 
>> +	while ((commit = get_revision(&rev))) {
> [...]
>> +++ b/t/t5526-fetch-submodules.sh
>> @@ -192,4 +192,113 @@ test_expect_success "--no-recurse-submodules overrides config setting" '
> [...]
>> +	echo "Fetching submodule submodule" > expect.out.sub &&
>> +	echo "From $pwd/." > expect.err.sub &&
>> +	echo "   $head1..$head2  master     -> origin/master" >> expect.err.sub
> 
> I wonder if we should be testing the output in this much detail.
> 
> Wouldn't it be nicer to check the remote-tracking refs to make sure
> the lasting effects were correct, rather than the detailed output
> format?

Yes, that makes sense!

> So: aside from the option name, nothing but nits.  Thanks; that was
> fun.

Thanks!
