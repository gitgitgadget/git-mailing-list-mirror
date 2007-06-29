From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone: fetch possibly detached HEAD over dumb http
Date: Thu, 28 Jun 2007 17:02:18 -0700
Message-ID: <7vsl8bmxv9.fsf@assigned-by-dhcp.pobox.com>
References: <20070628105208.GA11105@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Louis-Noel Pouchet <louis-noel.pouchet@inria.fr>
To: Sven Verdoolaege <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Fri Jun 29 02:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I43wO-0001My-NI
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 02:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764705AbXF2ACV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 20:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763647AbXF2ACU
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 20:02:20 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:59927 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759461AbXF2ACU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 20:02:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629000219.IOWZ1257.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Jun 2007 20:02:19 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HC2K1X0091kojtg0000000; Thu, 28 Jun 2007 20:02:19 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51140>

Sven Verdoolaege <skimo@liacs.nl> writes:

> git-clone supports cloning from a repo with detached HEAD,
> but if this HEAD is not behind any branch tip then it
> would not have been fetched over dumb http, resulting in a
>
> 	fatal: Not a valid object name HEAD
>
> Since 928c210a, this would also happen on a http repo
> with a HEAD that is a symbolic link where someone has
> forgotton to run update-server-info.
>
> Signed-off-by: Sven Verdoolaege <skimo@liacs.nl>

Ok.  But I think the change regresses when the remote side is
actually on a particular branch, and is using symref to
represent $GIT_DIR/HEAD.

>  git-clone.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-clone.sh b/git-clone.sh
> index bd44ce1..cdbbc20 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -70,7 +70,8 @@ Perhaps git-update-server-info needs to be run there?"
>  		git-http-fetch $v -a -w "$tname" "$sha1" "$1" || exit 1
>  	done <"$clone_tmp/refs"
>  	rm -fr "$clone_tmp"
> -	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
> +	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" &&
> +	git-http-fetch $v -a $(cat "$GIT_DIR/REMOTE_HEAD") "$1" ||
>  	rm -f "$GIT_DIR/REMOTE_HEAD"
>  }

At this point, "$GIT_DIR/REMOTE_HEAD" is a copy of HEAD obtained
from the remote site via curl.  It can contain:

 (1) raw SHA-1 of the tip commit, if the HEAD is detached, or
     the repository uses a symlink to represent HEAD, or

 (2) "ref: refs/heads/$currentbranch".

You would want to do this extra fetch only in case (1).
I think the additional fetch would fail in case (2), and result
in removal of $GIT_DIR/REMOTE_HEAD.

Hmm?
