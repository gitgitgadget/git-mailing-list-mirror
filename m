From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Veryfing signatures in git log fails when language is not
 english
Date: Thu, 14 Feb 2013 08:47:47 -0800
Message-ID: <7vliaq3kr0.fsf@alter.siamese.dyndns.org>
References: <20130214011837.04880b3e@hydra.devrandom.pl>
 <511CC288.30607@drmicha.warpmail.net>
 <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Mariusz Gronczewski <xani666@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 17:48:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U61yo-0000Hq-Bt
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 17:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087Ab3BNQrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 11:47:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52388 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab3BNQru (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 11:47:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABAE0CBB5;
	Thu, 14 Feb 2013 11:47:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nH90IOxD7LBmpcI2SBJRLpdrflc=; b=fUckqU
	f3t6I3vULhyEhpKFx42U9vk/tFkn67f+cJYIFAniopev5aGKl1A1Rr772aHINOus
	dXnqv9qikUSfeD18v82OhJjEM7gBudNAaJRemG/C7gCs1kYC1IFzD/FJkzseyUfn
	TO/sbl7Jm0ir6nrFig4tOjNIWfpV1No9tF2XE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a0Wc5Esng1TfQ9H/erlnPK7hOG2G20l7
	b3BHCd3FmHH+iGyLyhRpPUzNgWZYFX8+/WCKNubTm5rc7P2ULPN7SyxkoSKHl0Qi
	ld+qTYTtYkl6DvU4XrmtWuTLfNfEp33JAhoigKQgkuEJwiM+VmEovzWHntvS5rIq
	Flym17rwcbI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D1AACBB3;
	Thu, 14 Feb 2013 11:47:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18D99CBAF; Thu, 14 Feb 2013
 11:47:49 -0500 (EST)
In-Reply-To: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com> (Mariusz
 Gronczewski's message of "Thu, 14 Feb 2013 13:42:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44019932-76C6-11E2-BAEF-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216320>

Mariusz Gronczewski <xani666@gmail.com> writes:

> What is really missing is an ability to display used key ID without
> hammering git log output with regexps, it would be much easier to
> validate incoming commits if there was format option to just display
> key ID instead of signer name. %GS isn't really good solution for that
> because it will show only one of email addresses used in the key and
> script checking signatures would have to always pick "right" one.

The %G<anything> pretty modifiers other than %GG were done mostly as
placeholders.

I think the following would be a good way to refine them:

    - %GG, and possibly "log --show-signature" should run GPG under
      the user's LANG.

    - %G? is mostly useless, unless it is made to always mean "does
      it verify crypto-wise" and nothing else.  One bit is simply
      too small to represent all the cases where you may or may not
      have the signer's key, or you may have the key but you do not
      have enough trust in it (e.g. the key may be expired, revoked,
      or not enough confidence in your web of trust).

    - The "right" one you mention for %GS is easier than you might
      think.  If you just verify against the accompanying "tagger"
      identity, that should be sufficient.  It of course cannot be
      generally solved, as you could tag as person A while signing
      with key for person B, but a simple social convention would
      help us out there: if you tag as Mariusz Gronczewski, your
      signature should also say so.
