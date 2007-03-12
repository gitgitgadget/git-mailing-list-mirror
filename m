From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH,RFC] Add git-mergetool to run an appropriate merge conflict resolution program
Date: Sun, 11 Mar 2007 23:47:22 -0700
Message-ID: <7vodmzt0ud.fsf@assigned-by-dhcp.cox.net>
References: <E1HQdaX-00025N-3s@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 12 07:47:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQeJl-0001BJ-KZ
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 07:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbXCLGrY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 02:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbXCLGrY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 02:47:24 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50565 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965187AbXCLGrX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 02:47:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070312064723.TTCQ28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 12 Mar 2007 02:47:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZinN1W00M1kojtg0000000; Mon, 12 Mar 2007 02:47:22 -0400
In-Reply-To: <E1HQdaX-00025N-3s@candygram.thunk.org> (Theodore Ts'o's message
	of "Mon, 12 Mar 2007 02:00:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42011>

"Theodore Ts'o" <tytso@mit.edu> writes:

> OK, here's my second attempt at a git-mergetool subcommand.
>
> Major differences from last time, besides addressing the comments made
> by Junio, is that the git-mergetool now handles various scnearios where
> the conflicts are caused by files changing to/from symlinks, and where
> the symlink was changed to two different destinations in the local and
> remote branches.

Thanks.  By the way, is it fashionable to misspell "scenario" in
the kernel circles? ;-)

> +    git cat-file blob ":1:$path" > "$BASE" 2>/dev/null
> +    git cat-file blob ":2:$path" > "$LOCAL" 2>/dev/null
> +    git cat-file blob ":3:$path" > "$REMOTE" 2>/dev/null
> +
> +    if test -z "$local_mode" -o -z "$remote_mode"; then
> +	echo "Deleted merge conflict for $path:"
> +	describe_file "$local_mode" "local" "$LOCAL"
> +	describe_file "$remote_mode" "remote" "$REMOTE"
> +	resolve_deleted_merge
> +	return
> +    fi

Running cat-file even when you know it does not exist at that
stage does not feel right here, although you are not checking
the exit status and discarding 2>/dev/null...

One situation that happens in the real life to cause "we deleted
while they modified" is when in reality we moved then modified
so much that the difference between our version and the common
ancestor version is too large to be considered a rename anymore.

Such a misidentified rename would appear as one path that is "we
deleted while they modified" (original path) and the other path
that is "we created while they didn't do anything to the path".
The latter does not conflict and is already resolved in the
index when you would run git-mergetool.

So if you have "we deleted while they modified" conflict, it may
make sense to give the paths the index adds (relative to HEAD),
let the user pick one of them and allow 3-way merge to update
the path we renamed to.  The original path which had conflicted
would be removed as the result.
