From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 22:40:33 +0200
Message-ID: <20050415204033.GG7417@pasky.ji.cz>
References: <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz> <7vwtr4ibkt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 22:39:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMXaT-0004UY-55
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 22:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVDOUmP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 16:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVDOUmP
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 16:42:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1249 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261964AbVDOUkf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 16:40:35 -0400
Received: (qmail 24367 invoked by uid 2001); 15 Apr 2005 20:40:33 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtr4ibkt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 12:22:26PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> After I re-read [*R1*], in which Linus talks about dircache,
> especially this section:
> 
>  - The "current directory cache" describes some baseline. In particular,
>    note the "some" part. It's not tied to any special baseline, and you
>    can change your baseline any way you please.
> 
>    So it does NOT have to track any particular state in either the object 
>    database _or_ in your actual current working tree. In fact, all real 
>    interactions with "git" are really about updating this staging area one 
>    way or the other: you might check out the state from it into your 
>    working area (partially or fully), you can push your working area into 
>    the staging area (again, partially or fully).
> 
>    And if you want to, you can write the thing that the staging area 
>    represents as a "tree" into the object database, or you can merge a 
>    tree from the object database into the staging area.
> 
>    In other words: the staging area aka "current directory cache" is 
>    really how all interaction takes place. The object database never 
>    interacts directly with your working directory contents. ALL 
>    interactions go through the current directory cache.
> 
> I started to have more doubts on the approach of *not*
> performing the merge in the dircache I set up specifically for
> merging, which is the direction in which you are pushing if I
> understand you correctly.  Maybe I completely misunderstand what
> you want.  This message is long but I need a clear understanding
> of what is expected to be useful to you, so please bear with me.



> PB> 	merge-tree.pl -b $base $(tree-id) $merged | parse-your-output
> 
> Please help me understand this example you have given earlier.
> Here is my understanding of your assumption when the above
> pipeline takes place.  Correct me if I am mistaken.
> 
>  * The user is in a working directory $W.  It is controlled by
>    git-tools and there are $W/.git/. directory and $W/.git/index
>    dircache.
> 
>  * The dircache $W/.git/index started its life as a read-tree
>    from some commit.  The git-tools is keeping track of which
>    commit it is somewhere, presumably in $W/.git/ directory.
>    Let's call it $C (commit).
> 
>  ? Question.  Is the $(tree-id) in your example the same as $C
>    above?

Yes. Actually $(tree-id) returns ID of the tree object, not the commit
object; but that doesn't matter here, probably - let's ignore that
distinction for simplicity.

>  * The user have run [*1*] (see Footnote below) checkout-cache
>    on $W/.git/index some time in the past and $W is full of
>    working files.  Some of them may or may not have modified.
>    There may be some additions or deletions.  So the contents of
>    the working directory may not match the tree associated with
>    $C.
> 
>  * The user may or may not have run [*1*] update-cache in $W.
>    The contents of the dircache $W/.git/index may not match the
>    tree associated with $C.
> 
>  ? Question.  Are you forbidding the user to run update-cache by
>    hand, and keeping track of the changes yourself, to be
>    applied all at once at "git commit" time, thereby
>    guaranteeing the $W/.git/index to match the tree associated
>    with $C all times?  From the description of The "GIT toolkit"
>    section in README, it is not clear to me which part of his
>    repository an end user is not supposed to muck with himself.

