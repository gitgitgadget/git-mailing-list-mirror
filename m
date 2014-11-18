From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Mon, 17 Nov 2014 16:48:41 -0800
Message-ID: <20141118004841.GE4336@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 01:48:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqWyL-0006Ph-DQ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 01:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbaKRAsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 19:48:41 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:47839 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbaKRAsk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 19:48:40 -0500
Received: by mail-ie0-f170.google.com with SMTP id tr6so4116839ieb.29
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 16:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/WhKQeKzDEWhvnQCNLJTr7N3M9LkMIT5pbc5ewtdKO4=;
        b=UYVqHSdm9a+3rlezxpVqg7eRiLzh9lCXJXIItiLncF1wCjtlJM7ZX61IUbN9k0BDUL
         AG2qxSp7ttnbNhqBkDUV4amHbgp25Pmj2jd9fhbu+uIFHxpxFWbJ5CspRQ4t6a089UDZ
         m4B0DYEpKxJN/0TCuB575xNpDihS+mi2nf1nuj2Ke8fjF6XxJEL0qECRz/N+lb8fGWLZ
         3BwcF45+iEbBTMgUJYPxy3C2IrRBVY9y9UXuH94lZuUYFelT77NoDKmfbNy04muDOc8i
         f9nc9MsMMEz1Bk7GSa9unOycK1UdBy4ubKpmqgvKUy5bWUvkLEZPpIa5gUix31zGaw9S
         7Y8g==
X-Received: by 10.50.39.67 with SMTP id n3mr29921742igk.43.1416271720316;
        Mon, 17 Nov 2014 16:48:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:8c00:16f4:9f72:d6ec])
        by mx.google.com with ESMTPSA id oq10sm6819182igb.0.2014.11.17.16.48.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 16:48:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(meta-comment: please snip out the context you are not responding to,
 to make reading easier)
Stefan Beller wrote:
> On Mon, Nov 17, 2014 at 3:35 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Stefan Beller wrote:

>>> Update copy_fd to return a meaningful errno on failure and also
>>> preserve the existing errno variable.
>>
>> Some functions in git make errno meaningful on error and others don't.
>> In general, the more we only use errno immediately after a system
>> call, the better, so based on the above description this seems like a
>> step in the wrong direction.
>
> I did reword the commit message badly. Before it just read
> "Update copy_fd to return a meaningful errno".
>
> In fact the proposed patch doesn't guarantee the errno, which is set
> at the beginning of the function to be the same at the end.
>
> What it really should preserve is the errno from xread, while
> evaluating error("copy-fd: read returned %s", strerror(errno));
> So the function call of error(...) or strerror(...) may change the errno.

A successful call to strerror() is guaranteed not to change errno, but
a call to error() does I/O so it can clobber errno.

The basic question is whether errno is and should be part of
copy_fd()'s contract.  Until v2.2.0-rc0~53^2~2 (2014-10-01), it
wasn't.  Even after that change, there's no user-visible effect to
clobbering errno (so this patch is about maintainability, as opposed
to fixing a user-visible bad behavior).

[...]
>> Can we do better?  E.g., if the signature were
>>
>>         int copy_fd(int ifd, int ofd, struct strbuf *err);
>>
>> then we could write the error message to the err strbuf for the
>> caller to print.  The error handling would be more explicit so
>> there would be no need to protect errno from clobbering by other
>> system calls (both here and in callers).
>>
>> Something like this:
>
> I like this approach, though your patch is not about the original
> intention as this one
> (having strerror(...) not messing with the errno), but rather
> accumulating the errors not
> in numbers but string buffers?

After this patch, setting errno is not part of the contract of
copy_fd, so the bug Ronnie was fixing is gone.

But it's a little more invasive.  What do you think?

Thanks,
Jonathan
