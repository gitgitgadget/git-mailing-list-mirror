From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 6/6] for-each-ref: avoid color leakage
Date: Tue, 19 Nov 2013 09:28:51 -0800
Message-ID: <xmqqwqk48fn0.fsf@gitster.dls.corp.google.com>
References: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
	<1384796353-18701-7-git-send-email-artagnon@gmail.com>
	<xmqqwqk59xyz.fsf@gitster.dls.corp.google.com>
	<CALkWK0mnYXBVW-agV_v6=mPxA=MoJAfHQaPKarwKU=x2SE+tnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 18:28:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vip6h-0005j7-2G
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 18:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393Ab3KSR2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 12:28:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34368 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962Ab3KSR2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 12:28:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 244D151DD7;
	Tue, 19 Nov 2013 12:28:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UzyMKLqUykqQbiZlPU5cFxNOki4=; b=SGrsyv
	q8+nPwO0WhTyb7C5uu8kNTXFjJCHWJX6cfidrTIogq3tlml01SYNqFn8xQkKJH3R
	PsdFKol7q7FS9N7ZWf0H/NPU/fvEyN8ZdKHXlXPb+Cn7vTt5uYPezWB5tZs2qzI1
	BNdUooAUtuNF1iNCtWCORsDhtN9jQbd4aCwRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IycNJ6+KvWq+AMUIZHgvXp4fzi3hbwL9
	wOP6VK7fbaYkmFw0c/BqPFxReLAz+/alTGToMxOgqaKFWzfdQj8IwzD9daS5Rgjg
	QAqEeqiRsHav4ugdf4F4R2nfwyYti1p+rwUNIUNa9xHcJfF0GOe6S2c2SaoxTiuX
	IPBzJZ8uEJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12C4351DD6;
	Tue, 19 Nov 2013 12:28:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D89351DD5;
	Tue, 19 Nov 2013 12:28:53 -0500 (EST)
In-Reply-To: <CALkWK0mnYXBVW-agV_v6=mPxA=MoJAfHQaPKarwKU=x2SE+tnQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 19 Nov 2013 10:07:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0FA1A66E-5140-11E3-96CC-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238033>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>>> index 2ff4e54..04e35ba 100644
>>> --- a/builtin/for-each-ref.c
>>> +++ b/builtin/for-each-ref.c
>>> @@ -23,6 +23,7 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>>  struct atom_value {
>>>       const char *s;
>>>       unsigned long ul; /* used for sorting when not FIELD_STR */
>>> +     int color : 2; /* 1 indicates color, 2 indicates color-reset */
>>>  };
>>
>> Hmph.  It looks wasteful to have this information in atom_value.
>
> I wanted to avoid an ugly global. On the other end of the spectrum,
> modifying the various functions to take an extra reset_color_leakage
> parameter seems much too intrusive. Do you have any suggestions?

We already represent information that is for the format string as
existing globals. It means that, if we ever want to make the program
accept and use more than one format string, we can't.  We need one
set of them for each such format string before we can use more than
one.

If you want to solve that problem, complaining by using a subjective
word "ugly" does not help us much.  The right approach to the
solution would be to first think what each global really means and
decide which ones are per-format properties.  Then turn them into a
proper abstraction by defining a structure to hold the currently
considered format string and these various "per format string"
properties.

Once you do that, you can optionally make the code pass that single
structure around, and that will remove the global, but I think that
step can wait until we actually find a need for it.
