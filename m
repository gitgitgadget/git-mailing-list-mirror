From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-credential-store: support XDG config dir
Date: Thu, 05 Mar 2015 10:37:16 -0800
Message-ID: <xmqqk2yv47fn.fsf@gitster.dls.corp.google.com>
References: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
	<1425414299-24000-2-git-send-email-pyokagan@gmail.com>
	<20150304094505.GA15593@peff.net>
	<CACRoPnTBmqtB+mvx9wFG3EUDRjfrsM==GQsso6V3q9NHH1k-YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 19:37:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTaeH-0001Wy-Ug
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 19:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbbCEShZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 13:37:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751803AbbCEShY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 13:37:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB3CD3D620;
	Thu,  5 Mar 2015 13:37:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=04WvPOk0unls8JO4G7ZGBsZ6IFI=; b=U4FQO+
	463SSsaxb1+IkZtjFUZzGODjTxvIRCzx9YCU81R1vHfvrAlAL7zYXFXrPxIjBTWf
	AErqdbzJesNkXTjcQxM1PxsCvDyjKGyEqP6p4E8OSsSNV8wRCgrsoybsRnvgQTNb
	KseHZvvOSkuHKWhhJcB1ARedq7R4lLvQ3jFz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KDVyOSCw0Zsvx0xF5RWuViIxHibu4wPM
	o3LDlzKcY+QaR14fHZaOmjDmt94YwdU0Hby/lifTOtvygeOM8WmuoeUBGoNrGddy
	BTBKUlDnK/W91YHzUrrH9/RbpH1KtW7rFkvQLInQwCm2Lfv610EIG1Pi5i8x17Iy
	dEkLWRDQi5o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3BC13D61F;
	Thu,  5 Mar 2015 13:37:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80EAD3D615;
	Thu,  5 Mar 2015 13:37:18 -0500 (EST)
In-Reply-To: <CACRoPnTBmqtB+mvx9wFG3EUDRjfrsM==GQsso6V3q9NHH1k-YA@mail.gmail.com>
	(Paul Tan's message of "Thu, 5 Mar 2015 14:26:39 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7188F64-C366-11E4-8130-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264857>

Paul Tan <pyokagan@gmail.com> writes:

> On Wed, Mar 4, 2015 at 7:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Paul Tan <pyokagan@gmail.com> writes:
>>
>>>       struct credential entry = CREDENTIAL_INIT;
>>> +     int found_credential = 0;
>>>
>>>       fh = fopen(fn, "r");
>>>       if (!fh) {
>>>               if (errno != ENOENT)
>>>                       die_errno("unable to open %s", fn);
>>> -             return;
>>> +             return 0;
>>
>> Returning found_credential here would be easier to read, no?  After
>> all, that is why you explicitly initialized it to 0 up there to say
>> "no we haven't found any yet".
>
> Actually I think die_errno is a function that does not return at all.
> The return is just to shut the compiler up. Perhaps I shall comment
> that.

Commenting just on this part (I am not agreeing or disagreeing with
you on other parts of your message yet).

When fopen() fails because we cannot open an existing file for
reading, then die_errno() will trigger and we stop there, in which
case the return will not be reached.

But when we try to open fn and we fail only because fn does not
exist, we do not say "die".  We instead return to the caller,
telling it that we have not found any credential so far in the file
supplied by the caller.

So the return does matter, and spelling that zero with
found_credential does matter for readability, I would think.
