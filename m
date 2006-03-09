From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] clone: add refs/remotes/* to Pull: targets when cloning
Date: Thu, 09 Mar 2006 10:23:19 -0800
Message-ID: <7vfylr5vfs.fsf@assigned-by-dhcp.cox.net>
References: <20060309115452.GA13369@localdomain>
	<20060309115535.GB13369@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 19:24:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHPnO-0002DB-Sg
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 19:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWCISX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 13:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWCISX0
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 13:23:26 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43212 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750744AbWCISXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 13:23:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309181935.ZBNX17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 13:19:35 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060309115535.GB13369@localdomain> (Eric Wong's message of
	"Thu, 9 Mar 2006 03:55:35 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17431>

Eric Wong <normalperson@yhbt.net> writes:

> diff --git a/git-clone.sh b/git-clone.sh
> index 4ed861d..a8ab7fd 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -249,6 +249,12 @@ Pull: $head_points_at:$origin" &&
>  			test "$origin" = "$head" ||
>  			echo "Pull: ${head}:${head}"
>  		done >>"$GIT_DIR/remotes/origin"
> +		(test -d "$GIT_DIR"/refs/remotes && cd "$GIT_DIR" &&
> +		 find "refs/remotes" -type f -print | sed -e 's|^refs/||') |
> +		while read ref
> +		do
> +			echo "Pull: $ref:$ref"
> +		done >>"$GIT_DIR/remotes/origin"
>  	esac

I am not sure I agree with what you are doing here.  I thought
the idea behind refs/remotes is to migrate away from copying all
the remote heads into refs/heads (so that Linus does not need to
see my "next" and "pu" under his refs/heads), and putting
foreign SCM tracking branches used by SVN and CVS importers in
there instead of in refs/heads naturally falls out from that
pattern.

Now I do not propose to change the current clone that
contaminates the local branch namespace by copying remote
refs/heads into local refs/heads in the middle of v1.3.0
development without laying out a transition plan, but I think
that is a sensible future direction.  Instead of copying
everything from refs/heads to refs/heads, we only copy what
remote HEAD points at to refs/heads/master to initialize the
local clone, and copy everything from refs/heads to
refs/remotes, _and_ set up Pull: lines to do the same tracking.
The part of the code you are touching corresponds to the last
part.

We would probably be better off not doing this right now.  When
we are sure everybody thinks it is a better approach to use
refs/remotes for remote branch tracking, we would need to change
the part you did not change (I think the clone-pack part is the
hardest to change since it has a built-in "copy refs to matching
locations" logic) alongside with the part you touched with this
patch to make things consistent.  At that time also you would
need to remove several lines above the part you touched so that
we do not use local refs/heads/* for tracking.

How does that sound?
