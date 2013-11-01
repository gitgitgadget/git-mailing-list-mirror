From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 03/10] transport-helper: add 'force' to 'export' helpers
Date: Fri, 1 Nov 2013 09:37:14 -0600
Message-ID: <CAMP44s1wfk3zmiof6E474vNi72zTo_QFj=56G3POjopukGK-5Q@mail.gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-7-git-send-email-felipe.contreras@gmail.com>
	<xmqqa9hp714d.fsf@gitster.dls.corp.google.com>
	<CAMP44s39H8tASO_OvK+C+XSG-2pm09RJY6Xeg4AqDZBAU7GPaw@mail.gmail.com>
	<xmqqfvrh5kev.fsf@gitster.dls.corp.google.com>
	<xmqqppqk2n3d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 16:37:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcGmq-0000wX-IR
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 16:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab3KAPhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 11:37:17 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50981 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab3KAPhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 11:37:16 -0400
Received: by mail-lb0-f174.google.com with SMTP id q8so3558039lbi.5
        for <git@vger.kernel.org>; Fri, 01 Nov 2013 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CtSKoGabv23wfK6HcrJruGoJfkO6Vj+z10GLypC9d9g=;
        b=aUkwpP9KCak32pcJvRSOnlGftzn1kTqX9DNVK1LSE/AxatoRtkVQQzjAkbKsmeGsVo
         eIz2SFYtNYt9uQ1/AJmoeCykopakXnc8XON1Rv3scmC1N/hKLVlKJ1x2sMKqHSijbE8C
         RgHy4qLAoy+qgbXhzBPmwjMA+axRDSGMrkwRXRVeDbBDFm5nb0rte2Jiz7wTs+UI3444
         dIih3x8QabSsAHbz64XuE3CZosP5+JmbHvvfmA6q44uTnVBmU7bs2CiAieel0ab3hNUO
         ZMOVa43FFLNVhX2+3hHxiSn8ZGCinCY2UISUzdiv9wZGDeQj2IjZLCJfONOEF1mpFwLu
         KHLA==
X-Received: by 10.112.130.168 with SMTP id of8mr50191lbb.66.1383320234303;
 Fri, 01 Nov 2013 08:37:14 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Fri, 1 Nov 2013 08:37:14 -0700 (PDT)
In-Reply-To: <xmqqppqk2n3d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237213>

On Fri, Nov 1, 2013 at 8:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Thu, Oct 31, 2013 at 12:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>> Otherwise they cannot know when to force the push or not (other than
>>>>> hacks).
>>>>> ...
>>>>> diff --git a/transport-helper.c b/transport-helper.c
>>>>> index d05fc7c..ed238e5 100644
>>>>> --- a/transport-helper.c
>>>>> +++ b/transport-helper.c
>>>>> @@ -854,6 +854,11 @@ static int push_refs_with_export(struct transport *transport,
>>>>>                       die("helper %s does not support dry-run", data->name);
>>>>>       }
>>>>>
>>>>> +     if (flags & TRANSPORT_PUSH_FORCE) {
>>>>> +             if (set_helper_option(transport, "force", "true") != 0)
>>>>> +                     die("helper %s does not support 'force'", data->name);
>>>>> +     }
>>>>> +
>>>>
>>>> Does this cause a "git push --force $there A:B" to fail when $there
>>>> is a destination that goes via an existing helper does not suport
>>>> "force" option?
>>>
>>> Yes.
>>>
>>>> Should it fail even when the current value of B is an ancestor of A
>>>> (i.e. when an unforced push would succeed)?
>>>
>>> It might make sense to fail only when the push is non-fast-forward,
>>> but it's not so straight-forward to implement.
>>
>> OK; let's see if anybody screams by cooking the series in 'next'
>> (that is, when other issues people may discover in the series are
>> addressed).
>>
>> Thanks.
>
> Actually, thinking about it again, would it be a better alternative
> to issue an error message and continue, instead of dying here
> (i.e. replace the above die() with error() or even warning())?
>
> That way, if the helper has not been updated to support 'force', but
> the user has been happily accepting the result he gets from "git
> push $there +master" (perhaps because he has never pushed a non-ff
> history so far), he now gets a warning that essentially says that
> his push has been working by accident, even when the particular
> ff-push that showed the error message goes through successfully.
>
> If his push through the helper that has not been updated does need
> 'force', he gets the same old behaviour, possibly a broken one, out
> of the helper, and again he does get the warning.
>
> Because updated helpers know 'force' option, such a s/die/warning/
> change would not affect them at all.

Yeah, that makes sense.

-- 
Felipe Contreras
