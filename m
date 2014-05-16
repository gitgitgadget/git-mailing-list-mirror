From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v3 09/31] Test suite: properly check the exit status of
 commands.
Date: Fri, 16 May 2014 11:45:13 -0400
Message-ID: <20140516154513.GI1770@meili.valhalla.31bits.net>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
 <1400251578-17221-10-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri May 16 17:45:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlKJt-0003wB-Mt
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 17:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbaEPPpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 11:45:07 -0400
Received: from josefsipek.net ([64.9.206.49]:1655 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373AbaEPPpG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 11:45:06 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 8F9FC55654;
	Fri, 16 May 2014 11:45:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400251578-17221-10-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249353>

On Fri, May 16, 2014 at 04:45:56PM +0200, Per Cederqvist wrote:
> The "cmd" and "shouldfail" functions checked the exit status of the
> replace_path function instead of the actual command that was running.
> (The $? construct checks the exit status of the last command in a
> pipeline, not the first command.)
> 
> Updated t-032.sh, which used "shouldfail" instead of "cmd" in one
> place.  (The comment in the script makes it clear that the command is
> expected to succeed.)
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/scaffold | 17 +++++++++++------
>  regression/t-032.sh |  2 +-
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/regression/scaffold b/regression/scaffold
> index 5c8b73e..e4d7487 100644
> --- a/regression/scaffold
> +++ b/regression/scaffold
> @@ -51,18 +51,23 @@ function filter_dd
>  function cmd
>  {
>  	echo "% $@"
> -	"$@" 2>&1 | replace_path && return 0
> -	return 1
> +	(
> +		exec 3>&1
> +		rv=`(("$@" 2>&1; echo $? >&4) | replace_path >&3 ) 4>&1`

Wow.  This took a while to decipher :)

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>


> +		exit $rv
> +	)
> +	return $?
>  }
>  
>  # usage: shouldfail <cmd>..
>  function shouldfail
>  {
>  	echo "% $@"
> -	(
> -		"$@" 2>&1 || return 0
> -		return 1
> -	) | replace_path
> +	! (
> +		exec 3>&1
> +		rv=`(("$@" 2>&1; echo $? >&4) | replace_path >&3 ) 4>&1`
> +		exit $rv
> +	)
>  	return $?
>  }
>  
> diff --git a/regression/t-032.sh b/regression/t-032.sh
> index b1d5f19..bba401e 100755
> --- a/regression/t-032.sh
> +++ b/regression/t-032.sh
> @@ -28,7 +28,7 @@ shouldfail guilt import -P foo3 foo
>  cmd guilt import -P foo2 foo
>  
>  # ok
> -shouldfail guilt import foo
> +cmd guilt import foo
>  
>  # duplicate patch name (implicit)
>  shouldfail guilt import foo
> -- 
> 1.8.3.1
> 

-- 
Fact: 28.1% of all statistics are generated randomly.
