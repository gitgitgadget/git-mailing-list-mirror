From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] http-push: trim trailing newline from remote symref
Date: Tue, 13 Jan 2015 16:21:01 -0800
Message-ID: <05091340-887B-4743-AB62-39E609E22CEE@gmail.com>
References: <20150113022857.GA4087@peff.net> <4E1001F7-2D26-483A-9339-E2570559ECF0@gmail.com> <20150113195806.GA13282@peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 01:21:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBBhw-0002dU-2T
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 01:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbbANAVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 19:21:07 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:39776 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbbANAVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 19:21:06 -0500
Received: by mail-pd0-f181.google.com with SMTP id v10so6267605pde.12
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 16:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=dniz/hfQqEZ/5pyOd10u/3uvBnyAvmH+fG3Mf7GBG8A=;
        b=D5jL098PIao2ZamCqVHR+3YOpFDHPbT3elMfq7TvC5AazbZ03ULk08zEcUVZbwceI2
         9ZCw7Gs15IjTwcOtNq3V+6AhjE8XomphVN2uR3NWzu8cqcU5nhhbkumd/KZyd2+vI2Kt
         /f2VmzOP0rzWLkJrEjysKrbsgUNdb1wg+5lAXQyVqS+bdOe+Jpyogbruqe0vEG4XV7gl
         JF6Z3ZsYuEQzCe60arW0p4Y9iN47Leo2epD8SK3pHltA+12RPEZv/YOKMVF5O4SyreUx
         eJBoY9+EtRLrWh1sqJAPrG1rParDOsNcfG7b/dQacER4BIRFW+aLLHgiyPHZuJjf2D2/
         AplA==
X-Received: by 10.67.3.100 with SMTP id bv4mr1375732pad.15.1421194864753;
        Tue, 13 Jan 2015 16:21:04 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id rb5sm18214772pab.14.2015.01.13.16.21.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 13 Jan 2015 16:21:04 -0800 (PST)
In-Reply-To: <20150113195806.GA13282@peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262366>

On Jan 13, 2015, at 11:58, Jeff King wrote:
> On Tue, Jan 13, 2015 at 08:26:31AM -0800, Kyle J. McKay wrote:
>
>> I have this line in my 2.1.4 test output log:
>>
>> t5540-http-push-webdav.sh .......................... ok
>> [...]
>> I do not build with NO_EXPAT.  This is running the tests on OS X  
>> without
>> this patch applied.  Is something else required to get a failure?
>
> Hmm. I think it is probably this:
>
>  http://curl.haxx.se/docs/adv_20150108B.html
>
> where curl has started complaining about URLs with newlines in them.  
> So
> ae021d8 did introduce a bug, but older versions of curl did not really
> care. The combination of ae021d8 with a new version of curl triggers  
> the
> problem.

I'm running curl 7.38, and in this context "older" is anything before  
7.40, so that would explain it.  curl 7.38 was released 2014-09-10, so  
it's only 4 months old at this point.  7.40 was only released 5 days  
ago on 2015-01-08 which is probably why there have not been a whole  
lot of reports about this so far.

> And that also explains why it worked prior to eecc8367f4; curl was  
> more
> forgiving. Also, interestingly, if you "git log -S'- 6' http-push.c",
> you can see the exact same bug reappear and go away in 2006/2007. The
> implicit "chop one character" behavior is there in the original
> 3dfaf7bc, adding http-push support. Then it disappears as a side  
> effect
> of bfbd0bb6, and then comes back again in eecc8367.

After updating to curl 7.40 I get:

t5540-http-push-webdav.sh (Wstat: 256 Tests: 19 Failed: 1)
   Failed test:  10
   Non-zero exit status: 1

> Anyway. I think my patch is still the right thing. But that does  
> explain
> why we didn't notice the test failure.

And then after applying your patch I'm back to:

t5540-http-push-webdav.sh .. ok

So definitely a needed patch.

Tested-by: Kyle J. McKay <mackyle@gmail.com>

-Kyle
