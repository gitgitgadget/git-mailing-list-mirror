From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2 5/5] refs.c: enable large transactions
Date: Thu, 22 Jan 2015 17:33:08 +0100
Message-ID: <54C12644.1000406@alum.mit.edu>
References: <1421893929-7447-1-git-send-email-sbeller@google.com> <1421893929-7447-6-git-send-email-sbeller@google.com> <54C0DDE7.8030708@alum.mit.edu> <20150122131018.GE19681@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	gitster@pobox.com, loic@dachary.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 17:33:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEKh5-0001a6-Jd
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 17:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbbAVQdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 11:33:16 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55364 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750794AbbAVQdO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 11:33:14 -0500
X-AuditID: 1207440d-f79976d000005643-e3-54c1264645a0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.DF.22083.64621C45; Thu, 22 Jan 2015 11:33:10 -0500 (EST)
Received: from [192.168.69.130] (p5DDB02C5.dip0.t-ipconnect.de [93.219.2.197])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t0MGX8SR021752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 22 Jan 2015 11:33:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <20150122131018.GE19681@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqOumdjDE4OtGDYuuK91MFg29V5gt
	Xm33sfjR0sNssXlzO4sDq8ezbaweCzaVejzr3cPocfGSssfnTXIBrFHcNkmJJWXBmel5+nYJ
	3BmrrvxiLVjOU/Hm9inWBsYrnF2MnBwSAiYSyxrPskPYYhIX7q1n62Lk4hASuMwocWXqC0YI
	5xyTRE/PM6AqDg5eAW2Jt7dMQUwWAVWJz/v5QHrZBHQlFvU0M4HYogJBEldaNjOD2LwCghIn
	Zz5hAbFFBGQlvh/eyAhiMwtkSnR37AOrERawkTjYchVq705GiZ7Hh8CKOAX0JPrPPWWGaFCX
	+DPvEpQtL7H97RzmCYwCs5DsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30
	cjNL9FJTSjcxQoKbdwfj/3UyhxgFOBiVeHgFCg+ECLEmlhVX5h5ilORgUhLlvSx/MESILyk/
	pTIjsTgjvqg0J7X4EKMEB7OSCO9LFaAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampB
	ahFMVoaDQ0mCN1IVqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKnxxcBYBUnx
	AO1dDdLOW1yQmAsUhWg9xagoJc7bAZIQAElklObBjYWlrFeM4kBfCvN2gVTxANMdXPcroMFM
	QIMLth8AGVySiJCSamDUsUtdVDC9v2tbrILIxBlrozQOvSvTzXaOaW9z21RXv5jH6HSy4oVF
	qVoyhnoLZ6qpvTNOnZpk8/xSntN3LW7FRRYXZ05eKHXl/r6OzI3rr3877mq8/23X 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262844>

On 01/22/2015 02:10 PM, Jeff King wrote:
> On Thu, Jan 22, 2015 at 12:24:23PM +0100, Michael Haggerty wrote:
> 
>> I can't figure out where to apply this series or where to fetch it from,
>> so I can't see these changes in context, so maybe I'm misunderstanding
>> something. It looks like this code is doing
>>
>>     open(), close(), open(), fdopen(), write(), fclose(), rename()
>>
>> on each lockfile. But don't we have enough information to write the
>> SHA-1 into the lockfile the first time we touch it? I.e., couldn't we
>> reduce this to
>>
>>     open(), fdopen(), write(), fclose(), rename()
>>
>> , where the first four calls all happen in the initial loop? If a
>> problem is discovered when writing a later reference, we would roll back
>> the transaction anyway.
>>
>> I understand that this would require a bigger rewrite, so maybe it is
>> not worth it.
> 
> I had a nagging feeling on the multiple-open thing, too, and would much
> prefer to just write out the contents early (since we know what they
> are). It looks like we would just need to split write_ref_sha1() into
> its two halves:
> 
>   1. Write out the lockfile
> 
>   2. Commit the change
> 
> And then call them at the appropriate spots from ref_transaction_commit().
> 
> I guess that is maybe a step backwards for abstracted ref backends,
> though.

Nah, the implementation of ref_transaction_commit() will have to differ
between backends anyway. I don't think this would be a step backwards.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
