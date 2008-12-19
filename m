From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd merge behaviour involving reverts
Date: Fri, 19 Dec 2008 00:45:19 -0800
Message-ID: <7vocz8a6zk.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>
 <1229642734.5770.25.camel@rotwang.fnordora.org>
 <20081219124452.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alan <alan@clueserver.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 09:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDb0S-0001NR-M2
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 09:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbYLSIpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 03:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbYLSIpa
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 03:45:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbYLSIpa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 03:45:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C206A1AA11;
	Fri, 19 Dec 2008 03:45:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A13621AA10; Fri,
 19 Dec 2008 03:45:21 -0500 (EST)
In-Reply-To: <20081219124452.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri, 19 Dec 2008 12:44:52 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6290F9A8-CDA9-11DD-A482-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103554>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> If I understand Alan's case correctly, I think he does not want to
> "undo" the revert but wants to merge an updated version of the branch,
> as if no mistaken merge nor its revert happened in the past.
>
> If you revert the revert on the branch before merging, doesn't it mean
> that you will be merging what the older version of the branch did (that
> is in the revert of the revert as a single huge patch) and what the
> updated version of the branch wants to do?  Wouldn't that lead to a mess
> with huge conflicts?

The history immediately after the "revert of the merge" would look like
this:

 ---o---o---o---M---x---x---W---x
               /     
       ---A---B

where A and B are on the side development that was not so good, M is the
merge that brings those premature changes into the mainline, x are
unrelated changes already made on the mainline and W is the "revert of the
merge M" (doesn't W look M upside down?).  IOW, "diff W^..W" is similar to
"diff -R M^..M".

I think you misunderstood what "merging an updated version of the branch"
meant by Alan's description to mean that the side branch developers
discarded their faulty A and B, and redone the changes, which would have
resulted in something like:

 ---o---o---o---M---x---x---W---x---x
                                 \
                                  A'--B'--C'

If that were the situation, suggestion by Linus to revert the revert and
then merge would result in something like this:

 ---o---o---o---M---x---x---W---x---x---Y---*
                                 \         /
                                  A'--B'--C'

where Y is the revert of W, A' and B'are rerolled A and B, and there may
also be a further fix-up C' on the side branch.  "diff Y^..Y" is similar
to "diff -R W^..W" (which in turn means it is similar to "diff M^..M"),
and "diff A'^..C'" by definition would be similar but different from that,
because it is a rerolled series of the earlier change.  There would be a
lot of overlap as you feared.  In such a case, not having Y (revert of the
revert) would result in a much more trivial merge:

 ---o---o---o---M---x---x---W---x---x-------*
                                 \         /
                                  A'--B'--C'

because problematic large commits M and W are already outside of the scope
of this final merge.

But I think what Alan's developers did is different.  They did this
instead:

 ---o---o---o---M---x---x---W---x
               /
       ---A---B-------------------C---D

where C and D are to fix what was broken in A and B.  In such a situation,
what Linus suggests makes perfect sense.  You first revert the revert,
which would result in this:

 ---o---o---o---M---x---x---W---x---Y
               /
       ---A---B-------------------C---D

where Y is the revert of W, which would (ignoring possible conflicts
between what W and W..Y changed) be equivalent to not having W nor Y at
all in the history:

 ---o---o---o---M---x---x-------x----
               /
       ---A---B-------------------C---D

and merging the side branch again will not have conflict arising from an
earlier revert and revert of revert.

 ---o---o---o---M---x---x-------x-------*
               /                       /
       ---A---B-------------------C---D

Of course the changes made in C and D still can conflict with what was
done by any of the x, but that is just a normal merge conflict.

To recap, these are two very different scenarios, and wants two very
different resolution strategies:

 - If the faulty side branch whose effects were discarded by an earlier
   revert of a merge was rebuilt from scratch (i.e. rebasing and fixing,
   as you seem to have interpreted), then re-merging the result without
   doing anything else fancy would be the right thing to do.

 - If the faulty side branch was fixed by adding corrections on top, then
   doing a revert of the previous revert would be the right thing to do.

I hope this clears up confusion and fear.
