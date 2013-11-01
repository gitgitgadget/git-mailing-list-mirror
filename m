From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 03/10] transport-helper: add 'force' to 'export' helpers
Date: Fri, 01 Nov 2013 07:49:58 -0700
Message-ID: <xmqqppqk2n3d.fsf@gitster.dls.corp.google.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-7-git-send-email-felipe.contreras@gmail.com>
	<xmqqa9hp714d.fsf@gitster.dls.corp.google.com>
	<CAMP44s39H8tASO_OvK+C+XSG-2pm09RJY6Xeg4AqDZBAU7GPaw@mail.gmail.com>
	<xmqqfvrh5kev.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 15:50:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcG3K-0006TX-HC
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 15:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257Ab3KAOuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 10:50:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53282 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab3KAOuP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 10:50:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CD234CFC4;
	Fri,  1 Nov 2013 10:50:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JpPArZ336IPTuOjRLfuMGW0+b58=; b=sya0ac
	quIC1eUe5kxiaum1IXv475cg5HqbpTGLbANkhSOtw/SdXfRFEidFCATou9ubHLyE
	QoDcskEsroEqLLBGbbPZeGpAw9q3OuN39I/BIFyygR4KRBy/7RC+Qgw+jpYxuQCN
	Y2IK5JYiosiH6HoKwVrYXyWEze4GTdT9/53iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UMMbcs8I+iILD31dee4zkoBVaatgixoz
	CC1xvIhzzVKEE4L54rjjVS9qiLS9aesh+gW6UTLbSg1gQNEsHEYcMcvt3YKBJGC7
	7Rh0UNxxMi62qpvtqaux1Z33aJft1zBCqhZtfLsMdtziMWyOfY+ELTq56H4lo9Rj
	b2vZfBzxdvA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E9F74CFC2;
	Fri,  1 Nov 2013 10:50:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4789E4CFB7;
	Fri,  1 Nov 2013 10:50:00 -0400 (EDT)
In-Reply-To: <xmqqfvrh5kev.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 31 Oct 2013 12:07:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E2128CA2-4304-11E3-9620-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237211>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Oct 31, 2013 at 12:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Otherwise they cannot know when to force the push or not (other than
>>>> hacks).
>>>> ...
>>>> diff --git a/transport-helper.c b/transport-helper.c
>>>> index d05fc7c..ed238e5 100644
>>>> --- a/transport-helper.c
>>>> +++ b/transport-helper.c
>>>> @@ -854,6 +854,11 @@ static int push_refs_with_export(struct transport *transport,
>>>>                       die("helper %s does not support dry-run", data->name);
>>>>       }
>>>>
>>>> +     if (flags & TRANSPORT_PUSH_FORCE) {
>>>> +             if (set_helper_option(transport, "force", "true") != 0)
>>>> +                     die("helper %s does not support 'force'", data->name);
>>>> +     }
>>>> +
>>>
>>> Does this cause a "git push --force $there A:B" to fail when $there
>>> is a destination that goes via an existing helper does not suport
>>> "force" option?
>>
>> Yes.
>>
>>> Should it fail even when the current value of B is an ancestor of A
>>> (i.e. when an unforced push would succeed)?
>>
>> It might make sense to fail only when the push is non-fast-forward,
>> but it's not so straight-forward to implement.
>
> OK; let's see if anybody screams by cooking the series in 'next'
> (that is, when other issues people may discover in the series are
> addressed).
>
> Thanks.

Actually, thinking about it again, would it be a better alternative
to issue an error message and continue, instead of dying here
(i.e. replace the above die() with error() or even warning())?

That way, if the helper has not been updated to support 'force', but
the user has been happily accepting the result he gets from "git
push $there +master" (perhaps because he has never pushed a non-ff
history so far), he now gets a warning that essentially says that
his push has been working by accident, even when the particular
ff-push that showed the error message goes through successfully.

If his push through the helper that has not been updated does need
'force', he gets the same old behaviour, possibly a broken one, out
of the helper, and again he does get the warning.

Because updated helpers know 'force' option, such a s/die/warning/
change would not affect them at all.

Am I missing something?
