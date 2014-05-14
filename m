From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 28/29] Added guilt.reusebranch configuration option.
Date: Wed, 14 May 2014 11:53:24 -0400
Message-ID: <20140514155324.GE1582@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-29-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Wed May 14 17:53:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkbUi-0000d2-9z
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 17:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbaENPxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 11:53:20 -0400
Received: from josefsipek.net ([64.9.206.49]:1644 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbaENPxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 11:53:19 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id C993255654;
	Wed, 14 May 2014 11:53:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-29-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248923>

On Tue, May 13, 2014 at 10:31:04PM +0200, Per Cederqvist wrote:
> When the option is true (the default), Guilt does not create a new Git
> branch when patches are applied.  This way, you can switch between
> Guilt 0.35 and the current version of Guilt with no issues.
> 
> At a future time, maybe a year after Guilt with guilt.reusebranch
> support is released, the default should be changed to "false" to take
> advantage of the ability to use a separate Git branch when patches are
> applied.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt                |  28 +++-
>  regression/scaffold  |   1 +
>  regression/t-062.out | 441 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  regression/t-062.sh  | 137 ++++++++++++++++
>  4 files changed, 601 insertions(+), 6 deletions(-)
>  create mode 100644 regression/t-062.out
>  create mode 100755 regression/t-062.sh
...
> diff --git a/guilt b/guilt
> index 9947acc..7c830eb 100755
> --- a/guilt
> +++ b/guilt
...
> @@ -928,13 +935,22 @@ else
>  	die "Unsupported operating system: $UNAME_S"
>  fi
>  
> -if [ "$branch" = "$raw_git_branch" ] && [ -n "`get_top 2>/dev/null`" ]
> -then
> -    # This is for compat with old repositories that still have a
> -    # pushed patch without the new-style branch prefix.
> -    old_style_prefix=true
> +if [ -n "`get_top 2>/dev/null`" ]; then
> +	# If there is at least one pushed patch, we set
> +	# old_style_prefix according to how it was pushed.  It is only
> +	# possible to change the prefix style while no patches are
> +	# applied.
> +	if [ "$branch" = "$raw_git_branch" ]; then
> +		old_style_prefix=true
> +	else
> +		old_style_prefix=false
> +	fi
>  else
> -    old_style_prefix=false
> +	if $reuse_branch; then
> +		old_style_prefix=true
> +	else
> +		old_style_prefix=false
> +	fi

I don't know if this is a good idea or not, but:

	old_style_prefix="$reuse_branch"

>  fi
>  
>  _main "$@"
> diff --git a/regression/scaffold b/regression/scaffold
> index e4d7487..e4d2f35 100644
> --- a/regression/scaffold
> +++ b/regression/scaffold
> @@ -93,6 +93,7 @@ function setup_git_repo
>  	git config log.date default
>  	git config log.decorate no
>  	git config guilt.diffstat false
> +	git config guilt.reusebranch false
>  }
>  
>  function setup_guilt_repo
...
> diff --git a/regression/t-062.sh b/regression/t-062.sh
> new file mode 100755
> index 0000000..85596ca
> --- /dev/null
> +++ b/regression/t-062.sh
> @@ -0,0 +1,137 @@
...
> +function fixup_time_info
> +{
> +	touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
> +}
> +
> +cmd setup_repo
> +
> +cmd git config guilt.reusebranch true
> +
> +cmd guilt push -a
> +cmd list_files
> +cmd git for-each-ref
> +
> +cmd git for-each-ref
> +
> +cmd list_files

duplicate list_files & for-each-ref

> +
> +for i in `seq 5`; do
> +	if [ $i -ge 5 ]; then
> +		shouldfail guilt pop
> +	else
> +		cmd guilt pop
> +	fi
> +	cmd git for-each-ref
> +	cmd guilt push
> +	cmd git for-each-ref
> +	cmd guilt pop
> +	cmd git for-each-ref
> +done
> +
> +# Check that "pop -a" does the right thing.

What exactly is the right thing?  no-op since the above loop poped
everything?  (I'd make the comment say what the "right thing" is.)

Jeff.

-- 
In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like
that.
		- Linus Torvalds
