From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 2/2] xdiff/xprepare: fix a memory leak
Date: Sat, 5 Mar 2016 01:19:18 +0000
Message-ID: <56DA3416.10707@ramsayjones.plus.com>
References: <56DA15FA.1090601@ramsayjones.plus.com>
 <xmqqegbpyf94.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 02:20:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac0t5-00007C-2N
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 02:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759691AbcCEBTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 20:19:24 -0500
Received: from avasout02.plus.net ([212.159.14.17]:53579 "EHLO
	avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989AbcCEBTX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 20:19:23 -0500
Received: from [10.0.2.15] ([80.189.40.55])
	by avasout02 with smtp
	id S1KL1s0041BQLD4011KMSF; Sat, 05 Mar 2016 01:19:21 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=COHXJkfD c=1 sm=1 tr=0
 a=LVbmpxbf7ppclCt3pfQTng==:117 a=LVbmpxbf7ppclCt3pfQTng==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=EBOSESyhAAAA:8 a=NeTxBt9OS_FiriEu9mAA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <xmqqegbpyf94.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288288>



On 04/03/16 23:50, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> The xdl_prepare_env() function may initialise an xdlclassifier_t
>> data structure via xdl_init_classifier(), which allocates memory
>> to several fields, for example 'rchash', 'rcrecs' and 'ncha'.
>> If this function later exits due to the failure of xdl_optimize_ctxs(),
>> then this xdlclassifier_t structure, and the memory allocated to it,
>> is not cleaned up.
>>
>> In order to fix the memory leak, insert a call to xdl_free_classifier()
>> before returning.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>  xdiff/xprepare.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
>> index 5ffcf99..13b55ab 100644
>> --- a/xdiff/xprepare.c
>> +++ b/xdiff/xprepare.c
>> @@ -301,6 +301,7 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>>  
>>  		xdl_free_ctx(&xe->xdf2);
>>  		xdl_free_ctx(&xe->xdf1);
>> +		xdl_free_classifier(&cf);
>>  		return -1;
>>  	}
> 
> This looks obviously correct from the pattern of prepare's and
> free's in the code that this part follows.  This potential leak has
> been that way since 3443546f (Use a *real* built-in diff generator,
> 2006-03-24), i.e. the very beginning.
> 
> I find it somewhat strange that the call to xdl_free_classifier() at
> the end of this function is made conditional to XDF_HISTOGRAM_DIFF,
> though.  I can half-buy the argument "that is because we do not call
> init-classifier for XDF_HISTOGRAM_DIFF", but in the error path we
> call free-classifier unconditionally, so the code clearly knows that
> it is safe to call free-classifier on a classifier that is cleared
> with the initial memset(&cf, 0, sizeof cf).

Indeed, this is actually why I noticed that XDF_DIFF_ALG() wasn't used.
Rather than doing patch #1, I did consider making this call unconditional.
I can't remember why I didn't. (Hmm, perhaps I just chickened out! ;-))

ATB,
Ramsay Jones
