From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 05/13] ref-filter: implement an `align` atom
Date: Thu, 13 Aug 2015 01:37:17 +0530
Message-ID: <CAOLa=ZQbjVnJCxVu5SgKDUEVnidY=zw9nVYqG_z3nWhK8QnLTA@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
 <1439129506-9989-6-git-send-email-Karthik.188@gmail.com> <xmqqy4hhr72q.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZTnS0kL=CK8Lx-brO0tryB5YzOFUpapsM4LMW-m2Yf9pw@mail.gmail.com> <xmqqpp2sl9au.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 22:07:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPcJU-0001mB-Qu
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 22:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbbHLUHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 16:07:48 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36268 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbHLUHs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 16:07:48 -0400
Received: by obnw1 with SMTP id w1so21407437obn.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pRUdHoy/V8TRD2/f4pOnyeUG+lrFa4lGApfRRXBWQOM=;
        b=aDlgWLHijykXJhY2q06qZhCG3h2BquujvhsfYkPVYe9KJDgus6egWUApEdHxmWVn2T
         06QFhFL2LLKdhFk2LUDX3wdHAURM01zJo9E71Egbx76p7VTimTKjdkkVW/8Xarcou62A
         trfEW1z7sVS/SxHpVl0LEzAa3SW6os9DGExURVine9s0XIGHB+j+/e7IESwtx5rKU9ON
         reH/mr7MRvjwmME8fN5yzDbiXZ6gb/TSK9YiSyRXoBjxjF2fK4aYIEKbBwjMxgQg8KS2
         B+efqe9Vb+ASngjkOvhAkbD0SrcttPMbeOBniiYOP8BB9SJrNx0TERCgcYp3VFMubiuO
         fjLQ==
X-Received: by 10.60.177.195 with SMTP id cs3mr31487668oec.37.1439410067311;
 Wed, 12 Aug 2015 13:07:47 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 12 Aug 2015 13:07:17 -0700 (PDT)
In-Reply-To: <xmqqpp2sl9au.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275808>

On Wed, Aug 12, 2015 at 10:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Wed, Aug 12, 2015 at 12:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> Minor nits on the design.  %(align:<width>[,<position>]) would let
>>> us write %(align:16)...%(end) and use the "default position", which
>>> may be beneficial if one kind of alignment is prevalent (I guess all
>>> the internal users left-align?)  %(align:<position>,<width>) forces
>>> users to spell both out all the time.
>>>
>>
>> Isn't that better? I mean It sets a format which the others eventually
>> can follow
>> %(atom:suboption,value).
>> For example: %(objectname:abbrev,size)
>
> No, I do not think it is better.  First of all, the similarity you
> are perceiving does not exist.  For 'objectname:abbrev', the 'size'
> is a property of the 'abbrev'.  For 'align:left', the 'width' is not
> a property of the position.  It is a property given to 'align'
> (i.e. you have this many display columns to work with).
>
> Also, if there are ways other than 'abbrev' that '8' could affect
> the way how %(objectname) is modified, then it should be spelled as
> %(objectname:abbrev=8).  To specify two modification magics, each of
> which takes a number, the user would say e.g.
>
>     %(objectname:abbrev=8,magic=4)
>
> The syntax %(objectname:abbrev,size) would not allow you to extend
> it nicely---you would end up with %(objectname:abbrev,8,magic,4) or
> something silly like that.
>
> Seeing your %(objectname:abbrev,size), I'd imagine that you are
> assuming that you will never allow any magic other than 'abbrev'
> that takes a number to %(objectname).  And under that assumption
> %(objectname:8) would be a short-hand for %(objectname:8,abbrev).
>

I never thought about this, thanks for explaining.

> And that would be following %(align:8).  Both 'left' (implied
> default) and '8' are instructing 'align' what to do.
>

Will follow this. :)

-- 
Regards,
Karthik Nayak
