From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (1b)] merge-recursive.c: Add more generic
 merge_recursive_generic()
Date: Wed, 13 Aug 2008 14:45:22 -0700
Message-ID: <7vljz0lhcd.fsf@gitster.siamese.dyndns.org>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org>
 <1218572040-23362-1-git-send-email-s-beyer@gmx.net>
 <alpine.LNX.1.00.0808122309460.19665@iabervon.org>
 <20080813172938.GC12871@leksak.fem-net>
 <alpine.LNX.1.00.0808131333230.19665@iabervon.org>
 <7v3al8ofjw.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808131559060.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 23:46:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTOAw-0003J1-Ge
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 23:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbYHMVpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 17:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbYHMVpe
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 17:45:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYHMVpd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 17:45:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 19DB354C9C;
	Wed, 13 Aug 2008 17:45:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 11BF954C9B; Wed, 13 Aug 2008 17:45:24 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0808131559060.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 13 Aug 2008 16:36:36 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 260A0BE6-6981-11DD-88B5-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92281>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Maybe merge_trees should get the two sides as structs with a struct tree * 
> and a char * branch name, and the struct could someday get optional struct 
> commit *s for the lineage of the side if somebody comes up with a method 
> for merging that makes use of the component changes.

I do agree with you that with some ancestry-based hinting the "find
renames" part of merge_trees() postprocessing can do a better job than the
current code.  Contrary to a widespread misconception we often hear on
this list and on #git, merge-recursive detects renames solely by looking
at the three endpoints.  Some people incorrectly recommend "commit a pure
rename, then commit modifications to the renamed path"; such an artificial
split would not at all help merging histories with renames if the
modification made after renames are too great.

Suppose you have this history, where upper branch renames a path and
modifies the contents in the renamed path in commits X, Y and Z.  You
would want to merge the history leading to B to your HEAD, A, to create a
merge M:

            X---Y---Z---B              X---Y---Z---B  
           /                ===>      /             \
       ---O---o---o---A           ---O---o---o---A---M    

Maybe the rename done between O and X were pure enough that "diff-tree -M
O X" would have found it, but commits Y, Z, or B changed the contents of
the renamed path too greatly for "diff-tree -M O B" to notice the rename
anymore.  "git merge B" when you are at A will not find such a rename, but
if we allowed rename detection stepwise to look at "diff-tree -M" for
(O,X), (X,Y), (Y,Z), (Z,B), (and the same for history between O and A), we
might be able to find renames better [*1*].

Suppose instead of merging the whole history leading to B, you would want
to apply the small fix made with Y on top of A:

            X---Y---Z---B              X---Y---Z---B   
           /                ===>      /                
       ---O---o---o---A           ---O---o---o---A---Y'

You would "checkout A && cherry-pick Y" which amounts to three-way merge
using X as "common", A as "mine" and Y as "his", which is the moral
equivalent of:

	read-tree -m -u X A Y

but with rename detection.  merge_trees(A, Y, X) could traverse ancestry
between X and A to find O and figure out where in A the paths that are
affected in diff(X,Y) appear by making pairwise "diff-tree -M" to go from
X back to O and then forward to A to find out that where the paths touched
by Y were originally in O and where they are in A.

But you are assuming that "common" and "ours" have any ancestry
relationship.  You generally cannot.

The most extreme case is "am -3" where both "common" and "theirs" are pure
trees without any ancestry relationship to anything else.  They are built
by looking at the "index" lines contained in the patch and contain only
those paths that are affected by the patch, and the merge machinery merges
that change into arbitrary "ours".

You can cherry-pick a change C from history that does not have any common
ancestor with your history leading to "ours" ("common"=C^ and "theirs"=C
in this case), and the same applies to revert of C ("common"=C and
"theirs"=C^).  "rebase --onto A C^ C" works the same way.

So this "extra ancestry information to help rename discovery" can at most
be a hint.

More importantly, all of the above does not have anything to do with the
"recursiveness" of merge-recursive (which is the difference between
merge_trees() and merge_recursive()) at all.  So I am still correct to say
that "cherry-pick", "revert", "checkout -m", "am -3" and "stash apply"
should use the merge_trees() interface, not the recursive one.

[Footnote]

*1* But that would be quite more expensive than what we currently do, and
it only deals with an uninteresting special case of wholesale file rename.

I suspect if we ever do the stepwise thing, we would be better off doing
not "diff-tree -M" but "blame -C" to really find where the lines affected
between O and B ended up in A, and apply the change there.
