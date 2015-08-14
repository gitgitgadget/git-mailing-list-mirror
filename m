From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 05/13] ref-filter: implement an `align` atom
Date: Fri, 14 Aug 2015 10:42:14 -0700
Message-ID: <xmqqh9o1ix6x.fsf@gitster.dls.corp.google.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-6-git-send-email-Karthik.188@gmail.com>
	<xmqqy4hhr72q.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZTnS0kL=CK8Lx-brO0tryB5YzOFUpapsM4LMW-m2Yf9pw@mail.gmail.com>
	<xmqqpp2sl9au.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZQbjVnJCxVu5SgKDUEVnidY=zw9nVYqG_z3nWhK8QnLTA@mail.gmail.com>
	<xmqqr3n8jlvv.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZQcd37Vq8j9sRYwnio0T3ua5C3frMc7-uEqLWsLo6eYYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 19:42:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQIzw-00050Q-O3
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 19:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbbHNRmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 13:42:17 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34737 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbbHNRmR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 13:42:17 -0400
Received: by pdbfa8 with SMTP id fa8so33241378pdb.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=CskhqL5uyDCvUH2lspL0vB8xqGf7xvggheMKbp7lKoI=;
        b=eHMLUsHk9OhhQwWXisCojh/bx8+z9jAfWgsJAQPLnYAVl+vJNsgkQ0vxm4tek469SJ
         iC886wOt8JsWA5G1qpmMrJ87GiUDA7tWU0BIl8YTWCPuWdWHLqNi7/xZwl1bBsxWIf3C
         Lj90Gwwf1ouJ7winvlI3TTLgFMBwhpMmO88lK7uYZ0fdy0+/Wl1dyHHATBOayi2gR4k9
         LrVp6R58jVWpLyBUsR5qPJpTy33aWltICxngfecfboCg9OY0MoY4w2xiQRj/BjKa9Ug8
         rrvQaeF1qzywU5sTqmL27j+8giN6sEHImjwyQxphbkTbO6CKyqA93YsKEoP2iWJXI8y3
         BkuA==
X-Received: by 10.70.38.132 with SMTP id g4mr18052208pdk.85.1439574136432;
        Fri, 14 Aug 2015 10:42:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id qf7sm6683675pbc.18.2015.08.14.10.42.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 10:42:15 -0700 (PDT)
In-Reply-To: <CAOLa=ZQcd37Vq8j9sRYwnio0T3ua5C3frMc7-uEqLWsLo6eYYg@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 14 Aug 2015 21:16:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275914>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Thu, Aug 13, 2015 at 1:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I think the most generic way to think about this is to consider that
>> the most fully spelled form of align would be this:
>>
>>         %(align:width=12,position=left)
>>
>> And another rule you would have is that the user is allowed to omit
>> "<attr>=" when it is obvious from its value.  For "align", 'left'
>> can only possibly be the value for 'position' and similarly '12' for
>> 'width'.  That is why the "objectname" example says "abbrev=8", and
>> not "abbrev,8", because from the value of "8" without the attribute
>> name, you cannot tell if the user meant abbrev=8 or magic=8.
>>
>> That '"<attr>=" can be omitted' rule makes both of these valid
>> constructs:
>>
>>         %(align:12,left) %(align:left,12)
>>
>
> Are you sure you want it to be so flexible?

Eventually, yes.

But that does not mean you must do it by next week, and that is why
I said "way to think about is to consider", not "way to design this
is to implement".

In the worst case, if the only-allowed form the end-users can give
were limited to "align:12,left" and "align:12" and "align:left,12"
failed in the version you complete by the end of GSoC, it is still
OK to ship it in 2.7, with a "known bugs" section for somebody
(maybe you) to further polish in the future.  As long as we leave
the door open for such an enhancement that would not make what used
to be valid invalid and only would allow what used to be invalid
valid, we would be fine---we can make progress without harming
existing users.
