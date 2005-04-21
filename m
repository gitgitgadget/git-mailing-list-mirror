From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Allow "git cancel" to change branches
Date: Thu, 21 Apr 2005 16:00:09 -0400
Message-ID: <1114113609.29603.24.camel@dv>
References: <E1DObsr-0006Au-MA@server.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 21:57:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOhmN-0003Cx-HY
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 21:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVDUUAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 16:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVDUUAY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 16:00:24 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:58000
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261831AbVDUUAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 16:00:12 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id 427C8EFF72; Thu, 21 Apr 2005 16:00:09 -0400 (EDT)
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <E1DObsr-0006Au-MA@server.smurf.noris.de>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Matthias!

On Thu, 2005-04-21 at 23:31 +1000, Matthias Urlichs wrote:
> "git cancel" may not be named correctly for this job, but it does almost
> everything you'd need for switching between one branch and another
> within a repository, so...

This functionality is badly needed, but "git cancel" should probably
remain what it is.

> +if [ "$1" ] ; then
> +	test -f .git/heads/$1 || cp .git/HEAD .git/heads/$1
> +	ln -sf "heads/$1" .git/HEAD
> +fi

Considering that the patch is essentially just this block of code, it
could be (in the first approximation) a separate command, e.g. "git
switch", that would call "git cancel" if needed.

But let's consider the fact that "git cancel" removes all local changes.
That's quite a serious side effect.  I don't always want to remove local
changes when I switch between branches in CVS.  Many users would prefer
git to do a merge.

I think that "git track" needs to be redesigned.  There are at least
three properties of the working directory (related to branch tracking)
that users may want to change:

1) Where new revisions are pulled from.  It could be more than one
branch (ideal implementation - with several copies of rsync run
simultaneously).

2) What branch is "checked out" to the working directory, i.e. what
branch would "git cancel" restore.

3) Whether new changes are merged automatically.

I suggest following syntax:

git track -b WORKING-BRANCH [--cancel] [--active|--passive]
[TRACK-BRANCH...|--notrack]

--cancel would cancel changes rather than merge when the current branch
changes.

--active enables automerge, --passive disables it

Empty list of branches to track should not disable tracking.  Only
--notrack should do it.

Then your "git cancel BRANCH" would become:
git track -b BRANCH --cancel

-- 
Regards,
Pavel Roskin

