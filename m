From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/2] optimizing pack access on "read only" fetch repos
Date: Thu, 31 Jan 2013 08:47:37 -0800
Message-ID: <CAJo=hJuGw8x=VrjWhvZhzakuhWrCWr2FRuEsNt5gQNC=6PPuVw@mail.gmail.com>
References: <20130126224011.GA20675@sigill.intra.peff.net> <7vlibfxhit.fsf@alter.siamese.dyndns.org>
 <20130129082939.GB6396@sigill.intra.peff.net> <7vwquwrng6.fsf@alter.siamese.dyndns.org>
 <20130129211932.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 17:48:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0xJE-0007HQ-O6
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 17:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab3AaQr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 11:47:59 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35251 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3AaQr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 11:47:57 -0500
Received: by mail-ie0-f182.google.com with SMTP id k14so2557849iea.27
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 08:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wkXkJf6wFo+nRLPrziFvSYloZ6nT2QJpQ7C1y2Oj6+Y=;
        b=XQmcZkvXf9uqpUEYRSyTBnH0h0hzL+K5kXwFNhdObjcPseUeFj0ouAcafj0W8s83Kb
         xrKpblvzU20RWRw0f6GItzCIG9UExVzKxqUrDtpZJiDvz9Nbd77HumLV75oBBM+V7IHp
         zep++9hlstDMf0EqEKwu3dUExlz7rL9tBhn/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=wkXkJf6wFo+nRLPrziFvSYloZ6nT2QJpQ7C1y2Oj6+Y=;
        b=VMY4+UOeWqEd6yOaWQMPq+iOFPEUrzYNXvIWevurWG69pXWqup1nRNfK74NDbNLpRn
         Op/spQnO/m6gFhXgWOpmIDVoBZ0U86w6aWwkcYR2OQrrr+7VlITN39hdgsJSyX4V2sFb
         GBnj0TW1/ImssbC8dpY1q9rZW+2UzAXr4GjJh00JfBg2rgqf6B9Jj9VmiVbkW23pjmFN
         12PhPraEn8oZZucYgaWp0SCmk9Oyx0JDTecFzWVhbAQiuQdHdSz3oWEUmpF2bDy34Kw4
         Vab+biN6yzdvnOD/j5PZesCT6fjXLFHInay12FgTZ8zx0zIWLMX5offBIgTxyGbl1xh8
         qu6g==
X-Received: by 10.50.216.229 with SMTP id ot5mr1699057igc.76.1359650877149;
 Thu, 31 Jan 2013 08:47:57 -0800 (PST)
Received: by 10.64.170.100 with HTTP; Thu, 31 Jan 2013 08:47:37 -0800 (PST)
In-Reply-To: <20130129211932.GA17377@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQkdobLp4UQ7SSKcU8d/WHrxi7IPLqnaHkOt/QJzkgqGwTefUbsGeBkSATQysUqAECznzorU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215124>

On Tue, Jan 29, 2013 at 1:19 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 29, 2013 at 07:58:01AM -0800, Junio C Hamano wrote:
>
>> The point is not about space.  Disk is cheap, and it is not making
>> it any worse than what happens to your target audience, that is a
>> fetch-only repository with only "gc --auto" in it, where nobody
>> passes "-f" to "repack" to cause recomputation of delta.
>>
>> What I was trying to seek was a way to reduce the runtime penalty we
>> pay every time we run git in such a repository.
>>
>>  - Object look-up cost will become log2(50*n) from 50*log2(n), which
>>    is about 50/log2(50) improvement;
>
> Yes and no. Our heuristic is to look at the last-used pack for an
> object. So assuming we have locality of requests, we should quite often
> get "lucky" and find the object in the first log2 search. Even if we
> don't assume locality, a situation with one large pack and a few small
> packs will have the large one as "last used" more often than the others,
> and it will also have the looked-for object more often than the others

Opening all of those files does impact performance. It depends on how
slow your open(2) syscall is. I know on Mac OS X that its not the
fastest function we get from the C library. Performing ~40 opens to
look through the most recent pack files and finally find the "real"
pack that contains that tag you asked `git show` for isn't that quick.

Some of us also use Git on filesystems that are network based, and
slow compared to local disk Linux ext2/3/4 with gobs of free RAM.

> So I can see how it is something we could potentially optimize, but I
> could also see it being surprisingly not a big deal. I'd be very
> interested to see real measurements, even of something as simple as a
> "master index" which can reference multiple packfiles.

I actually tried this many many years ago. There are threads in the
archive about it. Its slower. We ruled it out.

>>  - System resource cost we incur by having to keep 50 file
>>    descriptors open and maintaining 50 mmap windows will reduce by
>>    50 fold.
>
> I wonder how measurable that is (and if it matters on Linux versus less
> efficient platforms).

It does matter. We know it has a negative impact on JGit even on Linux
for example. You don't want 300 packs in a repository. 50 might be
tolerable. 300 is not.
