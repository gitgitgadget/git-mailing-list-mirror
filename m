From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/8] t2024: Add tests verifying current DWIM behavior
 of 'git checkout <branch>'
Date: Sat, 20 Apr 2013 13:44:50 -0700
Message-ID: <20130420204449.GC8586@elie.Belkin>
References: <1366470363-22309-1-git-send-email-johan@herland.net>
 <1366470363-22309-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Apr 20 22:45:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTeef-0003VX-SC
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 22:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272Ab3DTUo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 16:44:59 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:56644 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233Ab3DTUo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 16:44:58 -0400
Received: by mail-pd0-f170.google.com with SMTP id 10so2826075pdi.1
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JwbABvT4ec2l4l9OLdktH60pIy3lW97IeVW6i9sl6hM=;
        b=n0fHOIpddMT3uyEBTmEN6mPawwcydRvKHwoCQsOJARBuWCj7i8YEwQ5mwtDW7XJwsO
         DC4ZQT49lxUWGAP+e7RDlsuk4zyVPrx5UiJF0EmI/1LB7jtfIBdiofNWVPRlo/1cRvsG
         1h3q6CIMYBBV73rl/P9AzLd0qi/2aV5IewJjZV5X4eCgzI1Kl1eV4lr8kp9YeLY1snNw
         N4liN60XmfDnltEzafbGtKesoYShr1m1qgy+sALqQgZt/5DP7YdABiH3SlsLqsrm64As
         eXfyDLv7shyGLrOI1YVQv8qQCCrOwwsFcgMfvgduDKTBWBetg4bP37YdAQk+4YTJEx8+
         EscA==
X-Received: by 10.68.209.162 with SMTP id mn2mr24993080pbc.190.1366490698336;
        Sat, 20 Apr 2013 13:44:58 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ad7sm18405131pbd.14.2013.04.20.13.44.56
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 13:44:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1366470363-22309-2-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221874>

Johan Herland wrote:

> The DWIM mode of checkout allows you to run "git checkout foo" when there is
> no existing local ref or path called "foo" and there is exactly one remote
> with a remote-tracking branch called "foo".

Thanks for testing this.  I'm surprised no one suggested a test since
v1.7.0-rc0~51^2~6 (2009-10-18).

Maybe it would also be worthwhile to also test --no-guess?  (c.f.
46148dd7, 2009-10-18)

[...]
> +++ b/t/t2024-checkout-dwim.sh
> @@ -0,0 +1,66 @@
[...]
> +# Arguments: <branch> <remote> <remote-tracking>
> +#
> +# Verify that we have checked out <branch>, and that it is at the same
> +# commit as <remote-tracking>, and that has appropriate tracking config
> +# setup against <remote>
> +test_tracking_branch() {
> +	branch=$1 &&
> +	remote=$2 &&
> +	remote_track=$3 &&
> +	test "refs/heads/$branch" = "$(git rev-parse --symbolic-full-name HEAD)" &&
> +	test "$(git rev-parse --verify HEAD)" = "$(git rev-parse --verify "$remote_track")" &&
> +	test "$remote" = "$(git config "branch.$branch.remote")" &&
> +	test "refs/heads/$branch" = "$(git config "branch.$branch.merge")"

Stylistic tweaks:

 * setting all local vars on one line
 * avoiding command substitution so we notice if commands fail
 * using test_cmp in place of test $foo = $bar for better output
   when the test fails

	# Is the current branch "refs/heads/$1"?
	test_branch () {
		printf "%s\n" "refs/heads/$1" >expect.HEAD &&
		git symbolic-ref HEAD >actual.HEAD &&
		test_cmp expect.HEAD actual.HEAD
	}

	# Is branch "refs/heads/$1" set to pull from "$2/$3"?
	test_branch_upstream () {
		printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
		{
			git config "branch.$1.remote" &&
			git config "branch.$1.merge"
		} >actual.upstream &&
		test_cmp expect.upstream actual.upstream
	}

	test_tracking_branch () {
		branch=$1 remote=$2 remote_branch=$3 &&

		test_branch "$branch" &&
		test_cmp_rev "refs/remotes/$remote/$remote_branch" HEAD &&
		test_branch_upstream "$branch" "$remote" "$remote_branch"
	}

> +}
> +
> +test_expect_success 'setup' '
> +	(git init repo_a &&
> +	 cd repo_a &&
> +	 test_commit a_master &&
> +	 git checkout -b foo &&
> +	 test_commit a_foo &&
> +	 git checkout -b bar &&
> +	 test_commit a_bar
> +	) &&
> +	(git init repo_b &&
> +	 cd repo_b &&
> +	 test_commit b_master &&
> +	 git checkout -b foo &&
> +	 test_commit b_foo &&
> +	 git checkout -b baz &&
> +	 test_commit b_baz
> +	) &&
> +	git remote add repo_a repo_a &&
> +	git remote add repo_b repo_b &&
> +	git config remote.repo_b.fetch \
> +		"+refs/heads/*:refs/remotes/other_b/*" &&
> +	git fetch --all

