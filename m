From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2 6/6] limit "contains" traversals based on commit
 generation
Date: Fri, 15 Jul 2011 11:22:03 -0700
Message-ID: <7vpqlb1k1g.fsf@alter.siamese.dyndns.org>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070644.GF18566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 15 20:22:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhn1i-0000JC-GC
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 20:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864Ab1GOSWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 14:22:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892Ab1GOSWH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 14:22:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE6B03968;
	Fri, 15 Jul 2011 14:22:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xDLkU2fv9DxWDJmOmnPuUnl9mg8=; b=HtXuFk
	pwCiEty1mYXeXi4D02fyuuJfld0gfFS8wGUH2qy03fon/09mzVIWF+kqSTZO1NRN
	tIWXVzBL+FO2zpBF7H6bjLEqQt3cl686RpMGbwj766de+ZntZ1mESH4TtBO8KI4I
	darZakXJ9DPp2DX57nz/WjfipKv+LmDIg9wYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iBZ5N9Te7jeprvGCQRtjr0p4NIOA5Mw5
	7dWJOW2pcqgLyuFj/GLFocf2fSWz1hQH2u97Znd7ZOhVOEALPloSVzvK1QUH++5t
	2pQ+NE16ggYtdvEk1ZfoGk/HbCj/OkJM8G9avCvnzG0LbzxaGkH1KK0tSBfsuiQq
	HC1JGs08s+E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B289E3967;
	Fri, 15 Jul 2011 14:22:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FA093966; Fri, 15 Jul 2011
 14:22:05 -0400 (EDT)
In-Reply-To: <20110713070644.GF18566@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 13 Jul 2011 03:06:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57B1C694-AF0F-11E0-8CBF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177206>

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/tag.c b/builtin/tag.c
> index 63bce6e..df6de47 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -40,7 +40,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
>  }
>  
>  static int contains_recurse(struct commit *candidate,
> -			    const struct commit_list *want)
> +			    const struct commit_list *want,
> +			    unsigned long cutoff)
>  {
>  	struct commit_list *p;
>  
> @@ -57,9 +58,13 @@ static int contains_recurse(struct commit *candidate,
>  	if (parse_commit(candidate) < 0)
>  		return 0;
>  
> +	/* stop searching if we go too far back in time */
> +	if (commit_generation(candidate) < cutoff)
> +		return 0;
> +

Here, the "generation number" was the commit timestamp of the commit in
your earlier round, but now it is not.

I agree with Linus that for the purpose of "rev-list A ^B ^C" computation,
"generation number" is a much better thing to use than the commit
timestamp, and I also think if we want to revamp the codepath around
still_interesting() in revision.c, Linus's "let's add generation header in
new commits" is a good first step. I haven't stared at that codepath long
enough lately to say for sure, but I suspect that in that codepath we
could use generation number in commits when available and fall back to
timestamp with slop without recomputing the generation number and caching
for older commits.

But that is _not_ the codepath your series is about.

What you are trying to say in this series is that "If a tag points at a
commit X (i.e. candidate), another commit Y (i.e. "want") that is much
younger than cannot possibly be included by it, because a tag was made on
commit X way before Y was created". You cut off by "age".

The heuristics would work efficiently to check what tags point at a
relatively recent commit (e.g. when trying to see which releases are
affected and needing a fix by a recently discovered bug introduced by
commit Y) by discarding tags for ancient releases. In such a scenario, the
timestamp of a tagged and ancient commit X on a side branch that was never
merged in the mainline that leads to commit Y (i.e. "want"), in an ideal
world without clock skews, will be way older than the timestamp of commit
Y. In other words, if you use timestamp as "age", even though X and Y do
not relate to each other directly, except that they may share an ancient
common ancestor, their "age"s can be compared and you could apply your
heuristics to optimize.

But if you use the generation number as "age", even in an ideal world
without clock skew nor miscomputed generation number, you no longer can
compare "age" of X and Y.  The ancient side branch that led to X may have
tons more commits than the history leading to Y.

So I have two tangents here.

 * As to revision traversal, the reason we do the SLOP in
   still_interesting() is to avoid the issue arising from the following
   topology:

              5
             /
     ---2---4---...---1
         \
          3---6

   where numbers denote the timestamp of the commit (1 incorrectly records
   ancient timestamp, while everybody else has newer timestamp than its
   parents). When we try to "rev-list 5 --not 1 6", we start from having
   ~1, ~6 and 5 to "currently active" list, and iteratively pick more
   recent commits from the active list to dig deeper while newly found
   ancestors back to the active list. ~6 leads to 3 marked as
   uninteresting and active list gets ~3 while ~6 is removed. 5 leads to 4
   marked as interesting and 4 gets inserted in the list while 5 is
   removed. 4 finds 2 to also be interesting. Then ~3 finds 2 to be
   uninteresting. At that point, we have ~1 (still not processed) and ~2
   in the active list, while we have 5 and 4 in the result list. We need
   to dig through ~1 to realize that 4 is reachable from it to mark it
   uninteresting.

   So how about marking commits (using the metainfo-cache facility) that
   has an ancestor (not necessarily its direct parent) that records a
   younger timestamp (e.g. 1 is such a commit, as its ancestors include
   things like 2 and 4)? There should be relatively small number of them,
   and still_interesting() logic can be told to dig through such commits
   even if everybody is uninteresting in the active list.

 * As to "tag --contains", when timestamp based heuristics breaks down is
   when a tagged commit incorrectly records way young timestamp or the
   "want" commit records way old timetsamp. I haven't thought things
   through, but the same metainfo-cache may be useful to detect which
   commit to dig through ignoring the cutoff heuristics.
