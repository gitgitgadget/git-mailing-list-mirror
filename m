From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive.
Date: Sun, 18 Feb 2007 17:49:08 -0800
Message-ID: <7vlkiudii3.fsf@assigned-by-dhcp.cox.net>
References: <1171838852534-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 02:49:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIxeT-0005Xx-VQ
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 02:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbXBSBtK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 20:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbXBSBtK
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 20:49:10 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:61855 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbXBSBtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 20:49:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219014909.KBOV22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Feb 2007 20:49:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RDp81W00U1kojtg0000000; Sun, 18 Feb 2007 20:49:09 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40090>

Mark Levedahl <mdl123@verizon.net> writes:

> Some workflows require use of repositories on machines that cannot be
> connected, preventing use of git-fetch / git-push to transport objects
> and references between the repositories.

Looks much nicer.  Thanks.

>  6 files changed, 338 insertions(+), 4 deletions(-)
>  mode change 100755 => 100644 Documentation/cmd-list.perl

Hmmmm?

> +verify() {
> +    # Check bundle version
> +    test -f "$bfile" || die "cannot find $bfile"
> +    test "$($TAR -xf ""$bfile"" -O version)" = "v1 git-bundle" ||
> +        die "$bfile doesn't look like a v1 bundle file."

It makes me feel uneasy to see these double quotes next to each
other.  Are you sure you got your quoting right (I haven't
checked)?

Just a minor style issue: traditional single command letter to
tar is easier to read if you do not write leading '-'.  IOW,
"tar xf" is preferred over "tar -xf".

> +	# do fast check, then if any prereqs are missing then go line by line
> +	# to be verbose about the errors
> +    prereqs=$($TAR xf "$bfile" -O prerequisites)
> +	test -z "$prereqs" && return 0
> +	bad=$(echo "$prereqs" | cut -b-40 | git-rev-list --stdin --not --all 2>&1)
> +    if test -n "$bad" ; then
> +		test "$1" = "--silent" && return 1
> +        echo "error: $bfile requires the following commits you lack:"
> +		echo "$prereqs" |
> +		while read sha1 comment ; do
> +            missing=$(git-rev-list $sha1 --not --all 2>&1)
> +            test -n "$missing" && echo "$sha1 $comment"
> +		done
> +        exit 1
> +    fi

This part is very hard to read.  Maybe your tabstop is not set
to 8?

Linus rightly said "or something like that"; I do not think the
empty output from "git-rev-list --stdin --not --all" is enough.

Here, you are making sure that each line of $prereqs are names
of objects available in your repository, and well connected to
your existing refs.  If one of the commits listed in $prereqs
does not exist in your repository, I think rev-list exits with
non-zero status, with a message to stderr, without spitting out
anything to its stdout, so you would need:

	if bad=$(echo ... | rev-list ...) && test -z "$bad"
        then
        	: happy
	else
        	echo 2>&1 "error: you lack these..."
	fi

Incidentally, I think you do not have to squelch error message
from rev-list here.

Other than that, I think Linus's check is correct and the above
fills his "something like that" [*1*].


> +list_heads() {
> +	if test -z "$*" ; then
> +		$TAR -xf "$bfile" -O references 2>/dev/null || exit 1
> +	else
> +		($TAR -xf "$bfile" -O references 2>/dev/null || exit 1) |
> +		while read sha1 ref ; do
> +			for arg in $* ; do
> +				if test "${ref%$arg}" != "$ref" ; then
> +					echo "$sha1 $ref"
> +					break
> +				fi
> +			done
> +		done
> +	fi
> +}

I suspect that "exit 1" in the upstream of pipe does not have
any effect on the outcome -- yup, I just tried...

	$ (tar xf no-such-file -O references || exit 1) |
	  while read foo; do echo $foo; done ; echo $?
        0
	$

> +test -z "$action" && die "No action given, what should I do?"
> +
> +# what tar to use, prefer gtar, then tar.
> +if test -z "$TAR" ; then
> +    GTAR=$(which gtar 2>/dev/null)
> +    TAR=${GTAR:-tar}
> +fi

"which" is Ok for interactive use, but never use it in scripts.
I've seen "which foo" that says "No foo found." to its standard
output without erroring out (I think it was older Solaris).

+unbundle)
+    verify --silent || exit 1
+    $TAR -xf "$bfile" -O pack | git-index-pack --stdin ||
+        die "error: $bfile has a corrupted pack file"
+    list_heads $args;;
+esac

Hmm.  Your verify () shell function silently fails if prereq is
not met, so this makes the user of "git --unbundle file.bdl"
would get silent failure and left wondering why the bundle does
not unpack, doesn't it?

> diff --git a/git-fetch.sh b/git-fetch.sh
> index ca984e7..42cc62f 100755
> --- a/git-fetch.sh
> +++ b/git-fetch.sh
> @@ -377,8 +377,15 @@ fetch_main () {

Nice.

> diff --git a/git-ls-remote.sh b/git-ls-remote.sh
> index 8ea5c5e..28bb9b8 100755
> --- a/git-ls-remote.sh
> +++ b/git-ls-remote.sh
> @@ -89,8 +89,13 @@ rsync://* )

Likewise.


[footnote]

*1* If somebody wants to know why it works...

Suppose the "global" history looked like this:

	---A---B---C

and your receiving repository earlier had its tip of the branch
at commit A.  Then the user used git-http-fetch to fetch from a
repository that had its tip at commit B.  http-fetch (another
"commit walker", local-fetch, works the same way) learns that
the tip commit is B, downloads commit B, reads what's in there
to learn the tree associated with commit B, fetches that tree,
reads what's in there to learn the subtrees and blobs in it, ...

The user can interrupt this process, at the point after commit B
and everything that is needed to complete it was downloaded, but
before it actually updated the ref to point at B.

Suppose then you created a bundle with B..C to update the tip to
C, requiring you to have B.  "echo B | rev-list --not --all"
would happily say "Oh, B is a commit that is not reachable from
any of your refs", but in fact you can safely update the ref
that currently point at A (because the user interrupted the
earlier fetch) with C after checking C is a fast forward of A.
This might make "outputs empty" look like a wrong check.

However, the user could have interrupted the earlier http-fetch,
at the point after commit B was downloaded but before finishing
to download the tree associated with it.  A commit walker does
not update the ref, so the commit object B will be in your
receiving repository but it is not complete (it lacks its tree
object).  Even in this case "echo B | rev-list --not --all"
would say "B is ahead of your repository".  That's why "outputs
empty" is a good check.

Before somebody wonders further.  An alternative good check is
to see if "echo B | rev-list --objects --not --all" does _not_
fail, and all of the objects listed in its output are available
in the receiving repository.  This will solve the apparent
inefficiency in the case of killing http-fetch after it
downloaded all the necessary objects before it updated the ref,
which I described earlier.  But I think that the window for that
to happen is very small and if you killed a commit walker it is
much more likely that you lack some objects, so doing this
alternative check is optimizing for a wrong case.
