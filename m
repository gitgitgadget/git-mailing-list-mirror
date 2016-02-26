From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/16] bisect: use a modified breadth-first search to find relevant weights
Date: Thu, 25 Feb 2016 19:09:54 -0800
Message-ID: <xmqqr3g0kvzx.fsf@gitster.mtv.corp.google.com>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
	<1456452282-10325-15-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 04:10:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ8n4-0003pp-Na
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 04:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbcBZDJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 22:09:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750767AbcBZDJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 22:09:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7FA6145CDB;
	Thu, 25 Feb 2016 22:09:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lhphyx+ha4iWehuAhlKkZt4rsec=; b=Fxp99Z
	TbzR4J8++t3N6DauEA77Tpgytbs/pzP/3OKMSzTdvIbBNGDHF1QHni/BGxY8ou44
	YCJOkhTWYLjStGnDw55tL8rfKZ65bBrQUK9BPDzpfRmHrnzVSUDLf2THX/fhELu8
	nU6kzfwRXieqt1nlXCauMDudcwmaaYhqhWv34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fG1alTcLanAbdipHVclxvEQd7bG70vJ4
	L3oVw2quY3FmxSYTf5tmNSZKCz+5aUvf6Os+ZQ7t3SxpukzYlseTeCSPARxXtY1x
	bwgJ12NqDwDRLUXr8vyh+Fpuz+0937/11+LcDTRSCFfBqnwnXv0CcehiucF/BGsW
	3YF6tRMd7yE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 774AF45CDA;
	Thu, 25 Feb 2016 22:09:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CAA8F45CD6;
	Thu, 25 Feb 2016 22:09:55 -0500 (EST)
In-Reply-To: <1456452282-10325-15-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Fri, 26 Feb 2016 03:04:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 69592D34-DC36-11E5-8972-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287535>

Stephan Beyer <s-beyer@gmx.net> writes:

> The idea is to reverse the DAG and perform a modified breadth-first search
> on it, starting on all sources of the reversed DAG.
> Before each visit of a commit, its weight is induced.
> This only works for non-merge commits, so the BFS stops prematurely on
> merge commits (that are collected in a list).
> Merge commits from that collection are considered for further visits
> as soon as all their parents have been visited.
> Their weights are computed using compute_weight().
> Each BFS walk ends when the computed weight is falling or halfway.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>
> In other words: walk the history up, compute the weight of each
> commit and stop when you know a better commit cannot follow.
>
> This way, the expensive "compute_weight()" function is not called
> on merge commits that will not help to find the maximum distance.

Interesting.  So you walk from the bottom commits, incrementing the
weight while walking on a part of the graph that is single strand of
pearls, or doing the "count the reachable ones the hard way" when
you hit a merge [*1*], but either way, once you know the commit you
are looking at is above the mid-way, i.e. reaches more than half of
the graph, then stop walking because its children will never be
better than that commit?

This is doubly clever idea [*2*].  It cuts the search space in half
for one thing, and more importantly, because "count the reachable
ones the hard way" counting has to traverse the graph from a merge
to the bottom boundary, the computation for a merge commit in the
more recent half of the history is more expensive than the
computation for a merge comit in the older half of the history, and
what you are avoiding is to waste the cycles on that more expensive
half.

I like it.

I haven't studied the code carefully, but your mention of BFS makes
me wonder if you can "narrow" down the search space even more.  In
an earlier step of the series, you introduced a work queue to
replace the recursion.  The recursion forces the algorithm to work
along the topology of the history, but you have more latitude in
selecting the commit to dig further with a work queue.

I wonder if you can sort the elements on the work queue based on
their distance (i.e. by using a priority queue).  You know the total
upfront, so you may find a commit whose weight is exactly half of it
before traversing all the bottom half of the history and it may turn
out to be even more efficient.  After all, you are only looking for
just one such commit, not trying to find all the commits with the
best weight.


[Footnote]

*1* A merge between a commit that reaches N commits and another that
reaches M commits may have weight smaller than the sum of N and M,
and that is why I left the original "truly stupid algorithm" Linus
wrote as-is when I did the obvious optimization for the linear parts
of the history.

*2* Whenever I revisited the bisection in my head, I thought about
ways to improve that "truly stupid" counting, but never thought
about an approach to simply reduce the number of times the "truly
stupid" counting has to be done.
