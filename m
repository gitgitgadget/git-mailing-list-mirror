From: Sergey Organov <sorganov@gmail.com>
Subject: git rebase: yet another newbie quest.
Date: Fri, 05 Sep 2014 14:28:46 +0400
Message-ID: <87a96ecqe9.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 12:28:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPqlD-00047z-W8
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 12:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464AbaIEK2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 06:28:51 -0400
Received: from mail.javad.com ([54.86.164.124]:50363 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756344AbaIEK2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 06:28:50 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 8B8A46180E
	for <git@vger.kernel.org>; Fri,  5 Sep 2014 10:28:48 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XPql4-0005bH-NT
	for git@vger.kernel.org; Fri, 05 Sep 2014 14:28:46 +0400
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256507>

Hello,

Caveat: this is somewhat long, sorry.

Recently I've run into yet another rather tricky trouble with
pull/rebase. No, neither of my troubles is in the usual "rewriting
published history" group.

(The first trouble I ran earlier was caused by the fact that "git pull"
breaks local merges when "pull.rebase" configuration variable is set to
"true".)

Below is shell script to create test repo that shows the steps I did
that lead me to the trouble, along with explanations why I did them.
Then follows description of the actual quest I ran through to figure a
work-around.

I must admit I still don't know what I should have done differently in
the script below to avoid this problem in the first place, nor do I
entirely understood what git is doing.

$ git --version
git version 1.9.3

----- 8< -----  Test repo creation ----- 8< -----

#!/bin/sh

# Git output is prefixed with '#> " below

# Prepare some initial state for the show. Create 2 files to be changed
# in 2 different branches to avoid content conflicts later.

git init t
cd t
echo A > a
echo B > b
git add a b
git commit -m "A" -a

# Pretend we have some origin/master. It was really the case in the
# original scenario. Here I just set a tag instead, as it doesn't
# change the outcome.

git tag origin_master

# OK. Here we start. On the branch 'master' (that tracked origin/master in
# original scenario) I do some small change:

echo B >> b
git commit -m B -a

# Then I realize I need more changes and it gets complex enough to
# warrant a topic branch. I create the 'topic' branch that will track
# 'master' branch and reset 'master' back to its origin (remote
# origin/master in original scenario).

git checkout -b topic
git branch --force master origin_master
git branch -u master

# Now I do more work on the topic branch...

echo C >> b
git commit -m C -a

# Meanwhile something non-conflicting (in another file) changed upstream...

git checkout master
echo A >> a
git commit -m D -a
git checkout topic

----- >8 -----  Test repo creation end ----- >8 -----

The creation of the test setup complete, we end-up with the following
simple history:

$ git log --all --oneline --graph --decorate
* 335fc12 (master) D
| * 2cefe9f (HEAD, topic) C
| * aed3006 B
|/
* 951b15b (tag: origin_master) A
$

And my 'topic' branch is set to track 'master':

$ git branch -vv --list topic
* topic 2cefe9f [master: ahead 2, behind 1] C

Exactly what I wanted to achieve. Now we are ready to go to the essence
of the quest.

Being on the 'topic' branch I pull from upstream, rebasing. Can you
guess what I expectated? Yeah, something as simple as B and C being
rebased on top of D, like this:

> $ git pull --rebase
> ...
> $ git log --all --oneline --graph --decorate
> * xxxxxxx (HEAD, topic) C
> * xxxxxxx B
> * 335fc12 (master) D
> * 951b15b (tag: origin_master) A

Here is what I got instead:

$ git pull --rebase
From .
 * branch            master     -> FETCH_HEAD
First, rewinding head to replay your work on top of it...
Applying: C
Using index info to reconstruct a base tree...
M	b
Falling back to patching base and 3-way merge...
Auto-merging b
CONFLICT (content): Merge conflict in b
Recorded preimage for 'b'
Failed to merge in the changes.
Patch failed at 0001 C
The copy of the patch that failed is found in:
   /home/osv/f/t/t/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".

$

Wait... Conflict?! That's unexpected. Let's first get back to a sane state:

$ git rebase --abort
$

I suspect it's not easy to figure what happens here, even having this
simple imitation. It was even harder in real life as there were a lot of
unrelated things happening simultaneously.

What I did:

Looking closer at the "git rebase" output, it applies C, but not (yet?)
B. Why doesn't it apply B?

Let's first exclude "git pull" from the equation:

$ git rebase
...
$

Still the same outcome as with 'git pull --rebase" above -- at least git
is consistent at kicking me into the stomach ;-) Good...

Let's figure how to check which commits are to be rebased:

$ git help rebase

 "...
  This is the same set of commits that would be shown by
  git log <upstream>..HEAD"

$ git rebase --abort
$ git log --oneline master..HEAD
2cefe9f C
aed3006 B
$

So it should apply B and C, but only applies C. The manual lies?
Unlikely. Let's dig more into the manual... Ah, maybe here it is:

 "Note that any commits in HEAD which introduce the same textual
  changes as a commit in HEAD..<upstream> are omitted "

Check...

$ git log --oneline HEAD..master
335fc12 D
$

