From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Wed, 01 Jun 2016 08:07:16 -0700
Message-ID: <xmqqfusx0wyj.fsf@gitster.mtv.corp.google.com>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
	<20160531225628.GA4585@sigill.intra.peff.net>
	<CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
	<20160601023159.GA5411@sigill.intra.peff.net>
	<20160601033139.GB5411@sigill.intra.peff.net>
	<20160601034413.GC5411@sigill.intra.peff.net>
	<20160601053325.GA20797@sigill.intra.peff.net>
	<20160601054048.GB20797@sigill.intra.peff.net>
	<xmqqshwx1k0p.fsf@gitster.mtv.corp.google.com>
	<20160601070425.GA13648@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 17:07:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b87k4-00045M-Uy
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 17:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758537AbcFAPHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 11:07:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754751AbcFAPHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 11:07:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D242A1E9B4;
	Wed,  1 Jun 2016 11:07:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tmAJ+mqbXP8B35GwqAKdCyLlDgw=; b=o5rLuy
	KCiJj4+meXVua7FFKYM9kFUi3gT8pwpDd3a4vBpaRFbd7oVu0FZAjjj+Y79J/tkq
	P/gRetm1q5A3CGQw/F5d3v1xAwQG2SduNxm0aGetNjzbp2Y8RWV+qGC2jpWSH3oe
	vySRAsiPdavvmXQuZN4Rcz0XKqAXJDMLZJevo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wkY9uY5NXWTZiDzO8mUBhhqV36/LtNHM
	+3VrbDi3l95bphkxCdBfWqbk48kdL4d7Iism8fFyrWk8ULHx3x1NHlQwGcK2Pmot
	Cao0qksJEWrBst8+OZGv8qnPqkp7pK0edeEqFnT3RG8y0g/lcvCuYPdUuiTT4DlJ
	QJIVjncfyMU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C89441E9B1;
	Wed,  1 Jun 2016 11:07:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DD211E9B0;
	Wed,  1 Jun 2016 11:07:18 -0400 (EDT)
In-Reply-To: <20160601070425.GA13648@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 1 Jun 2016 03:04:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8853302A-280A-11E6-A698-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296087>

Jeff King <peff@peff.net> writes:

>> > 					eval "${1%%=*}=\${1#*=}"
>> 
>> Is this an elaborate way to say 'eval "$1"', or is there anything
>> more subtle going on?
>
> Notice that the value half isn't expanded until we get inside the eval.

Ahh, right.

> Here's the patch I wrote up earlier (but was too timid to send out after
> my barrage of emails :) ).

Looks very sensible.  I'll drop all these "Attempt to test with
ksh93 found these breakages" patches and queue this one.

> -- >8 --
> Subject: test-lib: add in-shell "env" replacement
>
> The one-shot environment variable syntax:
>
>   FOO=BAR some-program
>
> is unportable when some-program is actually a shell
> function, like test_must_fail (on some shells FOO remains
> set after the function returns, and on others it does not).
>
> We sometimes get around this by using env, like:
>
>   test_must_fail env FOO=BAR some-program
>
> But that only works because test_must_fail's arguments are
> themselves a command which can be run. You can't run:

We can do "test_must_fail test_commit ...", but "test_must_fail env
FOO=BAR test_commit ..." would not work, right?

If so s/because/when/, perhaps?
