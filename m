From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [RFC/PATCH] merge: loosen overcautious "working file will be lost" check.
Date: Mon, 9 Oct 2006 10:20:52 -0700 (PDT)
Message-ID: <20061009172053.48882.qmail@web31804.mail.mud.yahoo.com>
References: <7v8xjqdoq1.fsf_-_@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 19:23:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWyoO-0005hI-29
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 19:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932988AbWJIRUz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 13:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932992AbWJIRUz
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 13:20:55 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:46696 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932988AbWJIRUy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 13:20:54 -0400
Received: (qmail 48886 invoked by uid 60001); 9 Oct 2006 17:20:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AytsZN1Rr0+ghHl5PLQg0swL/28ghg1Hvy5uMy7TBuMUQ/nWaGM7Dco4vz/PN5esv30d6Zt2fOBVv052eSjAW5pJcJloOj5nYho//u4U5ImmG+ActlV/056j20mmxAuJAmcIhsgMARhwOLHnsBhWAcdw6D6xOxk5/A5EgnapeMc=  ;
Received: from [71.80.233.118] by web31804.mail.mud.yahoo.com via HTTP; Mon, 09 Oct 2006 10:20:52 PDT
To: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v8xjqdoq1.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28574>

I think this is a good thing.

How about this case I've noticed in my trees:

After branching out, a file is deleted, only to add
a different file with the same file name.

Then any time I pull in from the trunk to merge,
merge fails with git-diff-files showing all 0's and the
file name in question.  Picture:

  Branch B       +-----------------M1---->
                /                 /
               C2 <-- git-add A  /
              /                 /
             C1 <-- git-rm A   /
            /                 /
Trunk -----+-----------------+---->

Since the common ancestor precedes git-rm, any Merge M1,
complains that file A needs resolving with git-show-files
all 0's.  I don't mind that so much and was wondering
what you thought about it.

    Luben

--- Junio C Hamano <junkio@cox.net> wrote:

> The three-way merge complained unconditionally when a path that
> does not exist in the index is involved in a merge when it
> existed in the working tree.  If we are merging an old version
> that had that path tracked, but the path is not tracked anymore,
> and if we are merging that old version in, the result will be
> that the path is not tracked.  In that case we should not
> complain.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
>  * Consolidated patch to summarize a few crapoids I sent out
>    tonight.
> 
>    The change to merge-one-file still does not do .gitignore
>    check but that is easy to add once we know this is the right
>    direction to go, which I am not sure yet.  If we can convince
>    ourselves that this is the right direction we should update
>    merge-recursive as well.
> 
>  git-merge-one-file.sh       |   16 ++++++++++++-
>  t/t1004-read-tree-m-u-wf.sh |   53 +++++++++++++++++++++++++++++++++++++++++++
>  unpack-trees.c              |    2 -
>  3 files changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> index fba4b0c..74ad4f2 100755
> --- a/git-merge-one-file.sh
> +++ b/git-merge-one-file.sh
> @@ -23,6 +23,12 @@ #
>  "$1.." | "$1.$1" | "$1$1.")
>  	if [ "$2" ]; then
>  		echo "Removing $4"
> +	else
> +		# read-tree checked that index matches HEAD already,
> +		# so we know we do not have this path tracked.
> +		# there may be an unrelated working tree file here,
> +		# which we should just leave unmolested.
> +		exit 0
>  	fi
>  	if test -f "$4"; then
>  		rm -f -- "$4" &&
> @@ -34,8 +40,16 @@ #
>  #
>  # Added in one.
>  #
> -".$2." | "..$3" )
> +".$2.")
> +	# the other side did not add and we added so there is nothing
> +	# to be done.
> +	;;
> +"..$3")
>  	echo "Adding $4"
> +	test -f "$4" || {
> +		echo "ERROR: untracked $4 is overwritten by the merge."
> +		exit 1
> +	}
>  	git-update-index --add --cacheinfo "$6$7" "$2$3" "$4" &&
>  		exec git-checkout-index -u -f -- "$4"
>  	;;
> diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
> new file mode 100755
> index 0000000..018fbea
> --- /dev/null
> +++ b/t/t1004-read-tree-m-u-wf.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +
> +test_description='read-tree -m -u checks working tree files'
> +
> +. ./test-lib.sh
> +
> +# two-tree test
> +
> +test_expect_success 'two-way setup' '
> +
> +	echo >file1 file one &&
> +	echo >file2 file two &&
> +	git update-index --add file1 file2 &&
> +	git commit -m initial &&
> +
> +	git branch side &&
> +	git tag -f branch-point &&
> +
> +	echo file2 is not tracked on the master anymore &&
> +	rm -f file2 &&
> +	git update-index --remove file2 &&
> +	git commit -a -m "master removes file2"
> +'
> +
> +test_expect_success 'two-way not clobbering' '
> +
> +	echo >file2 master creates untracked file2 &&
> +	if err=`git read-tree -m -u master side 2>&1`
> +	then
> +		echo should have complained
> +		false
> +	else
> +		echo "happy to see $err"
> +	fi
> +'
> +
> +# three-tree test
> +
> +test_expect_success 'three-way not complaining' '
> +
> +	rm -f file2 &&
> +	git checkout side &&
> +	echo >file3 file three &&
> +	git update-index --add file3 &&
> +	git commit -a -m "side adds file3" &&
> +
> +	git checkout master &&
> +	echo >file2 file two is untracked on the master side &&
> +
> +	git-read-tree -m -u branch-point master side
> +'
> +
> +test_done
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3ac0289..b1d78b8 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -661,8 +661,6 @@ int threeway_merge(struct cache_entry **
>  	if (index) {
>  		verify_uptodate(index, o);
>  	}
> -	else if (path)
> -		verify_absent(path, "overwritten", o);
>  
>  	o->nontrivial_merge = 1;
>  
> -- 
> 1.4.2.3.g2c59
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
