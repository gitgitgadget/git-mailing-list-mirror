From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file>
 <external file>' finds changes
Date: Mon, 18 Jun 2012 13:09:13 -0700
Message-ID: <7vr4tc2xhy.fsf@alter.siamese.dyndns.org>
References: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 22:09:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgiGI-00076H-27
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 22:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab2FRUJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 16:09:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388Ab2FRUJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 16:09:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D16A936D;
	Mon, 18 Jun 2012 16:09:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PFkeV+ML+4GbpwLtY8u/OzhysUY=; b=Kmj2cg
	EBjqlTRvqlc14D//KMUsITSddULA96hObRoRJjI8a2Mj+zHxfYL7RX4mz2zYWqNk
	YEc9MUAutGMC3beIkgDeUHbcu5vdmEQf9p9IODsvt+ZqB+1jv0KY50mZsvLXPVgM
	YBp/2c3IX5QmtseR1g09tranMUpVqdNXksGyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EtkQ4N+TG36+zcG7pn46fXpbP2ysW5kY
	8K0EnzGP9xqUHJML3tD/+uEl4m9g1Rz2THCEjXittYmc4ozzICdSVDJr3J5eWckn
	h3J03Elp9l8FZLTPsss0kuUBSzGpz8hZFSEcRNDIIm7jnqLk9SeJn68G656zCA1C
	r2nIbNLnDXE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64B26936C;
	Mon, 18 Jun 2012 16:09:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAEB69369; Mon, 18 Jun 2012
 16:09:14 -0400 (EDT)
In-Reply-To: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Mon, 18 Jun 2012 15:28:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A1231BA-B981-11E1-B24A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200163>

Tim Henigan <tim.henigan@gmail.com> writes:

> When running 'git diff --quiet <file1> <file2>', if file1 or file2
> is outside the repository, it will exit(0) even if the files differ.
> It should exit(1) when they differ.
>
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---
>
>
> v3 improves the test coverage to include variations of 'diff --quiet'
> where one or both of the files are outside the repository. Tests for
> '--ignore-space-at-eol' and '--ignore-all-space' are included as well.
>
>
>  diff-no-index.c       |  3 +-
>  t/t4035-diff-quiet.sh | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 80 insertions(+), 2 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index f0b0010..b935d2a 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -273,5 +273,6 @@ void diff_no_index(struct rev_info *revs,
>  	 * The return code for --no-index imitates diff(1):
>  	 * 0 = no changes, 1 = changes, else error
>  	 */
> -	exit(revs->diffopt.found_changes);
> +	int result = diff_result_code(&revs->diffopt, 0);
> +	exit(result);
>  }

Decl-after-stmt.

> diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
> index cdb9202..33d8980 100755
> --- a/t/t4035-diff-quiet.sh
> +++ b/t/t4035-diff-quiet.sh
> @@ -10,7 +10,22 @@ test_expect_success 'setup' '
>  	git commit -m first &&
>  	echo 2 >b &&
>  	git add . &&
> -	git commit -a -m second
> +	git commit -a -m second &&
> +	mkdir -p test-outside/repo && (
> +		cd test-outside/repo &&
> +		git init &&
> +		echo "1 1" > a &&

Please drop extra SP between ">" and "a".

> +		git add . &&
> +		git commit -m 1
> +	) &&
> +	mkdir -p test-outside/no-repo && (
> +		cd test-outside/no-repo &&
> +		echo "1 1" >a &&
> +		echo "1 1" >matching-file &&
> +		echo "1 1 " >trailing-space &&
> +		echo "1   1" >extra-space &&
> +		echo "2" >never-match
> +	)

The inspiration of using CEILING comes from the existing t7810-grep
test, and I would have preferred if you used the same non/git for a
non-git repository for easier greppability ("git grep CEIL t/" to
notice the use of the technique and then "git grep non/git t/" to
verify, for example).

>  '
>  
>  test_expect_success 'git diff-tree HEAD^ HEAD' '
> @@ -77,4 +92,66 @@ test_expect_success 'git diff-index --cached HEAD' '
>  	}
>  '
>  
> +test_expect_success 'git diff, one file outside repo' '
> +	(
> +		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
> +		export GIT_CEILING_DIRECTORIES &&

Do you even need these two lines for this test?  your test runs
inside test-outside/repo that _is_ a git repository, and that
repository knows that ../no-repo is not part of it already.

> +		cd test-outside/repo &&
> +		test_expect_code 0 git diff --quiet a "$TRASH_DIRECTORY/test-outside/no-repo/matching-file" &&
> +		test_expect_code 1 git diff --quiet a "$TRASH_DIRECTORY/test-outside/no-repo/extra-space"
> +	)
> +'
> +
> +test_expect_success 'git diff, both files outside repo' '
> +	(
> +		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd test-outside/no-repo &&
> +		test_expect_code 0 git diff --quiet a matching-file &&
> +		test_expect_code 1 git diff --quiet a extra-space

This one does need the ceiling to prevent git from finding the trash
directory.

> +	)
> +'
> +
> +test_expect_success 'git diff --ignore-space-at-eol, one file outside repo' '
> +	(
> +		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
> +		export GIT_CEILING_DIRECTORIES &&

This one does not, I think (please correct me; I am not being very careful).

> +		cd test-outside/repo &&
> +		test_expect_code 0 git diff --quiet --ignore-space-at-eol a "$TRASH_DIRECTORY/test-outside/no-repo/trailing-space" &&
> +		test_expect_code 1 git diff --quiet --ignore-space-at-eol a "$TRASH_DIRECTORY/test-outside/no-repo/extra-space"
> +	)
> +'
> +
> +test_expect_success 'git diff --ignore-space-at-eol, both files outside repo' '
> +	(
> +		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd test-outside/no-repo &&
> +		test_expect_code 0 git diff --quiet --ignore-space-at-eol a trailing-space &&
> +		test_expect_code 1 git diff --quiet --ignore-space-at-eol a extra-space
> +	)
> +'
> +
> +test_expect_success 'git diff --ignore-all-space, one file outside repo' '
> +	(
> +		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
> +		export GIT_CEILING_DIRECTORIES &&

This one does not, I think (please correct me; I am not being very careful).

> +		cd test-outside/repo &&
> +		test_expect_code 0 git diff --quiet --ignore-all-space a "$TRASH_DIRECTORY/test-outside/no-repo/trailing-space" &&
> +		test_expect_code 0 git diff --quiet --ignore-all-space a "$TRASH_DIRECTORY/test-outside/no-repo/extra-space" &&
> +		test_expect_code 1 git diff --quiet --ignore-all-space a "$TRASH_DIRECTORY/test-outside/no-repo/never-match"
> +	)
> +'
> +
> +test_expect_success 'git diff --ignore-all-space, both files outside repo' '
> +	(
> +		GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd test-outside/no-repo &&
> +		test_expect_code 0 git diff --quiet --ignore-all-space a trailing-space &&
> +		test_expect_code 0 git diff --quiet --ignore-all-space a extra-space &&
> +		test_expect_code 1 git diff --quiet --ignore-all-space a never-match
> +	)
> +'
> +
>  test_done
