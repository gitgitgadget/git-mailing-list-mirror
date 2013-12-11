From: Paulo Matos <paulo@matos-sorge.com>
Subject: Re: Unexpected cherry-pick behaviour
Date: Wed, 11 Dec 2013 11:19:34 +0000
Message-ID: <beee32a53ece8b839578703deb851eaa@matos-sorge.com>
References: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com>
 <xmqqvbywts9d.fsf@gitster.dls.corp.google.com>
 <7050e7272bb83d083a56a2c391228ed8@matos-sorge.com>
 <CALWbr2zPPnDiv7oVBhnM9dSW=pfz2jUA_A5u_gk2ttgXTStvkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	git-owner@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 12:19:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqhpN-0001fx-S2
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 12:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860Ab3LKLTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 06:19:37 -0500
Received: from matos-sorge.com ([176.58.118.32]:58882 "EHLO
	centauri.matos-sorge.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751623Ab3LKLTg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Dec 2013 06:19:36 -0500
Received: from mail.matos-sorge.com (localhost [127.0.0.1])
	by centauri.matos-sorge.com (Postfix) with ESMTP id 00A8271C701;
	Wed, 11 Dec 2013 11:19:34 +0000 (GMT)
In-Reply-To: <CALWbr2zPPnDiv7oVBhnM9dSW=pfz2jUA_A5u_gk2ttgXTStvkw@mail.gmail.com>
X-Sender: paulo@matos-sorge.com
User-Agent: Roundcube Webmail/0.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239185>

On 11/12/2013 11:09, Antoine Pelisse wrote:
>> 
>> I don't know how to interpret the fact that the line you sent (with 
>> the
>> obvious --conflicts being --conflict) outputs nothing...
> 
> That is expected. git-checkout with this option [1] will reset the
> conflict on gcc/tree-ssa-threadedge.c file to the initial conflict
> state, and use the diff3 markers. You should have a new look at that
> file as you will now be able to see the "ancestor" in the conflict.
> 
> [1] You can have a look either at git-checkout manpage or here:
> http://git-scm.com/docs/git-checkout, especially --merge and
> --conflict options.
> --

Got it, but still not helpful as git is still modifying code out of the 
conflicting zone.

$ git checkout --conflict=diff3 tree-ssa-threadedge.c
$ git diff tree-ssa-threadedge.c
diff --cc gcc/tree-ssa-threadedge.c
index cb6accf,f022eed..0000000
--- a/gcc/tree-ssa-threadedge.c
+++ b/gcc/tree-ssa-threadedge.c
@@@ -936,34 -854,33 +936,57 @@@ thread_around_empty_blocks (edge taken_
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

++<<<<<<< ours
  +   Our caller is responsible for restoring the state of the expression
  +   and const_and_copies stacks.  */
++||||||| base
++  /* If E is a backedge, then we want to verify that the COND_EXPR,
++     SWITCH_EXPR or GOTO_EXPR at the end of e->dest is not affected
++     by any statements in e->dest.  If it is affected, then it is not
++     safe to thread this edge.  */
++  if (e->flags & EDGE_DFS_BACK)
++    {
++      if (cond_arg_set_in_bb (e, e->dest))
++      goto fail;
++    }
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
++>>>>>>> theirs

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

-- 
Paulo Matos
