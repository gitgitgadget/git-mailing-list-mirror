From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2 6/6] limit "contains" traversals based on commit
 generation
Date: Fri, 15 Jul 2011 14:04:06 -0700
Message-ID: <7vzkkfz261.fsf@alter.siamese.dyndns.org>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070644.GF18566@sigill.intra.peff.net>
 <7vpqlb1k1g.fsf@alter.siamese.dyndns.org>
 <20110715204002.GC356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 15 23:04:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhpYX-0007hn-2H
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 23:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663Ab1GOVEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 17:04:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226Ab1GOVEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 17:04:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFCD04862;
	Fri, 15 Jul 2011 17:04:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VJ97MmIwBIOm1JZ091sXxfmYVPk=; b=srtFte
	SMo5WFJ1DammFy03YGgP4EQAi1vHKlNaY1IlzmjkEinC5lBDbI6gVNrUIy/2y6yF
	hpi8xDuMMuyFavC6DXTBa0qKGK7fHYqFiMBYkmN3j3pQ1LbqKbK8t3nsvJYLP6yb
	QT6x6Lof2ieKTrbxpoYOQb33+dsZXiCpydFSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rdNfoaleAu9IBLhVJUUszFRaPLLP8I17
	I8iQnno87bP4sh3jjk4japvjHywIIwNQS6FV1gEErrnY9jzks/vrgvbWvLAZ5rOE
	0iRzoK4qBhbOx0PiBKaIudhYaAJ6i+OtQEsm+7M2MODUsosPAcubpOVvKpaEXfJm
	LrnYaZ+wnwM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5D954861;
	Fri, 15 Jul 2011 17:04:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 606394860; Fri, 15 Jul 2011
 17:04:08 -0400 (EDT)
In-Reply-To: <20110715204002.GC356@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 15 Jul 2011 16:40:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB3554A0-AF25-11E0-83B3-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177230>

Jeff King <peff@peff.net> writes:

>>    So how about marking commits (using the metainfo-cache facility) that
>>    has an ancestor (not necessarily its direct parent) that records a
>>    younger timestamp (e.g. 1 is such a commit, as its ancestors include
>>    things like 2 and 4)? There should be relatively small number of them,
>>    and still_interesting() logic can be told to dig through such commits
>>    even if everybody is uninteresting in the active list.
> ...
>>  * As to "tag --contains", when timestamp based heuristics breaks down is
>>    when a tagged commit incorrectly records way young timestamp or the
>>    "want" commit records way old timetsamp. I haven't thought things
>>    through, but the same metainfo-cache may be useful to detect which
>>    commit to dig through ignoring the cutoff heuristics.
>
> It can also break down if intermediate commits are wrong, because we
> have to traverse backwards, and we may erroneously cutoff early.
>
> For example:
>
>    A--B--C
>
>    timestamp(A) = 2
>    timestamp(B) = 1 # skewed!
>    timestamp(C) = 3
>
> If tag=C and want=A, then we traverse backwards from C. We can't stop
> immediately because we know that 2 < 3. But we go back to B, and see
> that 2 > 1, and assume that A cannot possibly be an ancestor of B.

I envisioned that the metainfo-cache to help rev-list I mentioned earlier
would mark B having an ancestor A that has a timestamp younger than it, so
I think we can certainly notice that we have to "dig through" B.
