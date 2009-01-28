From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 10:26:51 -0800
Message-ID: <7vmydbs2vo.fsf@gitster.siamese.dyndns.org>
References: <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com>
 <20090128020220.GE1321@spearce.org>
 <7v3af4yvmu.fsf@gitster.siamese.dyndns.org>
 <20090128033020.GF1321@spearce.org>
 <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org>
 <20090128044150.GI1321@spearce.org>
 <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org>
 <20090128075515.GA1133@coredump.intra.peff.net>
 <7vfxj3vos2.fsf@gitster.siamese.dyndns.org>
 <20090128081745.GA2172@coredump.intra.peff.net>
 <20090128161652.GK1321@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 19:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSF9L-0000Lf-9u
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 19:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbZA1S1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 13:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbZA1S1G
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 13:27:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbZA1S1D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 13:27:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A2B021D792;
	Wed, 28 Jan 2009 13:27:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 76F4A1D7D9; Wed,
 28 Jan 2009 13:26:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 40DCAACA-ED69-11DD-8C86-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107562>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Actually, the only time where it *isn't* a corruption is when its
> input to "git bundle create A.bdl ... -not $SOMEBADID" as that is
> the exact same thing as coming from the other side via send-pack.

And notice that it is about a nagative ref.

Another case you may use an object ID that may or may not be good and it
is not a corruption is when a Porcelain has an object ID obtained from
somewhere, and wants to know if it is safe to use the object.  After
determining that the object itself exists (e.g. via "cat-file -t"),
you run

	rev-list --objects $THAT_UNKNOWN_ID --not --all

to see if it is reachable from some of your own refs, or at least it is
connected to them without gaps.  If it errors out while traversing, you
know it is bad; if it doesn't, you know you can merge one of the commits
reachable from your refs with it and put the result in your ref without
violating the ref-objects contract.

Notice that in this case, it is about a positive ref, and revision
machinery is set to notice the breakage.

So in that sense, the existing semantics is internally consistent.  The
rules (I am not making up a new rule here, but just spelling out) are:

 (1) You cannot just pick a random object that happens to exist in your
     repository, traverse to the objects it refers to and expect
     everything exists;

 (2) If an object is reachable from any of your refs, however, you can
     expect everything reachable from that object exists.  Otherwise you
     have a corrupt repository [*1*]).

 (3) Your object store may have garbage objects that are not reachable
     from any of your refs and it is normal.

 (4) You can use random objects that may not be well connected as negative
     revs to limit the range of revs (and optionally objects reachable
     from them) listed by object traversal.  If they are well connected,
     they will affect the outcome, but it is not an error if they are
     leftover cruft that is not connected to the positive ones you start
     your listing traversal at.


[Footnote]

*1* You don't have to bring up grafts and shallow.  People who know about
them know they are ways to hide or deliberately introduce this type of
corruption while keeping the system (mostly) working.
