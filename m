From: Junio C Hamano <gitster@pobox.com>
Subject: Re: new to git
Date: Tue, 04 Sep 2007 23:54:31 -0700
Message-ID: <7v7in5lhzs.fsf@gitster.siamese.dyndns.org>
References: <46D32973.8030104@krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Kyle Rose <krose@krose.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 08:54:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISomn-0002iT-6Q
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 08:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbXIEGyo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 02:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbXIEGyo
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 02:54:44 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbXIEGyn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 02:54:43 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D24E012E981;
	Wed,  5 Sep 2007 02:55:00 -0400 (EDT)
In-Reply-To: <46D32973.8030104@krose.org> (Kyle Rose's message of "Mon, 27 Aug
	2007 15:43:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57670>

[jc: I think this is really worth saving somewhere.  Could some
kind soul make this into a patch to have under Documentation/
somewhere?]

Kyle Rose <krose@krose.org> writes:

> (1) Let's say I:
>
> git clone something

  Origin repository's history is copied and you get their master
  in remotes/origin/master (aka remotes/origin/HEAD aka
  remotes/origin), and you can call that 'origin' for brevity.
  At the same time, you get your own 'master' branch that points
  at the same commit as the 'origin'.  Your current branch
  pointed at by your HEAD is 'master'.

     ['origin' repository]
     ---A---B---C
                ^master

 ==>

     [your cloned repository]
     ---A---B---C
                ^master = HEAD
                ^remotes/origin

> git branch foo

  You create a new branch of your own 'foo' in your repository,
  initially pointing at the same commit as your current commit
  (i.e. C as you are on 'master' after the clone).

 ==>

     [your cloned repository]
     ---A---B---C
                ^master = HEAD
                ^remotes/origin
                ^foo

> git checkout foo

  You switch from your current branch (i.e. 'master') to the
  named branch (i.e. 'foo'), making the latter the current
  branch.  Your work tree will largely match the commit at the
  tip of the branch you are switching to, except that if you had
  any local changes (i.e. uncommitted) in your work tree, you
  take it along (but in this example you do not have any).

 ==>

     [your cloned repository]
     ---A---B---C
                ^master
                ^remotes/origin
                ^foo = HEAD

> <make some changes>
> git commit -a

  You build a commit whose parent is the commit your HEAD used
  to point at; the tip of your current branch advances.

 ==>

     [your cloned repository]

     ---A---B---C---D
                    ^foo = HEAD
                ^master
                ^remotes/origin

> git checkout master

  You switch from your current branch (i.e. 'foo') to the
  named branch (i.e. 'master'), making the latter the current
  branch.  Your work tree will largely match the commit at the
  tip of the branch you are switching to, except that if you had
  any local changes (i.e. uncommitted) in your work tree, you
  take it along (but in this example you do not have any).

 ==>

     [your cloned repository]

     ---A---B---C---D
                    ^foo
                ^master = HEAD
                ^remotes/origin

> git pull . foo

  This "git pull" command instructs git to "from the repository
  '.', grab the commit the repository calls 'foo', and update my
  current branch by merging that commit".  Because '.' is "the
  current directory", which in turn means "my repository", you
  do not have to really "grab the commit" --- you already have
  it locally.

  "git merge foo" is more natural way to write this since 1.5.0
  days.  The latter command instructs git "update my current
  branch by merging commit I call 'foo'".

  Now, looking at the above history graph, your current
  branch'es tip is at C (you are on 'master', remember?), and
  'foo' is at D, which is an descendant of C.  By definition, a
  merge between such commit pair is the descendant D, so your
  current branch is updated to D (this is called "fast
  forward").

 ==>

     [your cloned repository]

     ---A---B---C---D
                    ^foo
                    ^master = HEAD
                ^remotes/origin

> git push

  This is kind of "lazy" and "very not-git-like" command I
  literally *hate*.  What "git push" does, whey you do not say
  anything about "where to" nor "what", is to "push all
  corresponding branches and tags to the repository you call
  'origin'".

  If you recall the very initial picture, the 'origin'
  repository has 'master' branch but not 'foo'.  The only
  matching branch is 'master', and that is pointing at C over
  there, which is replaced by your 'master' which now points at
  'D'.

     ['origin' repository]
     ---A---B---C
                ^master

 ==>

     ['origin' repository]
     ---A---B---C---D
                    ^master

  Note that this update *MUST* be fast-forward by default.  IOW,
  if somebody worked elsewhere and updated the 'master' branch
  at the 'origin' repository before your push, your 'push' will
  be prevented with an error message that tells you that remote
  'master' is not a strict subset of what you are pushing.

> git pull

  Instruct git to "grab the history from the 'origin' repository
  and update remotes/origin/* with its branch, and then update my
  current branch by merging its tip".

  The first step of updating the remotes/origin again *MUST* be
  fast-forward by default.

 ==>

     [your cloned repository]

     ---A---B---C---D
                    ^foo
                    ^master = HEAD
                    ^remotes/origin

  If you recall, you are on 'master' branch whose tip is at D.
  Now you are telling git to update it by merging what you
  fetched, which also is D.  So nothing happens.

> (2) Any way to disable this warning:
>
> Warning: No merge candidate found because value of config option
>          "branch.local.merge" does not match any remote branch fetched.

Do as the warning says; I do not think the message can be any
clearer (see Documentation/config.txt, or even better "The
User's Manual").  Set branch.local.merge configuration variable
if you want to always merge specific branch you obtain from the
remote.

E.g.

     [branch "local"]
	remote = origin
        merge = refs/heads/master

if you want "git pull", without saying what to pull from where,
to fetch from 'origin' and merge its 'master' branch, when you
are on your 'local' branch.

> (3) I notice I can't reset --hard a single file.  So, if I want to
> revert a single file to some revision, blowing away my changes, what is
> the accepted way of doing this?  Is there a way to do the equivalent of
> a p4 print foo@some_revision?

I have no idea what p4 does, but:

	git checkout -- path

updates the work tree file with the last version of paths you
did "git add path",

	git checkout HEAD -- path

updates the work tree file with the version of paths in the HEAD
commit, and

	git checkout some_version -- path

updates the work tree file with the version of paths in the
named commit.  For various ways to name commits, see
git-rev-parse(1).

> (4) I'm still not clear on when a dst should and should not be used in a
> refspec.  It appears that one can only do non-fast forward updates to
> the branch that is checked out (which makes sense, since you may need to
> resolve), but other than that, what is the difference between
>
> git checkout foo
> git pull . master
>
> and
>
> git checkout master
> git push . master:foo

The obvious difference is which branch you end up with.

> (5) Are there any tools for managing some of the metadata (e.g., the
> origin URL) or is it expected that one edit it directly?

git-remote(1).
