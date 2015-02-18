From: Junio C Hamano <gitster@pobox.com>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Wed, 18 Feb 2015 09:13:10 -0800
Message-ID: <xmqq4mqj3zyx.fsf@gitster.dls.corp.google.com>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
	<vpqtwyl90mx.fsf@anie.imag.fr>
	<340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com>
	<vpqiof14qu8.fsf@anie.imag.fr>
	<13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com>
	<vpqr3tozzs5.fsf@anie.imag.fr>
	<xmqqwq3g31hj.fsf@gitster.dls.corp.google.com>
	<vpqwq3fup5g.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fairuzan Roslan <fairuzan.roslan@gmail.com>, git@vger.kernel.org,
	tboegi@web.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 18 18:14:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO8D5-0002Gr-56
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 18:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbbBRROm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 12:14:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753956AbbBRROk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 12:14:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF14938609;
	Wed, 18 Feb 2015 12:14:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hz9J/vOkpZiKOvJWFgufsDvicGc=; b=g8rJFv
	bkKv46vH2izBCn3f2XDZxmPRKM3rHB0kBxvSrClehCDZNQRGB9d/U9xOeVu6O9ST
	QoADkahF3RfM+2qi7Yzr9koupvnSCVGzdS/eXoZG3ZLGkW+AHpKQq4bUhqUwpN/o
	VkI2PYRgKLB4ArC/nClVUflfmt0QnItRA0HFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AvbDdr23lnJ7svHEjY2YaQKImC6nxuUP
	f2qRBiCBJUt0+gZNinJi4uqlv5ujjl4hYb0HPeRtg3ozcGqvcoA+q9gnK7CEgENj
	YAJMMhWd1SnDyEqby512Y5luiPwmjtNoEij3AP+cnlCoMD+xWiEEE1ausQMJaSda
	iMdIOPcUlac=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E653438608;
	Wed, 18 Feb 2015 12:14:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FA673857D;
	Wed, 18 Feb 2015 12:13:12 -0500 (EST)
In-Reply-To: <vpqwq3fup5g.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	18 Feb 2015 18:04:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B2A7070-B791-11E4-8944-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264031>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> in compat/broken-unlink.c and something like this
>>
>> 	#ifdef BROKEN_UNLINK
>> 	#define unlink(x) workaround_broken_unlink(x)
>>         #endif
>>
>> in git-compat-util.h instead? 
>
> That means we have to know BROKEN_UNLINK at compile-time. I had never
> heard about AFP before this thread, but they seem mountable on Linux and
> Windows. I don't know whether these platforms will have the same issue,
> but I suspect they will (if the server rejects the unlink).
>
> So, if my suspicion is right, we'd have to activate it on any platform
> able to mount AFP, i.e. essentially everywhere.

Sigh.

>
>> That way, people on well behaving systems do not have to worry about
>> clobbering errno and stuff, perhaps?
>
> With my solution, unlink() is always the last call in the function, so
> it should behave correctly right? Or did I miss anything?

I am primarily worried about blindly attempting to run chmod() after
seeing a failure from the first unlink() _without_ even making sure
that the failure is caused by this silly bug in a single filesystem.

If the first unlink() failed for some other reason, chmod()
succeeded, and then the second unlink() failed for the same reason
as the first failure (because the mode bits of the file being
unlinked did not have anything to do with it), that would leave a
file with wrong permission bits.  And doing so when the user may
know that there is no AFP involved in her set-up would be doubly
wrong, no?
