From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer parsing
Date: Tue, 24 Mar 2015 09:09:09 -0700
Message-ID: <xmqq1tke8jiy.fsf@gitster.dls.corp.google.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq7fudld61.fsf@gitster.dls.corp.google.com>
	<551185D9.6050200@alum.mit.edu>
	<xmqq619q8k0h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 24 17:09:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaROH-0002kY-Us
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 17:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbbCXQJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 12:09:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753686AbbCXQJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 12:09:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09E80409E8;
	Tue, 24 Mar 2015 12:09:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WZs6T79zahJ80+YGXDtFq2TP+fs=; b=kFy+et
	6IehSH41Qnds1cAr7rFKZUu4RjJwYIP8s9e4jwtvGC0BzAh4ZzqglD46ik9lxgmh
	Cz46gKe/txrtrpTW6ngwwsx1RkgObglAf+cZaX2Pl3Ewwc4ZrgegyPCAq46X0VTX
	r8vIMtUt1tVLPZPFLONLEbcjns5I8j66I0olg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CxRMzoBKoBe8QxY/XrBO9wUgTzri6ota
	MOBZvJG7s1hOHrILefnkNqQUS+jSLrVQAD4pHzKbNvccgLIIM2y9tocMcKaH/yH9
	uzE8LPwf755yD7LbFb3Ldb+12r0cPeU3mxRJzE1l38zOkI+k49sFQfdha5pV0+g0
	l9Btv+4xQm8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 011AF409E6;
	Tue, 24 Mar 2015 12:09:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59288409E3;
	Tue, 24 Mar 2015 12:09:10 -0400 (EDT)
In-Reply-To: <xmqq619q8k0h.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 24 Mar 2015 08:58:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B300700-D240-11E4-BA0F-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266195>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> It is easy to allow "--abbrev=+7"; I would just need to add NUM_PLUS to
>> those call sites. Should I do so?
>
> The more relevant question to ask from my point of view is why you
> need to "add" NUM_PLUS to "enable" it.  What valid reason do you
> have to forbid it anywhere?  Only because you do not accept it by
> default, you need to "add" to "enable".
>
>>> Why is it a problem to allow "git cmd --hexval=0x1234", even if "git
>>> cmd --hexval=1234" would suffice?
>>
>> In some cases we would like to allow that flexibility; in some cases
>> not. But the strtol()/strtoul() functions *always* allow it.
>
> The same issue.  Whare are these "some cases"?

And the same issue appears in the "leading whitespace" thing I did
not mention in the earlier part of your message I responded to. I
also notice you answered yourself that there may not be a valid
reason to forbid end-user supplied "0x" prefix to arguments we
expect an integer for in your other message.

In short, if it is not a clearly bogus input that indicates a typo
or something (e.g.  "--size=48l? did the user meant 48, 48k, or
48m?"), and if it is clear we can tell the user meant what the code
would naturally interpret as (e.g. "--hexval=0x1234"), why forbid
it?