Style: indenting code in subshells.

	test_expect_success 'setup' '
		git init repo_a &&
		(
			cd repo_a &&
			test_commit a_master &&
			git checkout -b foo &&
			test_commit a_foo &&
			git checkout -b bar &&
			test_commit a_bar
		) &&
		git init repo_b &&
		(
			cd repo_b &&
			test_commit b_master &&
			git checkout -b foo &&
			test_commit b_foo &&
			git checkout -b baz &&
			test_commit b_baz
		) &&
		git remote add repo_a repo_a &&
		git remote add repo_b repo_b &&
		git config remote.repo_b.fetch \
			"+refs/heads/*:refs/remotes/other_b/*" &&
		git fetch --all
	'

> +'
> +
> +test_expect_success 'checkout of non-existing branch fails' '
> +	test_must_fail git checkout xyzzy
> +'

Maybe, to defend against state from previous tests and confirm that
the checkout didn't do anything:

	git checkout -B master &&
	test_might_fail git branch -D xyzzy &&

	test_must_fail git checkout xyzzy &&
	test_must_fail git rev-parse --verify refs/heads/xyzzy &&
	test_branch master

> +
> +test_expect_success 'checkout of branch from multiple remotes fails' '
> +	test_must_fail git checkout foo
> +'

Likewise:

	git checkout -B master &&
	test_might_fail git branch -D foo &&

	test_must_fail git checkout foo &&
	test_must_fail git rev-parse --verify refs/heads/foo &&
	test_branch master

> +
> +test_expect_success 'checkout of branch from a single remote succeeds #1' '
> +	git checkout bar &&
> +	test_tracking_branch bar repo_a refs/remotes/repo_a/bar

	git checkout -B master &&
	test_might_fail git branch -D bar &&

	git checkout bar &&
	test_branch bar &&
	test_cmp_rev remotes/repo_a/bar HEAD &&
	test_branch_upstream bar repo_a bar

> +test_expect_success 'checkout of branch from a single remote succeeds #2' '
> +	git checkout baz &&
> +	test_tracking_branch baz repo_b refs/remotes/other_b/baz

	git checkout -B master &&
	test_might_fail git branch -D baz &&

	git checkout baz &&
	test_branch baz &&
	test_cmp_rev remotes/other_b/baz HEAD &&
	test_branch_upstream baz repo_b baz

And for --no-guess:

	test_expect_success '--no-guess suppresses branch auto-vivification' '
		git checkout -B master &&
		test_might_fail git branch -D bar &&

		test_must_fail git checkout --no-guess bar &&
		test_must_fail git rev-parse --verify refs/heads/bar &&
		test_branch master
	'

Sane?

Thanks,
Jonathan
