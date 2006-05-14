From: Tommi Virtanen <tv@inoi.fi>
Subject: The git newbie experience
Date: Sun, 14 May 2006 21:36:40 +0300
Organization: Inoi Oy
Message-ID: <446778B8.7080201@inoi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 14 20:36:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfLSV-0007Yo-3X
	for gcvg-git@gmane.org; Sun, 14 May 2006 20:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWENSgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 14:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWENSgr
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 14:36:47 -0400
Received: from i1.inoi.fi ([194.100.97.46]:15519 "EHLO mail.inoi.fi")
	by vger.kernel.org with ESMTP id S1751194AbWENSgq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 14:36:46 -0400
Received: from mail.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.inoi.fi (Postfix) with ESMTP id 192B8F54AB
	for <git@vger.kernel.org>; Sun, 14 May 2006 21:37:16 +0300 (EEST)
Received: from [10.116.0.191] (GMMDXXVII.dsl.saunalahti.fi [85.76.242.28])
	by mail.inoi.fi (Postfix) with ESMTP id C65D2121C77
	for <git@vger.kernel.org>; Sun, 14 May 2006 21:37:15 +0300 (EEST)
User-Agent: Mail/News 1.5 (X11/20060309)
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19978>

Here's my thoughts from teaching half a dozen people git recently:

Minimal newbie command set
--------------------------

The complete set of "newbie commands" for useful development work should
be as small as possible, for fast learning.

People can always look up new things when they want to, but if they
don't get the simple things going quickly they will forever see git
as "that overcomplex thing I tried to use once".

Concretely: explain the indexless "git commit -a" case first,
so people don't need update-index right away. Most new docs are
pretty good at this, already.

Fix the cases where "git commit -a" is not enough. Here's a case I
ran into:

- Jack is a beginning user of git and does not (want to) understand
  the index (right now).
- Jack works on branch X, say his HEAD points to X1. He has an edited,
  uncommitted files with the names A, B and C.
- Jack wants to pull new changes made by others to his branch.
  There are merge conflicts in files D, E, ..., Z.
- Jack resolves the merge conflicts and is ready to commit the resulting
  merge. Note files A, B and C should not be committed.

  1. if Jack says "git commit -a", then A, B and C will be committed
     also.

  2. if Jack says "git commit", then the current state of the index will
     be committed. That is, the commit will not contain the proper
     merged state of files D, E, ..., Z.

  3. if Jack says "git commit D E ... Z", things work correctly. But
     Jack does not want to type or copy-paste that much, and that's
     horribly error-prone anyway. If the leaves one file out, or
     accidentally adds B there too, the merge goes wrong.

  4. if Jack says "git update-index --refresh" and then "git commit",
     things work correctly. But Jack doesn't (want to) know about the
     index.

My best idea so far is to add a "git commit -A" option, that
essentially does the "update-index --refresh". Whenever index
has a file state != HEAD, update-index it. The modified unrelated
files will have index state == HEAD. Or altering "git commit -a"
to do that.

Except, trying to solve usability problems by _adding_ options
is just insane.

I'd really like to see a way to use git without caring about the
index, and just having things work. I can appreciate the index
is useful, and possibly even necessary to work on projects the size
of the Linux kernel, but I really wish it would default to being
_only_ an optimization, not the central bit of user interface to
prepare commits.

Basic git use _should_ be as easy as basic svn/bzr/hg use. Anything
else will just mean git is not used outside of what codebases Linus
has dictatorship over. (At least not after bzr is more done or hg
more well known; right now git has a very nice feature set, but the
others are catching up fast.)

This is a part that Subversion got right. Basic use needs to be simple.
(If you catch me in agitated mood, I'd claim it's the _only_ part
Subversion got right;-)


And to reply to a comment on IRC I missed at the time:

(21:05:35) gitster: as gittus said much earlier, refusing index is like
refusing git.  We might be able to implement "index-less" mode in which
things like merge and am refuse to operate when you have any change from
HEAD in the working tree. Then new users can always do "commit -a".
(21:06:04) gitster: "git-repo-config core.newuser yes" perhaps?

If you do it that way, you only make git unnecessarily hard to use for
newbies. For example, we had a case where we absolutely _had_ to keep
an ugly workaround in the tree, in a file not otherwise edited, but
we definitely did not want to commit the kludge, at least not to the
branch that was really being worked on. So such restricted mode would
just have meant either people could not merge, or they had to use index
anyway. That's a point where people who have a choice make on, and stop
trying to use git.

(21:08:34) ***gitster personally considers getting more users a very
high priority but agrees that from usability point of view, having a
mode to expose "stripped down" set of features for simple needs would be
beneficial.

That I can 100% agree with.


Branch management
-----------------

"master" and "origin" are good enough for the really simple use, but
that starts to fail fast when you add in more branches.

The remotes/* branch support is really nice, but should be used better.
Here's a bunch of wild ideas:

- When cloning a repository, just clone all the non-remote heads to
local remotes/* heads. See what name the remote HEAD points to, store
that locally also as a refs/heads/master, set local HEAD to it. Note,
origin is gone, and is now called remotes/master.

- Alternatively (and I think I like this more): When cloning a
repository, just clone all the non-remote heads to local remotes/*
heads. See what the remote HEAD points to, store that locally
also as a refs/heads/* head, set local HEAD to it. Note, origin and
master are both gone, and accessible via remotes/X and refs/heads/X
(where X is the name remote HEAD pointed to).

- Currently, when people start tracking a new remote branch, they end
up editing .git/remotes/origin and adding new Pull: lines. If they
intend to work on the branch, they also clone the branch locally, and
add a Push: line. Make this simpler. Here's a rough sketch:

  "git track [--read-only] REMOTE [BRANCH | --all]"

  Without --all, git track would:
  - abort if refs/remotes/foo exists
  - add "Pull: foo:remotes/foo" to .git/remotes/origin (or the
    equivalent config file)
  - if --read-only is not given:
    - add "Push: foo:foo" to .git/remotes/origin
  - fetch foo from origin to remotes/foo
  - if --read-only is not given:
    - run "git branch foo remotes/foo"

  With --all, it would do the same, but for everything the REMOTE has
  in refs/remotes/. Exactly when to abort is a bit harder to define,
  but still..

- Or, if that's too much, at least make peek-remote understand
.git/remotes/* shortcuts, so finding out what branches exist is a bit
simpler.
