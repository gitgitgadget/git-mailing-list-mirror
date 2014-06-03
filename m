From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 25/41] fast-import.c: use a ref transaction when
 dumping tags
Date: Tue, 3 Jun 2014 14:32:49 -0700
Message-ID: <CAL=YDW=M1nioeiXu5mEHPY+hgPhLbm6MC509Je5E-13UYOUnPQ@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-26-git-send-email-sahlberg@google.com>
	<20140528194746.GX12314@google.com>
	<CAL=YDWkUhdoJkdg_zaq+p=XRu7H9fqNXDz89uPhbr4equTyVLQ@mail.gmail.com>
	<20140528221720.GB12314@google.com>
	<CAL=YDW=ruMzd=twadncjgFTh3yv=796cN72amJ4ep8a41tgmrA@mail.gmail.com>
	<20140528233940.GC12314@google.com>
	<CAL=YDW=WmNObkTO_uybTToeMKGGQf5NC0oFvy_pMrsg+ehpzog@mail.gmail.com>
	<20140529174106.GE12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 23:32:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwKF-0001pJ-4W
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934123AbaFCVcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:32:51 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:41117 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932907AbaFCVcu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:32:50 -0400
Received: by mail-ve0-f170.google.com with SMTP id db11so7672886veb.15
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H5DgRx938VJvLGMBlOrlxuH+kgM628uwu6svoxUNZZw=;
        b=PxCUjdmakpj3DwqdC8l2kJrAJFYx7F/lGVjmOcf1uUR3QiZk3RX2PVYBb4pzZVU8St
         yEhsl1OAFSvy2pyBNsYkUU0wh+ocHQQ1usB2s70OWboVvkNqmVzNcbeAhswCE8I81k7y
         eQfeqnKhK6zxFQRwT16UdhWFWrgyYeIzjpshU0VpUvhX++vkvg3rAdGEbfYajDLA01qO
         2C0vOXhpv1sv0WUSReD46Qvovdr/F/JUdBj/NIBesVaAP1rzufzXTXMgYbm20k5bPM94
         va9+QTyboHLA09zDqKxcjora0Utrjdmjjn8mQNGwflAL+I4t8UNQvE7jC7guJw1o7jJb
         bTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=H5DgRx938VJvLGMBlOrlxuH+kgM628uwu6svoxUNZZw=;
        b=j9pKKkaXDFRqfPJlUqrLmtA3b0Y3IrF1DnY+lc72rSxYdqyP4PnmgY+2jZZdBaKCeb
         vtzDZze3u96B+kYd/9ZzGw6BAKjrm/JAvPC4BDvlE8wNNy9rJA6BsC/wLMjywru+w15B
         5fIlvTzT9H1xZcpd4WfaOwwhtdxNISrY3h7GI0phrZeOP8TdJ8zFGYm7VhfRpf/GpVY1
         VqWHWSSv2vPC/VmgSwwTAHfknfCyzAgww+p39S/UM5a4mJU2peW/qbhzpH7cqDMMexQ/
         n15E++MpwFf5Mp3qrSBLjkEZ86PD9pjjbVlTPeez4A0Jq3qULBf6Kip4Ba+ADkVTpCBM
         TDBQ==
X-Gm-Message-State: ALoCoQmKSB3zFMNnLJMtGQmEFPO4NxzYgcjXcUTJSB248E4dIbHg7a18OFAeWdvxAzTKOPyCcdS4
X-Received: by 10.58.112.8 with SMTP id im8mr11014349veb.35.1401831169093;
 Tue, 03 Jun 2014 14:32:49 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Tue, 3 Jun 2014 14:32:49 -0700 (PDT)
In-Reply-To: <20140529174106.GE12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250646>

Thanks.

I have changed the transaction functions to die(BUG:) if the user
tries to call _update/_create/_delete on a failed transaction.



On Thu, May 29, 2014 at 10:41 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>> On Wed, May 28, 2014 at 4:39 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> Usually when ref_transaction_commit is called I can do
>>>
>>>         struct strbuf err = STRBUF_INIT;
>>>         if (ref_transaction_commit(..., &err))
>>>                 die("%s", err.buf);
>>>
>>> and I know that since ref_transaction_commit has returned a nonzero
>>> result, err.buf is populated with a sensible message that will
>>> describe what went wrong.
> [...]
>>> But the guarantee you are describing removes that property.  It
>>> creates a case where ref_transaction_commit can return nonzero without
>>> updating err.  So I get the following message:
>>>
>>>         fatal:
>>>
>>> I don't think that's a good outcome.
>>
>> In this case "fatal:" can not happen.
>> This is no more subtle than most of the git core.
>>
>> I have changed this function to explicitly abort on _update failing
>> but I think this is making the api too restrictive.
>
> I don't want to push you toward making a change you think is wrong.  I
> certainly don't own the codebase, and there are lots of other people
> (e.g., Michael, Junio, Jeff) to get advice from.  So I guess I should
> try to address this.
>
> I'm not quite sure what you mean by too restrictive.
>
>  a. Having API constraints that aren't enforced by the function makes
>     using the API too fussy.
>
>     I agree with that.  That was something I liked about keeping track
>     of the OPEN/CLOSED state of a transaction, which would let
>     functions like _commit die() if someone is misusing the API so the
>     problem gets detected early.
>
>  b. Having to check the return value from _update() is too fussy.
>
>     It certainly seems *possible* to have an API that doesn't require
>     checking the return value, while still avoiding the usability
>     problem I described in the quoted message above.  For example:
>
>      * _update() returns void and has no strbuf parameter
>      * error handling happens by checking the error from _commit()
>
>     That would score well on the scale described at
>     http://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html
>
>     An API where checking the return value is optional would be
>     doable, too.  For example:
>
>      * _update() returns int and has a strbuf parameter
>      * if the strbuf parameter is NULL, the caller is expected to
>        wait for _commit() to check for errors, and a relevant
>        message will be passed back then
>      * if the strbuf parameter is non-NULL, then calling _commit()
>        after an error is an API violation
>
> I don't understand the comment about no more subtle than most of git.
> Are you talking about the errno action at a distance you found in some
> functions?  I thought we agreed that those were mistakes that accrue
> when people aim for a quick fix without thinking about maintainability
> and something git should have less of.
>
> Jonathan
