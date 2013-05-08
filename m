From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 10/11] sha1_name: reorganize get_sha1_basic()
Date: Wed, 8 May 2013 15:39:25 -0500
Message-ID: <CAMP44s38eJP6WRQTQMDRqo-AXb7-YE1ZS-tJ7NK_QRwgHB3Obw@mail.gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
	<1367963711-8722-11-git-send-email-felipe.contreras@gmail.com>
	<7vbo8lfi8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 08 22:39:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaB99-00022b-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 22:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234Ab3EHUj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 16:39:29 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:36231 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781Ab3EHUj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 16:39:27 -0400
Received: by mail-la0-f48.google.com with SMTP id eg20so2178724lab.35
        for <git@vger.kernel.org>; Wed, 08 May 2013 13:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=L5wx8CfTsm6RyHR9PXKmoY7p8fE0DEbNDW6CrDoJt4g=;
        b=hgJb79xRfdBQlW8AQgMWjfxU8QCn3OFF0LUI8l0ImC7wqLg/eiO1JAXsj1I7vDQ7Gn
         N1KC8cTHwl6Rfa04jfFQE8Vhb/krAmoR7SvfbaUmM7hjvEc0lWOlJSDvKD0RkRehJrQM
         4Bzia03D5SF4ZWsGaDqsH4WFAJ8t3JaXRsFTKRvmD9GP5k8QiMGQrthewQC4Yfq3lHfU
         vSRJjnkevMY+OQ4Yqg5qP20Mw1jvwJ8oa88pN48tPJe8hyRrYoNzt2e4jeBZxflqw55E
         /JN2JkK6NKaIwyL7yu+3PUARGgUkHZyuE0iNGSNGweZcTlRGI/6cF6+rLngOY4g8Ap1q
         nLCw==
X-Received: by 10.112.125.130 with SMTP id mq2mr3953294lbb.103.1368045565772;
 Wed, 08 May 2013 13:39:25 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Wed, 8 May 2013 13:39:25 -0700 (PDT)
In-Reply-To: <7vbo8lfi8y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223685>

On Wed, May 8, 2013 at 1:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Through the years the functionality to handle @{-N} and @{u} has moved
>> around the code, and as a result, code that once made sense, doesn't any
>> more.
>>
>> There is no need to call this function recursively with the branch of
>> @{-N} substituted because dwim_{ref,log} already replaces it.
>>
>> However, there's one corner-case where @{-N} resolves to a detached
>> HEAD, in which case we wouldn't get any ref back.
>>
>> So we parse the nth-prior manually, and deal with it depending on
>> weather it's a SHA-1, or a ref.
>> ...
>
> s/weather/whether/;
>
>> @@ -447,6 +448,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>>       if (len && str[len-1] == '}') {
>>               for (at = len-4; at >= 0; at--) {
>>                       if (str[at] == '@' && str[at+1] == '{') {
>> +                             if (at == 0 && str[2] == '-') {
>> +                                     nth_prior = 1;
>> +                                     continue;
>> +                             }
>
> Does this have to be inside the loop?

Yes, the whole purpose is to avoid reflog_len to be set.

>> @@ -460,19 +465,22 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>>       if (len && ambiguous_path(str, len))
>>               return -1;
>>
>> -     if (!len && reflog_len) {
>> +     if (nth_prior) {
>>               struct strbuf buf = STRBUF_INIT;
>> -             int ret;
>> -             /* try the @{-N} syntax for n-th checkout */
>> -             ret = interpret_branch_name(str, &buf);
>> -             if (ret > 0)
>> -                     /* substitute this branch name and restart */
>> -                     return get_sha1_1(buf.buf, buf.len, sha1, 0);
>> -             else if (ret == 0)
>> -                     return -1;
>> +             int detached;
>> +
>> +             if (interpret_nth_prior_checkout(str, &buf) > 0) {
>> +                     detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
>> +                     strbuf_release(&buf);
>> +                     if (detached)
>> +                             return 0;
>> +             }
>> +     }
>
> Earlier, if @{-N} resolved to a detached head, we just fed it to
> get_sha1_1().  If it resolved to a concrete refname, we also fed it
> to get_sha1_1().  We ended up calling ourselves again and did the
> right thing either way.
>
> The new code bypasses the recursive call when we get a detached head
> back, because we know that calling get_sha1_1() with the 40-hex will
> eventually take us back to this codepath, and immediately return
> when it sees get_sha1_hex() succeeds.
>
> What happens when str @{-N} leaves a concrete refname in buf.buf?
> The branch name is lost with strbuf_release(), and then where do we
> go from here?  Continuing down from here would run dwim_ref/log on
> str which is still @{-N}, no?
>
> Ahh, OK, the new code will now let dwim_ref/log to process @{-N}
> again (the log message hints this but it wasn't all that clear),

I thought it was clear we would let dwim_{ref,log} do the job:

---
There is no need to call this function recursively with the branch of
@{-N} substituted because dwim_{ref,log} already replaces it.
---

> That is somewhat contrived, and I am not so sure if that is a good
> reorganization.

But much less contrived than before, because the code that deals with
@{-N} is in one place, instead of sprinkled all over as many
corner-cases, and there's no recursion.

> Also, a few points this patch highlights in the code before the
> change:
>
>  - If we were on a branch with 40-hex name at nth prior checkout,
>    would we mistake it as being detached at the commit?
>
>  - If we were on a branch 'foo' at nth prior checkout, would our
>    previous get_sha1_1() have made us mistake it as referring to a
>    tag 'foo' with the same name if it exists?

I don't know, but I suspect there's no change after this patch.

-- 
Felipe Contreras
