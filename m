From: Eric Raymond <esr@thyrsus.com>
Subject: RFC - "git editlog" feature for fixing up local commit messages
Date: Mon, 29 Mar 2010 09:31:32 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100329133132.GA12201@thyrsus.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 15:31:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwF48-0003dE-1b
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 15:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab0C2Nbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 09:31:34 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:35799
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0C2Nbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 09:31:33 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id A48F620CBA3; Mon, 29 Mar 2010 09:31:32 -0400 (EDT)
Content-Disposition: inline
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143471>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm quite prone to typos in my commit comments - sufficiently so that
that when I was using Subversion for GPSD I wrote a script to ssh to
the repo server and edit the comment property of a specified revision.
That way, when I noticed a typo in the output of SVN log, I could fix it.

I don't have that liberty in the DVCS world of chained commit hashes, unless
the commit is only local and hasn't been pushed.  But that exception 
is important.  Since switching GPSD to git, I've developed a workflow
that looks like this: 

(1) I develop, test, and commit a bunch of changes.

(2) Before pushing them to rigin, I eyeball the git log.

(3) If I spot typos in past revisions, I fix them locally.

(4) Only then do I push upstream.

Now, about step 3.  The official git command set only directly supports
amending the tip commit.  There is a semi-documented procedure for 
amending previous commits using an interactive rebase, but trying to
understand it makes my brain hurt.  Don't want to go there.

Instead, following a suggestion by thiago on #git, I've written a
script I call editcomment (enclosed).  It takes a revision spec as
argument, then checks to see if that ref has any remote references; it
it does, the script warns the user that he will discombobulate the
order of the universe if he continues and requests confrmation.

If the commit is local only, or the user confirms he want to shoot
self in foot, the script then runs a filter-branch operation using a
filter that no-ops all other commits through but fires up an editor on the
contents of the matching one as presented on stdin, writing the
modified version to stdout on editor exit.

The overall effect is the commit comment gets edited and all hashes
there and afterwards change, but if they were all local that's OK.
I don't have to think about rebases or amends or reverts, and that;s
exactly the way I want it.  When I need to edit a comment, *I desire 
the luxury of ignorance about how it's done*.

My editcomment script, as it exists, has a technical problem...the
editor needs to be something like emacsclient that actually invokes in
a different X window, otherwise whatever it writes to stdout will end
up stuffed in the comment along with the text I actually wanted to put
there.  The underlying problem is that git-filter-branch is sort of a
nuclear-powered chainsaw - gets the job done, but in a way that is
prone to messy side effects.  A more elegant implementation would
probably need to tie deeper into the plumbing.

Here's what I think any git user should be able to do: call "git editlog
<commit>" and have it either

(1) refuse with an error message because the commit has remote references
    and the user didn't specify -f, or

(2) fire up an editor of the user's choice, accepting the edited result as
    a replacement for the commit comment. It should no-op if the
    comment is not changed.

For my own purposes, my editcomment script would be good enough, since 
I never really want to be able to use anything but emacsclient anyway --
vi not working is at best a very minor inconvenience for me.  

But I'm advocating for this feature to be in git anyway, because I
think it addresses a common need for which the existing interface is
needlessly painful and difficult to understand. In the local case, I
think this is not an operation that should require the user to care
that DAG surgery is implied.  git would be better art if users could
ignore that.

Accordingly, I want to open a discussion on this...

* Do others agree that git editlog would be a desirable feature?

* Supposing it is, what would be the best way to implement it?

* Are there issues with this proposal that I haven't noticed?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=editcomment

#!/bin/sh
# Give this a commit-ID specification.  It will edit the associated comment.
# Usual caveats apply; the edited one and all commits after will change IDs,
# and pushing them to a repo with the old commits will wreak havoc.
# Note also that this cavalierly overwrites refs/original.
#
# This script by Eric S. Raymond, March 2010, all rites perverted.
# It's based on an idea by thiago from #git, but debugged and with a safety.
# It contains porcelain and porcelain byproducts.

topdir=`git rev-parse --show-cdup`
test -n "$topdir" && cd "$topdir"

my_commit=`git rev-parse $1` || exit $?

# Run a safety check before edits that could hose remotes.
if test -n "`git branch -r --contains $mycommit`"
then
    echo -n "Commit has been pushed.  Really edit? "
    read yn
    if test "$yn" != 'y'
    then
	exit 0
    fi
fi

my_file=COMMIT_EDITMSG
test -d .git && myfile=.git/COMMIT_EDITMSG

# This effort to invoke the user's normal editor fails.
# the problem is that anything the editor writes to stdout on the
# controlling terminal becomes part of the commit message.  So
# the editor needs to actually run inside another window.
#test -z "$GIT_EDITOR" && GIT_EDITOR=$EDITOR
#test -z "$GIT_EDITOR" && GIT_EDITOR=vi
#my_editor=$GIT_EDITOR

# xterm -e vi should also work.
my_editor=emacsclient

export my_file my_commit my_editor

exec git filter-branch -f --msg-filter '
if test "$GIT_COMMIT" = "$my_commit"; then
    cat > $my_file;
    $my_editor $my_file >/dev/null;
    cat $my_file
else
    cat
fi' "$1~.."

# End

--VS++wcV0S1rZb1Fb--
