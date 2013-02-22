From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] git-commit: populate the edit buffer with 2 blank lines
 before s-o-b
Date: Fri, 22 Feb 2013 14:03:42 -0800
Message-ID: <CA+sFfMdok7wRDhgq7i=b3cu3LB+poExvxLBxYkg8L3pN92bEYg@mail.gmail.com>
References: <7vobfdtl1n.fsf@alter.siamese.dyndns.org>
	<1361525158-3648-1-git-send-email-drafnel@gmail.com>
	<7vbobcdwo7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: pclouds@gmail.com, jrnieder@gmail.com, john@keeping.me.uk,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 23:04:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U90iu-0003U3-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 23:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249Ab3BVWDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 17:03:44 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:59561 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756985Ab3BVWDn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 17:03:43 -0500
Received: by mail-wi0-f182.google.com with SMTP id hi18so1299734wib.15
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 14:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=oRQ/RfUAoPMiT11Ups6BMxefd+M1fozS2NTlrLLKmaA=;
        b=fRgrlyKQEWWlYxCLvxnfv3lM1VU6RjQsevjQSKKwrVLzzUUeaHOvJmO4NZe9yjjfx3
         Tz/iMsbAgaVmvhKy7t7Hnueiv3TYTXg1crXZZKAfWu0cQK1fQiIqwanVbf7N2pRigphk
         B2eBJQj47eVAacqsaLBz7uF0gKk8krU8ERhjAiPxKbN4WkbjO5cV71A5Gsrg5oZFbUXJ
         7jxiW13FI7eVl9RhDyGiY0yY7Sao9abfOVxzLOzsZyTlJytYWb7mhaiE9LYgcXRtf7mD
         VE+p0YJDUFwCgnnWegKtGVxYvZKf8l2w9C7oMuLKIQ47sTx1Km1a8gcf3NfZO8CDQ8pS
         PUMA==
X-Received: by 10.194.92.65 with SMTP id ck1mr6346120wjb.54.1361570622377;
 Fri, 22 Feb 2013 14:03:42 -0800 (PST)
Received: by 10.194.63.46 with HTTP; Fri, 22 Feb 2013 14:03:42 -0800 (PST)
In-Reply-To: <7vbobcdwo7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216867>

On Fri, Feb 22, 2013 at 10:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:

>> diff --git a/sequencer.c b/sequencer.c
>> index 53ee49a..2dac106 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1127,9 +1127,10 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>>               const char *append_newlines = NULL;
>>               size_t len = msgbuf->len - ignore_footer;
>>
>> -             if (len && msgbuf->buf[len - 1] != '\n')
>> +             /* ensure a blank line precedes our signoff */
>> +             if (!len || msgbuf->buf[len - 1] != '\n')
>>                       append_newlines = "\n\n";
>> -             else if (len > 1 && msgbuf->buf[len - 2] != '\n')
>> +             else if (len == 1 || msgbuf->buf[len - 2] != '\n')
>>                       append_newlines = "\n";
>
> Maybe I am getting slower with age, but it took me 5 minutes of
> staring the above to convince me that it is doing the right thing.
>
> The if/elseif cascade is dealing with three separate things and the
> logic is a bit dense:
>
>  * Is the buffer completely empty?  We need to add two LFs to give a
>    room for the title and body;
>
>  * Otherwise:
>
>    - Is the final line incomplete?  We need to add one LF to make it a
>      complete line whatever we do.
>
>    - Is the final line an empty line?  We need to add one more LF to
>      make sure we have a blank line before we add S-o-b.
>
> I wondered if we can rewrite it to make the logic clearer (that is
> where I spent most of the 5 minutes), but I did not think of a
> better way; probably the above is the best we could do.

We could unroll the conditionals into individual blocks and add your
comments from above like:

   if (!len) {
      /* The buffer is completely empty.  Leave room for the title and body. */
      append_newlines = "\n\n";
   } else if (msgbuf->buf[len - 1] != '\n') {
      /* Incomplete line.  Complete the line and add a blank one */
      append_newlines = "\n\n";
   } else if (len == 1) {
      /*
       * Buffer contains a single newline.  Add another so that we leave
       * room for the title and body.
       */
      append_newlines = "\n";
   } ...

Not sure that it will reduce the amount of time needed to understand
what's going on, but at least it describes the expectations made by
each block.

> Thanks.
>
> By the way, I think we would want to introduce a symbolic constants
> for the possible return values from has_conforming_footer().  The
> check that appears after this hunk
>
>         if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
>                 strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
>                                 sob.buf, sob.len);
>
> is hard to grok without them.

Yeah, Jonathan said the same thing and I agree.  I was hoping someone
else would beat me to it.

-Brandon
