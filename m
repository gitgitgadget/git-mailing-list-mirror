From: Paulo Matos <paulo@matos-sorge.com>
Subject: Unexpected cherry-pick behaviour
Date: Tue, 10 Dec 2013 11:04:16 +0000
Message-ID: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 10 12:10:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqLDK-0007QN-H0
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 12:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403Ab3LJLKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 06:10:50 -0500
Received: from matos-sorge.com ([176.58.118.32]:56864 "EHLO
	centauri.matos-sorge.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751805Ab3LJLKt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Dec 2013 06:10:49 -0500
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2013 06:10:49 EST
Received: from mail.matos-sorge.com (localhost [127.0.0.1])
	by centauri.matos-sorge.com (Postfix) with ESMTP id C543271C701
	for <git@vger.kernel.org>; Tue, 10 Dec 2013 11:04:16 +0000 (GMT)
X-Sender: paulo@matos-sorge.com
User-Agent: Roundcube Webmail/0.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239135>

Hi,

I have installed latest 1.8.5.1 git to confirm the behaviour I had seen 
in previous versions.

What I see is that when I cherry-pick a patch across two branches 
(source and destination) in a repository, cherry-pick picks changes from 
the source branch which do not exist in the cherry-picked patch.

To reproduce please follow the following in a clean directory (apologies 
for the large repo I use as example):
$ git clone git://gcc.gnu.org/git/gcc.git
$ cd gcc
$ git checkout -b gcc-4_8-branch origin/gcc-4_8-branch
$ cd gcc
$ sed -i '877i myport_hook ()' tree-ssa-threadedge.c
$ git diff tree-ssa-threadedge.c
index b31e961..f022eed 100644
--- a/gcc/tree-ssa-threadedge.c
+++ b/gcc/tree-ssa-threadedge.c
@@ -874,6 +874,7 @@ thread_across_edge (gimple dummy_cond,
        if (cond_arg_set_in_bb (e, e->dest))
         goto fail;
      }
+myport_hook ()

    stmt_count = 0;
$ git add tree-ssa-threadedge.c
$ git commit -m 'cherry-pick test'
[gcc-4_8-branch 49a2b7f] cherry-pick test
  1 file changed, 1 insertion(+)
$ git checkout master
$ git cherry-pick 49a2b7f # ensure you're cherry-picking the right sha
error: could not apply 49a2b7f... cherry-pick test
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'
$ git diff tree-ssa-threadedge.c
diff --cc gcc/tree-ssa-threadedge.c
index cb6accf,f022eed..0000000
--- a/gcc/tree-ssa-threadedge.c
+++ b/gcc/tree-ssa-threadedge.c
@@@ -936,34 -854,33 +936,47 @@@ thread_around_empty_blocks (edge taken_
      STACK is used to undo temporary equivalences created during the 
walk of
      E->dest.

  -   SIMPLIFY is a pass-specific function used to simplify statements.  
*/
  -
  -void
  -thread_across_edge (gimple dummy_cond,
  -                  edge e,
  -                  bool handle_dominating_asserts,
  -                  vec<tree> *stack,
  -                  tree (*simplify) (gimple, gimple))
  -{
  -  gimple stmt;
  +   SIMPLIFY is a pass-specific function used to simplify statements.

++<<<<<<< HEAD
  +   Our caller is responsible for restoring the state of the expression
  +   and const_and_copies stacks.  */
++=======
+   /* If E is a backedge, then we want to verify that the COND_EXPR,
+      SWITCH_EXPR or GOTO_EXPR at the end of e->dest is not affected
+      by any statements in e->dest.  If it is affected, then it is not
+      safe to thread this edge.  */
+   if (e->flags & EDGE_DFS_BACK)
+     {
+       if (cond_arg_set_in_bb (e, e->dest))
+       goto fail;
+     }
+ myport_hook ()
++>>>>>>> 49a2b7f... cherry-pick test

  -  stmt_count = 0;
  +static bool
  +thread_through_normal_block (edge e,
  +                           gimple dummy_cond,
  +                           bool handle_dominating_asserts,
  +                           vec<tree> *stack,
  +                           tree (*simplify) (gimple, gimple),
  +                           vec<jump_thread_edge *> *path,
  +                           bitmap visited,
  +                           bool *backedge_seen_p,
  +                           bitmap src_map,
  +                           bitmap dst_map)
  +{
  +  /* If we have traversed a backedge, then we do not want to look
  +     at certain expressions in the table that can not be relied upon.
  +     Luckily the only code that looked at those expressions is the
  +     SIMPLIFY callback, which we replace if we can no longer use it.  
*/
  +  if (*backedge_seen_p)
  +    simplify = dummy_simplify;

     /* PHIs create temporary equivalences.  */
  -  if (!record_temporary_equivalences_from_phis (e, stack))
  -    goto fail;
  +  if (!record_temporary_equivalences_from_phis (e, stack, 
*backedge_seen_p,
  +                                              src_map, dst_map))
  +    return false;

     /* Now walk each statement recording any context sensitive
        temporary equivalences we can detect.  */


Note how there are changes that are not part of the cherry-picked patch 
outside of the conflicting zone. This is trouble some because it means 
that when I go in to fix a patch and look only at the conflicting zone, 
I will have code outside the zone, that are _not_ part of the patch 
modified as well.

Is this a bug or a feature? If the latter, why this behaviour and how 
can I avoid it?

Cheers,

-- 
Paulo Matos
