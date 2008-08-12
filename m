From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] topgit: Implement tg-import
Date: Tue, 12 Aug 2008 19:31:50 +0200
Message-ID: <20080812173150.GM32184@machine.or.cz>
References: <1218558943-14398-1-git-send-email-aneesh.kumar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: aneesh.kumar@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 12 19:33:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSxjs-0006Ig-Hl
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 19:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbYHLRby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 13:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbYHLRbx
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 13:31:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58443 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbYHLRbx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 13:31:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3714C393A816; Tue, 12 Aug 2008 19:31:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218558943-14398-1-git-send-email-aneesh.kumar@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92118>

  Hi,

On Tue, Aug 12, 2008 at 10:05:43PM +0530, aneesh.kumar@gmail.com wrote:
> From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
> 
> This can be used to import a set of commits
> between range specified by range1..range2
> This should help us to convert an already
> existing quilt, stgit branches to topgit
> managed one
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

  thanks, unfortunately this script still needs work.

> ---
>  tg-import.sh |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 97 insertions(+), 0 deletions(-)
>  create mode 100644 tg-import.sh

  There seems to be no documentation.

> diff --git a/tg-import.sh b/tg-import.sh
> new file mode 100644
> index 0000000..0158f3b
> --- /dev/null
> +++ b/tg-import.sh
> @@ -0,0 +1,97 @@
> +#!/bin/bash
> +#derived out of git-format-patch.sh

  I feel this is a wrong approach - it should be derived from some of
the tg scripts instead. Please use the common header and options
parsing infrastructure. Also, please adjust your script to be non-bash
specific.

> +function die()
> +{
> +	echo >&2 "$@"
> +	exit 1
> +}

  We already have this function.

> +function tg_get_commit_msg
> +{
> +	commit=$1

  Please quote variables use; this also applies to the rest of the
script.

> +commitScript='

  Indentation?

> +	1,/^$/d
> +	: loop
> +	/^$/b loop
> +	: body
> +	p
> +	n
> +	b body'
> +	author=$(git cat-file commit "$commit" | grep author |
> +		cut -d ">" -f 1 | sed -ne "s/author//gp")
> +	echo "From: "$author">"
> +	git cat-file commit "$commit" | sed -ne "$commitScript"
> +}

  Wouldn't it be much more convenient to just use

	git log -1 --pretty=format:"From: %an <%ae>%nSubject: %s%n%n%b"

> +function tg_get_patch
> +{
> +	git show $1
> +}
> +
> +function tg_get_branch_name
> +{
> +
> +titleScript='
> +	1,/^$/d
> +	: loop
> +	/^$/b loop
> +	s/[^-a-z.A-Z_0-9]/-/g
> +        s/\.\.\.*/\./g
> +	s/\.*$//
> +	s/--*/-/g
> +	s/^-//
> +	s/-$//
> +	q
> +'

You should document the origin of this snippet.

> +	commit=$1
> +	title=$(git cat-file commit "$commit" | sed -e "$titleScript")
> +	echo ${title}
> +}
> +
> +tmp=.tmp-series$$

Please use mktemp.

Do you actually need the tmp file at all?

> +trap 'rm -f $tmp-*' 0 1 2 3 15
> +
> +series=$tmp-series
> +# Now we have what we want in $@

We didn't before?

> +for revpair
> +do
> +	case "$revpair" in
> +	?*..?*)
> +		rev1=`expr "z$revpair" : 'z\(.*\)\.\.'`
> +		rev2=`expr "z$revpair" : 'z.*\.\.\(.*\)'`
> +		;;
> +	*)
> +		echo >&2 "Unknow range spec $revpair"
> +		exit

die?

> +		;;
> +	esac
> +	git rev-parse --verify "$rev1^0" >/dev/null 2>&1 ||
> +		die "Not a valid rev $rev1 ($revpair)"
> +	git rev-parse --verify "$rev2^0" >/dev/null 2>&1 ||
> +		die "Not a valid rev $rev2 ($revpair)"
> +	git cherry -v "$rev1" "$rev2" |
> +	while read sign rev comment
> +	do
> +		case "$sign" in
> +		'-')
> +			echo >&2 "Merged already: $comment"

info?

> +			;;
> +		*)
> +			echo $rev

Does it make sense to print it all out now?

> +			;;
> +		esac
> +	done
> +done >$series

Why do we need all the rev-parses? Is the git cherry checking really
useful?

This flattens the commit structure, which is another problem; the commit
relationships should rather be described in the .topdeps files. Using
git log --parents should give us that information?

> +while read commit
> +do

Why do you actually loop twice?

> +	branch_name=$(tg_get_branch_name $commit)
> +	echo "Importing $commit to $branch_name"
> +	tg create tp/$branch_name

Make this configurable?

> +	tg_get_commit_msg $commit > .topmsg
> +	git add .topmsg
> +	git commit -a -m "Add the commit message for the topic branch"
> +	tg_get_patch $commit | patch -p1

Also, I don't think reimplementing git rebase here is good idea at all.
I would just imagine the script to do something like

	git rev-list ^HEAD lastcommit | while read commit; do
		tg create tp/$branch_name
		git read-tree $commit
		git add .top*
		git commit -C $commit
	done

So allow only to import commits that are _on top_ of the same commit the
topic branches system is going to be based on.

> +	git commit -a -m "Import the initial patch to the topic branch"

Why two commits?

> +done < $series

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
