From: Johan Herland <johan@herland.net>
Subject: Re: Comment on weak refs
Date: Sun, 10 Jun 2007 03:25:32 +0200
Message-ID: <200706100325.32846.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706092019.13185.johan@herland.net>
 <7vk5ucd6of.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 03:25:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxCBc-0003Dx-Ks
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 03:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbXFJBZm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 21:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbXFJBZl
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 21:25:41 -0400
Received: from smtp.getmail.no ([84.208.20.33]:46077 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbXFJBZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 21:25:40 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJE00603BYRGM00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 03:25:39 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE00JAZBYLID70@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 03:25:33 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE009H5BYLPBE0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 03:25:33 +0200 (CEST)
In-reply-to: <7vk5ucd6of.fsf_-_@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49649>

On Sunday 10 June 2007, Junio C Hamano wrote:
> The patch series to look-up and maintain "softref" relationship
> is trivially clean.  Although I probably would have many nits to
> pick, I do not think it is _wrong_ in a major way per-se.  I
> would not even mind saying that I liked the basic concept, until
> I thought things a bit deeper.
> 
> Here are some initial notes I took while reading your patches.
> 
> 
> Semantics
> ---------
> 
> Not all "softref" relationship is equal.  "This object is
> referred to by these tags" is one obvious application, and only
> because we already try to follow tags when git-fetch happens
> anyway, it looks natural to make everybody follow such a softref
> relationship.
> 
> However, as Pierre Habouzit wants to, we may want to make a bug
> tracking sheet (the details of the implementation of such a bug
> tracking sheet does not matter in this discussion -- it could be
> a blob, a commit, or a tag) refer to commits using this
> mechanism, by pointing at the blob from commits after the fact
> (i.e. "later it was verified that this commit fixes the bug
> described in this bug entry").
> 
> 	Side note: I am assuming a simplest implementation where
> 	one blob would always capture the latest status of the
> 	bug.  refs/bugs/12127 would point at the latest version
> 	of bug 12127's tracking sheet.  An alternative
> 	implementation would be to represent each entry of the
> 	tracking sheet for a single bug as a blob, and have
> 	multiple blobs associated to a commit on the main
> 	project, or the other way around, but then you would
> 	need a way to give order between referers to a single
> 	referent, which I do not find in your proposed
> 	"softref".
> 
> Most users who want to download and compile the main project do
> not care about bug tracker objects.  You would need to have a
> way to describe what kind of relationship a particular softlink
> represents, and adjust the definition of reachability for the
> purposes of traversal of objects.

Yes, I'm starting to see that it's not a good idea to put _all_ softrefs in 
one bag.

> It gets worse when you actually start using softrefs.  I do not
> think you would have a limited set of softrefs, such as
> "reverse-tag-lookup-softref", "bug-tracker-softref".  For
> example, a typical bug tracking sheet may look like this:
> 
>       - Hey I found a bug, you can reproduce like so... I am
>         testing commit _A_.
>       - It appears that commit _B_ introduced it; it does not
>         reproduce with anything older.
>       -	Here is a patch to fix it; please try.
>       - Oh, it seems to fix.  Committed as _C_.
>       - No, it does not work for me, and the approach to fix is
>         wrong; reopening the bug.
>       - Ok, take 2 with different approach.  Committed as _D_.
>  	please try.
>       - Thanks, it finally fixes it.  Closing the bug.
> 
> The bug will be associated with commits A, B, C and D.  The
> questions maintainers would want to ask are:
> 
>  - What caused this bug?
>  - Which versions (or earlier) have this bug?
>  - Which versions (or later) have proper fix?
>  - What alternate approaches were taken to fix this bug?
>  - In this upcoming release, which bugs have been fixed?
>  - What bugs are still open after this release?
> 
> Depending on what you want to find out, you would need to ask
> which commits are related to this bug tracking sheet object, and
> the answer has to be different.  Some "softref" relation should
> extend to its ancestry (when "this fixes" is attached to a
> commit, its children ought to inherit that property), some
> shouldn't ("this is what broke it" should not propagate to its
> parent nor child).

We're getting a little ahead of ourselves, aren't we? IMHO, it would be up 
to the bug system to determine which (and how many) connections to make 
between the bug reports and the commits (or even if softrefs would be the 
correct mechanism for these connections at all). We shouldn't necessarily 
base the softrefs design on how we imagine a hypothetical bug system to 
work. But Pierre might have something to say on how he would want to use 
softrefs, and his system is hopefully _less_ hypothetical. :)

