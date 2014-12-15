From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Mon, 15 Dec 2014 14:29:47 -0800
Message-ID: <xmqq4mswczs4.fsf@gitster.dls.corp.google.com>
References: <1418673368-20785-1-git-send-email-sbeller@google.com>
	<1418673368-20785-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 23:29:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0e9L-0005Z6-3U
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 23:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbaLOW3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 17:29:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750875AbaLOW3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 17:29:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A06B1278A7;
	Mon, 15 Dec 2014 17:29:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wdWMLJsYX7fv7fHY90OPAj+WYQQ=; b=hMrm4O
	2tUULz9L7bcRsh8RU31bKtoMSTnrTobgSZmR/IpF+t1XAt4D4GXuGqUezR+eogxb
	xDFP8esLttIHccXU6qvrtTyhJv1CGp1OH6tMic/1xGAp6S1zkRUVtShGSypf0EHp
	+JEQfy3H7c/Lq3F0dv73qz9g7L9OxTO6jr5lE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lHg+t02rSP6Q1qNbzAhCCu9in+UVJlJL
	FqHoZM+LwJ9jFJQn5E4vX48/rq4jV3gc6fsd4H3bnp86mWZY3VMNrWYpT/GsEdB2
	3LzQQW+PREPdViKUrr+h0SU9WYXizvb0K4p95QOisZZ2DjnXN1bjAXKbn/k01C6Z
	I+LxqRNFUHs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97AFA278A6;
	Mon, 15 Dec 2014 17:29:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DEBA4278A5;
	Mon, 15 Dec 2014 17:29:48 -0500 (EST)
In-Reply-To: <1418673368-20785-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 15 Dec 2014 11:56:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E12007F6-84A9-11E4-9837-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261429>

Stefan Beller <sbeller@google.com> writes:

> This adds tests for the atomic push option.
> The first four tests check if the atomic option works in
> good conditions and the last three patches check if the atomic
> option prevents any change to be pushed if just one ref cannot
> be updated.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     Originally Ronnie had a similar patch prepared. But as I added
>     more tests and cleaned up the existing tests (e.g. use test_commit
>     instead of "echo one >file && gitadd file && git commit -a -m 'one'",
>     removal of dead code), the file has changed so much that I'd rather
>     take ownership.
>
>  t/t5543-atomic-push.sh | 185 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100755 t/t5543-atomic-push.sh
>
> diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
> new file mode 100755
> index 0000000..6cbedc5
> --- /dev/null
> +++ b/t/t5543-atomic-push.sh
> @@ -0,0 +1,185 @@
> +#!/bin/sh
> +
> +test_description='pushing to a repository using the atomic push option'
> +
> +. ./test-lib.sh
> +
> +D=`pwd`

$(pwd)???

> +mk_repo_pair () {
> +	rm -rf workbench upstream thirdparty &&
> +	mkdir upstream &&
> +	(
> +		cd upstream &&
> +		git init --bare #&&
> +		#git config receive.denyCurrentBranch warn

Please drop unused comments; they are distracting.

> +	) &&
> +	mkdir workbench &&
> +	(
> +		cd workbench &&
> +		git init &&
> +		git remote add up ../upstream
> +	)
> +}

Hmph.  Shouldn't you be using test_create_repo to create these, so
that templates are used from the build (not install) location, and
their hooks are disabled?

> +test_push_failed () {

Does that mean "test_push_must_fail"?

> +	workbench_master=$(cd workbench && git show-ref -s --verify refs/heads/master) &&
> +	upstream_master=$(cd upstream && git show-ref -s --verify refs/heads/master) &&
> +	test "$workbench_master" != "$upstream_master" &&
> +
> +	workbench_second=$(cd workbench && git show-ref -s --verify refs/heads/second) &&
> +	upstream_second=$(cd upstream && git show-ref -s --verify refs/heads/second) &&
> +	test "$workbench_second" != "$upstream_second"

So the tests that use this helper always try to update master and
second?  Is "they are different" the only thing that matters?  Or
should you be verifying "They are left as the same value they used
to have before the attempted push that must have failed"?

It might be a good time to use "-C" option, e.g. "git -C workbench show-ref ...",
a bit more in our tests.

> +}
> +
> +test_push_succeeded () {
> +	workbench_master=$(cd workbench && git show-ref -s --verify refs/heads/master) &&
> +	upstream_master=$(cd upstream && git show-ref -s --verify refs/heads/master) &&
> +	test "$workbench_master" = "$upstream_master"

Broken &&-chain?

> +
> +	workbench_second=$(cd workbench && git show-ref -s --verify refs/heads/second) &&
> +	upstream_second=$(cd upstream && git show-ref -s --verify refs/heads/second) &&
> +	test "$workbench_second" = "$upstream_second"
> +}
> +
> +test_expect_success 'atomic push works for a single branch' '
> +	mk_repo_pair &&
> +	(
> +		cd workbench &&
> +		test_commit one &&
> +		git push --mirror up &&
> +		test_commit two &&
> +		git push --atomic-push --mirror up
> +	) &&
> +	workbench_master=$(cd workbench && git show-ref -s --verify refs/heads/master) &&
> +	upstream_master=$(cd upstream && git show-ref -s --verify refs/heads/master) &&
> +	test "$workbench_master" = "$upstream_master"

