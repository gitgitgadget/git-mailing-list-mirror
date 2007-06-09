From: Junio C Hamano <gitster@pobox.com>
Subject: Comment on weak refs
Date: Sat, 09 Jun 2007 16:55:28 -0700
Message-ID: <7vk5ucd6of.fsf_-_@assigned-by-dhcp.cox.net>
References: <200706040251.05286.johan@herland.net>
	<200706092019.13185.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 01:55:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxAmJ-0001Uv-Um
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 01:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757725AbXFIXzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 19:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757631AbXFIXza
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 19:55:30 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49004 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757449AbXFIXza (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 19:55:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609235529.PIAT14072.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 9 Jun 2007 19:55:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9bvU1X00B1kojtg0000000; Sat, 09 Jun 2007 19:55:29 -0400
cc: Pierre Habouzit <madcoder@debian.org>
In-Reply-To: <200706092019.13185.johan@herland.net> (Johan Herland's message
	of "Sat, 09 Jun 2007 20:19:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49641>

The patch series to look-up and maintain "softref" relationship
is trivially clean.  Although I probably would have many nits to
pick, I do not think it is _wrong_ in a major way per-se.  I
would not even mind saying that I liked the basic concept, until
I thought things a bit deeper.

Here are some initial notes I took while reading your patches.


Semantics
---------

Not all "softref" relationship is equal.  "This object is
referred to by these tags" is one obvious application, and only
because we already try to follow tags when git-fetch happens
anyway, it looks natural to make everybody follow such a softref
relationship.

However, as Pierre Habouzit wants to, we may want to make a bug
tracking sheet (the details of the implementation of such a bug
tracking sheet does not matter in this discussion -- it could be
a blob, a commit, or a tag) refer to commits using this
mechanism, by pointing at the blob from commits after the fact
(i.e. "later it was verified that this commit fixes the bug
described in this bug entry").

	Side note: I am assuming a simplest implementation where
	one blob would always capture the latest status of the
	bug.  refs/bugs/12127 would point at the latest version
	of bug 12127's tracking sheet.  An alternative
	implementation would be to represent each entry of the
	tracking sheet for a single bug as a blob, and have
	multiple blobs associated to a commit on the main
	project, or the other way around, but then you would
	need a way to give order between referers to a single
	referent, which I do not find in your proposed
	"softref".

Most users who want to download and compile the main project do
not care about bug tracker objects.  You would need to have a
way to describe what kind of relationship a particular softlink
represents, and adjust the definition of reachability for the
purposes of traversal of objects.

It gets worse when you actually start using softrefs.  I do not
think you would have a limited set of softrefs, such as
"reverse-tag-lookup-softref", "bug-tracker-softref".  For
example, a typical bug tracking sheet may look like this:

      - Hey I found a bug, you can reproduce like so... I am
        testing commit _A_.
      - It appears that commit _B_ introduced it; it does not
        reproduce with anything older.
      -	Here is a patch to fix it; please try.
      - Oh, it seems to fix.  Committed as _C_.
      - No, it does not work for me, and the approach to fix is
        wrong; reopening the bug.
      - Ok, take 2 with different approach.  Committed as _D_.
 	please try.
      - Thanks, it finally fixes it.  Closing the bug.

The bug will be associated with commits A, B, C and D.  The
questions maintainers would want to ask are:

 - What caused this bug?
 - Which versions (or earlier) have this bug?
 - Which versions (or later) have proper fix?
 - What alternate approaches were taken to fix this bug?
 - In this upcoming release, which bugs have been fixed?
 - What bugs are still open after this release?

Depending on what you want to find out, you would need to ask
which commits are related to this bug tracking sheet object, and
the answer has to be different.  Some "softref" relation should
extend to its ancestry (when "this fixes" is attached to a
commit, its children ought to inherit that property), some
shouldn't ("this is what broke it" should not propagate to its
parent nor child).

It is also unclear how relationship "softref" introduces is
propagated across repositories (not objects the softref binds,
but the fact that such a binding between two objects exists need
to be propagated).  I would imagine that your assumption is
simply "to take union".  IOW, if you say A refers to B and
transfer object A to the other side, in addition to transfering
object B (if the other side does not have it yet), you would
tell the other side that B is related to A and have the other
side add that to its set of softrefs.  Techinically it is a
simple and easy to implement semantics, but I suspect that would
not necessarily be useful in practice.  Maybe two people would
disagree if A and B are related or not.  Maybe you first think A
and B are related and then later change your mind.  Should
"softref" relationships be versioned?


Reachability
------------

The association brought in between referent and referer by
softref is "weak", in that referer needs to exist only if
referent need to be there.  This has the following
consequences.

Fsck/prune/lost-found
.....................

The current object traversal starts from "known tip objects"
(i.e. refs, HEAD, index, and reflog entries when not doing
lost-found) and follows the reachability link embedded in
referer objects (i.e. tag to tagged object, commit to tree, tree
to tree and blob).  We only need to extend this "reachability"
with softref.  If a referer object refers to another object via
a softref, we consider referent reachable and we are done.

This should be reasonably straightforward, except that we
probably would need to worry about circular references that
softlink makes possible.

push/fetch/rev-list --objects
.............................

We walk the revision range (object transfers essentially starts
traversal from the tips of the sender until it meets what the
receiver already has), enumerating the reachable objects.  I
suspect that adding reachability with softref to this scheme has
consequences on performance.

Imagine:

	A---B---C---D---E

The sender's tip is at E and the receiver claims to have C.  In
the sender's repository, E is associated with A (somebody
noticed that E fixes regression introduced by A, and added a
softlink to make A reachable from E).  Currently we only need to
know C is reachable from E to decide that we do not have to send
A again, but with softlink we would need to.

The ancestry chain of referent and referer do not have to share
any common commits.  Imagine a bug tracking system where each
bug's tracking sheet is represented as a DAG of commits (this
will allow you to merge and split bugs easily).  This history
would not share any tree nor blob with the history of the source
code of the project.  And you would make a commit in the main
project associated with objects in the bug tracking project
using softrefs.  As sender and receiver exchanges the commit
ancestry information on the main project, both ends may need to
negotiate which objects in the bug tracking history are already
present in the reciever.

One attractive point of softref is that you do not have to
anchor referents with explicit refs.  E.g. if a commit in the
main project is associated with bug tracking entries in the "bug
tracking" project via softrefs, that is enough to keep the bug
tracking objects alive.  But I suspect this property makes the
enumeration of "what do we have on this end" costly.  I dunno.

Come to think of it, and this is off topic for "softref", I
think using an isolated commit DAG for each bug is probably a
very natural way to implement a bug tracking system.  If you
want to refer to commits on the mainline, you can refer to them
by their object names, just like mainline commit log messages
would refer to earlier commits in the text (e.g. "This fixes the
regression introduced by commit ABC").  The new text entry for
traditional BTS will go to the commit message (a bug "project"
commit does not have to have anything in its tree), and you can
use "git log" to view what the ordinary BTS would provide, and
it will distribute the tracking.  You do not necessarily
need/benefit from "softref" for this, though.  It could be that
such a bug "project" commit might have a commit from the main
project in its tree (it would look like a subproject) whose tree
entry name may be something like "fixes/yyyy-mm-yy-author".
