From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHv3] git-fetch: Split fetch and merge logic
Date: Fri, 23 Feb 2007 01:53:49 -0800
Message-ID: <7vabz56vyq.fsf@assigned-by-dhcp.cox.net>
References: <87wt29i7hg.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 23 10:54:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKX8A-00054q-8E
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 10:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbXBWJxw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Feb 2007 04:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbXBWJxw
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 04:53:52 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36765 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbXBWJxv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Feb 2007 04:53:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223095351.VQIC2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Feb 2007 04:53:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Sxtq1W0011kojtg0000000; Fri, 23 Feb 2007 04:53:51 -0500
In-Reply-To: <87wt29i7hg.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 23
	Feb 2007 09:49:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40434>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> It makes git-parse-remote.sh and almost all git-fetch independent
> of the merge logic.
>
> git-fetch fetches the branches from the remote and saves this
> information in .git/FETCH_FETCHED, and at the end it generates
> the file .git/FETCH_HEAD.

I might have some more comments after actually applying this and
reviewing it with wider contexts, but it looks nice overall.

I am wondering if FETCH_FETCHED is purely for internal use by
git-fetch (it appears so), and if so if it is worth trying to do
without the temporary file, but that is a minor detail.

>  git-fetch.sh        |   79 +++++++++++++++++++++++++++++++----------=
----------
>  git-parse-remote.sh |   64 ++++++++++++-----------------------------
>  t/t5510-fetch.sh    |   16 ++++++++++
>  3 files changed, 83 insertions(+), 76 deletions(-)

Loses more lines than it adds (+16 lines to test does not
count), which is a very good sign.

> diff --git a/git-fetch.sh b/git-fetch.sh
> index d230995..637d732 100755
> --- a/git-fetch.sh
> +++ b/git-fetch.sh
> @@ -491,3 +467,44 @@ case "$orig_head" in
>  	fi
>  	;;
>  esac
> +
> +# Generate $GIT_DIR/FETCH_HEAD
> +case ",$#,$remote_nick," in
> +,1,$origin,)
> +	curr_branch=3D$(git-symbolic-ref -q HEAD | sed -e 's|^refs/heads/||=
')
> +	merge_branches=3D$(git-repo-config \
> +		--get-all "branch.${curr_branch}.merge" | sort -u)

Why "sort -u" (instead of erroring out if the repository is
misconfigured)?

> +	fetch_branches=3D$(get_remote_default_refs_for_fetch -n $remote_nic=
k |
> +		sed 's/:.*$//g;s/^+//' | sort -u)

GNU sed users do not have problems with this, but I recall that
we had to rewrite our sed scripts not to use multiple commands
concatenated with ';' for portability, like:

	sed -e 's/:.*$//g' -e 's/^+//'

Again why "sort -u"?

> +	test "$merge_branches" && test "$fetch_branches" &&

We probably would want to be defensive by saying "test -n".

> +	merge_branches=3D$(echo -e "$merge_branches\n$fetch_branches" | sor=
t | uniq -d)

I appreciate the cleverness of the intersection.  However, is
"echo -e" portable?  I think we have avoided it so far (we have
avoided even "echo -n" which is traditionally much more
available).

> +cat "$GIT_DIR"/FETCH_FETCHED | while IFS=3D'	' read sha1 ref note ; =
do
> +	remote_branch=3D$(expr "z$ref" : 'z\([^:]*\):')
> +	for merge_branch in $merge_branches ; do
> +		[ "$merge_branch" =3D=3D "$remote_branch" ] &&
> +			echo "$sha1		$note" && continue 2
> +	done
> +	if ! test "$merge_first" || test "$merge_first" =3D=3D "done" ; the=
n
> +		echo "$sha1	not-for-merge	$note"
> +	else
> +		echo "$sha1		$note"
> +		merge_first=3Ddone
> +	fi
> +done >> "$GIT_DIR/FETCH_HEAD"

You can do:

	while ...
        do
        done < "$GIT_DIR/FETCH_FETCHED"

which is easier on the eye. =20

I often see a buggy shell script that expects assignment in a
while loop to survive after the loop finished, when the loop is
on the downstream side of a pipe (e.g. the loop is run in a
subshell so merge_first after this loop is finished will never
be 'done').  You do not use the variable after the loop so your
script is not buggy, but avoiding a pipe into while loop is a
good habit to get into.

> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 5208ee6..691d46c 100755
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -196,32 +159,43 @@ canon_refs_list_for_fetch () {

>  	config)
> -		canon_refs_list_for_fetch -d "$1" \
> -			$(git-config --get-all "remote.$1.fetch") ;;
> +		set $(expand_refs_wildcard "$1" \
> +			$(git-repo-config --get-all "remote.$1.fetch")) ;;

Oops?  It is not buggy but it's better to set an example by
using git-config consistenty.  You have another mention of
repo-config above.

>  	remotes)
> -		canon_refs_list_for_fetch -d "$1" $(sed -ne '/^Pull: */{
> +		set $(expand_refs_wildcard "$1" $(sed -ne '/^Pull: */{
>  						s///p
> -					}' "$GIT_DIR/remotes/$1")
> +					}' "$GIT_DIR/remotes/$1"))

Hmph.  I wonder why the original author did not do '/^Pull: */s///p'...
