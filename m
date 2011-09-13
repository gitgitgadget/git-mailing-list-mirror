From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Tue, 13 Sep 2011 10:15:15 -0500
Message-ID: <DJ8J88If0KG_BPR1BK-feQRQ5yjv1AIYHW3sMosJzbrjCLKCIJABAFuSAH9IrkEl-y3-8mIKsysdqADcV6A7C7f4UuM9aZNpztbz_L9pXXw@cipher.nrlssc.navy.mil>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org> <7vk49d5t8u.fsf@alter.siamese.dyndns.org> <4E6E928A.6080003@sunshineco.com> <7vwrdd1gyc.fsf@alter.siamese.dyndns.org> <20110912233348.GE28994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Boaz Harrosh <bharrosh@panasas.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Shumkin <zapped@mail.ru>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 17:20:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3UmY-0004y0-C8
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 17:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab1IMPUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 11:20:11 -0400
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:59778 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab1IMPUK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 11:20:10 -0400
Received: by mail3.nrlssc.navy.mil id p8DFFGAN009545; Tue, 13 Sep 2011 10:15:16 -0500
In-Reply-To: <20110912233348.GE28994@sigill.intra.peff.net>
X-OriginalArrivalTime: 13 Sep 2011 15:15:15.0659 (UTC) FILETIME=[F0D391B0:01CC7227]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181286>

On 09/12/2011 06:33 PM, Jeff King wrote:
> On Mon, Sep 12, 2011 at 04:25:31PM -0700, Junio C Hamano wrote:
> 
>>> Peff also asked if uppercase extensions are common on Windows. They
>>> are, so one often sees .HTM, .HTML, etc. Should this issue be handled
>>> by jk/default-attr?
>>
>> I do not think we would mind adding .HTM but would people limit themselves
>> to uppercase while not limiting themselves to three letters and use .HTML?
> 
> I wonder if they should all be in the style of:
> 
>   [Hh][Tt][Mm][Ll]
>   [Jj][Aa][Vv][Aa]
> 
> for case-challenged systems. That feels like the wrong solution, though.
> If you're on a case-insensitive system, shouldn't we perhaps be
> comparing some kind of canonical version of the filename that is
> lowercased? That would help these built-in attributes, as well as ones
> that people write.

Perhaps fnmatch should be using FNM_CASEFOLD when core.ignorecase is
set. We already provide compat/fnmatch/ and have NO_FNMATCH_CASEFOLD in
Makefile, so it should be safe to use.

...and I see there is already an fnmatch_icase() in dir.c which adds
FNM_CASEFOLD when the global var ignore_case is set.  So, maybe it's as
easy as:

diff --git a/attr.c b/attr.c
index 09cb4fc..b482262 100644
--- a/attr.c
+++ b/attr.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "attr.h"
+#include "dir.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -649,7 +650,7 @@ static int path_matches(const char *pathname, int pathlen,
                /* match basename */
                const char *basename = strrchr(pathname, '/');
                basename = basename ? basename + 1 : pathname;
-               return (fnmatch(pattern, basename, 0) == 0);
+               return (fnmatch_icase(pattern, basename, 0) == 0);
        }
        /*
         * match with FNM_PATHNAME; the pattern has base implicitly
@@ -663,7 +664,7 @@ static int path_matches(const char *pathname, int pathlen,
                return 0;
        if (baselen != 0)
                baselen++;
-       return fnmatch(pattern, pathname + baselen, FNM_PATHNAME) == 0;
+       return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) == 0;
 }
 
 static int macroexpand_one(int attr_nr, int rem);


> Or maybe that is too large a can of worms to open. I sort of assume we
> have those canonicalization routines somewhere already, though.

> 
> I think we're missing Brandon's note that ".F" is used (as distinct from
> ".f", even on case-sensitive filesystems, as it has some magic meaning).
> And the pascal ones somebody mentioned.

Yep, that's all that is missing from my perspective.

-Brandon