No, there is no way missed commit 'B' textually matches commit 'D'.

Wondering further... let's try to specify <upstream> explicitly:

$ git --rebase master
First, rewinding head to replay your work on top of it...
Applying: B
Applying: C
$

Wow! This way it works! But the manual says:

 "If <upstream> is not specified, the upstream configured in
  branch.<name>.remote and branch.<name>.merge options will be
  used; see git-config(1) for details."

Did I mis-configured <upstream>? Check:

$ git config --list | grep topic
branch.topic.remote=.
branch.topic.merge=refs/heads/master
$

# So it's 'refs/heads/master'. I always thought I can say just 'master',
# but let's see if it suddenly matters in this case?:

$ git reset --hard @{1} # First get to pre-rebase state
HEAD is now at 2cefe9f C
$ git --rebase refs/heads/master
First, rewinding head to replay your work on top of it...
Applying: B
Applying: C
$

Still different from what vanilla "git rebase" does. So, what's next?
How do I figure what exactly it does? Searching for "debug", "verbose",
"dry-run", or something like that in the manual page. Well, there is
'-v', try it:

$ git reset --hard @{1}
HEAD is now at 2cefe9f C
$ git rebase -v
Changes from 951b15b8bfd6dee3d22ed1c48b0d2947aefac346 to 335fc12a2ddd175a22e086a08492ceda1280fd9f:
 a | 1 +
 1 file changed, 1 insertion(+)
First, rewinding head to replay your work on top of it...
Applying: C
Using index info to reconstruct a base tree...
M	b
Falling back to patching base and 3-way merge...
Auto-merging b
CONFLICT (content): Merge conflict in b
Recorded preimage for 'b'
Failed to merge in the changes.
Patch failed at 0001 C
The copy of the patch that failed is found in:
   /home/osv/f/t/t/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".

$

Doesn't help either, no luck.

Well, how does it calculate the set of commits? Probably it has
something to do with merge-base? (Yeah, I already knew about merge-base
as I wrote script to convert our CVS repository to git and learned a few
things on the way, so I'm not entirely newbie.)

$ git help merge-base
...

And there, right in SYNOPSIS, the --fork-point catches my attention.
Reading its description:

--fork-point
    Find the point at which a branch (or any history that leads to
    <commit>) forked from another branch (or any reference) <ref>. This
    does not just look for the common ancestor of the two commits, but
    also takes into account the reflog of <ref> to see if the history
    leading to <commit> forked from an earlier incarnation of the branch
    <ref> (see discussion on this mode below). :

It definitely clicks! Let's look for --fork-point in the

$ git help rebase

Yeah, it's there!

--fork-point, --no-fork-point
    Use git merge-base --fork-point to find a better common ancestor
    between upstream and branch when calculating which commits have have
    been introduced by branch (see git-merge-base(1)).

    If no non-option arguments are given on the command line, then the
    default is --fork-point @{u} otherwise the upstream argument is
    interpreted literally unless the --fork-point option is specified.


So, this last paragraph, hidden deep in the middle of the lengthy git
rebase manual page, brings us the answer:

"git rebase"      ==  "git rebase --fork-point @{u}"

while

"git rebase @{u}" ==  "git rebase --no-fork-point @{u}"

Surprise!

And the set of commits vanilla "git rebase" will rebase could apparently
be rather different from those output by

"git log @{u}..HEAD"

that the manual unconditionally claims in the DESCRIPTION.

... And after I wrote the above, out of curiosity I tried the following
(I've already re-created the test repo, so SHA1s won't match):

$ git pull --no-rebase --no-edit
From .
 * branch            master     -> FETCH_HEAD
Merge made by the 'recursive' strategy.
 a | 1 +
 1 file changed, 1 insertion(+)
$ git pull --rebase
From .
 * branch            master     -> FETCH_HEAD
First, rewinding head to replay your work on top of it...
Applying: B
Applying: C
$

So, if I first do pull/merge, then pull/rebase suddenly starts to do
what I asked it to do in the first place! That throws me back right into
the middle of the quest!

$ git reset --hard @{1}
HEAD is now at ed1ff0f Merge branch 'master' into topic
$ git log $(git merge-base --fork-point @{u} HEAD)..HEAD
<no output>
$ git merge-base --fork-point @{u} HEAD
<no output>
$ git log --one-line ${u}..HEAD
ed1ff0f Merge branch 'master' into topic
ff4d9fa C
e326c16 B
$

So, when there is no fork-point found, vanilla "git rebase" behaves as
if it were "git rebase @{u}"? I still neither understand what exactly
happens here, nor what all this --fork-point business is all about in
the first place.

How comes fork point disappears because of merge, and is it OK that
'merge-base --fork-point' produces no output at all when vanilla
'merge-base' does?

Could somebody please fix the manual page to explain what "git rebase"
is actually doing? I mean somebody who, unlike me, actually knows,

Also, what should I have done differently in the script above to avoid
the problem in the first place? Is it git bug I stumbled over?

P.S. On the positive side, it reminded me playing good old Larry game in
     the early 90's :-)

-- 
Sergey.
