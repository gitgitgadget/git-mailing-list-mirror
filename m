From: Junio C Hamano <gitster@pobox.com>
Subject: Re: small question about the repack algorithm
Date: Thu, 07 Feb 2008 23:12:44 -0800
Message-ID: <7vodarly4z.fsf@gitster.siamese.dyndns.org>
References: <20080207090331.GA1958@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 08:13:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNNQO-0006tz-3F
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 08:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259AbYBHHMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2008 02:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756007AbYBHHMy
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 02:12:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705AbYBHHMx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2008 02:12:53 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 719E36759;
	Fri,  8 Feb 2008 02:12:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BDD806758;
	Fri,  8 Feb 2008 02:12:46 -0500 (EST)
In-Reply-To: <20080207090331.GA1958@artemis.madism.org> (Pierre Habouzit's
	message of "Thu, 07 Feb 2008 10:03:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73045>

Pierre Habouzit <madcoder@debian.org> writes:

>   I've trying to see if that optimization was used but I was somehow
> unable to find if it was the case, as the code is a bit tough :)
>
>   I was wondering if the repacking window was using triangle inequali=
ty
> to discard trying some costly deltas (I assume that what costs the mo=
st
> in the repacking is computing the delta). I mean, if you consider the
> "size" of a delta, I'm almost sure that it's very near a distance.
>
>   So assuming that we know the delta sizes between any pair of refere=
nce
> objects in the window, well, if an object we want to delta against th=
e
> window Od are near one reference O1 enough, for each Oi in the window
> that holds: len(=CE=B4(O1, Oi)) > 2 * len(=CE=B4(Od, O1)), then it's =
not worth
> investigating.

We do not keep track of the delta size matrix between delta-base
candidates in the window, but I presume we could.  The storage
cost for doing so is very cheap (window^2 * size_t).  But we do
not even compute the distance matrix fully (I'll mention the
reason why the above is not (window^2 * size_t / 2) later).

    1-----------------------------i   <=3D delta-base candidates
     \
      \=20
       D <-- the target we are considering

Your idea is that if we want to find the cheapest delta-base,
and after we find out that candidate #1 is close to our target D
and candidate #i is very far from candidate #1, then delta to
create D using candidate #i as the base would be much bigger.
If the distance space is Euclidean, that would be a nice
optimization.

However I do not think deltification would work that way, for
two reasons.

The deltified representation of an object is a sequence of two
kinds of opcodes:

 (1) the N bytes in the target from the current point is a copy
     of the source at offset M;

 (2) the N bytes in the target from the current point are the
     following literal string.

The first form is two integers (and we represent short integers
efficiently), and the second form is one integer plus N bytes
literal.

An efficient delta candidate is the one with most common
contents with the target image.  Saying "copy that part" is
cheaper than "Here is the contents.....".

Notice that it does not matter how much other cruft a target
contains.  In an extreme case, if the base candidate #1 is a
prefix of the candidate #i, and the difference does not have any
commonality with target D, then the delta to represent D using
the base #1 and the delta using the base #i would be of the same
size and the same contents (as all offsets from the source image
of copied parts would be the same).  The tail part of #i would
not participate reconstruction of D at all.

In such a case, you would have a long distance between #1 and
#i, but that is because #i has very many unrelated contents that
are not shared with #1 (so the difference has to be represented
as "Append these bytes to represent #i, as we cannot copy from #1".

But that does not mean #i has less common contents than #1 has
with D.  In fact, we might even find common contents between the
tail part of #i and D that the delta using base #1 needed to
represent as literals.  In other words, #i could well be a
better candidate than #1.

The second reason is that the deltification is not symmetric.
If you define the "distance" between #1 and #i as "the size of
delta to reproduce #i using #1 as base", the distance between #1
and #i is very different from the distance between #i and #1.
