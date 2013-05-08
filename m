From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 10/11] sha1_name: reorganize get_sha1_basic()
Date: Wed, 8 May 2013 17:06:16 -0500
Message-ID: <CAMP44s0_h0gLyknHytdTeoA3E4e4hYYUP-_PKjJE9jWbUaYuPg@mail.gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
	<1367963711-8722-11-git-send-email-felipe.contreras@gmail.com>
	<7vbo8lfi8y.fsf@alter.siamese.dyndns.org>
	<CAMP44s38eJP6WRQTQMDRqo-AXb7-YE1ZS-tJ7NK_QRwgHB3Obw@mail.gmail.com>
	<7vsj1xcf81.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 00:06:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaCVD-000431-1r
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 00:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab3EHWGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 18:06:18 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:44603 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab3EHWGR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 18:06:17 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so2254028lab.12
        for <git@vger.kernel.org>; Wed, 08 May 2013 15:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AM7ZxrfdjH8q6eNX12moUR1J0uKr0LmkFC/3/X4iK2c=;
        b=BqiiNyDoruMI9bPFdg70nRMs/Yx67cndi/YJKNIizeyeMEPpJqcwESJb+DDMM0lnzw
         I7spIyvWnJCKo94G5d3oOD/KrgpzKIhYxF8bi+mJxRGFaVRODgvG5ESZpwwI7zvFWTRX
         whfZ/2XkuvUfmfNoCAQH3q/7JbKMzBNE8TEqeaEEx/Ob4FFMGbeP6zfbzrVJBYbWufTJ
         7nj7B+VB0ouvKCMjiPR4l6/SGieBvPby8VzX7xOQ6fX4btsVb8zUANlrgK+5ZJ2xdUu3
         DVtr/2ftufNqM1hqmbjL0cVvrBS5j86gTDcqLsqc/rdO7P0u1Ts2nq57BB2BPMU3yZZe
         XWeQ==
X-Received: by 10.152.22.168 with SMTP id e8mr4080238laf.20.1368050776225;
 Wed, 08 May 2013 15:06:16 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Wed, 8 May 2013 15:06:16 -0700 (PDT)
In-Reply-To: <7vsj1xcf81.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223690>

On Wed, May 8, 2013 at 4:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, May 8, 2013 at 1:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Through the years the functionality to handle @{-N} and @{u} has moved
>>>> around the code, and as a result, code that once made sense, doesn't any
>>>> more.
>>>>
>>>> There is no need to call this function recursively with the branch of
>>>> @{-N} substituted because dwim_{ref,log} already replaces it.
>>>>
>>>> However, there's one corner-case where @{-N} resolves to a detached
>>>> HEAD, in which case we wouldn't get any ref back.
>>>>
>>>> So we parse the nth-prior manually, and deal with it depending on
>>>> weather it's a SHA-1, or a ref.
>>>> ...
>>>
>>> s/weather/whether/;
>>>
>>>> @@ -447,6 +448,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>>>>       if (len && str[len-1] == '}') {
>>>>               for (at = len-4; at >= 0; at--) {
>>>>                       if (str[at] == '@' && str[at+1] == '{') {
>>>> +                             if (at == 0 && str[2] == '-') {
>>>> +                                     nth_prior = 1;
>>>> +                                     continue;
>>>> +                             }
>>>
>>> Does this have to be inside the loop?
>>
>> Yes, the whole purpose is to avoid reflog_len to be set.
>
> What I meant was the "<nothing>@{-" check, which happens only at==0.
>
>         if (!memcmp(str, "@{-", 3) && len > 3)
>                 nth_prior = 1;
>         else
>                 for (at = len - 4; at; at--) {
>                         ... look for and break at the first "@{" ...
>                 }
>
> or something.

That's doable, but would screw up the next patch.

>>> Ahh, OK, the new code will now let dwim_ref/log to process @{-N}
>>> again (the log message hints this but it wasn't all that clear),
>>
>> I thought it was clear we would let dwim_{ref,log} do the job:
>
> Yes, the reason I did not immediately think of that is because I
> knew @{-N} was expensive (need to read reflog backwards) and didn't
> think anybody would redo the code to deliberately do that twice ;-)

But that's what the commit message said.

>>> Also, a few points this patch highlights in the code before the
>>> change:
>>>
>>>  - If we were on a branch with 40-hex name at nth prior checkout,
>>>    would we mistake it as being detached at the commit?
>>>
>>>  - If we were on a branch 'foo' at nth prior checkout, would our
>>>    previous get_sha1_1() have made us mistake it as referring to a
>>>    tag 'foo' with the same name if it exists?
>>
>> I don't know, but I suspect there's no change after this patch.
>
> Yes, didn't I say "the code before the change" above?
>
> These two correctness issues look more important issues to me, with
> or without the restructure patch (in other words, they are
> independent).

Right, if you are interested in correctness, you might want to try
@{-1}{0}; it resolves to @{-1} currently, and it fails correctly with
my patch.

Cheers.

-- 
Felipe Contreras
