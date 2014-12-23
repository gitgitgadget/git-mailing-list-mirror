From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: git update-ref --stdin : too many open files
Date: Mon, 22 Dec 2014 18:41:47 -0800
Message-ID: <5498D66B.5090807@gmail.com>
References: <54954E44.1080906@dachary.org> <xmqqoaqv8jmi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Loic Dachary <loic@dachary.org>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 03:41:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3FQ3-0004ns-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 03:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbaLWClv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 21:41:51 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:60142 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbaLWClv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 21:41:51 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so7072706pad.9
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 18:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=uab2uukXkd0i2ynRFP6at0NzHF6L3EI1l2TLBrNNb1A=;
        b=R/ieB/Zw94VKsbLNikq9oTuDktzbsG7LHvyF2tC8Ift6WMZly/TNF/asnlQsiNQ9Mh
         1vWNUYaC+urX5tLnpGG1J8NaHH1AlSLucAQEfTxDYa4CT0frEFrxqEE3HJodR26cnuTq
         8LPfrw68/n1PO+O86t2HdTpq3qc1YtDiqxxSK36oWSCuEK+XFX4Ym3aC+rwkfAl6VCiJ
         aRNKkzrMPy1e26Syn2JXf+BEG+v4k6OdVqAmTyEA2oswRPM7gGLFYCjLzpzRz3mSiS8j
         Yn5503Yrr0CtgnIqtsevJircGk5teBO9Pq1imMrVpjhTpTxoy0FesNqXzcW3cpuGGEW3
         Ghzg==
X-Received: by 10.68.131.3 with SMTP id oi3mr39638566pbb.27.1419302510618;
        Mon, 22 Dec 2014 18:41:50 -0800 (PST)
Received: from [192.168.2.7] (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id wy1sm11395999pbc.5.2014.12.22.18.41.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2014 18:41:49 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqoaqv8jmi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261710>

On 22.12.2014 13:22, Junio C Hamano wrote:
> Loic Dachary <loic@dachary.org> writes:
> 
>> Hi,
>>
>> Steps to reproduce:
>>
>> $ git --version
>> git version 1.9.1
>> $ wc -l /tmp/1
>> 9090 /tmp/1
>> $ head /tmp/1
>> delete refs/pull/1/head
>> create refs/heads/pull/1 86b715f346e52920ca7c9dfe65424eb9946ebd61
>> delete refs/pull/1/merge
>> create refs/merges/1 c0633abdc5311354c9729374e0ba25c97a89f69e
>> ...
>> $ ulimit -n
>> 1024
>> $ git update-ref --stdin < /tmp/1
>> fatal: Unable to create
>> /home/gitmirror/repositories/Ceph/ceph/refs/heads/pull/1917.lock': Too
>> many open files
>> $ head -20 /tmp/1 | git update-ref --stdin
>> $ echo $?
>> 0
>>
>> The workaround is to increase ulimit -n
>>
>> git update-ref --stdin should probably close some files.
>>
>> Cheers
> 
> Sounds like the recent "ref update in a transaction" issue to me.
> 
> Stefan, want to take a look?  I think we do need to keep the .lock
> files without renaming while in transaction, but we do not have to
> keep them open, so I suspect that a fix may be to split the commit
> function into two (one to close but not rename, the other to
> finalize by renaming) or something.

Sounds reasonable. Though by closing the file we're giving up again a
bit of safety. If we close the file everyone could tamper with the lock
file. (Sure they are not supposed to touch it, but they could)

> 
> Also the version of transaction series we have queued seem to lock
> these refs very late in the process, but as we discussed privately
> a few weeks ago, we would want to move the lock much earlier, when
> the first update is attempted.

I'll look into that tomorrow.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
