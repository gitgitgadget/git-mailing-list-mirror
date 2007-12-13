From: Andreas Ericsson <ae@op5.se>
Subject: Re: Something is broken in repack
Date: Thu, 13 Dec 2007 08:32:21 +0100
Message-ID: <4760E005.6040102@op5.se>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com> <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com> <alpine.LFD.0.99999.0712102231570.555@xanadu.home> <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com> <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com> <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com> <alpine.LFD.0.99999.0712110832251.555@xanadu.home> <alpine.LFD.0.99999.0712110951070.555@xanadu.home> <alpine.LFD.0.99999.0712111117440.555@xanadu.home> <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com> <alpine.LFD.0.99999.0712112057390.555@xanadu.home> <alpine.LFD.0.99999.0712121106400.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	gcc@gcc.gnu.org, Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 08:32:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2iYt-0006Lb-Jk
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 08:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbXLMHc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 02:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753406AbXLMHc0
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 02:32:26 -0500
Received: from mail.op5.se ([193.201.96.20]:50160 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753105AbXLMHcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 02:32:25 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4F3AB1F0804B;
	Thu, 13 Dec 2007 08:32:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z8lrOZjwvadm; Thu, 13 Dec 2007 08:32:22 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 0AE061F08020;
	Thu, 13 Dec 2007 08:32:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <alpine.LFD.0.99999.0712121106400.555@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68126>

Nicolas Pitre wrote:
> On Wed, 12 Dec 2007, Nicolas Pitre wrote:
> 
>> I did modify the progress display to show accounted memory that was 
>> allocated vs memory that was freed but still not released to the system.  
>> At least that gives you an idea of memory allocation and fragmentation 
>> with glibc in real time:
>>
>> diff --git a/progress.c b/progress.c
>> index d19f80c..46ac9ef 100644
>> --- a/progress.c
>> +++ b/progress.c
>> @@ -8,6 +8,7 @@
>>   * published by the Free Software Foundation.
>>   */
>>  
>> +#include <malloc.h>
>>  #include "git-compat-util.h"
>>  #include "progress.h"
>>  
>> @@ -94,10 +95,12 @@ static int display(struct progress *progress, unsigned n, const char *done)
>>  	if (progress->total) {
>>  		unsigned percent = n * 100 / progress->total;
>>  		if (percent != progress->last_percent || progress_update) {
>> +			struct mallinfo m = mallinfo();
>>  			progress->last_percent = percent;
>> -			fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
>> -				progress->title, percent, n,
>> -				progress->total, tp, eol);
>> +			fprintf(stderr, "%s: %3u%% (%u/%u) %u/%uMB%s%s",
>> +				progress->title, percent, n, progress->total,
>> +				m.uordblks >> 18, m.fordblks >> 18,
>> +				tp, eol);
> 
> Note: I didn't know what unit of memory those blocks represents, so the 
> shift is most probably wrong.
> 

Me neither, but it appears to me as if hblkhd holds the actual memory
consumed by the process. It seems to store the information in bytes,
which I find a bit dubious unless glibc has some internal multiplier.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
