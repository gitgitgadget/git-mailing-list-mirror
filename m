From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 03/10] transport-helper: add 'force' to 'export' helpers
Date: Thu, 31 Oct 2013 12:07:20 -0700
Message-ID: <xmqqfvrh5kev.fsf@gitster.dls.corp.google.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-7-git-send-email-felipe.contreras@gmail.com>
	<xmqqa9hp714d.fsf@gitster.dls.corp.google.com>
	<CAMP44s39H8tASO_OvK+C+XSG-2pm09RJY6Xeg4AqDZBAU7GPaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:07:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbxaZ-0003mv-Em
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267Ab3JaTHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:07:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50286 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755207Ab3JaTHX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 15:07:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF9314CC6D;
	Thu, 31 Oct 2013 15:07:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ylAzdkisENix/Q6qaobVFuWVJgE=; b=lFb46B
	tXxg+slejzL95o9DuGrO0PIV+6B4DXrt+9T3GVrInRe9l0v44/y+V8W45JMtNjot
	2inn40WJ7CM+ASWKpJeEPj3FvSXH5LJM5lkiDSHz7dXdDayAbasBUT2EWkZzfnM5
	OverUbWpEQ1LqsOjj6yXXf5PVo8KXVyvG4Sx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FuqH5bJdylPlkk5sVuJD07R8vutozZS7
	NzXoYXXOUScThv4LoF/ZHKfX8GFy3uhw+oJyjBdler6rEgtPPEENfVNfz689Jk4X
	eXKTN6NXWdJsXpVKErPARZ7rkFwiifANxJu3RbrFoR5dBFJsrUtDLMu9SZzIGfA8
	l0ZX8p0OXvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F2AF4CC6C;
	Thu, 31 Oct 2013 15:07:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC9144CC69;
	Thu, 31 Oct 2013 15:07:21 -0400 (EDT)
In-Reply-To: <CAMP44s39H8tASO_OvK+C+XSG-2pm09RJY6Xeg4AqDZBAU7GPaw@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 12:55:06 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AB9D3532-425F-11E3-BBF5-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237160>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Oct 31, 2013 at 12:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Otherwise they cannot know when to force the push or not (other than
>>> hacks).
>>> ...
>>> diff --git a/transport-helper.c b/transport-helper.c
>>> index d05fc7c..ed238e5 100644
>>> --- a/transport-helper.c
>>> +++ b/transport-helper.c
>>> @@ -854,6 +854,11 @@ static int push_refs_with_export(struct transport *transport,
>>>                       die("helper %s does not support dry-run", data->name);
>>>       }
>>>
>>> +     if (flags & TRANSPORT_PUSH_FORCE) {
>>> +             if (set_helper_option(transport, "force", "true") != 0)
>>> +                     die("helper %s does not support 'force'", data->name);
>>> +     }
>>> +
>>
>> Does this cause a "git push --force $there A:B" to fail when $there
>> is a destination that goes via an existing helper does not suport
>> "force" option?
>
> Yes.
>
>> Should it fail even when the current value of B is an ancestor of A
>> (i.e. when an unforced push would succeed)?
>
> It might make sense to fail only when the push is non-fast-forward,
> but it's not so straight-forward to implement.

OK; let's see if anybody screams by cooking the series in 'next'
(that is, when other issues people may discover in the series are
addressed).

Thanks.
