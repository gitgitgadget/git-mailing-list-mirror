From: "David Jeske" <jeske@google.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 01:47:59 -0000
Message-ID: <29266.7213514962$1214273195@news.gmane.org>
References: <jeske@willow=01l5V7waFEDjChmh>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5V7wbFEDjCX7V>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:06:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAxvQ-0004l6-Js
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbYFXCFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbYFXCFd
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:05:33 -0400
Received: from w2.willowmail.com ([64.243.175.54]:59963 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751647AbYFXCFc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:05:32 -0400
Received: (qmail 6189 invoked by uid 90); 24 Jun 2008 02:05:12 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Tue, 24 Jun 2008 01:47:59 -0000
In-Reply-To: <jeske@willow=01l5V7waFEDjChmh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85966>

As a new user, I'm finding git difficult to trust, because there are operations
which are destructive by default and capable of inadvertently throwing hours or
days of work into the bit bucket.

More problematic, those commands have no discernible pattern that shows their
danger, and they need to be used to do typical everyday things. I'm starting to
feel like I need to use another source control system on top of the git
repository in case I make a mistake.  My philosophy is simple, I never never
never want to throw away changes, you shouldn't either. Disks are cheaper than
programmer hours. I can understand wanting to keep things tidy, so I can
understand ways to correct the 'easily visible changes', and also avoid pushing
them to other trees, but I don't understand why git needs to delete things.

For example, the following commands seem capable of totally destroying hours or
days of work. Some of them need to be used regularly to do everyday things, and
there is no pattern among them spelling out danger.

git reset --hard          : if another branch name hasn't been created
git rebase
git branch -D <branch>    : if branch hasn't been merged
git branch -f <new>       : if new exists and hasn't been merged
git branch -m <old> <new> : if new exists and hasn't been merged

I've heard from a couple users that the solution to these problems is to "go
dig what you need out of the log, it's still in there". However, it's only in
there until the log is garbage collected. This either means they are
destructive operations, or we expect "running without ever collecting the log"
to be a valid mode of operation... which I doubt is the case.

Question: How about assuring ALL operations can be done non-destructivly by
default? Then make destructive things require an explicit action that follows a
common pattern.

Suggestion Illustration
-----------------------

Below is one illustration of how these commands could be changed to be entirely
non-destructive, while retaining the current functionality. It also allows you
to destroy stuff if you have lawyers breathing down your neck, or really really
can't afford the hard drive space for a couple lines of text (though I'll
personally make a donation to anyone in this state!) :)

1) Require the "--destroy" flag for ANY git operation which is capable of
destroying data such that it is unrecoverable. A narrow view of this is to only
consider checked-in repository data, and not metadata, such as the location of
a branchname. However, the broad view would be to include all/most metadata.

2) Make a pattern for branch names which are kept in the local tree, not
included in push/pull, not modifiable without first renaming, and not shown by
default when viewing all branch history. For example, "local-<date>-*"

3) make 'git reset --hard <commit>' safe

Automatically commit working set and make a branch name (if necessary) to avoid
changes being thrown away. The branch name could be of the form
"local-<date>-reset-<user>-<date>". If the user really wants to destroy it,
they could use the dangerous version "git reset --hard --destroy", or they
could just "git branch -d --destroy <branchname>" afterwords. Most users would
do neither.

4) make 'git rebase' safe

'rebase' would make a branch name before performing its operation, assuring it
was easy to get back to the previous state. Currently, "git rebase" turns this:

A---B---C topic
/
D---E---F---G master

Into this:

A'--B'--C' topic
/
D---E---F---G master

.. and in turn destroys the original changes. It would instead create this:

A--B--C (x)    A'--B'--C' (y)
/              /
D---E------F-------G master

(x) - local-<date>-rebase-topic-<commit for G>
(y) - topic

5) make 'git branch' follow rule 1 above (safe without --destroy)

Using any of the following commands without --destroy would cause them to
create a branch "local-<date>-rename-<old branch name>", to prevet the
destruction of the old branch location:

git branch -d <branchname>
git branch -M <old> <new>
git branch -f <branchname>
