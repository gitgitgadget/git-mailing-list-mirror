From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v4 09/33] Test suite: properly check the exit status of
 commands.
Date: Thu, 22 Jan 2015 09:27:46 -0500
Message-ID: <20150122142746.GD101460@meili.jeffnet.31bits.net>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
 <1400450409-30998-10-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 15:28:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEIjs-0006Wj-AN
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 15:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbbAVO1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 09:27:51 -0500
Received: from josefsipek.net ([71.174.113.7]:1686 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbbAVO1t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 09:27:49 -0500
Received: from meili.jeffnet.31bits.net (unknown [172.31.0.119])
	by josefsipek.net (Postfix) with ESMTPSA id EE47C5567A;
	Thu, 22 Jan 2015 09:27:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1400450409-30998-10-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262836>

On Sun, May 18, 2014 at 11:59:45PM +0200, Per Cederqvist wrote:
> The "cmd" and "shouldfail" functions checked the exit status of the
> replace_path function instead of the actual command that was running.
> (The $? construct checks the exit status of the last command in a
> pipeline, not the first command.)
> 
> Print an explicit error message if a command that should fail actually
> succeeds.

This is a god idea.

The patch still looks good.

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>


> Updated t-032.sh, which used "shouldfail" instead of "cmd" in one
> place.  (The comment in the script makes it clear that the command is
> expected to succeed.)
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/scaffold | 23 ++++++++++++++++-------
>  regression/t-032.sh |  2 +-
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/regression/scaffold b/regression/scaffold
> index 5c8b73e..2e04c83 100644
> --- a/regression/scaffold
> +++ b/regression/scaffold
> @@ -51,19 +51,28 @@ function filter_dd
>  function cmd
>  {
>  	echo "% $@"
> -	"$@" 2>&1 | replace_path && return 0
> -	return 1
> +	if ! (
> +		exec 3>&1
> +		rv=`(("$@" 2>&1; echo $? >&4) | replace_path >&3 ) 4>&1`
> +		exit $rv
> +	) ; then
> +		echo "% FAIL: The above command should succeed but failed."
> +		exit 1
> +	fi
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
> -	return $?
> +	if (
> +		exec 3>&1
> +		rv=`(("$@" 2>&1; echo $? >&4) | replace_path >&3 ) 4>&1`
> +		exit $rv
> +	) ; then
> +		echo "% FAIL: The above command should fail but succeeded."
> +		exit 1
> +	fi
>  }
>  
>  # usage: list_files
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
Intellectuals solve problems; geniuses prevent them
		- Albert Einstein