Ideally, he shouldn't be using *any* of the low-level plumbing by now.
The only exception is update-cache --refresh, which he can do at will
(I'm yet thinking what to do with it :-).

The git-tools always assume that index basically contains the state as
of the last commit. (Actually the only time when this matters *now*
might be git diff - the user would get confused from the results.)

>  * Now the user has some changes in his working directory and
>    notices upstream or a side branch has notable changes
>    desireble to be picked up.  So he runs some git-tools command
>    to cause the above quoted pipeline to run.
> 
>  ? Question.  Does $merged in your example mean such an upstream
>    or side branch?  Is $base in your example the common ancestor
>    between $C and $merged?

Correct.

*HOWEVER* what is not correct is that git-tools would let you merge in
your working directory while you have local changes there.

In the past, the merge would happen in your working tree, but git-tools
wouldn't let you go for it unless your working tree has no local
changes. It would complain loudly and refuse to, since it's *not* what
you want to do and it was most likely a mistake.

Currently, git merge just creates a ,,merge/ subdirectory sharing the
object database with your working tree, but with an independent checkout
of it; it will do the merge there, and when you commit it there, it will
update your working tree with the merged changes.

I'm describing both behaviors since I might revert back to the first
one, based on what (if anything) will Linus reply to my mail about
out-of-tree merges.

But either way, when a merge is about to happen upon us, the working
tree is "clean".

> Assuming that my above understanding of your model is correct,
> here are my "thinking aloud".
> 
>  - "merge-trees $base $C $merged" looks only at the git object
>    database for those three trees named.  The data structure of
>    git object database is optimized to distinguish differences
>    in those recorded trees (and hence recorded blobs they point
>    at) without unpacking most of the files if the changes are
>    small, because all the blobs involved are already hashed.  It
>    is not very good at comparing things in git object store and
>    working files in random states, which would involve unpacking
>    blobs and comparing, so "merge-trees" does not bother.
> 
>  - What can come out from merge-trees is therefore one of the
>    following for each path from the union of paths contained in
>    $base, $C, and $merged:
> 
>    (a) Neither $C nor $merged changed it --- merge result is what
>        is in $C.

(Or in $base, if you don't want to give $C "unfair advantage", since it
does not matter. ;-)

>    (b) $C changed it but $merged did not --- merge result is what
>        is in $C.
> 
>    (c) Both $C and $merged changed it in the same way --- merge
>        result is what is in $C.
> 
>    (d) $C did not change it but $merged did --- merge result is
>        what is in $merged.
> 
>    (e) Both $C and $merged changed it differently --- merge is
>        needed and automatically succeeds between $C and $merge.
> 
>    (f) Both $C and $merged changed it differently --- merge is
>        needed but have conflicts.
> 
>  - Assuming we are dealing with the case where working files are
>    dirty and do not match what is in $C, among the above,
>    (a)-(c) can be ignored by SCM.  What the user has in his
>    working files is exactly what he would have got if he started
>    working from the merge result, although in reality the work
>    was started from $C.

Yes. Actually they can be ignored by git-tools in any case since what is
in the directory cache is $C. So it never needs to do any special
action.

>    Handling (d), (e) and (f) from SCM's point of view would be
>    the same.  They all involve 3-way merges between the file in
>    the working directory, and the file from $merged, pivoting on
>    the file from $base.  In order to help SCM, merge-trees
>    therefore should output SHA1 of blobs for such a file from
>    $base and $merged and expect SCM to run "cat-file blob" on
>    them and then merge or diff3.  Up to the point of giving
>    those two SHA1 out is the business of merge-trees and after
>    that it is up to SCM.
> 
>    That would work.  So I should base the design of output from
>    merge-trees on the above analysis, which probably needs to be
>    extended to cover differences between creation, modification,
>    and deletion.

Yes, it sounds sensible.

Actually, you don't even need to make $C more special than $merged; I
can filter out only the $merged changes on the SCM level. I guess that
would add no complexity to your tool and make it usable even for more
exotic kinds of merges (like the floating-in-the-void merge of two
"equally important" trees).

>  - However, the above is quite different from the way Linus
>    envisioned initially, on which my current implementation is
>    based [*3*].
> 
>    My current implementation is to record the merge outcome in
>    the temporary dircache $W/,,merge/.git/index for cases
>    (a)-(e).  The last case (f) is problematic and needs human
>    validation [*2*], so it is not recorded in that temporary
>    dircache, but the files to be merged are left in that
>    temporary directory and merge-trees stops there.  It is
>    expected that the end-user or SCM would merge the resulting
>    file and run update-cache to update $W/,,merge/.git/index.
>    After that happens, $W/,,merge/.git/index has the tree
>    representing the desired result of the merge.  It is expected
>    that the end-user or SCM would write-tree, commit-tree there
>    in the temporary directory, creating a new commit $C1.
> 
>    Then, it is expected that the SCM would make a patch file
>    between $C and the user working directory, checks out $C1
>    (either in the user's working directory or another temporary
>    directory; at this point merge-trees does not care because it
>    has already done its job and exited), applies that patch to
>    bring the user edits over to $C1.  Then that directory would
>    contain the desired merge of user edits.
> 
>    That is my understanding of how Linus originally wanted the
>    tool to do his kernel work with to work.  My hesitation to
>    suggestions from you to change it not to keep its own merge
>    dircache is coming from here.  Not doing what I am currently
>    doing to $W/,,merge/.git/index dircache would mean that SCM
>    would have to do more, not less, to arrive at $C1 (the result
>    of the clean $merge and $C merge pivoted at $base), where the
>    real SCM merge begins.

Well. Currently, apart from the directory cache part, I do it like you
describe. I create a new directory, after commit I apply the diff back
to the original tree etc.

The only problem is really the dircache, and that's because it would be
done totally differently than in the original tree, and I would
unnecessarily have to introduce crowds of special cases to my tools in
order for them to be usable in the merge tree (I call the ",,merge"
temporary directory a "merge tree").

And the user would still lose the capability of easily seeing the
changes being committed. I admit that I'm using this largely as an
excuse and there *could* be a tool made which would compare the given
tree with the cache, but it would be clumsy to use, violate Linus' "ALL
interactions go through the current directory cache" paradigm (whew, the
first time in my life I used this word), and we could do just fine with
our current tools.

> Although I suspect I am misunderstanding what you want, your
> messages so far suggest that what you want might be quite
> different from what Linus wants.  Please do not misunderstand
> what I mean by saying this.  I am not saying that Linus is
> always right [*4*] and therefore you are wrong for wanting
> something else.  It is just that, if what I started writing
> needs to support both of those quite different needs, I need to
> know what they are.  I think I understand what Linus wants well
> enough [*5*], but I am not certain about yours.

I can't see the conflicts between what I want and what Linus wants.
After all, Linus says that I can use the directory cache in any way I
please (well, the user can, but I'm speaking for him ;-). So I'm doing
so, and with your tool I would get into problems, since it is suddenly
imposing a policy on what should be in the index.

..snip..
> *2* Strictly speaking, case (e) needs human validation as
> well, because successful textual merge does not guarantee
> sensible semantic merge.
..snip..

Actually, I think _all_ the caches should make the human validation
_possible_ (by showing the diff of what would be merged), and it is
trivial to do so by having pristine index.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
