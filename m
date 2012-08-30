From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: use a priority queue in merge base functions
Date: Thu, 30 Aug 2012 09:23:25 -0700
Message-ID: <7v3934tkle.fsf@alter.siamese.dyndns.org>
References: <20120829110812.GA14069@sigill.intra.peff.net>
 <20120829111147.GB14734@sigill.intra.peff.net>
 <7vtxvlwt7o.fsf@alter.siamese.dyndns.org>
 <20120829205332.GA16064@sigill.intra.peff.net>
 <20120829205525.GA28696@sigill.intra.peff.net>
 <20120829210032.GA29179@sigill.intra.peff.net>
 <20120829210540.GA31756@sigill.intra.peff.net>
 <20120830125421.GA5687@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 18:23:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T77Wq-0005ud-O5
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 18:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab2H3QX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 12:23:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58542 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283Ab2H3QX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 12:23:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C837B817B;
	Thu, 30 Aug 2012 12:23:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hdewjFvBLcfkdcUnpQndYCtuYM4=; b=jSDmhC
	V+JUhvgLDz9zS1mvGv8jlhzzn/as2FKry5YwTlBndSSkxgrCRuQhfXMOPXpoY6UF
	ZZWOfVq/a/9XTRmfw6nKCr8mZzQU9tBzJfYgJ1i1Qwb3eJ6MwswOBaMuXWdF7iVF
	733JK/ILUVQiEpYM7oCy4yu5bOBOD8dCdXB48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TTdIR/K24X7MhihPOEbL+g6k9dyTEGG8
	+LR11W7pb7i7Uo3n/SiSpVR6s5Rxp36juoharUmOnZHsrs+tKqL3/TGiGop+aOpF
	FNmMNh0CYmnQ09SDM3tAH4nIzHU64O/4xc2a2fwfkNA4alqJs6IqyLZ48aumW49t
	4mJHFm+plAY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B566D817A;
	Thu, 30 Aug 2012 12:23:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FB698179; Thu, 30 Aug 2012
 12:23:27 -0400 (EDT)
In-Reply-To: <20120830125421.GA5687@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 30 Aug 2012 08:54:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 073E5200-F2BF-11E1-80F4-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204546>

Jeff King <peff@peff.net> writes:

> Anyway, since this isn't yielding any performance benefit, I'm not going
> to go down that route. But stability of the queue is something that we
> need to consider if we ever do replace commit_list with a different data
> structure.
>
> Here's the patch to make the existing priority queue stable (by wasting
> space) in case we ever want to use it.

Thanks for being thorough and showing a good analysis.

If we want stability, the space to hold insertion counter is not
"wasted", by the way.

I actually think the generic "queue" implementation may want to
handle elements that are not just single pointers.  Just like
qsort() is not about sorting an array of pointers but it is about
sorting an array of elements of caller specified size, perhaps
"queue" can hold elements of size the caller specified (set in stone
when the queue is initialized).

Then, a caller that wants a stable priority queue of commits can
tell the queue to manage "struct { struct commit *c; int gen; }",
use the "gen" field for stability in its comparison callback, etc.,
while a caller that does not need stability can tell the queue to
manage "struct commit *".  That way, the generic queue layer does
not have to worry about wasting the insertion counter space, no?
