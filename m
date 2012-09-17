From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the
 test suite for detecting heap corruption
Date: Mon, 17 Sep 2012 14:17:15 +0200
Message-ID: <CA+EOSBk0hN+v+PK8jzCCZgG0Ko7SsHOSB=cM7nnaSsrUOaJ-7Q@mail.gmail.com>
References: <1347641662-3596-1-git-send-email-gitter.spiros@gmail.com>
	<7v392k5w7u.fsf@alter.siamese.dyndns.org>
	<7vligc19d1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:17:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDaGT-0004j1-Su
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 14:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118Ab2IQMRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 08:17:17 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47174 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756102Ab2IQMRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 08:17:16 -0400
Received: by ieak13 with SMTP id k13so378826iea.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Pk9W7u4ZLCbRZC2D44P2tJamwJY/9i2DppbzVjdI+6U=;
        b=ACPjvn3kh0RcVSZBXqyL0EsIj1G9Bm8qIhKewaEhOhyw0zeLteMh5gM1KRAGaRA/3J
         taMg4K1N2PRZC57LNiZeyabeajMEv4CGQN3b04Pcpw3POE/EP3sBvKG12iD67JHD7gzq
         UorChhAMF0SkPzN/Y3QJDt93AfU3f+AISt627uOyWOBf24futEkttat7kjQmGhF0xb/F
         edhkGGWH+0N44MFjp5IdUjv3YE378mwZqLIRDrmsgmEqfN14beOKXL5gsNCbNhNqnVTG
         BDePFLlNi0+cblzMaUbKS5E2bLe8p5z35Kxe+MbU3ydaZKTehDs5zwp+CdtxzYjVcE4M
         StvA==
Received: by 10.50.236.100 with SMTP id ut4mr6518062igc.34.1347884235897; Mon,
 17 Sep 2012 05:17:15 -0700 (PDT)
Received: by 10.64.82.194 with HTTP; Mon, 17 Sep 2012 05:17:15 -0700 (PDT)
In-Reply-To: <7vligc19d1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205679>

2012/9/15 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Elia Pinto <gitter.spiros@gmail.com> writes:
>>
>>> Recent versions of Linux libc (later than 5.4.23) and glibc (2.x)
>>> include a malloc() implementation which is tunable via environment
>>> variables. When MALLOC_CHECK_ is set, a special (less efficient)
>>> implementation is used which is designed to be tolerant against
>>> simple errors, such as double calls of free() with the same argument,
>>> or overruns of a single byte (off-by-one bugs). When MALLOC_CHECK_
>>> is set to 3, a diagnostic message is printed on stderr
>>> and the program is aborted.
>>> ...
>>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>>> ---
>>> This the third reroll of the original patch.
>>
>> Well written.  I have one suggestion and a question, though.
>
> After looking at it a bit more, there are a few more things I would
> suggest, in the form of an squashable patch on top.
>
> Points to note:
>
>  - When test-lib.sh is used from perf-lib, we would not want to be
>    affected with MALLOC_CHECK_; we would want to run as vanilla as
>    possible in that case.
>
>  - We are interested in checking "git" and whatever we test using
>    the test harness, i.e. what comes inside test_expect_success.
>    Setting MALLOC_CHECK_ at the beginning will cover a lot more than
>    what we want to test.
>
>  - That "165" thing I mentioned earlier.

Thank you so much for the comments, that's fine. A single
consideration for  MALLOC_PERTURB.

You can use any value between 1..255 for MALLOC_PERTURB_
That chooses the byte that glibc will use to memset all freed buffers.
In general it is defined as

    export MALLOC_PERTURB_=$(($RANDOM % 255 + 1))

(as drepper pointed out http://udrepper.livejournal.com/11429.html)

I don't use RANDOM because it is not portable but $$ is sufficient for
the bias. I use this in popt
(http://rpm5.org/community/rpm-devel/5311.html but the site is down
now)

Using a random value is slightly better than using a fixed one
in case your fixed value is someday just the right/wrong value to mask
a problem.  At least with a random value, if you rerun
the test in a different shell, the odds are good you won't use
the unfortunate setting again. % is the module operation so the above
expression returns a value between 1 and 255 always (for the euclidean
division
property :=).

So OK per the original expression ? I prefer a perfect commit for git,
but no problem to follow your advice and reroll the patch.

Opinions ?

Best Regards
