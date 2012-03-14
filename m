From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT] [PATCH] Fix fatal "guilt graph" error in sha1sum
 invocation.
Date: Wed, 14 Mar 2012 10:21:48 -0400
Message-ID: <20120314142144.GB12588@poseidon.cudanet.local>
References: <87399bpaq9.fsf@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ceder@lysator.liu.se
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 15:22:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7p5R-0004Xt-KF
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 15:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062Ab2CNOVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 10:21:52 -0400
Received: from josefsipek.net ([64.9.206.49]:43621 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988Ab2CNOVv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 10:21:51 -0400
Received: from poseidon.cudanet.local (unknown [12.200.95.45])
	by josefsipek.net (Postfix) with ESMTPSA id 56605641B;
	Wed, 14 Mar 2012 10:21:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87399bpaq9.fsf@opera.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193111>

On Wed, Mar 14, 2012 at 02:34:38PM +0100, Per Cederqvist wrote:
> Fix the compatibility function sha1 so that it reads from
> stdin (and not a file with a zero-length file name) when
> no argument is supplied.

I just ran into this yesterday.  I stupidly changed the caller of sha1 to
pass in - for the filename.  That worked for me since I ended up using the
sha1sum implementations; openssl is not happy about that.  So, your patch
looks good.

Now, I should actually figure out how to get the git repo out there again.

Thanks,

Jeff.

> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  os.Darwin |    7 ++++++-
>  os.Linux  |    7 ++++++-
>  os.SunOS  |    7 ++++++-
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> Note: I have tested both versions of the sha1 function, but only on
> Linux as I don't have access to a Mac.
> 
>     /ceder
> 
> diff --git a/os.Darwin b/os.Darwin
> index 470f5fb..acf6b68 100644
> --- a/os.Darwin
> +++ b/os.Darwin
> @@ -27,7 +27,12 @@ head_n()
>  # usage: sha1 [file]
>  sha1()
>  {
> -	openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
> +	if [ $# = 1 ]
> +	then
> +		openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
> +	else
> +		openssl dgst -sha1 | sed 's,$,  -,'
> +	fi
>  }
>  
>  # usage: cp_a <src> <dst>
> diff --git a/os.Linux b/os.Linux
> index 30b9cb0..aaebf88 100644
> --- a/os.Linux
> +++ b/os.Linux
> @@ -30,7 +30,12 @@ head_n()
>  # usage: sha1 [file]
>  sha1()
>  {
> -	sha1sum "$1"
> +	if [ $# = 1 ]
> +	then
> +		sha1sum "$1"
> +	else
> +		sha1sum
> +	fi
>  }
>  
>  # usage: cp_a <src> <dst>
> diff --git a/os.SunOS b/os.SunOS
> index 30b9cb0..aaebf88 100644
> --- a/os.SunOS
> +++ b/os.SunOS
> @@ -30,7 +30,12 @@ head_n()
>  # usage: sha1 [file]
>  sha1()
>  {
> -	sha1sum "$1"
> +	if [ $# = 1 ]
> +	then
> +		sha1sum "$1"
> +	else
> +		sha1sum
> +	fi
>  }
>  
>  # usage: cp_a <src> <dst>
> -- 
> 1.7.9
> 

-- 
Only two things are infinite, the universe and human stupidity, and I'm not
sure about the former.
		- Albert Einstein
