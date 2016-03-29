From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v2] path.c enter_repo(): fix unproper strbuf unwrapping
 and memory leakage
Date: Tue, 29 Mar 2016 10:40:06 +0800
Message-ID: <CAKqreuxRbZ6VKNVbv+cNCJdguT3mt0Zy53vXZ+8dg0e1J3x59g@mail.gmail.com>
References: <20160325175947.GC10563@sigill.intra.peff.net>
	<1459180570-5521-1-git-send-email-huiyiqun@gmail.com>
	<20160328175528.GB20028@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Your friend <pickfire@riseup.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 04:40:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akjZl-00064n-Dn
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 04:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbcC2CkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 22:40:08 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36430 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbcC2CkH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 22:40:07 -0400
Received: by mail-oi0-f66.google.com with SMTP id s186so364021oib.3
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 19:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=guOqBtHqH/PEnCbPl9vgkzdTP46+eBLIuuelkP1891o=;
        b=YxlvIE72Gk4LRQcuHDXWkgdfV/r0cF0QYMNtaAerFwQzbw1eReitSFTW9NUOfK7csD
         YKMj01fnd7GAvUDWd/4HTmv1bVj/kz5VBeHUlCXihibN4t5xdx7G9P2WyVXZ2jYp/orY
         3tax/p9k/d7smupZ10eh+lWNsDX1VJjXQXUY2I27pJVh3cLvM7Bl/Zr8M5vAvqZnobsP
         n5IINVMn15VXrZPqK6Kjset5s4RNbxM8nlH8G1zvbuu/I9oarY4zvlSN2WtzQkG3n7n0
         iF3CRHUCAcot/EIBTioROBsSuadlmvRrLXepipFms/N4kIvRmLpxe46ccDjiIA8v/kM2
         aCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=guOqBtHqH/PEnCbPl9vgkzdTP46+eBLIuuelkP1891o=;
        b=ZBDYHymIyCwwH14SVbWnfcrzB1kg64Gb9JwBzHlA57LBe1pVFDW03Asir81aWbQ17a
         dL82vXN1j7VihMGn/ngTZXBAVqgl2A2PGiKe7M8EqV+tP3hFtmA+QeddhZHLA/2nBjYn
         e06VPnYXsB/KpqwdkU6ks95byns+0s8i2EN7EPgo2Syl7P9eHtj2eyzLSbhMlg14g1z5
         QYN4TMUPa8wjDtisWIWyZV5OKNwTTLUizgJroRq5aV1oIbYbWMn2QwNDiCVKShQxpP1W
         bNBcyXZE8q2EcJRB0vxsXbdBZG5E+EVsPWx5FNe7O3hq3spIo6Tn9UnFnSVJaF0ssCLx
         g9Lw==
X-Gm-Message-State: AD7BkJIltkb+NmsovldG8LwwuTaigwJDYye4PBM0/db6ognznNLFcBOcFJJH2I5PXMromgza8YLl5MdNdwE/Sg==
X-Received: by 10.157.44.66 with SMTP id f60mr12329503otb.163.1459219206764;
 Mon, 28 Mar 2016 19:40:06 -0700 (PDT)
Received: by 10.157.12.170 with HTTP; Mon, 28 Mar 2016 19:40:06 -0700 (PDT)
In-Reply-To: <20160328175528.GB20028@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290098>

2016-03-29 1:55 GMT+08:00 Jeff King <peff@peff.net>:
> On Mon, Mar 28, 2016 at 11:56:10PM +0800, Hui Yiqun wrote:
>
>> According to strbuf.h, strbuf_detach is the sole supported method
>> to unwrap a memory buffer from its strbuf shell.
>>
>> So we should not return the pointer of strbuf.buf directly.
>>
>> What's more, some memory leakages are solved.
>
> There is something else going on here, which makes this case different
> than some others. Note that the function returns a const string:
>
>> diff --git a/path.c b/path.c
>> index 969b494..b07e5a7 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -625,6 +625,7 @@ const char *enter_repo(const char *path, int strict)
>
> By convention, that means that the result is not owned by the caller,
> and should not be freed. We implement that by:
>
>>  {
>>       static struct strbuf validated_path = STRBUF_INIT;
>>       static struct strbuf used_path = STRBUF_INIT;
>
> ...using static variables which persist after the call returns. So this
> function retains ownership of the memory, and it remains valid until the
> next call to enter_repo().

Sorry for my carelessness. I didn't notice it.

> There's no leak when we return NULL, because the function retains
> control of the memory (though it will hold onto it until the end of the
> program if nobody calls enter_repo() again). And thus we shouldn't use
> strbuf_detach(), which loses that reference to the memory (and since the
> callers don't take ownership, it actually _creates_ a leak).
>
> We could release the memory when returning, but I don't think it's a big
> deal to do so.
>
> -Peff