Hmph.  It is a shame that the nice helper you created cannot be used
here.

> +'
> +
> +test_expect_success 'atomic push works for two branches' '
> +	mk_repo_pair &&
> +	(
> +		cd workbench &&
> +		test_commit one &&
> +		git branch second &&
> +		git push --mirror up &&
> +		test_commit two &&
> +		git checkout second &&
> +		test_commit three &&
> +		git push --atomic-push --mirror up
> +	) &&
> +	test_push_succeeded
> +'

OK.

> +test_expect_success 'atomic push works in combination with --mirror' '
> +	mk_repo_pair &&
> +	ls workbench &&

Debugging?

> +	(
> +		cd workbench &&
> +		test_commit one &&
> +		git checkout -b second &&
> +		test_commit two &&
> +		git push --atomic-push --mirror up

It is not wrong per-se, but haven't you already tested in
combination with --mirror in the previous test?

> +	) &&
> +	test_push_succeeded
> +'
> +
> +test_expect_success 'atomic push works in combination with --force' '
> +	mk_repo_pair &&
> +	(
> +		cd workbench &&
> +		test_commit one &&
> +		git checkout -b second &&
> +		test_commit two &&
> +		test_commit three &&
> +		test_commit four &&
> +		git push --mirror up &&
> +		git reset --hard HEAD^ &&
> +		git push --force --atomic-push up master second
> +	) &&
> +	test_push_succeeded
> +'

OK.

> +# set up two branches where master can be pushed but second can not
> +# (non-fast-forward). Since second can not be pushed the whole operation
> +# will fail and leave master untouched.
> +test_expect_success 'atomic push fails if one branch fails locally' '
> +	mk_repo_pair &&
> +	(
> +		cd workbench &&
> +		test_commit one &&
> +		git checkout -b second master &&
> +		test_commit two &&
> +		test_commit three &&
> +		test_commit four &&
> +		git push --mirror up

Broken &&-chain.

> +		git reset --hard HEAD~2 &&
> +		git checkout master &&
> +		test_commit five &&
> +		! git push --atomic-push --all up

test_must_fail?

> +	) &&
> +	test_push_failed

You not only want to see master and second in upstream different from 
those in workbench, but they point at specific commits that the previous
mirror push updated to.

Instead of test_push_failed / test_push_succeeded, how about a
single helper that takes the two commit object names you expect
these two branches point at?  E.g.

	check_branches upstream master HEAD@{2} second HEAD~

(I am probably miscounting HEAD@{$offset} here; this is for
illustration only) that roughly does

	check_branches () {
		target=$1
                shift
                while test $# -ne 0
                do
			git -C "$target" rev-parse --verify "refs/heads/$1" >actual &&
			git rev-parse "$2" >expect &&
			test_cmp expect actual || return 1
			shift
                        shift
		done
	}

or something like that?

> +test_expect_success 'atomic push fails if one branch fails remotely' '
> +	# prepare the repo
> +	mk_repo_pair &&
> +	(
> +		cd workbench &&
> +		test_commit one &&
> +		git checkout -b second master &&
> +		test_commit two &&
> +		git push --mirror up
> +	) &&
> +	# a third party modifies the server side:
> +	(
> +		git clone upstream thirdparty &&
> +		cd thirdparty
> +		git checkout second
> +		test_commit unrelated_changes &&
> +		git push origin second
> +	) &&
> +	# see if we can now push both branches.
> +	(
> +		cd workbench &&
> +		git checkout master &&
> +		test_commit three &&
> +		git checkout second &&
> +		test_commit four &&
> +		! git push --atomic-push up master second
> +	) &&
> +	test_push_failed
> +'

What's the value of this test?  Isn't it a non-fast-forward check
you already tested in the previous one?

> +test_expect_success 'atomic push fails if one tag fails remotely' '
> +	# prepare the repo
> +	mk_repo_pair &&
> +	(
> +		cd workbench &&
> +		test_commit one &&
> +		git checkout -b second master &&
> +		test_commit two &&
> +		git push --mirror up
> +	) &&
> +	# a third party modifies the server side:
> +	(
> +		git clone upstream thirdparty &&
> +		cd thirdparty
> +		git checkout second
> +		git tag test_tag &&
> +		git push --tags origin second
> +	) &&

Broken &&-chain aside, you do not need thirdparty.  Doing the "git
tag" inside upstream itself should suffice.

> +	# see if we can now push both branches.
> +	(
> +		cd workbench &&
> +		git checkout master &&
> +		test_commit three &&
> +		git checkout second &&
> +		test_commit four &&
> +		git tag test_tag &&
> +		! git push --tags --atomic-push up master second

test_must_fail?

> +	) &&
> +	test_push_failed
> +'

One more failure mode you would want to check is what if "update"
hook in the receiving repository rejected one update (but not the
other).  Something along the lines of:

	... setup ...
	git -C workbench push up &&
        write_script upstream/hooks/update <<-\EOF &&
	# only allow update to master from now on
        test "$1" = "refs/heads/master"
        EOF
        ... further update to master and second ...
        test_must_fail git -C workbench push up
	check_branches upstream master ... second ...


perhaps?
