From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Add test for filter-branch on a subdirectory that's been added and deleted and re-added
Date: Sat, 8 Mar 2008 15:39:53 -0500
Message-ID: <E6873C4A-ACCC-4E51-B32E-41F1AAA56339@sb.org>
References: <1204977007-7267-3-git-send-email-kevin@sb.org> <7vzlt9t5wr.fsf@gitster.siamese.dyndns.org> <91DF7A2E-540B-4AD6-91B2-BDB0B04EFC71@sb.org> <7vejalt12h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 21:40:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY5qM-0005fz-WF
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 21:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbYCHUjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 15:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbYCHUjz
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 15:39:55 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:37706 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750919AbYCHUjz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 15:39:55 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id 525EF109E8B;
	Sat,  8 Mar 2008 12:39:54 -0800 (PST)
In-Reply-To: <7vejalt12h.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76581>

On Mar 8, 2008, at 3:25 PM, Junio C Hamano wrote:

> This will hopefully be the final version.

Assuming that the lack of a GIT_INDEX_FILE doesn't break git-checkout- 
index, git-diff-index, git-update-index, or anything that an --index- 
filter might run (I assume it doesn't, but I didn't test all the  
relevant commands), then this looks fine by me.

-Kevin

>
> -- >8 --
> filter-branch: handle "disappearing tree" case correctly in subdir  
> filter
>
> The subdirectory filter had a bug to notice that the commit in  
> question
> did not have anything in the path-limited part of the tree.  $commit: 
> $path
> does not name an empty tree when $path does not appear in $commit.
>
> This should fix it.  The additional test in t7003 is originally from  
> Kevin
> Ballard but with fixups.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> * -f is needed because the previous one is about aborting the filter  
> and
>    leaving the "original" namespace.
>
> git-filter-branch.sh     |   11 ++++++++++-
> t/t7003-filter-branch.sh |   24 ++++++++++++++++++++++++
> 2 files changed, 34 insertions(+), 1 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 49e13f0..010353a 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -252,7 +252,16 @@ while read commit parents; do
> 		git read-tree -i -m $commit
> 		;;
> 	*)
> -		git read-tree -i -m $commit:"$filter_subdir"
> +		# The commit may not have the subdirectory at all
> +		err=$(git read-tree -i -m $commit:"$filter_subdir" 2>&1) || {
> +			if ! git rev-parse --verify $commit:"$filter_subdir" 2>/dev/null
> +			then
> +				rm -f "$GIT_INDEX_FILE"
> +			else
> +				echo >&2 "$err"
> +				false
> +			fi
> +		}
> 	esac || die "Could not initialize the index"
>
> 	GIT_COMMIT=$commit
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 868babc..6e14bf1 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -179,4 +179,28 @@ test_expect_success 'Name needing quotes' '
>
> '
>
> +test_expect_success 'Subdirectory filter with disappearing trees' '
> +	git reset --hard &&
> +	git checkout master &&
> +
> +	mkdir foo &&
> +	touch foo/bar &&
> +	git add foo &&
> +	test_tick &&
> +	git commit -m "Adding foo" &&
> +
> +	git rm -r foo &&
> +	test_tick &&
> +	git commit -m "Removing foo" &&
> +
> +	mkdir foo &&
> +	touch foo/bar &&
> +	git add foo &&
> +	test_tick &&
> +	git commit -m "Re-adding foo" &&
> +
> +	git filter-branch -f --subdirectory-filter foo &&
> +	test $(git rev-list master | wc -l) = 3
> +'
> +
> test_done
>

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com


