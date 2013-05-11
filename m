From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] cache.h: eliminate SHA-1 deprecation warnings on OS X 10.8
Date: Sat, 11 May 2013 02:17:10 -0700
Message-ID: <CAJDDKr4DoEUw=4O_m-91Hsg4SRZzkn6yJPf_nBsPsEv0Weibrw@mail.gmail.com>
References: <1368240282-89581-1-git-send-email-davvid@gmail.com>
	<20130511062336.GD3394@elie>
	<CAJDDKr6QkeSk32kNhU_QuvrZSGUEokcEbN7Aq3PcOhvaA_hFgg@mail.gmail.com>
	<20130511082203.GA953@sigill.intra.peff.net>
	<CAJDDKr7-sMrX=2Aek1LY8knM2jFPs933eLj3iZdTa68YYv-6Og@mail.gmail.com>
	<20130511084543.GA1905@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 11 11:17:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub5ve-0001iU-9n
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 11:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969Ab3EKJRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 05:17:13 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:34068 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab3EKJRM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 05:17:12 -0400
Received: by mail-ee0-f49.google.com with SMTP id d17so2627409eek.36
        for <git@vger.kernel.org>; Sat, 11 May 2013 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=gwvNvac4hDFVGjhL6Cw/pcmZHySsfDmYh/3C7jxQwUQ=;
        b=COuSHgPiXnTDH1NB01eG/Ys3j5pTvNTAyiRsXvCNdZoOCudd6iZSN7VgHCW9VNvzKZ
         p9uJcfBjdHxpVmUwRN+R1hey39rdL53fKa9IVugw4Pz6bFr4q6PZd6SVG/KRzkYC59Y+
         lo1I6uYtYoQP0TRcv5La4Dh5FaFvPUNiWOxqNsAw46n6dAG2kq+o8IX7407NqnAVQFsT
         hbimgxKaHfeZ0knhv8cqRGImRWm+MuIjT1C4DfOHZMMsCIwm8Xlszm8Jn5orKmQ74LTC
         kekt7xs/lg/4Ql7NATXqgzv6c2kqkj5DrZv3Wm3ft2bhaNINME6Ukk18PDqNrakgR5hJ
         yNGQ==
X-Received: by 10.14.3.137 with SMTP id 9mr52017789eeh.0.1368263830850; Sat,
 11 May 2013 02:17:10 -0700 (PDT)
Received: by 10.14.32.65 with HTTP; Sat, 11 May 2013 02:17:10 -0700 (PDT)
In-Reply-To: <20130511084543.GA1905@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223947>

On Sat, May 11, 2013 at 1:45 AM, Jeff King <peff@peff.net> wrote:
> On Sat, May 11, 2013 at 01:38:32AM -0700, David Aguilar wrote:
>
>> > Adding "--verify-objects" would sha1 the blobs, too, which might be more
>> > reasonable (or running "git fsck"). Something like "git add" on a large
>> > blob would also be a good test.
>>
>> Thanks.  Here are the numbers with --verify-objects:
>>
>> $ time git rev-list --all --objects --verify-objects >/dev/null
>>
>> # CommonCrypto 32.24s user 4.65s system 99% cpu 37.098 total
>> # master       33.00s user 4.68s system 99% cpu 37.852 total
>> # BLK_SHA1     54.17s user 4.67s system 99% cpu 58.928 total
>>
>> Doing BLK_SHA1 seems like less of a good idea now, so I think my
>> latest re-roll might be the way to go...
>
> Wow, that's really terrible. What level of optimization do you compile
> with? With the other implementations, you are calling into
> (presumably) optimized library code, but with BLK_SHA1 you are getting
> whatever you just compiled.
>
> Here are three timings that show how big a difference that can make:
>
>   openssl,  -O0    0m21.152s
>   BLK_SHA1, -O0    0m31.920s
>   BLK_SHA1, -O3    0m19.652s
>
> So it is a win over openssl with optimizations on, but a pretty big loss
> otherwise.

Good catch.  I had a config.mak without any -O flags in CFLAGS.
Here are the timings with -O3.  We're back to parity.

$ time git rev-list --all --objects --verify-objects >/dev/null

# CommonCrypto 28.95s user 4.62s system 99% cpu 33.630 total
# master       29.81s user 4.70s system 99% cpu 34.760 total
# BLK_SHA1     29.80s user 4.62s system 99% cpu 34.505 total

If BLK_SHA1 were the default on all platforms then I wouldn't have
bothered with the SHA-1 patch.  With this patch it makes it like Linux
in that Git can choose between the built-in functions and the external
library.

That's why I moved this patch to 3/3.. it could go either way.
--
David
