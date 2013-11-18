From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 0/21] pack bitmaps
Date: Mon, 18 Nov 2013 21:16:15 +0000
Message-ID: <528A839F.10804@ramsay1.demon.co.uk>
References: <20131114124157.GA23784@sigill.intra.peff.net> <5285224A.2070606@ramsay1.demon.co.uk> <20131114213320.GA16466@sigill.intra.peff.net> <52855834.3080608@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 18 22:16:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViWBE-0007ry-Ip
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 22:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab3KRVQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 16:16:20 -0500
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:43824 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751350Ab3KRVQT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 16:16:19 -0500
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id C0FC5AC4080;
	Mon, 18 Nov 2013 21:16:17 +0000 (GMT)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 8D2DCAC406C;
	Mon, 18 Nov 2013 21:16:17 +0000 (GMT)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Mon, 18 Nov 2013 21:16:17 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52855834.3080608@ramsay1.demon.co.uk>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238014>

On 14/11/13 23:09, Ramsay Jones wrote:
> On 14/11/13 21:33, Jeff King wrote:
>> On Thu, Nov 14, 2013 at 07:19:38PM +0000, Ramsay Jones wrote:
>>
>>> Unfortunately, I didn't find time this weekend to finish the msvc build
>>> fixes. However, after a quick squint at these patches, I think you have
>>> almost done it for me! :-D
>>>
>>> I must have misunderstood the previous discussion, because my patch was
>>> written on the assumption that the ewah directory wouldn't be "git-ified"
>>> (e.g. #include git-compat-util.h).
>>
>> I think it was up for debate at some point, but we did decide to go
>> ahead and git-ify. Please feel free to submit further fixups if you need
>> them.
> 
> Yep, will do; at present it looks like that one-liner.

Despite saying I would wait for these patches to land in pu, I applied these
patches to the next branch (@ 8721652 "Sync with 1.8.5-rc2") so that I could
try them out.

As expected, everything was fine on Linux and cygwin, and the msvc build needed
a one-liner fix. However, I didn't expect that MinGW would need the same fix! ;-)

I had forgotten that "git-compat-util.h" does not include the <inttypes.h> header
on MinGW (my previous patch included that header directly), so that we have to
add the printf format macros directly to the compat/mingw.h header.

[I assume that an earlier version of the library on MinGW did not have the
<inttypes.h> and <stdint.h> headers. We could now include that header on MinGW
and move the PRIuMAX, PRId64 and PRIx64 macros to compat/msvc.h, but I didn't
think it was worth the churn ... ]

The one-liner is given below ...

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] compat/mingw.h: Fix the MinGW and msvc builds

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/mingw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index 92cd728..8828ede 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -345,6 +345,7 @@ static inline char *mingw_find_last_dir_sep(const char *path)
 #define PATH_SEP ';'
 #define PRIuMAX "I64u"
 #define PRId64 "I64d"
+#define PRIx64 "I64x"
 
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
-- 
1.8.4
