From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recent unresolved issues: shallow clone
Date: Fri, 14 Apr 2006 17:25:12 -0700
Message-ID: <7vr73zn0rb.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<87irpb7oma.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 02:25:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUYbL-0002b1-4n
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 02:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWDOAZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 20:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWDOAZQ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 20:25:16 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:10139 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751446AbWDOAZO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 20:25:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415002514.GGWJ20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 20:25:14 -0400
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87irpb7oma.wl%cworth@cworth.org> (Carl Worth's message of "Fri,
	14 Apr 2006 15:56:29 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18713>

Carl Worth <cworth@cworth.org> writes:

> On Fri, 14 Apr 2006 02:31:36 -0700, Junio C Hamano wrote:
>>   I am beginning to think using "graft" to cauterize history
>>   for this, while it technically would work, would not be so
>>   helpful to users, so the design needs to be worked out again.
>
> As context, here is some of what you mentioned in IRC:
>
>>>	Suppose you have this:
>>>
>>>	A---B---C
>>>	 \       \ 
>>>	  D---E---F---G
>>>	 
>>>	and you made a shallow clone of C (because that is where the
>>>	upstream master was when you made that clone).  Then the
>>>	upstream updated the master branch tip to G.
>>>
>>>	The next update from upstream to your shallow clone would break.
>>>	The upstream says: I have G at master.
>>>	You say: I want G then.  By the way, I have C.
>>>
>>>	What it means to tell the other end "I have X" is to promise
>>>	that you have X and _everything_ behind it.  So the upstream
>>>	would send objects necessary to complete D, E, F and G for
>>>	"somebody who already have A and B".  As a consequence, you
>>>	would not see A nor B.
>>>
>>>	Even if the only thing you are interested in is to be in sync
>>>	with the tip of the upstream, you can end up with an
>>>	incomplete tree for G, if some of the blobs or trees contained
>>>	in G already exist in A or B.  They are not sent -- because
>>>	you told the upstream that you have everything necessary to
>>>	get to C.
>
> So that's an argument against using a cauterizing graft for the
> shallow clone of C. It definitely confuses the existing protocol to
> say "I have C" if I have only a cauterized C, (its tree only, but none
> of the commits that should be backing C).

That's what I meant by "graft technically works but is
inconvenient". 

Maybe after the update to G happens (which means you now have C,
F, G but not A B D E commits), the client side could enumerate
commits on "rev-list ^C G" and cauterize the ones with missing
parents (in this case, F does not have one of its parents).
While doing this would help keeping the resulting commit
ancestry sane, it does not solve the problem of missing blobs
and trees.  See below.

> So, in the scenario above, the original shallow clone of C would be:
>
> 	Want C->tree, have nothing.
>
> and the later shallow update to G would be:
>
> 	Want G->tree, have C->tree

When you ask for G, you do not know what G^{tree} is, so that is
fantasy without a protocol extention.  To solve the missing
blobs/trees problem we would probably need a protocol extention
that says it wants to receive enough data to complete trees and
blobs associated with the commits being sent _without_ assuming
the recipient has any trees or blobs other than what are
contained in "have" commits.  Then after such a successful
transfer, missing parents of commits listed in "rev-list ^C G"
are the ones from the side branch, so the client can cauterize
them (F in the above example) appropriately without bothering
the server.

However, I think this "do not assume I have any trees behind the
commits I explicitly say I have" must be an option, because it
makes the resulting transfer unnecessarily more expensive for
normal uses.  A fetch of the Linux kernel once a day would
update about a couple of hundered commits, each of which touches
only 3 paths on average (so that would be 600 files out of
18,000 file tree.  When side-branch merges are involved, usually
many things in G (and F) are unchanged since either A or C, but
the extention we are discussing forbids reusing what are found
in A (it still allows reusing what are found in C).

> A final step of a shallow clone would then require creating a new
> parent-less commit object so that there's something to point refs/head
> at, (or maybe rather than being parentless, they could be chained
> together with each update?).

Rewriting commit objects transferred to the cloner is something
you would _not_ want to do (e.g. rewriting F commits to say it
has only one parent C).  The history based on that would diverge
from parents and would become unmergeable.  It is cleaner to
just make a new graft entry to say "As far as this repository is
concerned, F has one parent C".  Shallowness of the repository
and its slightly different view of history is a local matter.
