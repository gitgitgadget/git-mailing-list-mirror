From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] filter-branch: Add more error-handling
Date: Wed, 11 Feb 2009 11:03:44 -0800
Message-ID: <7vhc30eqy7.fsf@gitster.siamese.dyndns.org>
References: <1234361365-63711-1-git-send-email-git@randomhacks.net>
 <1234372518-6924-1-git-send-email-git@randomhacks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Kidd <git@randomhacks.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:06:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKPE-0006MC-NL
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758142AbZBKTDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758089AbZBKTDw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:03:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758015AbZBKTDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:03:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F7559839A;
	Wed, 11 Feb 2009 14:03:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EAC7698394; Wed,
 11 Feb 2009 14:03:45 -0500 (EST)
In-Reply-To: <1234372518-6924-1-git-send-email-git@randomhacks.net> (Eric
 Kidd's message of "Wed, 11 Feb 2009 12:15:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B7225C88-F86E-11DD-88F4-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109504>

Eric Kidd <git@randomhacks.net> writes:

> In commit 9273b56278e64dd47b1a96a705ddf46aeaf6afe3, I fixed an error
> ...
> Thank you to charon on #git for pointing me in the right direction.

The commit message is not a reception speech at Emmy Awards.  If you want
to do the speech, do so after the three-dash lines.

Please just stick to what problem it tries to solve, how it does so, and
what the outcome is.  

> This patch causes 'git filter-branch' to fail if the --commit-filter
> argument returns an error.  A test case for this behavior is included.

That's a very good start for the description of the solution, which would
be for the second paragraph.  The problem description is missing.

> Feedback on the original version of this patch was provided by Johannes
> Sixt and Johannes Schindelin.

Giving credits to others like this with a short sentence at the end is
fine.

> v2:
>   Remove useless $ret variable
>   Correctly check the first command in a pipeline, not the second
>   Replace verbose 'die' messages with 'exit 1' in most cases

This goes after three-dashes; people who read "git log" output wouldn't
know nor care what was in v1.

    Subject: Fix X under condition Z

    X should do Y if condition Z holds, but it does not.  This can result
    in broken results such as W and V.

    This patch fixes X by changing A, B and C.

    Thanks for M, N and O for reviewing and suggesting improvements.

    Signed-off-by: A U Thor <au.thor@example.xz>

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 86eef56..fff07c8 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -221,7 +221,7 @@ die ""
>  trap 'cd ../..; rm -rf "$tempdir"' 0
>  
>  # Make sure refs/original is empty
> -git for-each-ref > "$tempdir"/backup-refs
> +git for-each-ref > "$tempdir"/backup-refs || exit 1

Why "exit 1", not "exit"?

> @@ -241,8 +241,9 @@ GIT_WORK_TREE=.
>  export GIT_DIR GIT_WORK_TREE
>  
>  # The refs should be updated if their heads were rewritten
> -git rev-parse --no-flags --revs-only --symbolic-full-name --default HEAD "$@" |
> -sed -e '/^^/d' >"$tempdir"/heads
> +git rev-parse --no-flags --revs-only --symbolic-full-name \
> +	--default HEAD "$@" > "$tempdir"/raw-heads || exit 1

Likewise.

> @@ -315,10 +314,11 @@ while read commit parents; do
>  			die "tree filter failed: $filter_tree"
>  
>  		(
> -			git diff-index -r --name-only $commit
> +			git diff-index -r --name-only $commit &&
>  			git ls-files --others
> -		) |
> -		git update-index --add --replace --remove --stdin
> +		) > "$tempdir"/tree-state || exit 1
> +		git update-index --add --replace --remove --stdin \
> +			< "$tempdir"/tree-state || exit 1

Likewise.

> @@ -339,7 +339,8 @@ while read commit parents; do
>  		eval "$filter_msg" > ../message ||
>  			die "msg filter failed: $filter_msg"
>  	@SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
> -		$(git write-tree) $parentstr < ../message > ../map/$commit
> +		$(git write-tree) $parentstr < ../message > ../map/$commit ||
> +			die "could not write rewritten commit"

Hmm, wouldn't commit-tree have issued its own error message already?  If
redirect failed, then the shell would have.

> @@ -407,7 +408,8 @@ do
>  			die "Could not rewrite $ref"
>  	;;
>  	esac
> -	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1
> +	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1 ||
> +		 exit 1

Why "exit 1", not "exit"?

> @@ -483,7 +485,7 @@ test -z "$ORIG_GIT_INDEX_FILE" || {
>  }
>  
>  if [ "$(is_bare_repository)" = false ]; then
> -	git read-tree -u -m HEAD
> +	git read-tree -u -m HEAD || exit 1

Likewise

> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index cb04743..39affd9 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -48,6 +48,10 @@ test_expect_success 'result is really identical' '
>  	test $H = $(git rev-parse HEAD)
>  '
>  
> +test_expect_success 'Fail if commit filter fails' '
> +	! git filter-branch -f --commit-filter "exit 1" HEAD
> +'
> +

"test_must_fail git ..." would be better here than "! git ...".
