From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Fri, 17 Aug 2012 11:34:27 +0200
Message-ID: <874no1hnfg.fsf@thomas.inf.ethz.ch>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
	<877gt16ewe.fsf@thomas.inf.ethz.ch>
	<7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
	<87sjbpa5m8.fsf@thomas.inf.ethz.ch>
	<7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
	<CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com>
	<7vipcj2w9f.fsf@alter.siamese.dyndns.org>
	<7vehn72vyl.fsf@alter.siamese.dyndns.org>
	<87pq6rw77l.fsf@thomas.inf.ethz.ch> <502CC4E7.5060508@alum.mit.edu>
	<87k3wzujuy.fsf@thomas.inf.ethz.ch>
	<7v628i3jiu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 11:34:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Iwv-000830-7C
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 11:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab2HQJeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 05:34:31 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:46859 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645Ab2HQJea (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 05:34:30 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 17 Aug
 2012 11:34:24 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 17 Aug
 2012 11:34:27 +0200
In-Reply-To: <7v628i3jiu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 16 Aug 2012 09:10:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203607>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> The right fix would be to dig up Peff's work on generation number
>> caching, and modify the algorithm to take generation numbers into
>> account.
>
> I think you are totally wrong here, unless you are talking about a
> generation number that is different from what I recall from the
> older discussion.

Hrm, now you're making me feel like I missed something.  But my
reasoning goes roughly like this.

Consider the commit graph as a DAG, where the parent pointers are
directed edges from child to parent.  Thus, tip commits are sources and
root commits are sinks.  One way to get a valid topo ordering, knowing
the complete DAG, is:

  while there are vertices left:
    remove any source and emit it

(You can also generate it from the sinks instead; I haven't actually
checked what the code currently does.  But for the following, we need to
start from the sources.)

To implement this efficiently, one usually keeps track of the set S of
sources, and inserts vertices that (by removal of their last
in-neighbour) have become a source.

The distinction between topo-order and date-order is the preference
given in the choice of source.  IIUC, date-order prefers the newest
source by committer date (using a priority queue or such for S), and
topo-order prefers the source(s) which were parents of the vertex
removed in the previous iteration (using a stack for S).

The problem with this algorithm is that it requires knowledge of the
DAG[1].  So with --topo-order, git dutifully loads the whole commit
graph, and then runs the algorithm, leading to the discussed startup
delay.

However, suppose we knew generation numbers.  I haven't actually looked
into the old threads again, but my understanding was that they are
numbers g(C) attached to each commit C such that

  g(C) = 1 + max(g(P) for P a parent of C)   for non-root commits

  g(C) = 0                                   for root commits

They are invariant given the commit, so they can be cached.  And they
allow us to infer something about ancestry: if g(C)<=g(D), then C cannot
possibly be a descendant of D.

The topo order algorithm can be modified to take advantage of them, in
order to provide incremental processing:

  Let S be the set of tentative sources

  Let U be the set of vertices whose out-edges are no known yet
    (i.e., the set of commits which haven't been loaded yet)

  Let max g(U) denote "max g(C) taken over all C in U".

  Fill S and U from the revisions given:
    load all positive revisions, let's call this set P
    put all zero-indegree members of P in S
    put all parents of members of P in U (as far as they are not also
    members of P, and therefore loaded already)

  while there are any vertices left:

    pick any tentative source C from S that we "want to emit"

    # Ascertain that no unknown commit (from U or further beyond) can be
    # a descendant of C
    while there is a D in U such that g(D) > g(C):
      load D
      remove D from U
      add the parents of D to U if they were not already loaded
      possibly remove some elements of S if their indegree became nonzero

    if C was removed from S:
      continue

    remove C from the graph and emit it

I hope I got that right.  The order of commits is still entirely
determined by the choice of "any tentative source", but the algorithm
should now stream nicely once the generation numbers are known.


Footnotes: 

[1] If there are any parent pointers not yet followed, they may in fact
wind up (over at least one more commit) pointing to the commit you
wanted to emit next, making that an invalid choice.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
