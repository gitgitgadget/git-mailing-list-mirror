From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 18:23:19 -0700
Message-ID: <7v1wh4ped4.fsf@assigned-by-dhcp.cox.net>
References: <8c5c35580705251501u6346c27by1d133efc3d157bf2@mail.gmail.com>
	<11801386283399-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 03:23:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrl0L-0006Zd-19
	for gcvg-git@gmane.org; Sat, 26 May 2007 03:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbXEZBXV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 21:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbXEZBXV
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 21:23:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61882 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbXEZBXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 21:23:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070526012321.UPMY22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 25 May 2007 21:23:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3dPL1X0011kojtg0000000; Fri, 25 May 2007 21:23:20 -0400
In-Reply-To: <11801386283399-git-send-email-hjemli@gmail.com> (Lars Hjemli's
	message of "Sat, 26 May 2007 02:17:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48441>

Lars Hjemli <hjemli@gmail.com> writes:

> With this entry in .gitmodules (and a commit reference in the index entry for
> the path "git"), the command 'git submodule init' will clone the repository
> at kernel.org into the directory "git".
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>
> On 5/26/07, Lars Hjemli <hjemli@gmail.com> wrote:
>> I'll redo the patch, removing the branch-specific things, and try to
>> shut up :)

Hey, don't shut up.  Starting small and covering corner cases
incrementally is really the right approach.

> +status::
> +	Show the status of the submodules. This will print the sha1 of the
> +	currently checked out commit for each submodule, along with the
> +	submodule path and the output of gitlink:git-describe[1] for the
> +	sha1. Each sha1 will be prefixed with '-' if the submodule is not
> +	initialized and '+' if the currently checked out submodule commit
> +	does not match the sha1 found in the index of the containing
> +	repository. This command is the default command for git-submodule.

(markup) probably you would want `` there for typewriter face.

(wording) didn't we have "the name of the hash function is
SHA-1" patch earlier?  I'd personally prefer calling them
"object names", though...

Other than that, the command description is very nicely done,
which means the design of the command set hence the semantics is
cleanly done.  Good job.

> diff --git a/git-submodule.sh b/git-submodule.sh
> new file mode 100755
> index 0000000..247b1ee
> --- /dev/null
> +++ b/git-submodule.sh
> @@ -0,0 +1,172 @@
> ...
> +#
> +# print stuff on stdout unless -q was specified
> +#
> +say()
> +{
> +	if test -z "$quiet"
> +	then
> +		echo -e "$@"
> +	fi
> +}

We tend to avoid "echo -e" (not POSIX).  I do not see any string
you feed to this function that you would _want_ backslash
escaped sequences (actually I would suspect you would not want
them).

> +
> +#
> +# Run clone + checkout on missing submodules
> +#
> +# $@ = requested paths (default to all)
> +#
> +modules_init()
> +{
> +	git ls-files --stage -- $@ | grep -e '^160000 ' |

Did you mean "$@", i.e. inside double-quotes?

Because this pattern would appear a lot in superproject support,
it might be a good idea to give a new option, --subprojects, to
git-ls-files to limit its output to 160000 entries, but that is
a minor detail.

> +	while read mode sha1 stage path
> +	do

We would need to undo the shell-safety "quoted" output of paths
here.  I suspect it would be much easier to code this in Perl or
Python, do the "grep -e" part above in the script, when we start
caring about unwrapping c-quoting of path (or "ls-files -z").

But that is a minor detail we could fix up later.

> +		test -d "$path/.git" && continue
> +
> +		if test -d "$path"
> +		then
> +			rmdir "$path" 2>/dev/null ||
> +			die "Directory '$path' exist, but not as a submodule"
> +		fi

Could the currently checked-out $path be a symlink to another
directory, and what does the code do in such a case?

> +
> +		test -e "$path" &&
> +		die "A file already exist at path '$path'"

"test -e" is a relatively new invention and I tended to stay
away from it, but it should be safe to use these days...

> +		url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)
> +		test -z "$url" &&
> +		die "No url found for submodule '$path' in .gitmodules"
> +
> +		git-clone "$url" "$path" ||
> +		die "Clone of submodule '$path' failed"

"git-clone -n" please, as you will checkout something different
in the next step anyway.

> +
> +		$(unset GIT_DIR && cd "$path" && git-checkout -q "$sha1") ||
> +		die "Checkout of submodule '$path' failed"

Lose $() around this, as it is not producing a string which is
the name of the command to run.  You do want a subshell here
because of chdir, so instead of losing $(), replace them with
().

> ...
> +modules_update()
> +{
>...
> +		if test "$subsha1" != "$sha1"
> +		then
> +			$(unset GIT_DIR && cd "$path" && git-fetch &&
> +				git-checkout -q "$sha1") ||
> +			die "Unable to checkout '$sha1' in submodule '$path'"

Likewise.
