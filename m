From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2] pull: add --set-upstream
Date: Mon, 06 Jun 2016 17:54:54 +0200
Message-ID: <vpqvb1mgvn5.fsf@anie.imag.fr>
References: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org>
	<20160606093437.1992-1-erwan.mathoniere@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jordan.de-gea@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org,
	gitster@pobox.com
To: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 17:55:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9wrx-0006H1-CU
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 17:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbcFFPzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 11:55:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45818 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbcFFPzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 11:55:05 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u56FsrVI024369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jun 2016 17:54:53 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u56FssrC002926;
	Mon, 6 Jun 2016 17:54:55 +0200
In-Reply-To: <20160606093437.1992-1-erwan.mathoniere@grenoble-inp.org> (Erwan
	Mathoniere's message of "Mon, 6 Jun 2016 11:34:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 06 Jun 2016 17:54:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u56FsrVI024369
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465833297.04913@pDqapvosBFH2Dsme4fu7Fg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296522>

Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org> writes:

> @@ -497,6 +504,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
>  		fprintf(stderr, "\n");
>  		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:"));
>  		fprintf(stderr, "\n");
> +		fprintf_ln(stderr, "    git pull -u %s %s", _("<remote>"), _("<branch>"));

I'd rather use the long syntax "--set-upstream" in the advice. It gives
a hint to the user about what the command is actually going to do.

> +static void set_pull_upstream(const char *repo, const char **refspecs_name)
> +{
> +	unsigned char sha1[GIT_SHA1_RAWSZ];

The trend in the codebase is to use object_id instead of these char
sha1[] arrays. See the output of "git log --grep object_id" for details.

> +	strbuf_init(&buf, 0);
> +	refspec = parse_fetch_refspec(nr_refspec, refspecs_name);
> +
> +	for (i = 0; i < nr_refspec; i++) {
> +		if (refspec[i].pattern) {
> +			warning(_("upstream cannot be set for patterns"));
> +			continue;
> +		}
> +
> +		branch = branch_get(refspec[i].dst);
> +		if (!branch || !ref_exists(branch->refname)) {
> +			if (!refspec[i].dst || !*refspec[i].dst)
> +				warning(_("could not set upstream of HEAD when "
> +					"it does not point to any branch."));
> +			else
> +				warning(_("cannot set upstream: "
> +					"'%s' is not a branch"), refspec[i].dst);

Inconsistent message: "could not"/"cannot".

For this kind of code, it greatly helps to have comments refering to the
input syntax for each branch of each conditionals. I'm not familiar with
this part of the code, but if I understood correctly, the above would be

if ()
	/* refspec: <branch>: */
        warning(...);
else
	/* refspec: <branch>:<no-such-branch> */
        warning(...);

I think it would make sense to actually raise an error (i.e. set the
exit status of the "git pull" process to a non-zero value) when such
issue occur. OTOH, "git push --set-upstream" does not even issue a
warning when trying to --set-upstream to a tag for example, so not
raising an error is consistant.

>  int cmd_pull(int argc, const char **argv, const char *prefix)
>  {
> +	int ret;
>  	const char *repo, **refspecs;
>  	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
>  	unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
> @@ -918,11 +1013,16 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  	if (is_null_sha1(orig_head)) {
>  		if (merge_heads.nr > 1)
>  			die(_("Cannot merge multiple branches into empty head."));
> -		return pull_into_void(*merge_heads.sha1, curr_head);
> +		ret = pull_into_void(*merge_heads.sha1, curr_head);
>  	} else if (opt_rebase) {
>  		if (merge_heads.nr > 1)
>  			die(_("Cannot rebase onto multiple branches."));
> -		return run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
> +		ret = run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
>  	} else
> -		return run_merge();
> +		ret = run_merge();
> +
> +	if (opt_set_upstream && ret < 128)

Shouldn't this be "ret == 0"?

> --- /dev/null
> +++ b/t/t5544-pull-upstream.sh
> @@ -0,0 +1,164 @@
> +#!/bin/sh
> +
> +test_description='pull with --set-upstream'
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-terminal.sh
> +
> +test_config_unchanged () {
> +	git config --list --local >original
> +	"$@"
> +	git config --list --local >modified
> +	test_cmp original modified
> +}

The test passes if "$@" fails. You should &&-chain the lines here to
catch things like crashes or unexpected "exit 1" in git.

> +check_config () {

Perhaps "check_upstream" is more expressive.

> +	(echo "$2"; echo "$3") >expect

What happened to Junio's suggestion with test_write_lines?

> +test_expect_success 'setup repos' '
> +	git init parent &&
> +	(
> +		cd parent &&
> +		echo content >file &&
> +		git add file &&
> +		git commit -am one &&

test_commit can make this code simpler.

> +		echo content_modified >file &&
> +		git commit -am "file modification"

Likewise.

> +test_expect_success 'pull -u master' '
> +	git pull -u upstream master &&
> +	check_config master upstream refs/heads/master
> +'
> +
> +test_expect_success 'pull -u takes the last branch as upstream' '
> +	test_might_fail git config --unset branch.master.merge &&
> +	test_might_fail git config --unset branch.master.remote &&
> +	git pull -u upstream master master2 &&
> +	check_config master upstream refs/heads/master2
> +'
> +
> +test_expect_success 'pull -u master:other' '
> +	git pull -u upstream master:other &&
> +	check_config other upstream refs/heads/master
> +'
> +
> +

Nit: two blank lines instead of one.

> +test_expect_success 'pull -u refs/heads/*:refs/remotes/origin/* should not work' '
> +	git checkout master &&
> +	test_config_unchanged git pull -u upstream "refs/heads/*:refs/remotes/upstream/*"
> +'
> +
> +test_expect_success 'pull -u master:refs/remotes/origin/master should not work' '
> +	test_config_unchanged git pull -u upstream master:refs/remotes/upstream/master
> +'
> +
> +test_expect_success 'pull -u with a tag should not work' '
> +	git checkout master &&
> +	test_config_unchanged git pull -u upstream initial_tag
> +'
> +
> +test_expect_success 'pull -u on detached head should not work' '
> +	git checkout HEAD^0 &&
> +	test_config_unchanged git pull -u upstream master2 &&
> +	git checkout -
> +'

For all these "test_config_unchanged", it would be nice to check that
the error message is the right one too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
