From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] git checkout lies about number of ahead commits when
 switching from detached HEAD
Date: Sun, 20 Mar 2011 12:00:38 -0700
Message-ID: <7vd3llwrah.fsf@alter.siamese.dyndns.org>
References: <4D8525C9.2060203@gmail.com>
 <20110319222852.GB7116@sigill.intra.peff.net>
 <20110319224726.GC7116@sigill.intra.peff.net>
 <7vy64avdba.fsf@alter.siamese.dyndns.org>
 <20110320090111.GA15641@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 20:00:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Nrz-0007T2-Ux
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 20:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab1CTTAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 15:00:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab1CTTAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 15:00:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 23EB14DD6;
	Sun, 20 Mar 2011 15:02:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jDtZwww1zXa+1qVREWc8u073fcg=; b=UczSZt
	N+TI8I6uVzQqcohAPH7JaPxns+XojxGYhiNT7rBJkjGH5cMPHvo9okWmtJ2/WXAv
	w4ltlyxsDUoaXx7SCjQEUqQNHrn766jzuSQuQlZw+9g2cKsvWBsamhrIvPBNlORO
	O6fASAmy+xAcSwCin0LWRge7A3H+PuU2Y63ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ONADewm3MQK+Hr5dQiXF55nvpP9oQfh2
	xsWhYPA22MKXx3mXgHk6/kms2Xn4H+P7Ll7LsfNfLyB2hTXb+oGlqVbpxF/1mnj1
	7RvYyvqWHLYzS44641yeWdk5jsbmScu4wdW6ZU3cPpRNYKsMf+c/1TfX3X4DbfPU
	PoestSPOV2o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4CA64DD5;
	Sun, 20 Mar 2011 15:02:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B58FA4DCF; Sun, 20 Mar 2011
 15:02:18 -0400 (EDT)
In-Reply-To: <20110320090111.GA15641@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 20 Mar 2011 05:01:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96696AAA-5324-11E0-9742-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169518>

Jeff King <peff@peff.net> writes:

> For the case of 2 traversals, I suspect that clearing everything between
> is not so different from clearing from the tips, since most everything
> parsed was probably from the first traversal. But as we lib-ify more, we
> may end up with more and more traversals in a single program, so it's
> probably better to go the more efficient route from the beginning.

"Let the one that has more information to do the clearing" is not about
performance but about correctness and reusability potential.

When you insert a new traversal B in the existing codeflow before another
traversal C, B knows not just which commits it started from (hence knows
which commits were marked by it), but more importantly it also knows what
mark bits were potentially modified. If the existing codeflow had another
traversal A before you added B, and C took the marks A left on the objects
into account while doing its work, the only sensible clean-up is to clear
marks B touched (and no other marks) immediately after B, and we obviously
do not want C (and any later traversals in other codepaths that we may
later want to insert B) to have too much knowledge of which marks may have
been clobbered by B.

Of course, C could be coded defensively to clear marks other than what it
cares about (namely, the ones other than what A would have left and the
ones that would affect itself e.g. UNINTERESTING), and whoever inserts B
into existing codeflow needs to make sure that B does not stomp on marks
deliberately left by earlier traversals like A for later users like C
regardless of how the latter is coded.

> So how about this?
>
>   [1/3]: checkout: add basic tests for detached-orphan warning
>   [2/3]: checkout: clear commit marks after detached-orphan check
>   [3/3]: checkout: tweak detached-orphan warning format

Looks very sensible, except for the clear_marks(-1) that clears everything
I have a slight doubt about.

I think 3/3 was way overdue and it was my fault. Thanks for cleaning up my
mess.