But I can see the use of letting the user/porcelain/bugtracker define 
classes/namespaces of softrefs (at runtime).

> It is also unclear how relationship "softref" introduces is
> propagated across repositories (not objects the softref binds,
> but the fact that such a binding between two objects exists need
> to be propagated).  I would imagine that your assumption is
> simply "to take union".  IOW, if you say A refers to B and
> transfer object A to the other side, in addition to transfering
> object B (if the other side does not have it yet), you would
> tell the other side that B is related to A and have the other
> side add that to its set of softrefs.  Techinically it is a
> simple and easy to implement semantics, but I suspect that would
> not necessarily be useful in practice.  Maybe two people would
> disagree if A and B are related or not.

Yes, I see that different classes of softrefs would have different semantics 
for propagation. we could probably try to set up some sane defaults, and 
then let users put rules in their configs for how they would want to 
propagate the various softrefs classes.

> Maybe you first think A 
> and B are related and then later change your mind.  Should
> "softref" relationships be versioned?

Intriguing idea. Not immediately sure how we would implement it though...

> Reachability
> ------------
> 
> The association brought in between referent and referer by
> softref is "weak", in that referer needs to exist only if
> referent need to be there.  This has the following
> consequences.
>
> Fsck/prune/lost-found
> .....................
> 
> The current object traversal starts from "known tip objects"
> (i.e. refs, HEAD, index, and reflog entries when not doing
> lost-found) and follows the reachability link embedded in
> referer objects (i.e. tag to tagged object, commit to tree, tree
> to tree and blob).  We only need to extend this "reachability"
> with softref.  If a referer object refers to another object via
> a softref, we consider referent reachable and we are done.

Agreed.

> This should be reasonably straightforward, except that we
> probably would need to worry about circular references that
> softlink makes possible.

Isn't there a .used flag on objects we could easily check to see if we've 
seen an object before, thus preventing us from following the circular 
reference?

> push/fetch/rev-list --objects
> .............................
> 
> We walk the revision range (object transfers essentially starts
> traversal from the tips of the sender until it meets what the
> receiver already has), enumerating the reachable objects.  I
> suspect that adding reachability with softref to this scheme has
> consequences on performance.
> 
> Imagine:
> 
> 	A---B---C---D---E
> 
> The sender's tip is at E and the receiver claims to have C.  In
> the sender's repository, E is associated with A (somebody
> noticed that E fixes regression introduced by A, and added a
> softlink to make A reachable from E).  Currently we only need to
> know C is reachable from E to decide that we do not have to send
> A again, but with softlink we would need to.

Hmm. First of all, I'm not sure it would be useful to add a _direct_ link 
between E and A, but even so...
I'm thinking we can do the regular/current reachability calculation first, 
and after it's done, we analyze the softrefs to see if there are more 
objects to be fetched. In that scenario, we wouldn't need to send A again, 
since it's already in our repo.

> The ancestry chain of referent and referer do not have to share
> any common commits.  Imagine a bug tracking system where each
> bug's tracking sheet is represented as a DAG of commits (this
> will allow you to merge and split bugs easily).  This history
> would not share any tree nor blob with the history of the source
> code of the project.  And you would make a commit in the main
> project associated with objects in the bug tracking project
> using softrefs.  As sender and receiver exchanges the commit
> ancestry information on the main project, both ends may need to
> negotiate which objects in the bug tracking history are already
> present in the reciever.

As above, if the receving side gets the list of involved softrefs, it can 
make the decision on which objects it needs to fetch.

Hmm. Thinking about it, this process would of course need to be recursive, 
which could potentially adversely affect the runtime of fetch...

> One attractive point of softref is that you do not have to
> anchor referents with explicit refs.  E.g. if a commit in the
> main project is associated with bug tracking entries in the "bug
> tracking" project via softrefs, that is enough to keep the bug
> tracking objects alive.  But I suspect this property makes the
> enumeration of "what do we have on this end" costly.  I dunno.

Yeah, there are still may open questions. But I'm glad to see that most 
people seem to find the basic concept useful, at least.


Thanks for taking the time and effort to comment.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
