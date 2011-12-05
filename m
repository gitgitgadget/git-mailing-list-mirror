From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Evaluation of ref-api branch status
Date: Mon, 05 Dec 2011 10:26:28 -0800
Message-ID: <7vfwgynacr.fsf@alter.siamese.dyndns.org>
References: <4EDAB62E.5070204@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 05 19:26:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXdFN-0004XE-Sb
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 19:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756488Ab1LES0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 13:26:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667Ab1LES0b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 13:26:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67D0A5413;
	Mon,  5 Dec 2011 13:26:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CMfhLlv1QCCFuBQussd3c0Hu+HY=; b=sbF3Bn
	yYyVNAt1JG00ReYNpncMDa2QtLTkPSfFGZu0lEumSd3Rn41rR7H+LHw7Ce7W7s6r
	ZgIHQ3gTFw/d36F7FC3Z/1Fg2dF06BRc3oRG4RLMVuVAWXBrDkq/sqJHFqJFiCaQ
	Lltcum5bddtbcXomxvlaaZnDLMJbVuAGj0prs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uiGnJnFL5PTYS7xO5pm52BAU+yS1d5s1
	fboY7CnSXX0viH6YxNtGRLjq9I/8wlMpa5IiFnV+rJ8uVvD7pKNt2+vKWMKeRRQJ
	ydRxvXRDevLcGxtgtMo0NV3dwNLF2dNFV8V4yC4SvYVR9rpjkfEOSyjXAmH4DxCT
	xzyeNdV9bps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EA595412;
	Mon,  5 Dec 2011 13:26:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBC555411; Mon,  5 Dec 2011
 13:26:29 -0500 (EST)
In-Reply-To: <4EDAB62E.5070204@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 04 Dec 2011 00:52:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A67B6FEE-1F6E-11E1-827C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186283>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Now that 1.7.8 is out, I wanted to figure out the status of the
> remaining ref-api changes that are in flight, including the differences
> between between my tree and yours.

I understand that the ultimate and largest objective of these series is to
make sure that the performance does not suffer from very many negative
lookups on the refs/replace hierarchy (which almost always is empty in a
sane repository), and I do want to see that happen. I also think it is
good that the series tries to make sure that the various codepaths we
create new refs do not let the user accidentally create refs with bad
names and/or contents.

When we see a questionable ref that is _already_ in the respository,
however, we may warn but it is wrong to declare the repository to be
broken and refuse to work. That would make it cumbersome or impossible to
even _fix_ such breakage. Regressions of that kind wer in the earlier part
of the series already in 1.7.8 and it was rather unpleasant having to
hotfix them. As our test suite does not deliberately create these
questionable refs and/or try to use them (and I personally do not in my
regular workflow either), I am afraid that it is rather hard to realize
what kind of refnames are what we intended to forbid even from earlier
days but did not _bother_ to check and enforce the rule against so far,
but are forbidden by the updated code, until we unleash the new logic to
the end users with various third party tools that created them [*1*]. I
would want to see us get this part right and solid, and include it in
1.7.9.

It would be nice if we can include also the bits to read hierarchies
lazily, but as they come on top of your B & C, it may end up in 1.7.10 and
I do not mind it at all. Reference resolution is one of the central things
in the user experience, and we cannot afford to ship anything that is
half-done-and-mostly-works over slow-but-correct.

Alternatively you _could_ swap the order of your B & C and D and try to
have your D early while giving B & C more time to cook, but I suspect the
order you chose would be better in the longer term.

> I understand that "next" will soon be re-rolled.  Will the re-roll be
> based on the current "pu", or will you start from scratch?

As to the two quickfix patches that are on two remaining topics from you
in my tree, I did them merely as a short-term band-aid. I was expecting,
after 1.7.8 when we eject the topics out of 'next', that they will be
rebased on top of 'master' that already contains a proper fix before these
topics started touching the same codepath.

My reading of your summary suggests that it would be easiest to drop the
three mh/ref-api* topics from my tree, especially the 'refs: loosen
over-strict "format" check' band-aid patches, and re-queue a re-roll from
you.

Thanks.

[Footnote]

*1* Trying to be lenient when reading and being strict when writing as the
general principle would be the safe and sane way forward, and making sure
that we warn *loudly* when we think we are merely being lenient (i.e. we
think we found a bad ref with questionable name and/or contents) would be
a good way to catch our mistakes early.  E.g. ".git/config does not record
a correct object name" glitch was caught only because you added the
warning so while it was painful to hotfix that late in the cycle, the
warning was worth it.
