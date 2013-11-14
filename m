From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 0/21] pack bitmaps
Date: Thu, 14 Nov 2013 19:19:38 +0000
Message-ID: <5285224A.2070606@ramsay1.demon.co.uk>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <vicent@github.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 20:19:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2SA-0000BN-PO
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568Ab3KNTTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 14:19:43 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:51418 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755210Ab3KNTTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:19:42 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 18DB4A6499A;
	Thu, 14 Nov 2013 19:19:40 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id DC7F6A648B0;
	Thu, 14 Nov 2013 19:19:39 +0000 (GMT)
Received: from [192.168.254.6] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Thu, 14 Nov 2013 19:19:39 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237866>

On 14/11/13 12:41, Jeff King wrote:
> Here's another iteration of the pack bitmaps series. Compared to v2, it
> changes:
> 
>  - misc style/typo fixes
> 
>  - portability fixes from Ramsay and Torsten

Unfortunately, I didn't find time this weekend to finish the msvc build
fixes. However, after a quick squint at these patches, I think you have
almost done it for me! :-D

I must have misunderstood the previous discussion, because my patch was
written on the assumption that the ewah directory wouldn't be "git-ified"
(e.g. #include git-compat-util.h).

So, most of my patch is no longer necessary, given the use of the git
compat header (and removal of system headers). I suspect that you only
need to add an '#define PRIx64 "I64x"' definition (Hmm, probably to the
compat/mingw.h header).

I won't know for sure until I actually try them out, of course. I will
wait until these patches land in pu.

[Note: the msvc build is still broken, but the failure is not caused by
these patches. Unfortunately, the tests in t5310-*.sh fail. However, if
I include some debug code, the tests pass ... :-P ]

The part of the patch I was still working on was ...

> 
>  - count-objects garbage-reporting patch from Duy
> 
>  - disable bitmaps when is_repository_shallow(); this also covers the
>    case where the client is shallow, since we feed pack-objects a
>    --shallow-file in that case. This used to done by checking
>    !internal_rev_list, but that doesn't apply after cdab485.
> 
>  - ewah sources now properly use git-compat-util.h and do not include
>    system headers
> 
>  - the ewah code uses ewah_malloc, ewah_realloc, and so forth to let the
>    project use a particular allocator (and we want to use xmalloc and
>    friends). And we defined those in pack-bitmap.h, but of course that
>    had no effect on the ewah/*.c files that did not include
>    pack-bitmap.h.  Since we are hacking up and git-ifying libewok
>    anyway, we can just set the hardcoded fallback to xmalloc instead of
>    malloc.
> 
>   - the ewah code used gcc's __builtin_ctzll, but did not provide a
>     suitable fallback. We now provide a fallback in C.

... here.

I was messing around with several implementations (including the use of
msvc compiler intrinsics) with the intention of doing some timing tests
etc. [I suspected my C fallback function (a different implementation to
yours) would be slightly faster.]

ATB,
Ramsay Jones
