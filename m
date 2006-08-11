From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-sh-setup: Fail if the git directory was not found.
Date: Fri, 11 Aug 2006 15:39:11 -0700
Message-ID: <7vfyg2sxrk.fsf@assigned-by-dhcp.cox.net>
References: <44DC4C92.5060009@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 12 00:39:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBffT-00075m-V4
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 00:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWHKWjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 18:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWHKWjO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 18:39:14 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13747 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751230AbWHKWjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 18:39:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060811223912.FCLI6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Aug 2006 18:39:12 -0400
To: Robert Shearman <rob@codeweavers.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25242>

Robert Shearman <rob@codeweavers.com> writes:

> Always use git-rev-parse to find a valid git directory, as
> git-repo-config no longer returns an error code if a git directory
> wasn't found.
>
> This fixes the message received when invoking certain commands
> implemented as shell scripts from outside of a git tree, so
> e.g. instead of receiving this:
> /home/rob/bin/git-fetch: line 89: /FETCH_HEAD: Permission denied
> We get this again:
> fatal: Not a git repository: '.git'
>
> Also, move the setting of GIT_OBJECT_DIRECTORY to outside of the
> non-subdir-ok case as it isn't specific to that case.
>
> Signed-off-by: Robert Shearman <rob@codeweavers.com>

Moving the assignment of GIT_OBJECT_DIRECTORY is fine, but
changing it to an unconditional assignment is wrong.  The user
can have a GIT_OBJECT_DIRECTORY set independently from GIT_DIR
(or ../some/where/.git that is detected).

The rest looks sane; the new test should still detect the case the
original test tried to catch.

>  git-sh-setup.sh |   12 +++---------
>  1 files changed, 3 insertions(+), 9 deletions(-)
>
> Hopefully this patch addresses the concerns of Junio and others by
> continuing to allow git-ls-remotes to work outside of a git repository.
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index d15747f..49f9e3b 100755
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -37,15 +37,9 @@ esac
>  
>  if [ -z "$SUBDIRECTORY_OK" ]
>  then
> -	: ${GIT_DIR=.git}
> -	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
> -
> -	# Make sure we are in a valid repository of a vintage we understand.
> -	GIT_DIR="$GIT_DIR" git repo-config --get core.nosuch >/dev/null
> -	if test $? = 128
> -	then
> -	    exit
> -	fi
> +	GIT_DIR=$(GIT_DIR=.git git-rev-parse --git-dir) || exit
>  else
>  	GIT_DIR=$(git-rev-parse --git-dir) || exit
>  fi
> +
> +GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"
