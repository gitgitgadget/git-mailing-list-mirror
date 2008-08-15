From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [TopGit PATCH] tg redepend: New command.
Date: Fri, 15 Aug 2008 13:20:01 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808151241300.17250@harper.uchicago.edu>
References: <1218808427.25300.2.camel@heerbeest>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Jan Holesovsky <kendy@suse.cz>
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Aug 15 20:21:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU3vC-0001nB-2y
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 20:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbYHOSUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 14:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755089AbYHOSUG
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 14:20:06 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:52537 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbYHOSUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 14:20:05 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7FIK1oG031122;
	Fri, 15 Aug 2008 13:20:01 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7FIK1NC018841;
	Fri, 15 Aug 2008 13:20:01 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <1218808427.25300.2.camel@heerbeest>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92502>

Hi,

Jan Nieuwenhuizen wrote:

> As discussed previously
> 
>     http://kerneltrap.org/mailarchive/git/2008/8/13/2925144
> 
> Change a topgit branch's dependencies by doing a rebase-by-merge.
> 
> Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>
> ---
>  Makefile       |    2 +-
>  README         |    5 ++
>  tg-redepend.sh |  154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+), 1 deletions(-)
>  create mode 100644 tg-redepend.sh

[...]
> +		-h|--help)
> +			echo "Usage: tg [--add|--remove] DEPENDENCY..." >&2

s/tg/tg redepend/?

[...]
> +# Create new base B' -- does not have to be a topgit branch, but that's easiest
> +if [ -z "$restarted" ]; then
> +	git branch -D $p_  > /dev/null 2>&1 || :
> +
> +	tg create $b_ $redeps

Why not move the base-creation code in tg-create.sh to a new
function in tg.sh to use here?

[...]
> +if [ "$restarted" != "merge" ]; then
> +	git checkout $(git rev-parse $p)
> +	if ! git merge --no-ff --no-commit $b_; then
> +		touch "$git_dir/top-merge"
> +		fail merge
> +	fi
[snip continuing-a-merge case]
> +fi
> +git read-tree -m -u $(git rev-parse $p_)
[snip topdeps juggling]
> +git commit -m "Rebased-using-merge onto new dependencies: $redeps."  > /dev/null 2>&1

I know I suggested that code before, but the merge with B' is wasted, so
perhaps

	git checkout P
	head=$(git rev-parse --verify HEAD^0)
	result_tree=$(git log -1 --pretty=format:%T P')
	result_commit=$(git commit-tree "$result_tree" -p P -p B')
	git update-ref -m "commit (merge): tg-redepend" HEAD \
			"$result_commit" "$head" || ... (fail)
	test -x "$GIT_DIR/hooks/post-merge" && $GIT_DIR/hooks/post-merge 0

I'm not sure.  Is there some more porcelain-ish way to do this (create a
merge commit when you already know the resulting and parents)?

But with that change the entire restarted=merge branch would go away,
so I hope there is a nice way to do it.  I'll think more.

Hope that helps,
Jonathan

> +
> +git branch -f $p
> +git checkout $p
> +
> +tg delete $b_  > /dev/null 2>&1
> +git branch -D $p_
> +
> +info "Rebased-using-merge onto new dependencies: $redeps."
> +
> +# Local Variables:
> +# sh-basic-offset:8
> +# End:
> 
