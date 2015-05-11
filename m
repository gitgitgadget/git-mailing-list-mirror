From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring the
 packed-refs lock
Date: Mon, 11 May 2015 10:50:57 -0700
Message-ID: <CAGZ79kaR70QeX26jwR7AXSig5F_FjuT-bXSNBBaW_3Bk1vWJQQ@mail.gmail.com>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
	<1430491977-25817-3-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kZnhv+aW_GW8mBDyhfv_k54ScAFsHQz=8zfHBUJ8WrVUw@mail.gmail.com>
	<20150501182257.GA27728@peff.net>
	<55445E60.6010205@alum.mit.edu>
	<20150505192110.GD10463@peff.net>
	<555083CF.8010205@alum.mit.edu>
	<20150511164941.GA30541@peff.net>
	<CAGZ79kYc91z5S9j_hpA3b9-TvMBxr9jkdxhqEgHhOCT3mGzH5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 11 19:51:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrrrB-0001eD-Cc
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 19:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbbEKRvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 13:51:03 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36746 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbbEKRu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 13:50:58 -0400
Received: by iecmd7 with SMTP id md7so36847393iec.3
        for <git@vger.kernel.org>; Mon, 11 May 2015 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4ZpVY1raLZfSzGEDnY9DXiz5fiBMBA7lcDhIr+yUxqM=;
        b=lqIocBPMiBlmqAzAgHaN9VaCNMesEjEm3mEDCulyPFlcKKJPzvCxpMZAeF0yWWbUVa
         ehIAHKhvOWCqS/EylBxDCN5UEFiGwTcb4drMjIgYzqtIR7Vm/uXsvFbe2SVzw0xZKhBI
         6wtQ0KMj/jzQM5S5JvQh7hZvkiB9n3bmQ/woDBUwEg3CHM/qEddwjPS1yxFGAoeoSAdd
         H3nkuDGlbKAO0oueC1D1cCBWLSnSuBBV8NJ2e6Wu1ochWBXUSbAIhqTKxyLcFMfbsey8
         ggugJk2AO+pB33qIogI07dtxpUA920F7SJ5xOhFvQcJs3kreDX6ktwwRXSvJg1UixBQh
         /47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4ZpVY1raLZfSzGEDnY9DXiz5fiBMBA7lcDhIr+yUxqM=;
        b=bj6/1b3A/BtXIBcq/OpfSk9SNW/Wd8+GJzUocNuCSxriYVHWxGfjJmoTx3LiOiboBY
         xAXqRVp4yJatKYjPIg8D99leXNBdwBvsMiv/FBPUKuoC0gUuT7xrSARLb2nJoS3delZY
         sxSYs5MPP+ypNVV+BnWgzK8dn1PCvCip9OD4nlAOqo9TEeJrSZB1j7RlsllCTDMgapqZ
         Ja5zhhPKBbtXZXnJZ87F+9ET3G0jDf7NdmPTFjnWf/9r3O2GAyrAhjXUMzZm6/EMKX1i
         NgvT6TEgCW7fPTvBLzvyP7jcrv6OLpwiMVHYGGQm9FkzxSwSDA8H/1Ujom0ORztUGhB6
         vzsw==
X-Gm-Message-State: ALoCoQlVC3UYz0LXI/ZuYtoUpA8z87RzXEK13RKVSh/qvy965EjS+cvoOrwSlF/V3VCC/10qXit7
X-Received: by 10.107.170.226 with SMTP id g95mr14631865ioj.2.1431366658034;
 Mon, 11 May 2015 10:50:58 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 11 May 2015 10:50:57 -0700 (PDT)
In-Reply-To: <CAGZ79kYc91z5S9j_hpA3b9-TvMBxr9jkdxhqEgHhOCT3mGzH5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268804>

On Mon, May 11, 2015 at 10:49 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, May 11, 2015 at 9:49 AM, Jeff King <peff@peff.net> wrote:
>> On Mon, May 11, 2015 at 12:26:23PM +0200, Michael Haggerty wrote:
>>
>>> > So something like 100ms max backoff makes sense to me, in that it keeps
>>> > us in the same order of magnitude as the expected time that the lock is
>>> > held. [...]
>>>
>>> I don't understand your argument. If another process blocks us for on
>>> the order of 100 ms, the backoff time (reading from my table) is less
>>> than half of that.
>>
>> I think it is just that I was agreeing with you, but communicated it
>> badly. I think your series is fine as-is.
>
> By now I also think your series is fine as is.
> I am currently implementing something similar for Gerrit and I realize
> testing time based things is a royal pain in the butt. The tests you propose
> just take wall clock time and all should is good, though slowing down
> the test suite
> by another second or three in the worst case.
>
> So for tests in Gerrit I use a dedicated java class which is
> specialized to pretend different
> times, such that you can write:
>
>     doThings();
>     pretendTimePassing(1 second);
>     checkResultsFromThreads();
>
> but running the tests takes less than 1 second as it's no real wall
> clock time passing.
>
> On my machine there is
> /bin/usleep - sleep some number of microseconds

As we're using perl anyway we may even want to just do

    perl -e "select(undef,undef,undef,0.1);"

as found at
http://serverfault.com/questions/469247/how-do-i-sleep-for-a-millisecond-in-bash-or-ksh
