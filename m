From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 30/44] refs.c: add transaction.status and track
 OPEN/CLOSED/ERROR
Date: Wed, 21 May 2014 15:22:01 -0700
Message-ID: <20140521222201.GI12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-31-git-send-email-sahlberg@google.com>
 <20140521220035.GE12314@google.com>
 <CAL=YDW=Vpc8XGLGUTgKQc4yP5v+ViN02EeLzgRipntskok+fbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 00:22:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEtq-000415-He
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbaEUWWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:22:06 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:39704 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbaEUWWF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:22:05 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so1834505pbc.9
        for <git@vger.kernel.org>; Wed, 21 May 2014 15:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LsgTHbyx209U0QyiDqshGZt4RGOgHal6yotPc9E5ADU=;
        b=ugBCWBps1K55ooJCj5kPpK7322eak1i8+MhuA+f4DraDdseKlimSNToKQMSc2W0Bod
         0vwCwApCe9ZN+vzrClagRDByZcczIYUUyjOjm2cLUfrfL+ei66TZXTaLzKrQnwAanCoR
         IMtHdkqxsaERhcUuvBjSahWVjuPw+01xHcAOVlktCnT8V4ynJYOdA3SxBkK/Po4NKHSl
         yl8qI9JcORyTAI10pQQWLlnl6HCdEP0qwExAnpJ28wvJ/xIUERE7kYj3GEHhX3PiIuzJ
         up18+fTRNuEvmj5POpIya8OKAuXp8kcljTufkc/dvdlAJqBx3qK+gvK48K4p4rUcjyW+
         lswA==
X-Received: by 10.68.78.66 with SMTP id z2mr14736647pbw.71.1400710923957;
        Wed, 21 May 2014 15:22:03 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xc1sm110467910pab.39.2014.05.21.15.22.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 15:22:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDW=Vpc8XGLGUTgKQc4yP5v+ViN02EeLzgRipntskok+fbw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249853>

Ronnie Sahlberg wrote:

> Please pull my ref-transactions branch.

I'm at bd5736cb (2014-05-21 13:46) now.

> On Wed, May 21, 2014 at 3:00 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Ronnie Sahlberg wrote:

>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -3308,6 +3308,12 @@ struct ref_update {
>>>       const char refname[FLEX_ARRAY];
>>>  };
>>>
>>> +enum ref_transaction_status {
>>> +     REF_TRANSACTION_OPEN   = 0,
>>> +     REF_TRANSACTION_CLOSED = 1,
>>> +     REF_TRANSACTION_ERROR  = 2,
>>
>> What is the difference between _TRANSACTION_CLOSED and
>> _TRANSACTION_ERROR?
>
> Closed is a transaction that has been committed successfully, and
> which we can not do any more updates onto.
> Error is a transaction that has failed, and which we can not do any
> more updates onto.

That means that both mean the caller cannot do any more updates,
right?  Why not call them both _CLOSED?

> The distinction could be useful if in the future we add support to
> reuse a transaction

If the distinction becomes useful in the future, wouldn't that
be the moment to add a new state?

I don't mean that there has to be a big useful distinction.  E.g.,
maybe the idea is that when using a debugger it can be useful to see
the difference between _ERROR and _CLOSED or something, and I think
that would be fine as long as the intended meaning is documented
(e.g., using comments).  My only complaint is that it's hard to
understand the code and keep track of which status should be used in a
given place unless there is some distinction between them.

[...]
> ref_transaction_rollback is no more. It has been removed.

Thanks.  Sorry I missed that last time.

Jonathan
