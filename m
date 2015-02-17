From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git gc removes all packs
Date: Tue, 17 Feb 2015 13:57:05 -0800
Message-ID: <xmqq7fvg19se.fsf@gitster.dls.corp.google.com>
References: <CAC+L6n1M7LtGaJy94fnhXm94zJ32HXLNVGMguWSqHm=qqLLDxA@mail.gmail.com>
	<20150205200332.GD15326@peff.net> <54E36EBF.2070600@alum.mit.edu>
	<20150217165514.GA12176@peff.net> <54E3A695.1050708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Dmitry Neverov <dmitry.neverov@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 17 22:57:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNq8n-0003Vc-Ut
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 22:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbbBQV5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 16:57:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750846AbbBQV5I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 16:57:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 44B8338068;
	Tue, 17 Feb 2015 16:57:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ff4nEj9zQAuNc8kr7Su+PrqgQwM=; b=Feamd2
	UZBSJ4YrrCOPS+dJ/K3B166AXxtGfdLMnoR2ztS4Ny4WHz5KtpQ7LECqUwJlJ+mI
	K18PnoLaMB1yo07ezQplN2dC4Ww2lR1B76bTxwvsJmat+QUlN8kU59PfMafN471P
	tMUXRIIWFOkdMsCyYHBKGpyB1OOQeafXrJ1L8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ny/CtgiD4hG/rB1dZsw3HZUY9oF34Pit
	eK3JMJ9vv2qR0n47TAv6A1Ux/C/FdNNKRxKK0Og1Oh5mgE9wajG0QWWpqJoOM9WB
	PV32lFpX9IVXsUyS93zCrncZkOC0k3jmahJXQn5Lheru4TIpm2Rl4wQlv4B8lRGe
	1E+TOTP42E0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3750738067;
	Tue, 17 Feb 2015 16:57:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF3FC38065;
	Tue, 17 Feb 2015 16:57:06 -0500 (EST)
In-Reply-To: <54E3A695.1050708@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 17 Feb 2015 21:37:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EA0A9548-B6EF-11E4-95B0-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263989>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/17/2015 05:55 PM, Jeff King wrote:
>> On Tue, Feb 17, 2015 at 05:39:27PM +0100, Michael Haggerty wrote:
>> 
>>> There's a bunch of code in refs.c that is there explicitly for reading
>>> loose references that are symlinks. If the link contents literally start
>>> with "refs/", then they are read and treated as a symbolic ref.
>>> Otherwise, the symlink is just followed.
>> ...
> Yes, this makes sense too. But my point was that sticking symlinks to
> random files in your refs hierarchy is pretty questionable even *before*
> the symlink gets broken. If we would warn the user as soon as we saw
> such a thing, then the user's problem would never have advanced as far
> as it did. Do you think that emitting warnings on *intact* symlinks is
> too draconian?

Do you mean that we would end up reading refs/heads/hold if the user
did this:

    git rev-parse --verify HEAD -- >precious
    ln -s ../../../precious .git/refs/heads/hold

because that symbolic link does not begin with "refs/", and is an
accident waiting to happen so we should forbid it in the longer
term and warning when we see it would be the first step?
