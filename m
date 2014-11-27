From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/2] git-am: add --message-id/--no-message-id options
Date: Thu, 27 Nov 2014 01:23:55 +0100
Message-ID: <CAP8UFD1nibHuoz2a_EZigYuxPN6a7a8aXF9uGVS=syk5hm1iGw@mail.gmail.com>
References: <1416924056-29993-1-git-send-email-bonzini@gnu.org>
	<CAP8UFD0+Ef9JbbkZ+LBHcD6DVZiMGxFdrMnjLEViHHMERY5wuw@mail.gmail.com>
	<5474B5EE.1030406@redhat.com>
	<CAP8UFD0WcSM4NP8XHQe5pg0bwC5-C19OdcNoPWFFz7Ngrfbg8g@mail.gmail.com>
	<54759846.6040804@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paolo Bonzini <pbonzini@redhat.com>, git <git@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 27 01:24:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtmsL-00016V-2q
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 01:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbaK0AX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 19:23:57 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:60530 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaK0AX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 19:23:56 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so3651271iec.16
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 16:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EOW5GkfFWzBzoU6mLQ56Y4Ly6SCokSmFrkzejgA836Q=;
        b=xFGqaDnPQzh1vMzkCIwIEly4hwu4JxEd8JPcbTWD+Yab17NCE+oYq99IB8CEMZmpfm
         9/8HMazzYhLa4FubQfy/Bkiaqr6a56nhj7t4te/pMwzHiV3Q+IM8SkJiwW8C5FWe9+t6
         1arHhBrkB8UX8j7Fgi2IJElOCpQTMyEbC4L0LaCqYORQ8rfE+gDRgWX5dO6pDrwVQSP4
         5FJSKCxKRdDhBIKV8LpPSh8Mwzl7SnPw02ckV9X6mQkzPm1btiqjRaccReCyXXTEul/A
         Xmkyk4MJZORb1O8xVV/RW73lmfJfC2SMA+fqpzQYHBlG0Ckxqiz9GspsM9gNKGJd1n2Y
         8szg==
X-Received: by 10.42.155.197 with SMTP id v5mr29247854icw.52.1417047835675;
 Wed, 26 Nov 2014 16:23:55 -0800 (PST)
Received: by 10.50.30.40 with HTTP; Wed, 26 Nov 2014 16:23:55 -0800 (PST)
In-Reply-To: <54759846.6040804@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260326>

On Wed, Nov 26, 2014 at 10:07 AM, Paolo Bonzini <bonzini@gnu.org> wrote:
>
>
> On 25/11/2014 22:21, Christian Couder wrote:
>> On Tue, Nov 25, 2014 at 6:01 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> As far as I understand, all the git-am hooks are called on the commit
>>> rather than the incoming email: all headers are lost by the time
>>> git-mailinfo exits, including the Message-Id.  And you cannot call any
>>> hook before git-mailinfo because git-mailinfo is where the
>>> Content-Transfer-Encoding is processed.
>>>
>>> How would you integrate git-interpret-trailers in git-mailinfo?
>>
>> I don't know exactly, but people may want to add trailers when they
>> run git-am, see:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/251412/
>>
>> and we decided that it was better to let something like git
>> interpret-trailers decide how they should be handled.
>>
>> Maybe if git-interpret-trailers could be called from git-mailinfo with
>> some arguments coming from git-am, it could be configured with
>> something like:
>>
>> git config trailer.Message-Id.command 'perl -ne '\''print $1 if
>> m/^Message-Id: (.*)$/'\'' $ARG'
>>
>> So "git am --trailer 'Message-Id: msg-file' msg-file" would call "git
>> mailinfo ..." that would call "git interpret-trailers --trailer
>> 'Message-Id: msg-file'" that would call "perl -ne 'print $1 if
>> m/^Message-Id: (.*)$/' msg-file" and the output of this command, let's
>> call it $id, would be put into a "Message-Id: $id" trailer in the
>> commit message.
>
> I think overloading trailer.Message-Id.command is not a good idea,
> because it would prevent using "git interpret-trailers" to add a message
> id manually ("git interpret-trailers --trailer message-id='<foo@bar>'").

Well, it is possible to configure a trailer.Message-Id.command that
can detect if it is passed an existing file or not.
If it is passed an existing file, it could lookup the message id in
the file and print it, otherwise it would just print what it is
passed.

> Another possibility could be to add a third output file to git-mailinfo,
> including all the headers.  Then a hook could be called with the headers
> and commit message.

Yeah, but this hook could not do everything, because some people might
want to add trailers from the command line anyway.
So git interpret-trailers could be called once with the command line
arguments and once inside the hook.

If the user wants to have some processing done by some commands for
different trailers, it makes sense to have all the processing done by
commands specified in the trailer.<token>.command config variables,
instead of having some of it done by such config variables and other
done in some hooks.

> The question is: what would it be used for?  There aren't that many mail
> headers, and most of them (From, Subject, Date) are recorded in the
> commit anyway.  One idea could be to record who was a recipient of the
> original message, even if no Cc line was added explicitly.  In most
> projects, Cc is often added randomly, but I guess that's a valid
> usecase.  I can certainly code the above hook instead of this approach
> if Junio thinks it's better.

Yes, recording Cc'ed people in Cc: trailers is a very valid use case.
I don't think the trailer.<token>.command mechanism supports that well
if people want only one person per Cc: trailer.
That's something that could be improved in git-interpret-trailers.

> In the meanwhile, I have thought of a couple additions to "git
> interpret-trailers" and I can submit patches for them.

You are welcome to suggest and even more to submit patches for additions to it.
If you want, you can also have a look at some of these threads for
some things that have been suggested already:

http://thread.gmane.org/gmane.comp.version-control.git/259614/
thread.gmane.org/gmane.comp.version-control.git/259275/

Thanks,
Christian.
