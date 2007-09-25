From: Junio C Hamano <gitster@pobox.com>
Subject: Re: My stash wants to delete all my files
Date: Mon, 24 Sep 2007 18:26:08 -0700
Message-ID: <7vabrb8rin.fsf@gitster.siamese.dyndns.org>
References: <5A9D6E3B-7B0E-4414-9AFB-C1C8B2EE6A9D@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 03:26:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZzBw-000205-UF
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 03:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbXIYB0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 21:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbXIYB0Q
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 21:26:16 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687AbXIYB0P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 21:26:15 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 53A0413B785;
	Mon, 24 Sep 2007 21:26:32 -0400 (EDT)
In-Reply-To: <5A9D6E3B-7B0E-4414-9AFB-C1C8B2EE6A9D@steelskies.com> (Jonathan
	del Strother's message of "Mon, 24 Sep 2007 14:12:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59086>

Jonathan del Strother <maillist@steelskies.com> writes:

> $ git stash list
> stash@{0}: On master: --apply
> stash@{1}: WIP on master: 09e3c30... Better handling of cell sizes in
> the grid
>
> $ git stash show stash@{1}
>  ...
>  19 files changed, 0 insertions(+), 3805 deletions(-)
>
> Hmm.  Looks like it's trying to delete all of my versioned files.
> "git stash apply stash@{1}" confirms this.   Obviously that's not what
> I tried to stash - my WIP when I stashed was a few additions, a couple
> of new unversioned files, and moving a few lines of code from one file
> to another.
>
> Any ideas what happened there?  I can't seem to reproduce the problem
> in a test repository.

There are two possibilities that I can think of offhand, neither
of them is about git-stash but about the state you ran stash
from.

Whenever anybody wonders where inadvertent reverting changes
come from, two most likely reasons are incorrect push into the
current branch's tip initiated from elsewhere, or incorrect
fetch into the current branch's tip initiated from the
repository.

If your work repository is foo, and if you are working on
'master' branch, you could

	$ cd ../bar ; git push ../foo master:master

to push from elsewhere to update the tip of the checked out
branch.  This makes the index and the work tree that was based
on the old commit in foo repository totally out of sync with
respect to the HEAD (which you are replacing), and committing
that state would revert the change the above push made.

You can do the same by doing something equally silly and
destructive by:

	$ git fetch --update-head-ok ../bar master:master

After these operations that could make your index and work
tree state to include reverts, if you "stash", the stash will
record that the reverting was what you wanted to do.

I am not saying this is the only possible explanation though.
You can try:

	git ls-tree stash@{1}
        git rev-parse stash@{1}^1
        git diff stash@{1}^1 stash@{1}^2

The stash entry itself is the state of the work tree, its first
parent (i.e. ^1) is the commit your stash was originally based
on, and its second parent (i.e. ^2) is what was recorded in the
index.  Is the output from the first one empty?  Does the second
command show you that you were on the commit you thought you were
on?  Does the third command show you what you thought you have
told "git add" to put in the index just before you made the
stash?
