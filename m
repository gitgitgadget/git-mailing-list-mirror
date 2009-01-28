From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 00:05:33 -0800
Message-ID: <7vfxj3vos2.fsf@gitster.siamese.dyndns.org>
References: <7vvds0z1c1.fsf@gitster.siamese.dyndns.org>
 <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
 <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com>
 <20090128020220.GE1321@spearce.org>
 <7v3af4yvmu.fsf@gitster.siamese.dyndns.org>
 <20090128033020.GF1321@spearce.org>
 <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org>
 <20090128044150.GI1321@spearce.org>
 <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org>
 <20090128075515.GA1133@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 09:07:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS5S1-00066P-56
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 09:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbZA1IFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 03:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbZA1IFp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 03:05:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbZA1IFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 03:05:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BCE9D9400C;
	Wed, 28 Jan 2009 03:05:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A0F469400B; Wed,
 28 Jan 2009 03:05:35 -0500 (EST)
In-Reply-To: <20090128075515.GA1133@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 28 Jan 2009 02:55:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 761A3D94-ED12-11DD-BA3C-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107504>

Jeff King <peff@peff.net> writes:

> But in other cases, it silently gives you the wrong answer.  For
> example, consider a history like:
>
>        C--D
>       /
>   A--B
>       \
>        E--F
>
> now let's suppose I have everything except 'E'. If I ask for
>
>   git rev-list F..D
>
> then it will not realize that A and B are uninteresting, and I will get
> A-B-C-D. I think it is much better for git to complain loudly that it
> could not compute the correct answer.

Fair enough.  I think we can resurrect the conditional and the traversal
option revs->ignore_missing_negative only for this hunk in my [2/2] patch
to support that use case.

@@ -480,7 +483,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			struct commit *p = parent->item;
 			parent = parent->next;
 			if (parse_commit(p) < 0)
-				return -1;
+				continue;
 			p->object.flags |= UNINTERESTING;
 			if (p->parents)
 				mark_parents_uninteresting(p);
