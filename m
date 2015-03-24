From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer parsing
Date: Tue, 24 Mar 2015 11:08:20 -0700
Message-ID: <xmqq1tke6zfv.fsf@gitster.dls.corp.google.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq7fudld61.fsf@gitster.dls.corp.google.com>
	<551185D9.6050200@alum.mit.edu>
	<xmqq619q8k0h.fsf@gitster.dls.corp.google.com>
	<5511A166.3090009@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 24 19:08:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaTFf-0000GC-4z
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 19:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbbCXSIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 14:08:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752346AbbCXSIY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 14:08:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F62041004;
	Tue, 24 Mar 2015 14:08:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1R/mj5Ag5Q8CEN8g1eSmTcCuXrA=; b=bEntTD
	Dryv5BAaTph2awl6vjKqI2npPxFc7l36yfkcB6P9djwrvWzXT9gFE3RG+ZyUwoyz
	wD65CgYPdeou+N2HDN5IgNa23RA38Z3Hf4C8ShpULvAhOQ7csDuq1y6yruYBuqep
	Zxdg1NFc5pXAhZJRvOlZvNo79BrZ6rBv2wYYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hYw8Un0oryPzLpwjMw3IFbuTnY+S41xx
	3RzIg/nWZs23LodvFU0VKwS0/9rgsIzxe/452XTke+CwI8U/QzS7pUan6A66WtMP
	QhlpWj/k48iqFIdkRtJUdHYB5boAz/JeEjvVIVuziexl5z9W9qzNYMQgwg0Am/QY
	5ln7PwsaFiU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 681BD41003;
	Tue, 24 Mar 2015 14:08:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 751B542000;
	Tue, 24 Mar 2015 14:08:21 -0400 (EDT)
In-Reply-To: <5511A166.3090009@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 24 Mar 2015 18:39:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C194A1A4-D250-11E4-9AB4-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266217>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Regarding specifically allowing/disallowing a leading '+': I saw a
> couple of callsites that explicitly check that the first character is a
> digit before calling strtol(). I assumed that is to disallow sign
> characters [1]. For example,
>
>     diff.c: optarg()

This one I know is from "if not a digit we know it is not a number";
it is not an attempt to say "we must forbid numbers to be spelled
with '+'", but more about "we do not need it and this is easier to
code without a full fledged str-to-num helper API" sloppiness.

>     builtin/apply.c: parse_num()

This parses "@@ -l,k +m,n @@@" after stripping the punctuation
around the numbers, so this is a valid reason why you would want an
optional feature "CANNOT_HAVE_SIGN" in the str-to-num parser and use
it.

>     maybe date.c: match_multi_number()

The approxidate callers parse random garbage input and attempt to
make best sense out of it, so they tend to try limitting the damage
caused by incorrect guesses by insisting "we do not consider +0 to
be zero" and such.  So this is a valid reason why you would want an
optional feature "CANNOT_HAVE_SIGN" in the str-to-num parser and use
it.

> I'm coming around to an alternate plan:
>
> Step 1: write a NUM_DEFAULT combination-of-options that gives the new
> functions behavior very like strtol()/strtoul() but without their insane
> features.
>
> Step 2: rewrite all callers to use that option (and usually endptr=NULL,
> meaning no trailing characters) unless it is manifestly clear that they
> are already trying to forbid some other features. This will already
> produce the largest benefit: avoiding overflows, missing error checking,
> etc.
>
> Steps 3 through ∞: as time allows, rewrite individual callsites to be
> stricter where appropriate.
>
> Hopefully steps 1 and 2 will not be too controversial.

All sounds sensible to me.
