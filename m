From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH 4/4] Use guards information and functions
Date: Mon, 30 Jul 2007 00:15:49 -0400
Message-ID: <20070730041549.GF22017@filer.fsl.cs.sunysb.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu> <1185695418227-git-send-email-eclesh@ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 06:16:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFMfr-0002Xq-OB
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 06:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbXG3EQB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 00:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXG3EQB
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 00:16:01 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:46252 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbXG3EQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 00:16:00 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6U4Fnvd027043;
	Mon, 30 Jul 2007 00:15:49 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6U4FnwL027041;
	Mon, 30 Jul 2007 00:15:49 -0400
Content-Disposition: inline
In-Reply-To: <1185695418227-git-send-email-eclesh@ucla.edu>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54184>

On Sun, Jul 29, 2007 at 12:50:18AM -0700, Eric Lesh wrote:
> Make guilt-push respect guards. Also teach guilt-header, guilt-next,
> and guilt-unapplied to grok patches that are skipped because of
> guards.
> 
> Signed-off-by: Eric Lesh <eclesh@ucla.edu>
> ---
>  guilt-header    |    7 ++++---
>  guilt-next      |    2 +-
>  guilt-push      |    8 ++++----
>  guilt-unapplied |    2 +-
>  4 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/guilt-header b/guilt-header
> index d07e2be..ef7f55e 100755
> --- a/guilt-header
> +++ b/guilt-header
> @@ -15,15 +15,16 @@ patch="$1"
>  if [ -z "$patch" ]; then
>  	# use the patch that's on the top of the stack
>  
> -	eidx=`wc -l < $applied`
> -	if [ $eidx -eq 0 ]; then
> +	patch=`get_top`
> +	if [ -z "$patch" ]; then
>  		die "Status file is empty"
>  	fi
> +	eidx=`get_series | grep -ne "^$patch\$" | cut -d: -f1`
>  else
>  	# use the specified patch
>  
>  	eidx=`get_series | grep -ne "^$patch\$" | cut -d: -f1`
> -	if [ $eidx -eq 0 ]; then
> +	if [ -z "$eidx" ]; then
>  		die "Patch $patch is not in the series"
>  	fi
>  fi
> diff --git a/guilt-next b/guilt-next
> index f38f1cc..38f57fa 100755
> --- a/guilt-next
> +++ b/guilt-next
> @@ -13,5 +13,5 @@ fi
>  n=`wc -l < $applied`
>  n=$(($n + 1))
>  
> -get_series | awk "{ if (NR == $n) print \$0}"
> +get_guarded_series | awk "{ if (NR == $n) print \$0}"

Seeing this almost makes me thing that get_series should give you the
guarded series unless you poke it the right way...something like:

get_series --full

or

get_full_series


The guarded series is what most commands care about, right?

> diff --git a/guilt-push b/guilt-push
> index ad3616b..ce928e3 100755
> --- a/guilt-push
> +++ b/guilt-push
> @@ -24,7 +24,7 @@ if [ "$patch" = "--all" ] || [ "$patch" = "-a" ]; then
>  	# we are supposed to push all patches, get the last one out of
>  	# series
>  
> -	eidx=`get_series | wc -l`
> +	eidx=`get_guarded_series | wc -l`
>  	if [ $eidx -eq 0 ]; then
>  		die "There are no patches to push"
>  	fi
> @@ -37,9 +37,9 @@ else
>  	# we're supposed to push only up to a patch, make sure the patch is
>  	# in the series
>  
> -	eidx=`get_series | grep -ne "^$patch\$" | cut -d: -f1`
> +	eidx=`get_guarded_series | grep -ne "^$patch\$" | cut -d: -f1`
>  	if [ -z "$eidx" ]; then
> -		die "Patch $patch is not in the series"
> +		die "Patch $patch is not in the series or is guarded"
>  	fi
>  fi
>  
> @@ -52,7 +52,7 @@ fi
>  sidx=`wc -l < $applied`
>  sidx=`expr $sidx + 1`
>  
> -get_series | sed -n -e "${sidx},${eidx}p" | while read p
> +get_guarded_series | sed -n -e "${sidx},${eidx}p" | while read p
>  do
>  	echo "Applying patch..$p"
>  	if [ ! -f "$GUILT_DIR/$branch/$p" ]; then
> diff --git a/guilt-unapplied b/guilt-unapplied
> index 192a7e5..6904360 100755
> --- a/guilt-unapplied
> +++ b/guilt-unapplied
> @@ -13,4 +13,4 @@ fi
>  n=`wc -l < $applied`
>  n=`expr $n + 1`
>  
> -get_series | sed -n -e "$n,\$p"
> +get_guarded_series | sed -n -e "$n,\$p"
> -- 
> 1.5.2

-- 
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are, by
definition, not smart enough to debug it.
		- Brian W. Kernighan 
