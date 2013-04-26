From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: "git grep" parallelism question
Date: Fri, 26 Apr 2013 10:31:40 -0700
Message-ID: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 26 19:31:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVmUt-0008Hm-8J
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 19:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756661Ab3DZRbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 13:31:42 -0400
Received: from mail-vb0-f50.google.com ([209.85.212.50]:40049 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293Ab3DZRbl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 13:31:41 -0400
Received: by mail-vb0-f50.google.com with SMTP id w16so3804646vbb.9
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:date:x-google-sender-auth:message-id
         :subject:from:to:content-type;
        bh=PMQvgU2XQ3zaFAwnS/uqhW6wrB3uN1VSWLTEEFXmKCQ=;
        b=Ispm4HZ+cK6m7ZFZg/7X855w+nlSI9hBP94kOO03vXKsUh8AHln06S5xlm1qZlvHr7
         std3M9JO/ja1/kcCqnIcHJJUFTMIXBwa+8fvc7cQJ3498+WNq6ehPPx7qTFgItTyJNgL
         8YRxZ4Hqx/gQt9UgqbjVqueTOmzs6+G6ZZXlY95/dfSw+z+I4xRM9jOVZg59W/Rh+sLQ
         tIEAaOKZPLfvsAy/2gIPZLPLMIG5Fr8Yf7er4f0OHHzL7kz5s+3zGC24Fgj9tLZjqfL1
         L4Sup3qoI80PU7+jLYJgfUuDbz5W6N+QYBPBSk7TM8zrYLoeTBNmZIJ4jP6sEJRUjtHY
         iiXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:date:x-google-sender-auth:message-id
         :subject:from:to:content-type;
        bh=PMQvgU2XQ3zaFAwnS/uqhW6wrB3uN1VSWLTEEFXmKCQ=;
        b=goIDjYMtd8HAtpWfKz4gJ/I1KykAHC/MYL3GAE11eByhh9KKa5glOlOCm2WO8vKZ02
         B/U/862Yxm4HqWTOmkmasdSOJ3Ek3RrP0LisAkjbRhLjof/nYM2elp0TuRrk8frxTpt1
         ekozgnH0/9zss6r2dRETICXc+c5lLyry2joqg=
X-Received: by 10.58.188.48 with SMTP id fx16mr29391976vec.22.1366997500873;
 Fri, 26 Apr 2013 10:31:40 -0700 (PDT)
Received: by 10.220.186.197 with HTTP; Fri, 26 Apr 2013 10:31:40 -0700 (PDT)
X-Google-Sender-Auth: Ho8YIlbw5InIgGo9l-2Z6KRPXuU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222544>

Since I reboot fairly regularly to test new kernels, I don't *always*
have the kernel source tree in my caches, so I still care about some
cold-cache performance. And "git grep" tends to be the most noticeable
one.

Now, I have a SSD, and even the cold-cache case takes just five
seconds or so, but that's still somethng I react to, since the normal
"kernel tree in cache" case ends up bring close enough to
instantaneous (half a second) that then when it takes longer I react
to it.

And I started thinking about it, and our "git grep" parallelism seems
to be limited to 8.

Which is fine most of the time for CPU parallelism (although maybe
some people with big machines would prefer higher numbers), but for IO
parallelism I thought that maybe we'd like a higher number...

So I tried it out, and with THREADS set to 32, I get a roughly 15%
performance boost for the cold-cache case (the error bar is high
enough to not give a very precise number, but I see it going from
~4.8-4.9s on my machine down to 4.2..4.6s).

That's on an SSD, though - the performance implications might be very
different for other use cases (NFS would likely prefer higher IO
parallelism and might show bigger improvement, while a rotational disk
might end up just thrashing more)

Is this a big deal? Probably not. But I did react to how annoying it
was to set the parallelism factor (recompile git with a new number).
Wouldn't it be lovely if it was slightly smarter (something more akin
to the index preloading that takes number of files into account) or at
least allowed people to set the parallelism explicitly with a command
line switch?

Right now it disables the parallel grep entirely for UP, for example.
Which makes perfect sense if grep is all about CPU use. But even UP
might improve from parallel IO..

              Linus
