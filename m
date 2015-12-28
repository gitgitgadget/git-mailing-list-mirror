From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Combining APPLE_COMMON_CRYPTO=1 and NO_OPENSSL=1 produces unexpected result
Date: Sun, 27 Dec 2015 18:29:29 -0800
Message-ID: <xmqqy4cf9ugm.fsf@gitster.mtv.corp.google.com>
References: <CAMYxyaVQyVRQb-b0nVv412tMZ3rEnOfUPRakg2dEREg5_Ba5Ag@mail.gmail.com>
	<CAPig+cS2+NP=-XEYA6e=doQu=+Qn-Lzut-7OCeYJRFZFchNepg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jack Nagel <jacknagel@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 03:29:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDNZ2-0001ZT-KT
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 03:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbbL1C3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2015 21:29:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750833AbbL1C3b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2015 21:29:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA17537C91;
	Sun, 27 Dec 2015 21:29:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1c0YJXmah0fwON8bhXDqRKXDVzE=; b=E4qefl
	iymIa472Tc6kf9s+lXqKToNvRqbgih+YcNyjTZnfkLz3tULmjRulcGNJMZtGZDaH
	uJrVbdnEniRTQ4jU6HPxnacPp39NEv4OhpdM/wNGLrQBw1NSpacYnu4v5iReb2iD
	GgEUGyDY4LvSgRszzBrQgOR2dLE2cjT/Lg4kI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MbNSWxF+cgqdv8v4iberUWGTTYZlUPGM
	TDTNgcp6EbIR9A86kkY80vGqzJcyj9Lb7VK6l9P23kZERRyGih5GiYh2CikuF7Xj
	ccmak/M0H5vimeoVwjMR6NGDm7chckPi6Toa/2FT4+NM+3ZLTqDIdnF/If8t7tGP
	yDIRgnoC6Bw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D13D437C90;
	Sun, 27 Dec 2015 21:29:30 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 53DF837C8F;
	Sun, 27 Dec 2015 21:29:30 -0500 (EST)
In-Reply-To: <CAPig+cS2+NP=-XEYA6e=doQu=+Qn-Lzut-7OCeYJRFZFchNepg@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 23 Dec 2015 03:51:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D2DB95E0-AD0A-11E5-940D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283025>

Eric Sunshine <sunshine@sunshineco.com> writes:

> So, it might be easier to think of NO_OPENSSL as really meaning NO_SSL
> (that is, "disable all SSL-related functionality"). Since the only SSL
> implementation Git knows how to use is OpenSSL, perhaps one can
> consider the name NO_OPENSSL a historic anomaly.

That is a good explanation of what is observed.  I am not sure if it
is a good justification, though.  If you tell somebody who needs to
link an implementation of SHA-1 in that you (1) do not want to use
OpenSSL (or do not want to have SSL at all), and (2) do not mind
using Apple's CommonCrypto, and if you _know_ that CommonCrypto is
a possible source of the SHA-1 implementation, then I would think it
is reasonable to expect that CommonCrypto SHA-1 to be used.

	Note. To further explain the situation, the only reason we
	added CommonCrypto knob in the build system was to allow
	people to use OpenSSL as the SSL implementation.  Those who
	added the knob weren't making a conscious decision on which
	SHA-1 implementation to use in that scenario---they may not
	even have been aware of the fact that SHA-1 was offered by
	CommonCrypto for that matter.

A few questions we should be asking Apple users are:

 - Is there a strong-enough reason why those who do not want to use
   SSL should be able to choose the SHA-1 implementation available
   from CommonCrypto over block-sha1?

 - Is CommonCrypto SHA-1 a better implementation than block-sha1?

Depending on the answers to these questions, we might want to:

 - add a knob to allow choosing between two available
   implementations (i.e. when NO_APPLE_COMMON_CRYPTO is unset) of
   SHA-1, regardless of the setting of NO_OPENSSL.

 - decide which one between CommonCrypto and block-sha1 should be
   the default.

If we end up deciding that we use block-sha1 as the default, we
should do so even when both NO_OPENSSL and NO_APPLE_COMMON_CRYPTO
are left unset.  If we decide that block-sha1 should merely be a
fallback when no other SHA-1 implementation is availble, on the
other hand, we should be using CommonCrypto SHA-1 as long as the
user did not set NO_APPLE_COMMON_CRYPTO explicitly, even when we are
building with NO_OPENSSL.

If people do not care, we can leave things as they are.  It would
seem mysterious to use block-sha1 when we are not using CommonCrypto
for SSL (i.e. NO_OPENSSL), and otherwise CommonCrypto SHA-1, and
would invite a puzzlement we saw in this thread, though.
