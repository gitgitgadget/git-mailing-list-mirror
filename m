From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 26/29] "guilt pop" now fails when there are no more
 patches to pop.
Date: Tue, 13 May 2014 18:23:04 -0400
Message-ID: <20140513222304.GO4791@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-27-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Wed May 14 00:23:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkL6E-0003M2-Mx
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 00:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbaEMWW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 18:22:59 -0400
Received: from josefsipek.net ([64.9.206.49]:1703 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753632AbaEMWW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 18:22:58 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 3238755654;
	Tue, 13 May 2014 18:22:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-27-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248873>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Tue, May 13, 2014 at 10:31:02PM +0200, Per Cederqvist wrote:
> This is analogous to how "guilt push" now fails when there are no more
> patches to push.  Like push, the "--all" argument still succeeds even
> if there was no need to pop anything.
> 
> Updated the test suite.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-pop            | 17 +++++++++++------
>  regression/t-021.out |  2 ++
>  regression/t-021.sh  |  6 ++++++
>  regression/t-061.sh  |  6 +++++-
>  4 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/guilt-pop b/guilt-pop
> index f0e647f..191313e 100755
> --- a/guilt-pop
> +++ b/guilt-pop
> @@ -49,9 +49,19 @@ fi
>  patch="$1"
>  [ ! -z "$all" ] && patch="-a"
>  
> +# Treat "guilt pop" as "guilt pop -n 1".
> +if [ -z "$patch" ]; then
> +	patch=1
> +	num=t
> +fi
> +
>  if [ ! -s "$applied" ]; then
>  	disp "No patches applied."
> -	exit 0
> +	if [ "$patch" = "-a" ]; then
> +		exit 0
> +	else
> +		exit 1
> +	fi
>  elif [ "$patch" = "-a" ]; then
>  	# we are supposed to pop all patches
>  
> @@ -68,11 +78,6 @@ elif [ ! -z "$num" ]; then
>  	# catch underflow
>  	[ $eidx -lt 0 ] && eidx=0
>  	[ $eidx -eq $sidx ] && die "No patches requested to be removed."
> -elif [ -z "$patch" ]; then
> -	# we are supposed to pop only the current patch on the stack
> -
> -	sidx=`wc -l < "$applied"`
> -	eidx=`expr $sidx - 1`
>  else
>  	# we're supposed to pop only up to a patch, make sure the patch is
>  	# in the series
> diff --git a/regression/t-021.out b/regression/t-021.out
> index 9b42d9c..58be12f 100644
> --- a/regression/t-021.out
> +++ b/regression/t-021.out
> @@ -287,6 +287,8 @@ index 0000000..8baef1b
>  +++ b/def
>  @@ -0,0 +1 @@
>  +abc
> +% guilt pop
> +No patches applied.
>  % guilt push --all
>  Applying patch..modify
>  Patch applied.
> diff --git a/regression/t-021.sh b/regression/t-021.sh
> index 614e870..e0d2dc1 100755
> --- a/regression/t-021.sh
> +++ b/regression/t-021.sh
> @@ -23,6 +23,12 @@ guilt series | _tac | while read n ; do
>  done
>  
>  #
> +# pop when there is nothing to pop
> +#
> +
> +shouldfail guilt pop
> +
> +#
>  # push all
>  #
>  cmd guilt push --all
> diff --git a/regression/t-061.sh b/regression/t-061.sh
> index 1411baa..6192f1b 100755
> --- a/regression/t-061.sh
> +++ b/regression/t-061.sh
> @@ -48,7 +48,11 @@ cmd list_files
>  
>  for i in `seq 5`
>  do
> -	cmd guilt pop
> +	if [ $i -ge 5 ]; then
> +		shouldfail guilt pop
> +	else
> +		cmd guilt pop
> +	fi
>  	cmd git for-each-ref
>  	cmd guilt push
>  	cmd git for-each-ref
> -- 
> 1.8.3.1
> 

-- 
Linux, n.:
  Generous programmers from around the world all join forces to help
  you shoot yourself in the foot for free. 
