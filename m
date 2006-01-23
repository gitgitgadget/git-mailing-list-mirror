From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on Subproject Support
Date: Sun, 22 Jan 2006 20:36:23 -0800
Message-ID: <7v7j8r7e7s.fsf@assigned-by-dhcp.cox.net>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601222104120.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 05:37:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0tS7-00010J-4T
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 05:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWAWEg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 23:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWAWEg0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 23:36:26 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31141 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932215AbWAWEgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 23:36:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060123043408.NRWZ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 Jan 2006 23:34:08 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15075>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> tree 04803b09c300c8325258ccf2744115acc4c57067
>
> Does this tree include trees for the bound projects?

Yes, this part has not been changed from earlier thoughts.

>> bind 5b2bcc7b2d546c636f79490655b3347acc91d17f linux-2.6/
>> bind 0bdd79af62e8621359af08f0afca0ce977348ac7 appliance/
>> author Junio C Hamano <junio@kernel.org> 1137965565 -0800
>> committer Junio C Hamano <junio@kernel.org> 1137965565 -0800

The tree 04803b...  tree has everything.  If you run git-ls-tree
on 04803b... would have a tree object recorded at linux-2.6, and
it is the same as the tree associated with the commit 5b2bcc...

> I think "cd linux-2.6 && git commit" should work for the subproject, too, 
> but that can be a later enhancement.

It's just a matter of Porcelain scripting, so that is probably
true.  However I do not want people to get too used to it and
expect "cd Documentation && git commit" to work in git.git
repository.

>> With the new `--subproject` option, the directory structure
>> rooted at `linux-2.6/` part is written out as a tree, and a new
>> commit object that records that tree object with the commit
>> bound to that portion of the tree (`5b2bcc7b` in the above
>> example) as its parent is created.
>
> And the commit is written to the index, in the special slot for the 
> subproject, replacing its parent, I assume.

Yes.  It would probably be done with `update-index --bind` to
update the bound subproject commit there.

>> Switching branches
>> ------------------
>> 
>> Along with the traditional two-way merge by `read-tree -m -u`,
>> we would need to look at:
>> 
>> . `bind` lines in the current `HEAD` commit.
>> 
>> . `bind` lines in the commit we are switching to.
>> 
>> . subproject binding information in the index file.
>> 
>> to make sure we do sensible things.
>
> This is one place I think storing the bindings in the commit is awkward. 
> read-tree deals in trees (hence the name), but will need information from 
> the commit.

That's why it is 'along with'.  Dealing with binding information
can be done between commits and index without bothering tree
objects.  read-tree would not have to deal with it, and I think
keeping it that way is probably a good idea.

In other words, I think the design so far does not require us to
touch tree objects at all, and I'd be happy if we do not have to.

One reason I started the bound commit approach was exactly
because I only needed to muck with commit objects and did not
have to touch trees and blobs; after trying to implement the
core level for "gitlink", which I ended up touching quite a lot
and have abandoned for now.

Here is an update to the still-WIP draft.

-- >8 --
Separate role of read-tree and update-index cleaner

The previous draft prematurely merged what read-tree --prefix
does with what update-index --bind would do.  Keep them separate
for now until we know what the common patterns would be.

Introduce 'update-index --unbind'.  We would probably need a new
command that extracts bind information out of index when we
start writing Porcelainish, but it is not specified yet.

Attempt to clarify what the "merging into subproject part" would
do a bit.  "git pull --subproject=" is fetch + merge, just like
the current subproject-unaware 'git pull' is.

---
diff --git a/Subpro.txt b/Subpro.txt
index 4036e71..837cab8 100644
--- a/Subpro.txt
+++ b/Subpro.txt
@@ -95,19 +95,22 @@ $ git bind-projects \
 	$gadget_commit appliance/
 ------------
 
-This would do an equivalent of:
+This would probably do an equivalent of:
 
 ------------
+$ rm -f "$GIT_DIR/index"
 $ git read-tree --prefix=linux-2.6/ $kernel_commit
 $ git read-tree --prefix=appliance/ $gadget_commit
+$ git update-index --bind linux-2.6/ $kernel_commit
+$ git update-index --bind appliance/ $gadget_commit
 ------------
 [NOTE]
 ============
 Earlier outlines sent to the git mailing list talked
 about `$GIT_DIR/bind` to record what subproject are bound to
-which subtree in the curent working tree and index.  This
+which subtree in the current working tree and index.  This
 proposal instead records that information in the index file
-when `--prefix=linux-2.6/` is given to `read-tree`.
+with `update-index --bind` command.
 
 Also note that in this round of proposal, there is no separate
 branches that keep track of heads of subprojects.
@@ -258,9 +261,11 @@ our branch, and redoing the merge (this 
 anyway).  It might go like this:
 
 ------------
-$ git bind-projects \
-	$kernel_commit kernel/ \
-	$gadget_commit gadget/
+$ git reset
+$ git update-index --unbind linux-2.6/
+$ git update-index --unbind appliance/
+$ git update-index --bind $kernel_commit kernel/
+$ git update-index --bind $gadget_commit gadget/
 $ git commit -m 'Prepare for merge with side branch'
 $ git merge 'Merge in a side branch' HEAD side
 error: the merged heads have subprojects bound at different places.
@@ -336,7 +341,55 @@ make a commit.
 
 [NOTE]
 This suggests that we would need to have something similar to
-`MERGE_HEAD` for merging the subproject part.
+`MERGE_HEAD` for merging the subproject part.  In the case of
+merging two toplevel project commits, we probably can read the
+`bind` lines from the `MERGE_HEAD` commit and either our `HEAD`
+commit or our index file.  Further, we probably would require
+that the latter two must match, just as we currently require the
+index file matches our `HEAD` commit before `git merge`.
 
+Just like the current `pull = fetch + merge` semantics, the
+subproject aware version `git pull \--subproject=frotz` would be
+a `git fetch \--subproject=frotz` followed by a `git merge
+\--subproject=frotz`.  So the above would be:
 
+. Fetch the head.
++
+------------
+$ git fetch --subproject=kernel/ git://git.kernel.org/.../linux-2.6/
+------------
++
+which would do:
+. fetch the commit chain from the remote repository.
+. write something like this to `FETCH_HEAD`:
++
+------------
+3ee68c4...\tfor-merge-into kernel/\tbranch 'master' of git://.../linux-2.6
+------------
+
+. Run `git merge`.
++
+------------
+$ git merge --subproject=kernel/ \
+    'Merge git://.../linux-2.6 into kernel/' HEAD 3ee68c4...
+------------
+
+. In case it does not cleanly automerge, `git merge` would write
+the necessary information for a later `git commit` to use in
+`MERGE_HEAD`.  It may look like this:
++
+------------
+3ee68c4af3fd7228c1be63254b9f884614f9ebb2	kernel/
+------------
+
+With this, a later invocation of `git commit` to record the
+result of hand resolving would be able to notice that:
+
+. We should be first resolving `kernel/` subproject.
+. The remote `HEAD` is `3ee68c4...` commit.
+. The merge message is `Merge git://.../linux-2.6 into kernel/`.
 
+and make a merge commit, and register that resulting commit in
+the index file using `update-index --bind` instead of updating
+*any* branch head (remember, we do not use separate branches to
+keep track of subproject heads anymore).
