From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Stash missing, but not.  Can apply, but not drop or list the
 stash.
Date: Tue, 23 Sep 2008 18:08:55 -0500
Message-ID: <klevRMI-z5Id8iuqn2rqrKQZ8LdPNE4lABeC502X9y1Es5wwQ-s8GA@cipher.nrlssc.navy.mil>
References: <1222204981.28575.1275592473@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: mattjackets <mattlist@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Sep 24 01:11:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiH2c-00013n-MT
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 01:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbYIWXI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 19:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbYIWXI7
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 19:08:59 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55968 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbYIWXI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 19:08:58 -0400
Received: by mail.nrlssc.navy.mil id m8NN8tGb000492; Tue, 23 Sep 2008 18:08:55 -0500
In-Reply-To: <1222204981.28575.1275592473@webmail.messagingengine.com>
X-OriginalArrivalTime: 23 Sep 2008 23:08:55.0673 (UTC) FILETIME=[5A46CE90:01C91DD1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96610>

mattjackets wrote:
> I have a strange stash problem.  There is a single stash in the repo.
> 
> git stash apply 0  --  works, but results in a conflict.

The correct form is 'git stash apply stash@{0}'

'git stash apply 0' is doing the right thing for the wrong reason.
For example, 'git stash apply 1' would not do the right thing.

This is unrelated to your issue, but it seems you have uncovered
a flaw which should be fixed.

In git stash, when your command line above is used, eventually
the following command is executed:

    git rev-parse --revs-only --no-flags --default refs/stash 0

'git rev-parse' fails to resolve revision "0" and prints out nothing
and then falls back to printing the revision of "refs/stash". This
is not what is desired by stash.

Either rev-parse needs to error out in this case, or 'git stash' needs
to be changed so that '--default refs/stash' is not used here. Possibly,
something like what is done inside drop_stash().

>  Lets just go
> ahead and drop the stash...
> 
> git stash list  --  shows nothing.  huh?  Lets go ahead with the drop
> anyway and hope it works...
> 
> $ git stash drop stash@{0}
> fatal: Log .git/logs/refs/stash is empty.
> stash@{0}: not a valid stashed state
> 
> sure enough, .git/logs/refs/stash is empty

Right, it must exist since you actually got the error message
'fatal: Log .git/logs/refs/stash is empty', but it contains
nothing. Not sure how that happened.

> git stash clear  --  does nothing

It correctly removes .git/refs/stash for me.

> I'm at a loss.  I can apply the stash cleanly to older revisions, and
> gitk still shows the stash branch.  How can I fix this?  is it safe to
> simply delete the stash branch as if it was any other branch?

In this case yes it would be safe to just do 'rm .git/refs/stash', but
like I said, 'git stash clear' worked for me.

-brandon
