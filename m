From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Re: [TOY PATCH] filter-branch: add option --delete-unchanged
Date: Mon, 11 Aug 2008 12:43:06 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200808111243.06466.J.Wielemaker@uva.nl>
References: <1218153031-18443-1-git-send-email-trast@student.ethz.ch> <1218226224-25273-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 11 12:45:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSUtb-0003sK-Hx
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 12:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbYHKKoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 06:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbYHKKoB
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 06:44:01 -0400
Received: from korteweg.uva.nl ([146.50.98.70]:41864 "EHLO korteweg.uva.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbYHKKoA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 06:44:00 -0400
Received: from gollem.science.uva.nl ([146.50.26.20]) by korteweg.uva.nl with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 Aug 2008 12:43:58 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1218226224-25273-1-git-send-email-trast@student.ethz.ch>
Content-Disposition: inline
X-OriginalArrivalTime: 11 Aug 2008 10:43:58.0497 (UTC) FILETIME=[28EBC110:01C8FB9F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91930>

Hi Thomas,

On Friday 08 August 2008 10:10:24 pm Thomas Rast wrote:
> With --delete-unchanged, we nuke refs whose targets did not change
> during rewriting.  It is intended to be used along with
> --subdirectory-filter to clean out old refs from before the first
> commit to the filtered subdirectory.  (They would otherwise keep the
> old history alive.)
>
> Obviously this is a rather dangerous mode of operation.
>
> Note the "sort -u" is required: Without it, --all includes
> 'origin/master' twice (from 'origin/master' and via 'origin/HEAD'),
> and the second pass concludes it is unchanged and nukes the ref.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> This applies on top of "filter-branch: be more helpful when an
> annotated tag changes".
>
> I'm not really sure if this should go in, but it might have solved
> Jan's problem.

I may hope it isn't just `my problem' :-)  I tested with this patch,
and I can confirm the following produces precisily what I want:

git clone /home/git/pl.git/
cd pl
git remote rm origin
git filter-branch --subdirectory-filter packages/chr --tag-name-filter 
cat --delete-unchanged-refs -- --all
rm -r .git/refs/original
cd ..
git clone file://pl chr

chr is now a nice clean 2 MB repository, starting in 2004, the epoch of
this directory rather than 1992 (the overall project epoch). 

B.t.w. Pretending a remote clone was the only way to get a nice 2MB
repo.  The initial is 140MB.  After the filtering it is 62 MB.  Funny:
after a git gc it grows to 1.1 Gb!?

Anyway, thanks a lot and I hope this makes it into the next git release!

	Cheers --- Jan

>  git-filter-branch.sh |   33 +++++++++++++++++++++++----------
>  1 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index a140337..539b2e6 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -114,6 +114,7 @@ filter_tag_name=
>  filter_subdir=
>  orig_namespace=refs/original/
>  force=
> +delete_unchanged=
>  while :
>  do
>  	case "$1" in
> @@ -126,6 +127,11 @@ do
>  		force=t
>  		continue
>  		;;
> +	--delete-unchanged-refs)
> +		shift
> +		delete_unchanged=t
> +		continue
> +		;;
>  	-*)
>  		;;
>  	*)
> @@ -215,6 +221,7 @@ export GIT_DIR GIT_WORK_TREE
>
>  # The refs should be updated if their heads were rewritten
>  git rev-parse --no-flags --revs-only --symbolic-full-name --default HEAD
> "$@" | +sort -u |
>  sed -e '/^^/d' >"$tempdir"/heads
>
>  test -s "$tempdir"/heads ||
> @@ -344,7 +351,7 @@ do
>  	sha1=$(git rev-parse "$ref"^0)
>  	rewritten=$(map $sha1)
>
> -	test $sha1 = "$rewritten" &&
> +	test $sha1 = "$rewritten" -a -z "$delete_unchanged" &&
>  		warn "WARNING: Ref '$ref' is unchanged" &&
>  		continue
>
> @@ -355,16 +362,22 @@ do
>  			die "Could not delete $ref"
>  	;;
>  	$_x40)
> -		echo "Ref '$ref' was rewritten"
> -		if ! git update-ref -m "filter-branch: rewrite" \
> -					"$ref" $rewritten $sha1 2>/dev/null; then
> -			if test $(git cat-file -t "$ref") = tag; then
> -				if test -z "$filter_tag_name"; then
> -					warn "WARNING: You said to rewrite tagged commits, but not the
> corresponding tag." -					warn "WARNING: Perhaps use '--tag-name-filter
> cat' to rewrite the tag." +		if test "$delete_unchanged" -a $sha1 =
> "$rewritten"; then
> +			echo "Ref '$ref' was deleted because it is unchanged"
> +			git update-ref -m "filter-branch: delete" -d "$ref" $sha1 ||
> +				die "Could not delete $ref"
> +		else
> +			echo "Ref '$ref' was rewritten"
> +			if ! git update-ref -m "filter-branch: rewrite" \
> +			   "$ref" $rewritten $sha1 2>/dev/null; then
> +				if test $(git cat-file -t "$ref") = tag; then
> +					if test -z "$filter_tag_name"; then
> +						warn "WARNING: You said to rewrite tagged commits, but not the
> corresponding tag." +						warn "WARNING: Perhaps use '--tag-name-filter
> cat' to rewrite the tag." +					fi
> +				else
> +					die "Could not rewrite $ref"
>  				fi
> -			else
> -				die "Could not rewrite $ref"
>  			fi
>  		fi
>  	;;
