From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 03:22:26 -0700
Message-ID: <7vwtr4ibkt.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	<7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	<7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 12:20:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMNuu-0001ZA-Jh
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 12:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVDOKWm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 06:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVDOKWm
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 06:22:42 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:22452 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261799AbVDOKW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 06:22:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415102227.FJSH1497.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 06:22:27 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050414233159.GX22699@pasky.ji.cz> (Petr Baudis's message of
 "Fri, 15 Apr 2005 01:31:59 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

After I re-read [*R1*], in which Linus talks about dircache,
especially this section:

 - The "current directory cache" describes some baseline. In particular,
   note the "some" part. It's not tied to any special baseline, and you
   can change your baseline any way you please.

   So it does NOT have to track any particular state in either the object 
   database _or_ in your actual current working tree. In fact, all real 
   interactions with "git" are really about updating this staging area one 
   way or the other: you might check out the state from it into your 
   working area (partially or fully), you can push your working area into 
   the staging area (again, partially or fully).

   And if you want to, you can write the thing that the staging area 
   represents as a "tree" into the object database, or you can merge a 
   tree from the object database into the staging area.

   In other words: the staging area aka "current directory cache" is 
   really how all interaction takes place. The object database never 
   interacts directly with your working directory contents. ALL 
   interactions go through the current directory cache.

I started to have more doubts on the approach of *not*
performing the merge in the dircache I set up specifically for
merging, which is the direction in which you are pushing if I
understand you correctly.  Maybe I completely misunderstand what
you want.  This message is long but I need a clear understanding
of what is expected to be useful to you, so please bear with me.

PB> 	merge-tree.pl -b $base $(tree-id) $merged | parse-your-output

Please help me understand this example you have given earlier.
Here is my understanding of your assumption when the above
pipeline takes place.  Correct me if I am mistaken.

 * The user is in a working directory $W.  It is controlled by
   git-tools and there are $W/.git/. directory and $W/.git/index
   dircache.

 * The dircache $W/.git/index started its life as a read-tree
   from some commit.  The git-tools is keeping track of which
   commit it is somewhere, presumably in $W/.git/ directory.
   Let's call it $C (commit).

 ? Question.  Is the $(tree-id) in your example the same as $C
   above?

 * The user have run [*1*] (see Footnote below) checkout-cache
   on $W/.git/index some time in the past and $W is full of
   working files.  Some of them may or may not have modified.
   There may be some additions or deletions.  So the contents of
   the working directory may not match the tree associated with
   $C.

 * The user may or may not have run [*1*] update-cache in $W.
   The contents of the dircache $W/.git/index may not match the
   tree associated with $C.

 ? Question.  Are you forbidding the user to run update-cache by
   hand, and keeping track of the changes yourself, to be
   applied all at once at "git commit" time, thereby
   guaranteeing the $W/.git/index to match the tree associated
   with $C all times?  From the description of The "GIT toolkit"
   section in README, it is not clear to me which part of his
   repository an end user is not supposed to muck with himself.

 * Now the user has some changes in his working directory and
   notices upstream or a side branch has notable changes
   desireble to be picked up.  So he runs some git-tools command
   to cause the above quoted pipeline to run.

 ? Question.  Does $merged in your example mean such an upstream
   or side branch?  Is $base in your example the common ancestor
   between $C and $merged?

Assuming that my above understanding of your model is correct,
here are my "thinking aloud".

 - "merge-trees $base $C $merged" looks only at the git object
   database for those three trees named.  The data structure of
   git object database is optimized to distinguish differences
   in those recorded trees (and hence recorded blobs they point
   at) without unpacking most of the files if the changes are
   small, because all the blobs involved are already hashed.  It
   is not very good at comparing things in git object store and
   working files in random states, which would involve unpacking
   blobs and comparing, so "merge-trees" does not bother.

 - What can come out from merge-trees is therefore one of the
   following for each path from the union of paths contained in
   $base, $C, and $merged:

   (a) Neither $C nor $merged changed it --- merge result is what
       is in $C.

   (b) $C changed it but $merged did not --- merge result is what
       is in $C.

   (c) Both $C and $merged changed it in the same way --- merge
       result is what is in $C.

   (d) $C did not change it but $merged did --- merge result is
       what is in $merged.

   (e) Both $C and $merged changed it differently --- merge is
       needed and automatically succeeds between $C and $merge.

   (f) Both $C and $merged changed it differently --- merge is
       needed but have conflicts.

 - Assuming we are dealing with the case where working files are
   dirty and do not match what is in $C, among the above,
   (a)-(c) can be ignored by SCM.  What the user has in his
   working files is exactly what he would have got if he started
   working from the merge result, although in reality the work
   was started from $C.

   Handling (d), (e) and (f) from SCM's point of view would be
   the same.  They all involve 3-way merges between the file in
   the working directory, and the file from $merged, pivoting on
   the file from $base.  In order to help SCM, merge-trees
   therefore should output SHA1 of blobs for such a file from
   $base and $merged and expect SCM to run "cat-file blob" on
   them and then merge or diff3.  Up to the point of giving
   those two SHA1 out is the business of merge-trees and after
   that it is up to SCM.

   That would work.  So I should base the design of output from
   merge-trees on the above analysis, which probably needs to be
   extended to cover differences between creation, modification,
   and deletion.

 - However, the above is quite different from the way Linus
   envisioned initially, on which my current implementation is
   based [*3*].

   My current implementation is to record the merge outcome in
   the temporary dircache $W/,,merge/.git/index for cases
   (a)-(e).  The last case (f) is problematic and needs human
   validation [*2*], so it is not recorded in that temporary
   dircache, but the files to be merged are left in that
   temporary directory and merge-trees stops there.  It is
   expected that the end-user or SCM would merge the resulting
   file and run update-cache to update $W/,,merge/.git/index.
   After that happens, $W/,,merge/.git/index has the tree
   representing the desired result of the merge.  It is expected
   that the end-user or SCM would write-tree, commit-tree there
   in the temporary directory, creating a new commit $C1.

   Then, it is expected that the SCM would make a patch file
   between $C and the user working directory, checks out $C1
   (either in the user's working directory or another temporary
   directory; at this point merge-trees does not care because it
   has already done its job and exited), applies that patch to
   bring the user edits over to $C1.  Then that directory would
   contain the desired merge of user edits.

   That is my understanding of how Linus originally wanted the
   tool to do his kernel work with to work.  My hesitation to
   suggestions from you to change it not to keep its own merge
   dircache is coming from here.  Not doing what I am currently
   doing to $W/,,merge/.git/index dircache would mean that SCM
   would have to do more, not less, to arrive at $C1 (the result
   of the clean $merge and $C merge pivoted at $base), where the
   real SCM merge begins.

Although I suspect I am misunderstanding what you want, your
messages so far suggest that what you want might be quite
different from what Linus wants.  Please do not misunderstand
what I mean by saying this.  I am not saying that Linus is
always right [*4*] and therefore you are wrong for wanting
something else.  It is just that, if what I started writing
needs to support both of those quite different needs, I need to
know what they are.  I think I understand what Linus wants well
enough [*5*], but I am not certain about yours.


[Footnotes]

*1* By "The user have run" I mean either the user directly used
the low-level plumbing command himself, or used git-tools to
cause such command to run.

*2* Strictly speaking, case (e) needs human validation as
well, because successful textual merge does not guarantee
sensible semantic merge.

*3* See [*R2*] for descriptions on the way Linus wanted merge
in git to happen.  Especially around "5) At this point you need
to MERGE" onwards.  The current implementation handles (or
attempts to handle) the `your working directory was fully
committed' case described there.

*4* According to Linus himself, he is always right ;-). [*R3*]

*5* I consider [*R1*] and [*R2*] essential read for anybody
wanting to understand merging operation in git object model (I
am saying this for others; not for Pasky --- it would be like
preaching to the choir ;-)).


[References]

*R1* <Pine.LNX.4.58.0504110928360.1267@ppc970.osdl.org>
http://marc.theaimsgroup.com/?i=%3CPine.LNX.4.58.0504110928360.1267%20()%20ppc970%20!%20osdl%20!%20org%3E

*R2* <Pine.LNX.4.58.0504121606580.4501@ppc970.osdl.org> 
http://marc.theaimsgroup.com/?i=%3CPine.LNX.4.58.0504121606580.4501%20()%20ppc970%20!%20osdl%20!%20org%3E

*R3*
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0008.3/0555.html

