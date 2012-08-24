From: Tim Chase <git@tim.thechases.com>
Subject: Re: misleading diff-hunk header
Date: Fri, 24 Aug 2012 10:05:11 -0500
Message-ID: <50379827.3010709@tim.thechases.com>
References: <503385D0.5070605@tim.thechases.com> <87a9xoi82i.fsf@thomas.inf.ethz.ch> <5033AC55.8080405@tim.thechases.com> <7vfw7gdtfg.fsf@alter.siamese.dyndns.org> <20120824142908.GA15162@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 24 17:04:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4vQm-00081H-EY
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 17:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab2HXPEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 11:04:09 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:53885 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755030Ab2HXPEH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2012 11:04:07 -0400
Received: from ppp-70-251-69-251.dsl.rcsntx.swbell.net ([70.251.69.251] helo=[192.168.1.12])
	by boston.accountservergroup.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tim.thechases.com>)
	id 1T4vQT-0001qf-Mx; Fri, 24 Aug 2012 10:03:57 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111120 Icedove/3.1.16
In-Reply-To: <20120824142908.GA15162@sigill.intra.peff.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204213>

On 08/24/12 09:29, Jeff King wrote:
> On Tue, Aug 21, 2012 at 10:52:03AM -0700, Junio C Hamano wrote:
> 
>>>>> diff.{type}.xfuncname seems to start searching backwards in
>>>>> from the beginning of the hunk, not the first differing line.
>>>> [...]
>>>>>   @@ -4,4 +4,5 @@ int call_me(int maybe)
>>>>>
>>>>>    int main()
>>>>>    {
>>>>>   +  return 0;
>>>>>    }
>>>>>
>>>>> misleadingly suggesting that the change occurred in the call_me()
>>>>> function, rather than in main()
>>>>
>>>> I think that's intentional, and matches what 'diff -p' does. 
...
>>  xdiff/xemit.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
>> index 277e2ee..5f9c0e0 100644
>> --- a/xdiff/xemit.c
>> +++ b/xdiff/xemit.c
>> @@ -131,7 +131,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
>>  
>>  		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
>>  			long l;
>> -			for (l = s1 - 1; l >= 0 && l > funclineprev; l--) {
>> +			for (l = s1; l >= 0 && l > funclineprev; l--) {
>>  				const char *rec;
>>  				long reclen = xdl_get_rec(&xe->xdf1, l, &rec);
>>  				long newfunclen = ff(rec, reclen, funcbuf,
> 
> In the case we were discussing then, the modified function started on
> the first line of context. But as Tim's example shows, it doesn't
> necessarily have to. I think it would make more sense to start counting
> from the first modified line.

Junio mentions that it matches the "diff -p" output, though I'd
consider that a bug in diff as well, since the diff(1) man/info
pages state "-p  Show which C function each change is in."  In the
above (both with "diff -p" and with git), the change was clearly in
main() but it's not showing main().  Documented behavior and
implemented behavior conflict.

Starting at the first differing line rather than the first line of
context in the hunk would ameliorate this.  It doesn't address what
happens if multiple functions were changed in the same hunk, but at
least it becomes correct for the first one.  More complex code might
be doable to split hunks if an xfuncname match occurs between two
disjoint changes in the same hunk.  But for my purposes here, the
above should suffice.

-tkc
