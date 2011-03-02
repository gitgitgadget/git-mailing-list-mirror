From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git blame-tree
Date: Wed, 02 Mar 2011 10:31:30 -0800
Message-ID: <7vbp1tcr25.fsf@alter.siamese.dyndns.org>
References: <20110302164031.GA18233@sigill.intra.peff.net>
 <20110302171653.GA18957@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 19:33:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuqrI-0000c4-9s
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 19:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375Ab1CBSdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 13:33:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568Ab1CBSdF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 13:33:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1FE3A4B09;
	Wed,  2 Mar 2011 13:34:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5hqiY7nzZcQWIlxPt9mNMUtS6ic=; b=UQT4j3
	z6KlVVD9O53nb4jmIwNphn1EsOU3yRyOAdXSGleIbmvRVJwLLOys/sSAFqKBuj1a
	AiFpGCv3QgSzhsjZdTdsp2CHX/Zg9x+aD0mEaY0juTKRSDWUz0gy5Uk7olYuHSDN
	InPyvu/cxFS/ntv9QD5rD1HxVbo493uqMjMNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bQgv7apQt9uLFMmWjSI2dZ+xrPuy04i1
	JNUAEdIWj3BAy1S1XyhcYbfxw31NdM5B40DwDzy8AaBnOWkJGcu1HSDQyop9ovml
	e06Qdm2wyfHgED6hYIUqCZkMRIAhlXzbD2bF9/GgBm3pKUEVzDcwN2g/SZO0o0Zm
	Vd8j0S8Btww=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F0B9D4AFF;
	Wed,  2 Mar 2011 13:34:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 089A24AB4; Wed,  2 Mar 2011
 13:32:51 -0500 (EST)
In-Reply-To: <20110302171653.GA18957@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 2 Mar 2011 12\:16\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AFE1BB40-44FB-11E0-9891-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168333>

Jeff King <peff@peff.net> writes:

> I considered making it a special mode of "git blame" when blame is fed a
> directory instead of a file...  ... If we want to go that way,
> we can always catch the special case in blame and just exec blame-tree.

I agree that rolling it into "blame" will be a good way to conclude this
feature from the end-user UI point of view, provided if (as you said) this
proves to be the most reasonable way to give a coarser, file-level blame
to a history.

It has been my opinion that the default github view that seems to be
modeled after cvsview is the least useful choice of the default in the
more modern git era ;-), but I guess people's eyes and brains are trained
by the old school "file boundaries matter" way of thinking.

I am not against catering to them as long as it is done in a modular way
that does not negatively affect the other parts of the code, and this
implementation certainly is a good one from a cursory reading, except for
two points.

One is merges, which you punted on with --no-merges ;-).  If I were doing
this, I would probably have traversed without --no-merges, and would blame
all cases that are not TREESAME to the merge (i.e. regardless of the
cleanness of the content level merge), as this feature is about file level
blame.  If the child took the whole content as-is from a parent, it is a
no-event, but if the child has the resulting content that is different
from any of its parents, then that child is responsible for the end-result
content at the file level.

Doing nothing else makes sense.  There is a fundamental expectation for
file level history: if you give a commit C as the result for path F,
saying C was the one that touched path F the last, you are saying that F
that is contained in C is exactly the same as F at the tip of the history
(i.e. whereever you started digging back from).  If you don't stop at a
merge that had content-level merge, you would break that expectation.  You
would also rely on the local clock of the merged branches to say which
branch made a commit touching the path the last, but it is much minor
issue compared to the breakage of "result must match where we say it came
from" expectation.

> The initial set of interesting files we come up with is gotten by
> looking at the tree of the first pending object after parsing the rev
> options (defaulting to HEAD). Which sounds a little flaky to me, but
> does what you want in practice. I'd be curious if somebody can come up
> with a counterexample where the ability to manually specify the source
> tree would be more useful.

I started writing "In what sense is it flaky?  What corner case do you
have in mind?" in a few lines above and then moved that here ;-).

The second point is "why didn't you use pathspec, but chose to take only
one path?"  It would be useful if you can say

	$ git blame v2.6.24..v2.6.37 -- net include/net

no?

> So this is the per-commit processing. Basically we just do a diff for
> each commit, and see if each path has been claimed.  Note that it
> depends on the string-list item->util being initialized to zero. Hence
> my recent patch to string-list, and this needs to go on top of 62b8102
> (which is in master and maint).

Once you know who the guilty party is, can't you just remove that element
from the list, so that later search from the "remaining path" list would
decrease in cost as you go deeper?

Also at some point the set of remaining path would become small and it
might make sense to feed that as diff-tree pathspec.  After all, aren't
you re-initializing the diff machinery for each commit (which is _not_ a
bad thing to do--I am just pointing out that there is an opportunity to
use narrower pathspecs as you go without any additional cost)?  Note that
I am not suggesting to update the pathspec used for commit traversal in
the middle; that is a lot trickier.

>> +	while (data.num_interesting > 0 &&
>
> An optimization; we can quit the traversal as soon as everything is
> claimed. In practice this helps disappointingly little.

That is somewhat unexpected, but would strongly suggest that the approach
to use more specific pathspec that cover only the remaining paths would
give you faster per-commit diff?

> My merge handling is just "which files are different from the parents".
> Which is reasonable, but I don't actually exercise it since we use
> --no-merges by default. :)

I think that is a big mistake and I already said it above.

> We could try to do something clever here about evil merges.

Again, I wouldn't even think about it; this is a "file boundary matters"
tool; you shouldn't care about cleanliness of content-level merges.
