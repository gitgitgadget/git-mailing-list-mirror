From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Sun, 07 Jul 2013 10:49:46 -0700
Message-ID: <7vtxk645vp.fsf@alter.siamese.dyndns.org>
References: <20130707100133.GA18717@sigill.intra.peff.net>
	<20130707100949.GC19143@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 07 19:50:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvt6A-0004s8-Tv
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 19:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab3GGRtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 13:49:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56819 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847Ab3GGRtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 13:49:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BD862EB00;
	Sun,  7 Jul 2013 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZNR9bscpF7G6LnR5vNVynm+YZwA=; b=Ja30XJ
	9JlEHBwCA80NFCEIp6v6lkXJxUmoCEIzkjHl5EioL2j2oPXJiMcbSqqJNMvhFptI
	IUFP+8eTRppsM/vr35hDYC2jQ6uam2qzx0BFLyg2p+jXicZ/Cvj8U0ZVG8JzReO0
	tirSkZkMhfHhvMPw8SX1iuV1KTMQ7WVkkZABA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=btVkMo+q1Q/oLIqyxXh8FXxeu3+VmU7U
	ACjf5G1zjJH+9Iyu3G0hFZ3bfkZk0H8YM96orrjsIdToDp0uh9Oc2H+PUGXghCxI
	3uNUH3EPKK9gy7wYx06fbpTph1v8DR6ZZlbH0PWCVa0Eg6u8ufp+9OtbLbj74qYG
	rpmmfU1Lg60=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9063A2EAFF;
	Sun,  7 Jul 2013 17:49:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15C972EAF8;
	Sun,  7 Jul 2013 17:49:48 +0000 (UTC)
In-Reply-To: <20130707100949.GC19143@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 7 Jul 2013 06:09:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DC45C02-E72D-11E2-AA66-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229784>

Jeff King <peff@peff.net> writes:

> Perhaps we need
>
>   git cat-file --batch-format="%(disk-size) %(object)"
>
> or similar.

I agree with your reasoning.  It may be simpler to give an interface
to ask for which pieces of info, e.g. --batch-cols=size,disksize,
without giving the readers a flexible "format".

> +NOTE: The on-disk size reported is accurate, but care should be taken in
> +drawing conclusions about which refs or objects are responsible for disk
> +usage. The size of a packed non-delta object be much larger than the
> +size of objects which delta against it, but the choice of which object
> +is the base and which is the delta is arbitrary and is subject to change
> +during a repack. Note also that multiple copies of an object may be
> +present in the object database; in this case, it is undefined which
> +copy's size will be reported.

This is a good note to leave to the readers. I was wondering how
valid to accuse that B is taking a lot of space compared to C when
you have three objects A, B and C (in decreasing order of on-disk
footprint) when A is huge and C is a small delta against A and B is
independent.  The role of A and C in their delta chain could easily
be swapped during the next full repack and then C will appear a lot
larger than B.

It might be interesting to measure the total disk footprint of an
entire delta "family" (the objects that delta against the same
base).  You may find out that hello.c with a manageable size have
very many revisions and overall have a larger on-disk footprint than
a single copy of unchanging help.mov clip used in the documentation
does, which may be an interesting observation to make.
