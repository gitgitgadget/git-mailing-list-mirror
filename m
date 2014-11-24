From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Mon, 24 Nov 2014 14:04:07 -0800
Message-ID: <xmqqtx1ouug8.fsf@gitster.dls.corp.google.com>
References: <6997784.RuzRO1AFsK@al>
	<xmqqsiherirj.fsf@gitster.dls.corp.google.com>
	<12667112.uUCmIHHWmi@al> <1628833.9HksdDrMW8@al>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Mon Nov 24 23:04:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt1jz-0001O7-BY
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 23:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbaKXWEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 17:04:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750768AbaKXWEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 17:04:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF237217A3;
	Mon, 24 Nov 2014 17:04:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XCRglh0n5CBVEoPTOMW7zN8L/as=; b=W/yTcg
	Nd4BTJl04XoNciQaiVPtTIBePCIT3CqxSUXUY4ll1RY1Nf5J8Ewi0wQBABT641ie
	BA9VVqRZl2f9/eyX+AX6Oamzkr50tMmSPLOPKaZ2qtROhXwKZUTstagaLOGr275h
	MFj8ZIRiXrlh7Da4ilxoaQyTd3gZW48NB5cyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sWSuxtGWRAqWo5QGC+glFmNC6qmr9CXx
	Ou7dP2iFlY59OTB60nyGeS/rOH2DKf/pgHtAhR4wXoZSxaPiUBhGXJKyNsbAgRx7
	VF//OC9ViWjBpeqoUlv2v495yJSvWxGjSylFhFn/sDvmhBKOOXa+/yS5DX9Rj9ep
	Os7VXmU6LZU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4AEE217A2;
	Mon, 24 Nov 2014 17:04:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F502217A1;
	Mon, 24 Nov 2014 17:04:08 -0500 (EST)
In-Reply-To: <1628833.9HksdDrMW8@al> (Peter Wu's message of "Mon, 24 Nov 2014
	22:45:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D043C3F8-7425-11E4-975F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260157>

Peter Wu <peter@lekensteyn.nl> writes:

> I propose to add the option --fetch next to --push with the meaning "set
> the fetch/push URL of remote NAME to URL". Then --fetch --push means
> "set the fetch and push URL of remote NAME to URL". 

What would (and "should") the configuration look like after you did
this?

	git remote set-url nick $url1
        git remote set-url nick --push $url2
        git remote set-url nick $url3

Whatever happens without your patch after the above is what the
current users (i.e. those who do not use the --fetch option) expect,
so if the behaviour does not change with your patch, then there is
one less incompatibilities to worry about.

A new option "--fetch" introducing a different behaviour is
perfectly fine; existing users who are not using it will not be
harmed by sudden behaviour change.

> In a future git
> version, this could be made the default option to avoid surprises (which
> would be backwards incompatible though).

I am not sure what you mean "by default".  If you mean "set both if
remote.nick.pushurl does not exist but otherwise update only
remote.nick.url", then the sequence

	git remote set-url nick $url1
        git remote set-url nick --push $url2
        git remote set-url nick $url3

would retain the current behaviour, so it probably is OK.

If you mean to always set remote.nick.url and remote.nick.pushurl
pointing at the same value when neither --fetch nor --push is given,
That would make the sequence behave quite different from what people
would expect, and you would need to devise a transition plan to
first start warning when the user did something that will behave
differently between the current version and the future version
without changing the behaviour, then switch the behaviour but keep
warning and finally remove the warning, or something like that.

And the above three-command sequence may not be the only case where
the change you are proposing may hurt existing users.
