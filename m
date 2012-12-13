From: Junio C Hamano <gitster@pobox.com>
Subject: Re: possible Improving diff algoritm
Date: Wed, 12 Dec 2012 22:26:37 -0800
Message-ID: <7vzk1izcv6.fsf@alter.siamese.dyndns.org>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
 <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
 <7vvcc73yzh.fsf@alter.siamese.dyndns.org>
 <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com>
 <7vpq2f2az4.fsf@alter.siamese.dyndns.org>
 <CANv4PNnC1J54TSpHuBOpY=rbuU_naysYkmoyi=utNF0vWK1CnA@mail.gmail.com>
 <B1564B28-9BB9-48A2-B59E-7D7C0B0DDECF@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 07:27:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj2G5-0003VF-Gs
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 07:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626Ab2LMG0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 01:26:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924Ab2LMG0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 01:26:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A3256A7A;
	Thu, 13 Dec 2012 01:26:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tjW08+0uVveeKjbxwrRXY7xnngU=; b=Z7MWmr
	56+GGdm+LChJ2FvBCkxByW3XwV4qdkFBOxotnIg/52Q8uiN4ZEa9CZGqzAUr7A2u
	02DQLJaqHllOzKmCtAokUP0U7a9nQbfI0/rshdby344y8qmOcUYvNeU5AMyCnjhw
	uZU2BLpXCHUcgv/dV3p3jO4uazQyUqxTVTfoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fD0lNkeM9radmCIBc2fMdhsC9lpjcBUQ
	PL+n/1O9yUfQS0OtTJCX17hzKKFS6v7f2OU0kIxXZMG9Ch6KkO9FDQ66K35Y1qPi
	vZ9H7IIBf2CX+jnzNorVNt7TX66mBbEIMfyGagBh1RbkHbNv91Ax6ds3wLrByfi3
	m73LCX01Jmc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0642B6A79;
	Thu, 13 Dec 2012 01:26:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 585FC6A77; Thu, 13 Dec 2012
 01:26:39 -0500 (EST)
In-Reply-To: <B1564B28-9BB9-48A2-B59E-7D7C0B0DDECF@adacore.com> (Geert
 Bosch's message of "Wed, 12 Dec 2012 23:58:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D7C6C70-44EE-11E2-ABA0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211437>

Geert Bosch <bosch@adacore.com> writes:

> It would seem that just looking at the line length (stripped) of
> the last line, might be sufficient for cost function to minimize.
> Here the some would be 3 vs 0. In case of ties, use the last
> possibility with minimum cost.

-- 8< --
#ifdef A

some stuff
about A

#endif
#ifdef Z

some more stuff
about Z

#endif
-- >8 --

If you insert a block for M following the existing formatting
convention in the middle, your heuristics will pick the blank line
after "about A" as having minimum cost, no?

You inherently have to know the nature of the payload, as your eyes
that judge the result use that knowledge when doing so, I am afraid.
I think your "define a function that gives a good score to lines
that are likely to be good breaking points" idea has merit, but I
think that should be tied to the content type, most likely via the
attribute mechanism.

In any case, I consider this as a low-impact (as Michael Haggerty
noted, it is impossible to introduce a bug that subtly break the
output; your result is either totally borked or is correct) and
low-hanging fruit (it can be done as a postprocessing phase after
the xdiff machinery has done the heavy-lifting of computing LCA), if
somebody wants to experiment and implement one.  As long as the new
heuristics is hidden behind an explicit command line option to avoid
other "consequences", I wouldn't discourage interested parties from
working on it.  It is not just my itch, though.
