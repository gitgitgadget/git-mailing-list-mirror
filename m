From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: "git grep" parallelism question
Date: Mon, 29 Apr 2013 19:35:01 +0530
Message-ID: <CALkWK0k6Gi_J6nDbrGPxDMmWC73CHXdj7a5ugC15YVrrycP=hA@mail.gmail.com>
References: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
 <7vr4hxw2mp.fsf@alter.siamese.dyndns.org> <CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
 <7vip39w14d.fsf@alter.siamese.dyndns.org> <CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 29 16:05:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWoiE-00052Q-91
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 16:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272Ab3D2OFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 10:05:43 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:60875 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737Ab3D2OFm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 10:05:42 -0400
Received: by mail-ie0-f180.google.com with SMTP id to1so7198754ieb.25
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=kOiVdjKdbNXYtFQArCNZEFFvVPZg4zRkAQSRGDUeFak=;
        b=W8tDdefAbrIAUEzRkkVg31CpULn5Ev0ORSP/kRckUOrRwRSk+pqg3SXL9uiUEhwQHa
         VXwZgV+PrPtkeJk2gRiMTSXFUG20wg/qMPTRDCVXQDwDlmdm3vMoB9GBYIdeaVc8flZ+
         jIpPLaVsh1BHCT56/EzNePg0qeanSNzGjAujfog2NPc2GTx+LXPJUP3IhzoCiuLNuCa2
         aAiWtYWZ/9c+dDG/YHDBnBbCmmhVpBLfyx3DlPxdYIAlkiWR3I31qnCObrEZ/nxGrthX
         JCwJ2gV+kZJ1H+JRlINafH3kGbZc4E4sneXSdbAHU119h9K065CKvNKFGFNVKo2e+vVR
         quhQ==
X-Received: by 10.50.73.65 with SMTP id j1mr1042088igv.49.1367244341491; Mon,
 29 Apr 2013 07:05:41 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 07:05:01 -0700 (PDT)
In-Reply-To: <CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222796>

Linus Torvalds wrote:
> Anyway, I think your patch is good if for no other reason that it
> allows this kind of testing, but at least for my machine, clearly the
> current default of eight threads is actually "good enough". Maybe
> somebody with a very different machine might want to run the above
> script and see if how sensitive other machines are to this parameter..

I have four cores with HT, so I expect similar gains from CPU
parallelism (in the hot-cache case).  And the test results meet this
expectation:

1 real 0m1.287s
2 real 0m0.635s
4 real 0m0.460s
8 real 0m0.413s
16 real 0m0.443s
32 real 0m0.715s

I have a rotating hard disk, and expect the IO parallelism (cold-cache
case) benefits to peak at a larger number of threads (than in your SSD
case).  These are the test results:

1 real 0m28.566s
4 real 0m20.361s
8 real 0m16.990s
16 real 0m15.278s
32 real 0m13.710s
64 real 0m12.405s
128 real 0m11.913s
256 real 0m11.759s
512 real 0m12.022s

It looks like 128~256 threads is the sweet spot.

It's impossible for git to determine if the cache is hot or cold,
correct?  Cold cache is a very rare case, and I'm not sure how we can
optimize specifically for that case.  So, I'm not sure how we can
improve grep.

On a related note, one place that IO parallelism can provide massive
benefits is in executing shell scripts.  Accordingly, I always use the
following commands to compile and test git respectively:

    make -j 8 CFLAGS="-g -O0 -Wall"
    make -j 8 DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="-j 16" test

i.e. always use 8 threads when the task is known to be CPU intensive,
and always use 16 threads when the task is known to be IO intensive.
