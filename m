From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Fri, 17 Aug 2012 11:50:30 +0200
Message-ID: <87sjbletjt.fsf@thomas.inf.ethz.ch>
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
	<874no1hnfg.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 11:50:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2JCS-0003JZ-6x
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 11:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833Ab2HQJue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 05:50:34 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:2727 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756423Ab2HQJud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 05:50:33 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 17 Aug
 2012 11:50:29 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 17 Aug
 2012 11:50:30 +0200
In-Reply-To: <874no1hnfg.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
	"Fri, 17 Aug 2012 11:34:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203608>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> The topo order algorithm can be modified to take advantage of
> [generation numbers], in order to provide incremental processing:
>
>   Let S be the set of tentative sources
>
>   Let U be the set of vertices whose out-edges are no known yet
>     (i.e., the set of commits which haven't been loaded yet)
[...]
>   while there are any vertices left:
>
>     pick any tentative source C from S that we "want to emit"
>
>     # Ascertain that no unknown commit (from U or further beyond) can be
>     # a descendant of C
>     while there is a D in U such that g(D) > g(C):
>       load D
>       remove D from U
>       add the parents of D to U if they were not already loaded
>       possibly remove some elements of S if their indegree became nonzero
>
>     if C was removed from S:
>       continue
>
>     remove C from the graph and emit it

By the way, this does bump the runtime of the algorithm a bit, depending
on the data structure used for U.  Recall that ordinary topo-sort with a
stack for S (i.e., --topo-order) runs linearly with the number of
vertices.

If we use a priority queue for U, which lets us get at the
highest-generation unknown commits easily, it potentially goes to n log n 
if U reaches linear size at some point.

That shouldn't hurt too much of course, since on the one hand it should
rarely actually get that big, and OTOH --date-order has n log n runtime
anyway (using a priority queue for S).

Thanks for challenging me on my "it should work" feeling.  It was quite
interesting to actually think it through and write down a workable
algorithm.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
