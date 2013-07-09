From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] describe/name-rev: tell name-rev to peel the incoming object to commit first
Date: Mon, 08 Jul 2013 22:33:26 -0700
Message-ID: <7va9lwxpp5.fsf@alter.siamese.dyndns.org>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
	<1373236424-25617-5-git-send-email-gitster@pobox.com>
	<20130709050615.GF27903@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 09 07:33:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwQYP-00055V-B6
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 07:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab3GIFd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 01:33:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64313 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185Ab3GIFd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 01:33:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F10E2ACE5;
	Tue,  9 Jul 2013 05:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KW91Fm+QtdxyQYxm/n/T+MKwTi8=; b=oJIEqb
	ptqc6uM+E2xm/w2xnUzTG4Ssk8Vw1SjBkupv+yz+N4A2/7m1yFAiIgMvlBBFIVHE
	Hdh3cHBTwjdS3m1AymkSgJ+5+XKg5wgbjv1mUNfizkM/ZNul+1lU0GUcLltBVtd2
	fTgpSuPYmvuVGRaMwd/sSvPYAL7dfWEAMUbic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nbrb9MpXRaisAz6+TEgHHgT74SjNeB7l
	TNDGg7S7d2QB6nMTIs2fKjPBmwLzGCG5x6p/bC81E1FTN2yfkAn6VxWi2mRdsByS
	ilRztJntucwZbarTRaDm0ijs8H7hctGq8FgH8pS/DIB89XSHAc3frmQZL+Al7UB9
	p5VrQlUIw1k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 525DF2ACE4;
	Tue,  9 Jul 2013 05:33:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE60B2ACE2;
	Tue,  9 Jul 2013 05:33:27 +0000 (UTC)
In-Reply-To: <20130709050615.GF27903@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 9 Jul 2013 01:06:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1509B330-E859-11E2-AAEB-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229912>

Jeff King <peff@peff.net> writes:

>   1. Behave more or less the same between "git name-rev $sha1" and "echo
>      $sha1 | git name-rev --stdin". Your patch improves that. Though I
>      note that --peel-to-commit does not affect --stdin at all. Should
>      it? And of course the two differ in that the command line will take
>      any rev-parse expression, and --stdin only looks for full sha1s.

To "Should it?", I do not deeply care.  "--peel-to-commit" is an
exception that only is needed to support "describe".

I could instead have tucked "^0" at the end of each argument when
"describe" calls out to "name-rev" without adding this new option,
which is much much closer to what is really going on.

And that will alleviate your #2 below.

>   2. If name-rev prints "$X $Y", I would expect "git rev-parse $X" to
>      equal "git rev-parse $Y". With peeling, that is not the case, and
>      you get the misleading example that Ram showed:
>
>        $ git name-rev 8af0605
>        8af0605 tags/v1.8.3^0
>
>     or more obviously weird:
>
>        $ git name-rev v1.8.3
>        v1.8.3 tags/v1.8.3^0
>
> So I think your series moves in a good direction, but I would just worry
> that it is breaking backwards compatibility (but like I said, I am not
> clear on who is affected and what it means for them).
