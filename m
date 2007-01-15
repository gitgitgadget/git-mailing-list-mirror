From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-{parse-remote,pull}: throw away stderr of git-symbolic-ref
Date: Mon, 15 Jan 2007 14:07:10 -0800
Message-ID: <7vk5zo0ws1.fsf@assigned-by-dhcp.cox.net>
References: <200701151009.51868.andyparkins@gmail.com>
	<20070115212442.GA7409@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 23:07:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Zz2-00016T-Sa
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 23:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbXAOWHN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 17:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXAOWHN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 17:07:13 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:57049 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbXAOWHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 17:07:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070115220711.HBKX9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Mon, 15 Jan 2007 17:07:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ba6H1W00b1kojtg0000000; Mon, 15 Jan 2007 17:06:18 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20070115212442.GA7409@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 15 Jan 2007 16:24:43 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36890>

Jeff King <peff@peff.net> writes:

> We look up the destination of the HEAD symref in order to get the
> default remote and merge head for the current branch. However, if we
> have a detached HEAD, there is no current branch. We handle this
> situation by looking up branch..remote, which is empty.
> Unfortunately, git-symbolic-ref complained to stderr, potentially
> scaring users.

I think what I sent out was a moral equivalent, but generally
speaking I do not think we should discard stderr output
indiscriminatingly.

> diff --git a/git-pull.sh b/git-pull.sh
> index 9592617..f0cc023 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -83,7 +83,7 @@ merge_head=$(sed -e '/	not-for-merge	/d' \
>  
>  case "$merge_head" in
>  '')
> -	curr_branch=$(git-symbolic-ref HEAD | \
> +	curr_branch=$(git-symbolic-ref HEAD 2>/dev/null | \
>  		sed -e 's|^refs/heads/||')
>  	echo >&2 "Warning: No merge candidate found because value of config option
>           \"branch.${curr_branch}.merge\" does not match any remote branch fetched."

I missed this one, but I think this needs a bit more through
rework.  This is what happens when you say "git pull origin"
while your HEAD is detached, and specifying "branch..merge" in
the configuration should not be the way to define the default
remote branch to be merged while on a detached HEAD.  In fact, I
think there should not be any such default.

I think it makes more sense to say "your HEAD is detached and
you need to explicitly say which branch you would want to merge
in" in this case.
