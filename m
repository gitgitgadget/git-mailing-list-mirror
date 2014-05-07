From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 25/28] "guilt push" now fails when there are no more
 patches to push.
Date: Wed, 7 May 2014 18:04:27 -0400
Message-ID: <20140507220427.GD1459@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-26-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu May 08 00:04:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi9wy-0000NR-1A
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 00:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbaEGWEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 18:04:24 -0400
Received: from josefsipek.net ([64.9.206.49]:1618 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486AbaEGWEX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 18:04:23 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 5AF3F55654;
	Wed,  7 May 2014 18:04:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-26-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248384>

On Fri, Mar 21, 2014 at 08:32:03AM +0100, Per Cederqvist wrote:
> This makes it easier to script operations on the entire queue, for
> example run the test suite on each patch in the queue:
> 
>     guilt pop -a;while guilt push; do make test||break; done
> 
> This brings "guilt push" in line with the push operation in Mercurial
> Queues (hg qpush), which fails when there are no patches to apply.
> 
> Updated the test suite.
> 
> "guilt push -a" still does not fail.  (It successfully manages to
> ensure that all patches are pushed, even if it did not have to do
> anything to make it so.)
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-push           | 14 ++++-----
>  regression/t-020.out | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  regression/t-020.sh  | 13 +++++++-
>  3 files changed, 108 insertions(+), 8 deletions(-)
> 
> diff --git a/guilt-push b/guilt-push
> index 67687e7..2222350 100755
> --- a/guilt-push
> +++ b/guilt-push
> @@ -55,6 +55,7 @@ fi
>  
>  patch="$1"
>  [ ! -z "$all" ] && patch="-a"
> +[ -z "$patch" ] && { patch=1; num=t; }

I don't think there's any other place in the repo that does this.  Instead
you see a lot of if-then-fi.  To keep it consistent, I'd suggest:

if [ -z "$patch" ] ; then
	patch=1
	num=t
fi

Ah, this took me a while to figure out.  The above turns:

$ guilt push

into 

$ guilt push -n 1

I'd throw in a comment.

(Note to self, this file is a huge mess and could use a bit of cleanup.)

> @@ -78,11 +79,6 @@ elif [ ! -z "$num" ]; then
>  	# clamp to minimum
>  	[ $tidx -lt $eidx ] && eidx=$tidx
>  
> -elif [ -z "$patch" ]; then
> -	# we are supposed to push only the next patch onto the stack
> -
> -	eidx=`wc -l < "$applied"`
> -	eidx=`expr $eidx + 1`
>  else
>  	# we're supposed to push only up to a patch, make sure the patch is
>  	# in the series
> @@ -109,7 +105,11 @@ if [ "$sidx" -gt "$eidx" ]; then
>  	else
>  		disp "File series fully applied, ends at patch `get_series | tail -n 1`"
>  	fi
> -	exit 0
> +	if [ -n "$all" ]; then
> +		exit 0
> +	else
> +		exit 1
> +	fi

This changes the output on stdout.  E.g.,

$ guilt pu
$ guilt pu -n 1
File series fully applied, ends at patch crashdump

With this patch, both will print the message. Right?

>  fi
>  
>  get_series | sed -n -e "${sidx},${eidx}p" | while read p

Jeff.
