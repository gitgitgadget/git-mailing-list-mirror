From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring
 the packed-refs lock
Date: Mon, 11 May 2015 11:31:00 +0200
Message-ID: <555076D4.9020601@alum.mit.edu>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu> <1430491977-25817-3-git-send-email-mhagger@alum.mit.edu> <5543A621.7010208@kdbg.org> <554448B6.6080605@alum.mit.edu> <55454505.9060305@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon May 11 11:31:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrk3K-0005Ed-F2
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 11:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbbEKJbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 05:31:06 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:47344 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752731AbbEKJbE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 05:31:04 -0400
X-AuditID: 1207440f-f792a6d000001284-8b-555076d7abe9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 77.75.04740.7D670555; Mon, 11 May 2015 05:31:03 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4B9V0kQ019348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 05:31:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <55454505.9060305@kdbg.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqHu9LCDUYMYMHYuuK91MFg29V5gt
	nsy9y2zxo6WH2WLz5nYWB1aPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M/5PXc9ccIOzYtehxWwNjBfZuxg5OSQETCQa3sxggbDFJC7cW8/WxcjFISRwmVFixuvp
	YEVCAueYJLpn8YLYvALaEs8/bWAEsVkEVCWOtMwFa2YT0JVY1NPMBGKLCgRJtF6byghRLyhx
	cuYTsBoRAQWJA/sWsoIsYBZoZpT41bgKLCEskCCx4/5WdojNVxkl7n3bBDaJU0BDouPzF6BJ
	HEAduhJta2RAwswC8hLb385hnsAoMAvJjlkIVbOQVC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyY
	l5dapGuil5tZopeaUrqJERLg/DsYu9bLHGIU4GBU4uE1uOAfKsSaWFZcmXuIUZKDSUmUVzkj
	IFSILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG9gLlCONyWxsiq1KB8mJc3BoiTOq75E3U9IID2x
	JDU7NbUgtQgmK8PBoSTBW1wK1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitT4
	YmCsgqR4gPa2g7TzFhck5gJFIVpPMSpKifMuAEkIgCQySvPgxsLS1itGcaAvhXl5gUlMiAeY
	8uC6XwENZgIa7BgHNrgkESEl1cDoxaW2ai7Xl6kL/eTPbZu1ncsmwYO5Vv4ym3Th066qnZv5
	/y0WS9niwfra7HRw6KxJS3c+P/Ux+vI3KY4k0XehZ6rWe69gC9/aftxl5vcfJ99k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268765>

On 05/02/2015 11:43 PM, Johannes Sixt wrote:
> Am 02.05.2015 um 05:47 schrieb Michael Haggerty:
>> On 05/01/2015 06:13 PM, Johannes Sixt wrote:
>>> How about this:
>>>
>>>      test_when_finished "wait; rm -f $LOCK" &&
>>>      { sleep 1 & } &&
>>>      ...
>>
>> Thanks for pointing out this problem. Your suggestion seems good. I
>> assume that you didn't intend to omit the "rm -f $LOCK" from the
>> subprocess, because the whole point is for that to happen while "git
>> pack-refs" is running.
> 
> I see. So, if git pack-refs works correctly, it waits for the
> sub-process, and the 'wait' in test_when_finished does not buy a lot. If
> there is breakage, the trash directory is not attempted to be removed,
> and it does not matter that a process potentially occupies it. I think
> your version is good then.

Well, even if my version is working correctly, there is still a gap
between when the subprocess removes the lockfile and when the subprocess
ends, during which the outer process could theoretically finish and try
to delete the test directory. It may not cause problems in practice, but
let's add the wait anyway to make everything kosher.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
