From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A generalization of git notes from blobs to trees - git
 metadata?
Date: Sun, 07 Feb 2010 12:25:13 -0800
Message-ID: <7v8wb4aj4m.fsf@alter.siamese.dyndns.org>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
 <201002070236.12711.johan@herland.net>
 <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
 <20100207050255.GA17049@coredump.intra.peff.net>
 <2cfc40321002062136q64f832aesd979c9cb22f3612@mail.gmail.com>
 <20100207193320.GB3185@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 21:26:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeDiS-0005Dt-4v
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 21:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016Ab0BGUZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 15:25:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab0BGUZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 15:25:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30AB8972CC;
	Sun,  7 Feb 2010 15:25:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qAiYX5wJBJ8Q93JNGAYWjoj5Kn4=; b=rn33uy
	6+gCDo4SFh3gqGqciyAdYXfeF70u6wwLgAAOm8dVZQmaSpVbtylbdYT4CK0xus1t
	IQ9NwnyRXjh1RVI2GylIVBzbd7GnDiOnmY/HDAq6ESFm8xbJxlo1x/zDMzPKfgUJ
	Jm0nk+c4uaUlPhKnqmH/+KTGwYVlK1lZ8ZSqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W2pzeAf7B1urAmIN9keNBfJnNz1ceNP4
	3Iho/6Q6AQd5sCNRnAD+92WJw2dhjdYq5tudInXkLPTOfsIh39R4pJP+w7fiac7Y
	/8x4GaoLI5AoSO4rHlhKpQI9q9sB5Fjvllxnw3eP6QG+xFVYHs7Jv8Ny2OGc5wOx
	bKs9+dx6CJ0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D7C7F972CB;
	Sun,  7 Feb 2010 15:25:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFC38972CA; Sun,  7 Feb
 2010 15:25:14 -0500 (EST)
In-Reply-To: <20100207193320.GB3185@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 7 Feb 2010 14\:33\:20 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E93859A0-1426-11DF-B0EC-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139252>

Jeff King <peff@peff.net> writes:

> Or perhaps you would not even want to do a tree-merge between notes at
> all, and would rather see a conflict if two people noted two different
> trees.

I've been thinking about the merge issues, and am starting to suspect that
we might want a merge strategy quite drastically different even for blob
cases.  That is one of the reasons why I don't want to see us muddy the
issues by introducing even more complex "tree" case.

Anybody working in the same project can start 'notes' tree with his or her
own root.  That is the normal use case for annotating commits for your own
use.  For merges inside the history of primary contents that people try to
collaborate to advance, three-way merge pivoting on a common ancestor is a
natural way to reach a satisfactory result.  In notes namespace, on the
other hand, the norm is to simply overlay the notes trees, adjusting for
the fan-out.  You annotated that commit I was not interested in, while I
annotated this commit you weren't interested in.  We have our notes in the
end result, and both of us are happy.  If we happen to have annotated the
same commit without knowing what the other was doing, then there is no
sane consolidation---in the most typical case, we would want to keep both,
perhaps concatenating them together.  Textual merge becomes the exception
that triggers two "notes" histories happened to have forked from the same
root somehow.

And for that most typical use case, I suspect even the current "notes on
any and all commits for a single purpose are thrown into a one _bag_ that
is a notes tree, and the growth of that bag is made into a history" model
captures sets of notes that is too wide.

Suppose Alice, Bob and I are involved in a project, and we annotate
commits for some shared purpose (say, tracking regressions).  Alice and
Bob may independently annotate overlapping set of commits (and hopefully
they have shared root for their notes history as they are collaborating),
and they may even be working together on the same issue, but I may not be
involved in the area.  What happens when I pull from Alice and Bob and get
conflicts in notes they produced, especially the only reason I was
interested was because they have new things to say about commits that I am
interested in?

You can end up with conflicts in areas you are not familiar with but Alice
and Bob are in charge of even in the primary content space, but there is a
fundamental difference of this type of conflict in the notes space, I
think.  The set of contents in the primary content space are supposed to
make a consistent whole, and there is a topic branch workflow to partition
the work to allow me to easily kick the merge back to them (i.e. I can
tell Alice and Bob to resolve the conflicts between themselves and trust
that what they do between them do not touch outside of their area) without
getting blocked.  I don't see a clear workflow to resolve this in the
notes space, especially with the set of operations the current "git notes"
(and obvious and straightforward enhancements of what it does).  At least
not yet.

It's like "keeping track of /etc" (or "your home directory").  It is a
misguided thing to do because you are throwing in records of the states of
totally unrelated things into a single history (e.g. "Why does it matter I
added new user frotz to /etc/passwd before I futzed with my sendmail
configuration?  ---It shouldn't matter; there shouldn't be ancestry
relationships between these two changes").  I somehow feel that keeping
track of the "growth of the bag of annotations to any and all commits" in
a single history may be making the same mistake.
