From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git-blame shouldn't crash if run in an unmerged tree
Date: Thu, 18 Oct 2007 10:31:05 +0200
Message-ID: <20071018083105.GA21768@atjola.homenet>
References: <20071018063407.GA28861@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 10:31:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiQmq-0000AS-AI
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 10:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbXJRIbN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 04:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbXJRIbN
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 04:31:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:57902 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754861AbXJRIbL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 04:31:11 -0400
Received: (qmail invoked by alias); 18 Oct 2007 08:31:08 -0000
Received: from i577BAA3E.versanet.de (EHLO localhost) [87.123.170.62]
  by mail.gmx.net (mp049) with SMTP; 18 Oct 2007 10:31:08 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/nyaNnGzXneQDbUocBYR3SoYgteqSyOddZF9uPHR
	zxaG1WgxdwiGpZ
Content-Disposition: inline
In-Reply-To: <20071018063407.GA28861@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61504>

On 2007.10.18 02:34:07 -0400, Shawn O. Pearce wrote:
> I'm applying this patch to my maint tree tonight as it does resolve
> the issue for now.  What surprised me was the file that we were
> crashing out on wasn't even the file we wanted to get the blame
> data for.  :-\

The first merge moved some code from file1 (which doesn't exist in the
branch anymore) into file2, so I guess the code move detection comes
into play here.

Actually, in the original case that crashed here, I was curious about
some lines in file2 which looked like they had been automatically merge=
d
from file1, so I tried to use git blame with file2 to see if that reall=
y
happened (I didn't expect git to be even able to follow code moves whil=
e
merging). Unfortunately, I didn't get such a test case yet, which might
indicate that I've only imagined that merge, and thinking about it, I
think that file2 wasn't marked as modified in "git status". Hm, I'll tr=
y
to find that merge conflict again and try that again.

Bj=F6rn

>=20
> --8>--
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Subject: [PATCH] git-blame shouldn't crash if run in an unmerged tree
>=20
> If we are in the middle of resolving a merge conflict there may be
> one or more files whose entries in the index represent an unmerged
> state (index entries in the higher-order stages).
>=20
> Attempting to run git-blame on any file in such a working directory
> resulted in "fatal: internal error: ce_mode is 0" as we use the magic
> marker for an unmerged entry is 0 (set up by things like diff-lib.c's
> do_diff_cache() and builtin-read-tree.c's read_tree_unmerged())
> and the ce_match_stat_basic() function gets upset about this.
>=20
> I'm not entirely sure that the whole "ce_mode =3D 0" case is a good
> idea to begin with, and maybe the right thing to do is to remove
> that horrid freakish special case, but removing the internal error
> seems to be the simplest fix for now.
>=20
>                 Linus
>=20
> [sp: Thanks to Bj=F6rn Steinbrink for the test case]
>=20
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  read-cache.c     |    2 +
>  t/t8004-blame.sh |   73 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  2 files changed, 75 insertions(+), 0 deletions(-)
>  create mode 100755 t/t8004-blame.sh
>=20
> diff --git a/read-cache.c b/read-cache.c
> index 536f4d0..928e8fa 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -149,6 +149,8 @@ static int ce_match_stat_basic(struct cache_entry=
 *ce, struct stat *st)
>  		else if (ce_compare_gitlink(ce))
>  			changed |=3D DATA_CHANGED;
>  		return changed;
> +	case 0: /* Special case: unmerged file in index */
> +		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
>  	default:
>  		die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
>  	}
> diff --git a/t/t8004-blame.sh b/t/t8004-blame.sh
> new file mode 100755
> index 0000000..ba19ac1
> --- /dev/null
> +++ b/t/t8004-blame.sh
> @@ -0,0 +1,73 @@
> +#!/bin/sh
> +
> +# Based on a test case submitted by Bj=F6rn Steinbrink.
> +
> +test_description=3D'git blame on conflicted files'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup first case' '
> +	# Create the old file
> +	echo "Old line" > file1 &&
> +	git add file1 &&
> +	git commit --author "Old Line <ol@localhost>" -m file1.a &&
> +
> +	# Branch
> +	git checkout -b foo &&
> +
> +	# Do an ugly move and change
> +	git rm file1 &&
> +	echo "New line ..."  > file2 &&
> +	echo "... and more" >> file2 &&
> +	git add file2 &&
> +	git commit --author "U Gly <ug@localhost>" -m ugly &&
> +
> +	# Back to master and change something
> +	git checkout master &&
> +	echo "
> +
> +bla" >> file1 &&
> +	git commit --author "Old Line <ol@localhost>" -a -m file1.b &&
> +
> +	# Back to foo and merge master
> +	git checkout foo &&
> +	if git merge master; then
> +		echo needed conflict here
> +		exit 1
> +	else
> +		echo merge failed - resolving automatically
> +	fi &&
> +	echo "New line ...
> +... and more
> +
> +bla
> +Even more" > file2 &&
> +	git rm file1 &&
> +	git commit --author "M Result <mr@localhost>" -a -m merged &&
> +
> +	# Back to master and change file1 again
> +	git checkout master &&
> +	sed s/bla/foo/ <file1 >X &&
> +	rm file1 &&
> +	mv X file1 &&
> +	git commit --author "No Bla <nb@localhost>" -a -m replace &&
> +
> +	# Try to merge into foo again
> +	git checkout foo &&
> +	if git merge master; then
> +		echo needed conflict here
> +		exit 1
> +	else
> +		echo merge failed - test is setup
> +	fi
> +'
> +
> +test_expect_success \
> +	'blame runs on unconflicted file while other file has conflicts' '
> +	git blame file2
> +'
> +
> +test_expect_success 'blame runs on conflicted file in stages 1,3' '
> +	git blame file1
> +'
> +
> +test_done
