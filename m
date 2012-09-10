From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH] daemon: restore getpeername(0,...) use
Date: Mon, 10 Sep 2012 16:38:58 +0200
Message-ID: <k2ku26$jld$1@ger.gmane.org>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de> <1347124173-14460-2-git-send-email-jengelh@inai.de> <7v1uicuyqi.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.01.1209082119320.18369@frira.zrqbmnf.qr> <20120910142100.GB7906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 16:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB591-0007Av-DM
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 16:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab2IJOjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 10:39:15 -0400
Received: from plane.gmane.org ([80.91.229.3]:42423 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113Ab2IJOjO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 10:39:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TB58s-000735-Uf
	for git@vger.kernel.org; Mon, 10 Sep 2012 16:39:14 +0200
Received: from dsdf-4db54003.pool.mediaways.net ([77.181.64.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 16:39:14 +0200
Received: from jojo by dsdf-4db54003.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 16:39:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db54003.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205129>

Jeff King wrote:
> On Sat, Sep 08, 2012 at 09:20:48PM +0200, Jan Engelhardt wrote:
>
>> On Saturday 2012-09-08 20:59, Junio C Hamano wrote:
>>>> diff --git a/daemon.c b/daemon.c
>>>> index 4602b46..eaf08c2 100644
>>>> --- a/daemon.c
>>>> +++ b/daemon.c
>>>> @@ -1,3 +1,4 @@
>>>> +#include <stdbool.h>
>>>>  #include "cache.h"
>>>>  #include "pkt-line.h"
>>>>  #include "exec_cmd.h"
>>>
>>> Platform agnostic parts of the code that use "git-compat-util.h"
>>> (users of "cache.h" are indirectly users of it) are not allowed to
>>> do platform specific include like this at their beginning.
>>>
>>> This is the first use of stdbool.h; what do you need it for?
>>
>> For the use in setenv(,,true). It was not entirely obvious in which
>> .h to add it; the most reasonable place was daemon.c itself, since
>> the other .c files do not seem to need it.
>
> It would go in git-compat-util.h. However, it really is not needed;
> you can simply pass "1" to setenv, as every other callsite in git
> does.
>
> More importantly, though, is it actually portable? I thought it was
> added in C99, and we try to stick to C89 to support older compilers
> and systems. My copy of C99 is vague (it says only that the "bool"
> macro was added via stdbool.h in C99, but nothing about the "true"
> and "false" macros), and I don't have a copy of C89 handy.  Wikipedia
> does claim the header wasn't standardized at all until C99:
>
>  https://en.wikipedia.org/wiki/C_standard_library

Indeed stdbool is not part of C89, but inline isn't either and used 
extensively in git (could possible be defined away), as are non-const array 
intializers, e.g.:


                const char *args[] = { editor, path, NULL };
                                               ^
".../git/editor.c", line 39: error(122): expression must have a constant 
value

So git source is not plain C89 code (anymore?)

Bye, Jojo 
