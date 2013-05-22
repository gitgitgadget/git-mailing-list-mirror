From: Per Cederqvist <cederp@opera.com>
Subject: Re: [PATCH -v2] guilt: force the use of bare branches
Date: Wed, 22 May 2013 14:39:31 +0200
Message-ID: <519CBC83.3090705@opera.com>
References: <20130522032946.GA101217@meili.valhalla.31bits.net> <1369224677-16404-1-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jeffpc@josefsipek.net, git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed May 22 14:44:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf8PX-0007Na-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 14:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab3EVMow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 08:44:52 -0400
Received: from smtp.opera.com ([213.236.208.81]:38979 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873Ab3EVMov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 08:44:51 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2013 08:44:50 EDT
Received: from [10.30.2.116] (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r4MCdW2q011815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 May 2013 12:39:33 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <1369224677-16404-1-git-send-email-tytso@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225151>

On 05/22/13 14:11, Theodore Ts'o wrote:
> To make it harder to accidentally do "git push" with a guilt patch
> applied, "guilt push" changes branch from e.g. "master" to
> "guilt/master" starting with commit 67d3af63f422.  This is a feature
> which I use for ext4 development; I actually *do* want to be able to
> push patches to the dev branch, which is a rewindable branch much like
> git's "pu" branch.
>
> Allow the use of the environment variable GUILT_FORCE_BARE_BRANCH
> which disables the new behavior introduced by commit 67d3af63f422.
>
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Per Cederqvist <cederp@opera.com>

I just posted an alternative patch that solves the same issue.
I forgot to add in-reply-to headers, and did change the subject
to "Added guilt.reusebranch configuration option". Sorry if I've
caused any confusion.

     /ceder

> ---
>   guilt | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/guilt b/guilt
> index e9b2aab..35a84dc 100755
> --- a/guilt
> +++ b/guilt
> @@ -914,13 +914,22 @@ else
>   	die "Unsupported operating system: $UNAME_S"
>   fi
>
> -if [ "$branch" = "$raw_git_branch" ] && [ -n "`get_top 2>/dev/null`" ]
> -then
> -    # This is for compat with old repositories that still have a
> -    # pushed patch without the new-style branch prefix.
> +if [ -n "`get_top 2>/dev/null`" ]; then
> +  #
> +  # If we have repositories patches pushed, then use whatever scheme
> +  # is currently in use
> +  #
> +  if [ "$branch" = "$raw_git_branch" ]; then
>       old_style_prefix=true
> +  else
> +    old_style_prefix=false
> +  fi
>   else
> +  if [ "$(git config --bool --get guilt.bareBranch)" = "true" ]; then
> +    old_style_prefix=true
> +  else
>       old_style_prefix=false
> +  fi
>   fi
>
>   _main "$@"
>
