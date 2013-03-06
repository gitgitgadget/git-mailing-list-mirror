From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Wed, 06 Mar 2013 13:50:46 -0800
Message-ID: <7vip54p58p.fsf@alter.siamese.dyndns.org>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
 <20130306212140.GA30202@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 06 22:51:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDMF3-00049X-Tv
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 22:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab3CFVuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 16:50:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55446 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753980Ab3CFVut (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 16:50:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02E60A10D;
	Wed,  6 Mar 2013 16:50:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fddXingMnGCPn0kA6yiJYIhHlOw=; b=JX/Db0
	Jse3+rew/hHbO4svQyUOiVfzknjAurDO56eqDUvcqLrAQRm1b2ZGN+4iC0xznwah
	/2jKmc6wQlZ/twvfvklrM2moRUfSiNohtRGGuAIUIamGspmnQ1MvCc6wxhO3d4NC
	Ry5dFeF25bP7OF8P0prIj/QvY3e+YcXNDUExs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nkgm4LtWzHRUEt93ZWx8GwcCkBZ/7A9W
	JjZKUUORHKB5TNKCdmJP+d0b3yQ7sa+tdBlKBpS1fUbGqeu3wrV8Ca2svMAJil4s
	90uFzFEVdOu3bRjX5KTQh+UgwQIrfGqxmjgosrl418CKvegzLYC8J02u8SHUP0em
	lLPxzKvWsvU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECE0DA10C;
	Wed,  6 Mar 2013 16:50:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 594B0A108; Wed,  6 Mar 2013
 16:50:48 -0500 (EST)
In-Reply-To: <20130306212140.GA30202@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Mar 2013 16:21:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7F45426-86A7-11E2-8332-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217554>

Jeff King <peff@peff.net> writes:

> I think Uwe's example shows that it _is_ useful. Yes, you no longer have
> the information about what happened through 1-14 (whether it was really
> there in the ancestor file, or whether it was simply added identically).
> But that information might or might not be relevant.

I think it is more like "I added bread and my wife added bread to
our common shopping list" and our two-way "RCS merge" default is to
collapse that case to "one loaf of bread on the shopping list".  My
impression has always been that people who use "diff3" mode care
about this case and want to know that the original did not have
"bread" on the list in order to decide if one or two loaves of bread
should remain in the result.

> In Uwe's example,
> it is just noise that detracts from the interesting part of the change
> (or does it? I think the answer is in the eye of the reader).

In other words, you would use the "RCS merge" style because most of
the time you would resolve to "one loaf of bread" and the fact that
it was missing in the original is not needed to decide that.  So, it
feels strange to use "diff3" and still want to discard that
information---if it is not relevant, why are you using diff3 mode in
the first place?  That is the question that is still not answered.
