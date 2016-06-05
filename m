From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] regex: fix a SIZE_MAX macro redefinition warning
Date: Sun, 5 Jun 2016 14:35:01 +0100
Message-ID: <57542A85.3040206@ramsayjones.plus.com>
References: <575212DF.90209@ramsayjones.plus.com>
 <alpine.DEB.2.20.1606050815360.4250@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 05 15:35:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9YD8-0004hB-Hd
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 15:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbcFENfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 09:35:13 -0400
Received: from avasout04.plus.net ([212.159.14.19]:56392 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbcFENfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 09:35:12 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout04 with smtp
	id 31b31t0025VX2mk011b4HZ; Sun, 05 Jun 2016 14:35:09 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=19RlOg_XpvLLA51gPp4A:9 a=j769gL1bPeN1oPN8:21 a=xEVB34FvR-NXUy3Z:21
 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <alpine.DEB.2.20.1606050815360.4250@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296473>



On 05/06/16 08:15, Johannes Schindelin wrote:
> Hi Ramsay,
> 
> thanks for working on this!
> 
> On Sat, 4 Jun 2016, Ramsay Jones wrote:
> 
>> diff --git a/Makefile b/Makefile
>> index 0d59718..3f6c70a 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1987,7 +1987,7 @@ endif
>>  
>>  ifdef NO_REGEX
>>  compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
>> -	-DGAWK -DNO_MBSUPPORT
>> +	-DGAWK -DNO_MBSUPPORT -DHAVE_STDINT_H
> 
> Maybe a comment here, something like "the fallback regex implementation
> *requires* stdint.h"?

The original version of this patch looked like this:

  diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
  index fba5986..d8bde06 100644
  --- a/compat/regex/regcomp.c
  +++ b/compat/regex/regcomp.c
  @@ -18,8 +18,6 @@
      Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
      02110-1301 USA.  */
   
  -#include <stdint.h>
  -
   static reg_errcode_t re_compile_internal (regex_t *preg, const char * pattern,
   					  size_t length, reg_syntax_t syntax);
   static void re_compile_fastmap_iter (regex_t *bufp,
  diff --git a/compat/regex/regex.c b/compat/regex/regex.c
  index 6aaae00..5cb23e5 100644
  --- a/compat/regex/regex.c
  +++ b/compat/regex/regex.c
  @@ -60,6 +60,7 @@
      GNU regex allows.  Include it before <regex.h>, which correctly
      #undefs RE_DUP_MAX and sets it to the right value.  */
   #include <limits.h>
  +#include <stdint.h>
   
   #ifdef GAWK
   #undef alloca

So, just move the unconditional inclusion to the start of the compilation
unit root file, before the #include of the regex_internal.h header.

In some ways this is a better fix, because it makes it clear that, currently,
the compat/regex code requires <stdint.h>. This would remove the need for
such a comment.

This effectively makes the conditional inclusion of <stdint.h>, and the SIZE_MAX
fallback, in regex_internal.h dead code. (The C99 standard _requires_ the
definition of SIZE_MAX in <stdint.h>, thankfully! ;-). So, I was tempted to
remove them as part of the patch. However, I also wanted to minimize the changes
to the regex code, just in case we ever wanted to re-import a newer version
from upstream. Setting HAVE_STDINT_H seemed like a good solution, but maybe the
first patch would be more honest?

As I said earlier, I was a little concerned about the 'unconditional' aspect of
the inclusion of <stdint.h>. At one time we wanted to support systems that didn't
have <stdint.h> (or didn't have <inttypes.h> but did have <stdint.h>). However,
it has been several months and we have not heard anyone scream, so ...

It is slightly amusing that the reason you #included <stdint.h> was to get the
definition of 'intptr_t' and the C standard states that this type is optional.
In practice, I suspect that the number of platforms which do not define 'intptr_t'
and 'uintptr_t' in the <stdint.h> header is rather small.

Having said that ... If I'm reading the code/config correctly, HP-NONSTOP would
be failing to compile at the moment. (Although it has <stdint.h>, it does not
define 'intptr_t' - ie it defines 'NO_REGEX = YesPlease' and 'NO_INTPTR_T = \
UnfortunatelyYes').

> Other than that, I think this patch is an improvement.

Thanks. What do you think of replacing it with the original patch (above)?

ATB,
Ramsay Jones
