From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH 2/2] tg-import.sh: A dump quilt queue importer
Date: Sat, 9 Aug 2008 02:57:36 +0200
Message-ID: <20080809005736.GR10151@machine.or.cz>
References: <1218219588-6849-1-git-send-email-bert.wesarg@googlemail.com> <1218219588-6849-2-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 02:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRcn3-0001iy-H3
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 02:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbYHIA5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 20:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752330AbYHIA5j
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 20:57:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57913 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235AbYHIA5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 20:57:38 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 130BF393B32C; Sat,  9 Aug 2008 02:57:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218219588-6849-2-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91734>

On Fri, Aug 08, 2008 at 08:19:48PM +0200, Bert Wesarg wrote:
> A simple, non smart, quilt importer.
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> 
> ---
>  .gitignore   |    2 +
>  Makefile     |    3 +-
>  README       |   15 ++++++++
>  tg-import.sh |  115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 134 insertions(+), 1 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 6f0727f..5f1831b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -3,6 +3,8 @@ tg-create
>  tg-create.txt
>  tg-delete
>  tg-delete.txt
> +tg-import
> +tg-import.txt
>  tg-info
>  tg-info.txt
>  tg-patch
> diff --git a/Makefile b/Makefile
> index dba5f20..671beab 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -6,7 +6,8 @@ sharedir = $(PREFIX)/share/topgit
>  hooksdir = $(cmddir)/hooks
>  
>  
> -commands_in = tg-create.sh tg-delete.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh
> +commands_in = tg-create.sh tg-delete.sh tg-info.sh tg-patch.sh tg-summary.sh \
> +              tg-update.sh tg-import.sh
>  hooks_in = hooks/pre-commit.sh
>  
>  commands_out = $(patsubst %.sh,%,$(commands_in))
> diff --git a/README b/README
> index dc0045f..3fc6d18 100644
> --- a/README
> +++ b/README
> @@ -275,6 +275,21 @@ tg update
>  
>  	TODO: tg update -a for updating all topic branches
>  
> +tg import
> +~~~~~~~~~
> +	Import a quilt queue into TopGit. First argument is the series
> +	file from quilt. Second is the prefix for the topic names
> +	(i.e. "t/"). All remaining arguments are the dependencies for
> +	the first patch in the series.

Sensible usage, but I'm not happy with making tg import quilt-only;
what if we will say want to import to topgit from existing branches,
or from StGIT or something else? The command name is good, but maybe
I'd add a required --quilt switch. After all, this is not a command you
run three times a day by hand.

> + Use '-s' if you want to strip
> +	common patch suffixes from the patch file name (like .diff and
> +	.patch).

When *wouldn't* we want to do this? Doesn't it make sense to make this
the default?

> diff --git a/tg-import.sh b/tg-import.sh
> new file mode 100644
> index 0000000..f9403b9
> --- /dev/null
> +++ b/tg-import.sh

I think the functionality is good to have, but you are also reinventing
the wheel here. Git can already import quilt series by git-quiltimport.
So what about a more general approach?

* Build tg-import so that it primarily just imports given set of
  existing commits.
* Then, StGIT and Quilt importers are trivial extensions?

> +		# strip suffixes
> +		name="$patch"
> +		[ -n "$strip_suffixes" ] && {
> +			name="${name%.patch}"
> +			name="${name%.diff}"
> +		}

I think in these cases, it's better style to use plain if.

> +		# apply patch
> +		# be stupid, hard coded -p1
> +		# currently no support for compressed patch files
> +		patch -p1 -d "$root_dir" < "$patchfile"
> +
> +		# extract header from patch file and feed it into .topmsg
> +		# TODO: extract mail headers
> +		cat "$patchfile" |
> +			patch_header |
> +			strip_diffstat |
> +			make_topmsg "$name" > "$root_dir/.topmsg"
> +		# overwrite .topmsg from tg create in index
> +		git add "$root_dir/.topmsg"
> +
> +		# add all modified files from patch to index
> +		# (and prepending it with $root_dir)
> +		# be stupid, hard coded -p1 --strip=1
> +		lsdiff --strip=1 "$patchfile" |
> +			sed -e "s/^/$root_dir_esc\//" |
> +			xargs git add

lsdiff? I don't have this tool. And this won't work with file removals
properly anyway.

I guess git add -u is too new for us, so you might opt for this snippet
I've used in git-filter-branch:

	(
		git diff-index -r --name-only HEAD
		git ls-files --others
	) |
	git update-index --add --replace --remove --stdin

Or even better, use git apply?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
