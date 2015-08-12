From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 05/13] ref-filter: implement an `align` atom
Date: Wed, 12 Aug 2015 13:24:20 -0700
Message-ID: <xmqqr3n8jlvv.fsf@gitster.dls.corp.google.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-6-git-send-email-Karthik.188@gmail.com>
	<xmqqy4hhr72q.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZTnS0kL=CK8Lx-brO0tryB5YzOFUpapsM4LMW-m2Yf9pw@mail.gmail.com>
	<xmqqpp2sl9au.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZQbjVnJCxVu5SgKDUEVnidY=zw9nVYqG_z3nWhK8QnLTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 22:24:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPcZY-0003pY-9L
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 22:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbbHLUYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 16:24:23 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33728 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbHLUYW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 16:24:22 -0400
Received: by pabyb7 with SMTP id yb7so21404535pab.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bIrW40nv2ITMMWs4/Upi5uSGmVMOb+sqCykltQfXTk8=;
        b=qnyXmFt6wPrGorRtNujhzdpAsrfP56hExFQzaoZAhwtJFGl/mduTcw2zEMmnT3o0Qs
         YX1OSu2DvRJLuQCC0GHx23ULShf4N8Sjh6ZeZ1rNXkpl/DXz/Kny9SbZbtG/oS2B+950
         oqAouSFiqEnwH9Qdqe7AeDb+jADbWUEgAjs1TCxnk/2Ieo1GvXyzRM8OR4p7xirAAnSE
         MykNqaeEsdHB0ZkDZWZnCJg6lUYWOw7eH9LPjvzW0L4JXQBVH9YcNcwsiSFsI+1okoVe
         CRTOi+Shl28rFNGJAu9HanrYfn/XY9EESQERVwYa986y7CeodDSXzZOVpCxYlpGO+Lbm
         jhGQ==
X-Received: by 10.68.113.194 with SMTP id ja2mr70882882pbb.46.1439411062518;
        Wed, 12 Aug 2015 13:24:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id ra10sm7499684pab.19.2015.08.12.13.24.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 13:24:21 -0700 (PDT)
In-Reply-To: <CAOLa=ZQbjVnJCxVu5SgKDUEVnidY=zw9nVYqG_z3nWhK8QnLTA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 13 Aug 2015 01:37:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275809>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Wed, Aug 12, 2015 at 10:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> %(objectname:abbrev=8).  To specify two modification magics, each of
>> which takes a number, the user would say e.g.
>>
>>     %(objectname:abbrev=8,magic=4)
>> ...
>> And that would be following %(align:8).  Both 'left' (implied
>> default) and '8' are instructing 'align' what to do.
>
> Will follow this. :)

I think the most generic way to think about this is to consider that
the most fully spelled form of align would be this:

	%(align:width=12,position=left)

And another rule you would have is that the user is allowed to omit
"<attr>=" when it is obvious from its value.  For "align", 'left'
can only possibly be the value for 'position' and similarly '12' for
'width'.  That is why the "objectname" example says "abbrev=8", and
not "abbrev,8", because from the value of "8" without the attribute
name, you cannot tell if the user meant abbrev=8 or magic=8.

That '"<attr>=" can be omitted' rule makes both of these valid
constructs:

	%(align:12,left) %(align:left,12)

Moreover, if you make "left aligned" the default behaviour when
position is not specified, you can make %(align:12) the shortest way
to spell the same thing.  Note that I said "if you make"; I do not
offhand know if all the internal callers of this mechanism your
updates to "branch -l" and "tag -l" would want left aligned output
(if so, that is one argument to favor making left-aligned the
implicit default; if not, it may be better to require the position
always specified).
