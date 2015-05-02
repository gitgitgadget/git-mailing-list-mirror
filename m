From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring
 the packed-refs lock
Date: Sat, 02 May 2015 05:47:02 +0200
Message-ID: <554448B6.6080605@alum.mit.edu>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu> <1430491977-25817-3-git-send-email-mhagger@alum.mit.edu> <5543A621.7010208@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat May 02 05:47:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoOOw-0006Oz-8c
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 05:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbbEBDrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 23:47:20 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47849 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750785AbbEBDrT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 23:47:19 -0400
X-AuditID: 1207440e-f79bc6d000000c43-26-554448b9ba9a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id FF.7B.03139.9B844455; Fri,  1 May 2015 23:47:05 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97E83.dip0.t-ipconnect.de [79.201.126.131])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t423l24r014064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 23:47:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <5543A621.7010208@kdbg.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqLvTwyXUYPMMMYuuK91MFg29V5gt
	nsy9y2zxo6WH2WLz5nYWB1aPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M262/2UtWM9Z0bbwOHsDYzd7FyMnh4SAicSc801sELaYxIV768FsIYHLjBJrLhh1MXIB
	2eeZJL5Pv84CkuAV0JZofX4ArIhFQFXi04z/YDabgK7Eop5mJhBbVCBIovXaVEaIekGJkzOf
	gPWKCChIHNi3kBVkKLNAM6PEr8ZVYAlhgQSJHfe3skNsm8kocX5rG1iCU0BD4vyiW0AdHEAd
	uhJta2RAwswC8hLb385hnsAoMAvJjlkIVbOQVC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5da
	pGusl5tZopeaUrqJERLgfDsY29fLHGIU4GBU4uH9oOUSKsSaWFZcmXuIUZKDSUmUV54LKMSX
	lJ9SmZFYnBFfVJqTWnyIUYKDWUmEV8cSKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2a
	WpBaBJOV4eBQkuB95AbUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K1PhiYKyC
	pHiA9nK6g+wtLkjMBYpCtJ5i1OX4calxMZMQS15+XqqUOK8ySJEASFFGaR7cClg6e8UoDvSx
	MG8aSBUPMBXCTXoFtIQJaMn5Ww4gS0oSEVJSDYy5m3TOFvTOezJHYs9z5l6Z+9s8BLmOyp9r
	vL5m8vewW+/2l68tfpy9abaW5yPVWKtlu8LDOGQc94naJXVJP9LkW7WTaV+0WemM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268217>

On 05/01/2015 06:13 PM, Johannes Sixt wrote:
> Am 01.05.2015 um 16:52 schrieb Michael Haggerty:
>> +test_expect_success 'retry acquiring packed-refs.lock' '
>> +    LOCK=.git/packed-refs.lock &&
>> +    >$LOCK &&
>> +    test_when_finished "rm -f $LOCK" &&
>> +    {
>> +        ( sleep 1 ; rm -f $LOCK ) &
>> +    } &&
> 
> I haven't tested yet, but I think that this will be problematic on
> Windows: a directory cannot be removed if it is the current directory of
> a process. Here, the sub-shell process is alive for a second. If the
> remainder of the test script completes before the process dies, the test
> directory cannot be removed.
> 
> How about this:
> 
>     test_when_finished "wait; rm -f $LOCK" &&
>     { sleep 1 & } &&
>     ...
> 
>> +    git -c core.packedrefstimeout=3000 pack-refs --all --prune
>> +'
>> +
>>   test_done

Thanks for pointing out this problem. Your suggestion seems good. I
assume that you didn't intend to omit the "rm -f $LOCK" from the
subprocess, because the whole point is for that to happen while "git
pack-refs" is running.

I will include your change in v2.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
