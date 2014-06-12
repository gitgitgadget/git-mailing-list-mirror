From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6] Add an explicit GIT_DIR to the list of excludes
Date: Thu, 12 Jun 2014 08:19:19 +0200
Message-ID: <53994667.90209@kdbg.org>
References: <CACsJy8Cgu792Tamej3+_9w=Krg8nezYYA6k604gikebHG=yVUg@mail.gmail.com> <1402529308-3940-1-git-send-email-pasha.bolokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: pclouds@gmail.com, jrnieder@gmail.com, jnareb@gmail.com,
	git@vger.kernel.org
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 08:19:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuyMB-0000nA-U0
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 08:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbaFLGTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 02:19:24 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:3961 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754123AbaFLGTY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 02:19:24 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 023EACDF9C;
	Thu, 12 Jun 2014 08:19:20 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 34C5A19F3F1;
	Thu, 12 Jun 2014 08:19:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1402529308-3940-1-git-send-email-pasha.bolokhov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251394>

Am 12.06.2014 01:28, schrieb Pasha Bolokhov:
> +test_expect_success "setup" '
> +	mkdir repo-inside/ &&
> +	(
> +		cd repo-inside/ &&
> +		for f in a b c d
> +		do
> +			echo "DATA" >"$f" || exit 1
> +		done &&
> +		mkdir dir1 dir1/meta &&
> +		mkdir dir1/ssubdir dir1/ssubdir/meta &&
> +		for f in e f g h
> +		do
> +			echo "MORE DATA" >"dir1/$f" || exit 1
> +		done &&
> +		echo "EVEN more Data" >dir1/meta/aa &&
> +		echo "Data and BAIT" >dir1/ssubdir/meta/aaa &&
> +		mkdir dir2
> +		echo "Not a Metadata File" >dir2/meta

&&-chain broken twice.

We already use 'mkdir -p' elsewhere; you can use it here as well to
contract several mkdir invocations.

> +		git --git-dir=meta init
> +	) &&
> +	mkdir repo-outside/ repo-outside/external repo-outside/tree &&
> +	(
> +		cd repo-outside/tree &&
> +		for f in n o p q
> +		do
> +			echo "Literal Data" >"$f" || exit 1
> +		done &&
> +		mkdir meta sub sub/meta &&
> +		echo "Sample data" >meta/bb &&
> +		echo "Stream of data" >sub/meta/bbb &&
> +		git --git-dir=../external/meta init
> +	)
> +'
> +
> +
> +#
> +# The first set of tests (the repository is inside the work tree)
> +#
> +test_expect_success "'git status' ignores the repository directory" '
> +	(
> +		cd repo-inside &&
> +		git --git-dir=meta --work-tree=. status --porcelain --untracked=all |
> +			grep meta | sort >status.actual.2 &&

Please do not place a git invocation in a pipline such that it is not
the last command; its exist status would be ignored:

		git --git-dir=meta --work-tree=. status --porcelain --untracked=all
>status.actual.2+ &&
		grep meta status.actual.2+ | sort >status.actual.2 &&

There are more cases like this later in the patch.

> +		cat >status.expect.2 <<-\EOF &&
> +		?? dir1/meta/aa
> +		?? dir1/ssubdir/meta/aaa
> +		?? dir2/meta
> +		EOF
> +		test_cmp status.actual.2 status.expect.2

It is customary to call the files 'expect' and 'actual'. Furthermore,
swap the order so that in case of a failure the diff shows how the
actual text was changed from the expected text:

		test_cmp status.expect.2 status.actual.2

> +	)
> +'
> +
> +test_expect_success "'git add -A' ignores the repository directory" '
> +	(
> +		cd repo-inside &&
> +		git --git-dir=meta --work-tree=. add -A &&
> +		git --git-dir=meta --work-tree=. status --porcelain | grep meta | sort >status.actual.3 &&
> +		cat >status.expect.3 <<-\EOF &&
> +		A  dir1/meta/aa
> +		A  dir1/ssubdir/meta/aaa
> +		A  dir2/meta
> +		EOF
> +		test_cmp status.actual.3 status.expect.3
> +	)
> +'
> +
> +test_expect_success "'git grep --exclude-standard' ignores the repository directory" '
> +	(
> +		cd repo-inside &&
> +		test_might_fail git --git-dir=meta \
> +			grep --no-index --exclude-standard BAIT >grep.actual.4 &&
> +		cat >grep.expect.4 <<-\EOF &&
> +		dir1/ssubdir/meta/aaa:Data and BAIT
> +		EOF
> +		test_cmp grep.actual.4 grep.expect.4
> +	)
> +'
> +
> +#
> +# The second set of tests (the repository is outside of the work tree)
> +#
> +test_expect_success "'git status' acknowledges directories 'meta' \
> +if repo is not within work tree" '
> +	test_might_fail rm -rf meta/ &&

How might this fail? Only if permissions are wrong, and then we do want
this to fail.

Moreover, test_*_fail helpers are intended to be used only with git
commands; we don't expect system commands to fail in unexpected ways.

> +	(
> +		cd repo-outside/tree &&
> +		git --git-dir=../external/meta init &&
> +		git --git-dir=../external/meta --work-tree=. status --porcelain --untracked=all |
> +			grep meta | sort >status.actual.5 &&
> +		cat >status.expect.5 <<-\EOF &&
> +		?? meta/bb
> +		?? sub/meta/bbb
> +		EOF
> +		test_cmp status.actual.5 status.expect.5
> +	)
> +'
> +
> +test_expect_success "'git add -A' adds 'meta' if the repo is outside the work tree" '
> +	(
> +		cd repo-outside/tree &&
> +		git --git-dir=../external/meta --work-tree=. add -A &&
> +		git --git-dir=../external/meta --work-tree=. status --porcelain --untracked=all |
> +			grep meta | sort >status.actual.6 &&
> +		cat >status.expect.6 <<-\EOF &&
> +		A  meta/bb
> +		A  sub/meta/bbb
> +		EOF
> +		test_cmp status.actual.6 status.expect.6
> +	)
> +'
> +
> +test_done
> 
