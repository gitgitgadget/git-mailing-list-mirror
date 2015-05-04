From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring the
 packed-refs lock
Date: Mon, 4 May 2015 10:31:24 -0700
Message-ID: <CAGZ79kbohcVBnx2euCtJP+VndBA7DzO7EJDEvPNC4m0arSVHdA@mail.gmail.com>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
	<1430491977-25817-3-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kZnhv+aW_GW8mBDyhfv_k54ScAFsHQz=8zfHBUJ8WrVUw@mail.gmail.com>
	<20150501182257.GA27728@peff.net>
	<55445E60.6010205@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 04 19:31:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpKDL-0006pw-4d
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 19:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbbEDRb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 13:31:27 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33482 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbbEDRbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 13:31:25 -0400
Received: by igbpi8 with SMTP id pi8so70631998igb.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I/qYhZDIvMcgSytYNRMpEqD1E88Vb6o8zPzo1KFjct0=;
        b=gkFblRumoN+iIZf5Dz7E974zPhyOVWE3lsrdmubOPYBFCkjyLczmSTyhQtpVuvykgd
         LPe29LRyUfxQKTMd1qj4fbc/PMqKhhja0ofT2PZN8KQlXXebOq2HEiAfpYs6towNKBGl
         pm0jXC5xj0VFx0YRWTznm96eSXsVXwgujTp3TDMMomNWWuYfd/PzMoB4cTxXk3yMPMWc
         Qz9a7aczfwr6FbqSqVwd86RDF1UdM/0Aq63akJB0xWJV+C0iNB7zd+1Z70ZXw1pDsqCC
         ICUJIf8lSkArzLNBSfhFAFigKYkcTgKiq1qzYFhQNYxr4XNpEWc3ynovV8aCMS/ALcQX
         GSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=I/qYhZDIvMcgSytYNRMpEqD1E88Vb6o8zPzo1KFjct0=;
        b=NF0gi0aYbN/2UlOfkvcdY+7+8WYBMMyQnvjaTtni7c6DeZeIIuDt1yJQfxmEh54Iih
         M4N4yd2x0e1Q3nZG3ImTLJhIexV1g+477gJwqZYG/Nz9xHR1E0aF6S9gRATFsdMyuNO7
         0hMWwlvCHbesH75nElvOtPntArGkld0Ksn64fgxdYSsMg2yZ/W/qz0QGFo2OAskHspZr
         cdaIfzUcLFnc3xRwIF9L1xMT8qapZ9OEIwWAG0ixlA7uyZA7uxfTy7sZ3zn3BT748CEE
         L8kRAru/8hvvUBxf1yU+FVkloJjdYjRzCz7A/jVAC87LvhE3OEQlOuDejX09pkUewmoc
         nW2w==
X-Gm-Message-State: ALoCoQkKWLT809viANc0t/+u66/A+qVI5Fa4Upp0ZbjHJ0aX7cszAYiQ/1hm8BqN65TOY2OMcZIW
X-Received: by 10.50.138.72 with SMTP id qo8mr3081803igb.10.1430760684339;
 Mon, 04 May 2015 10:31:24 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 4 May 2015 10:31:24 -0700 (PDT)
In-Reply-To: <55445E60.6010205@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268332>

On Fri, May 1, 2015 at 10:19 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/01/2015 08:22 PM, Jeff King wrote:
>> On Fri, May 01, 2015 at 10:51:47AM -0700, Stefan Beller wrote:
>>
>>>> diff --git a/refs.c b/refs.c
>>>> index 47e4e53..3f8ac63 100644
>>>> --- a/refs.c
>>>> +++ b/refs.c
>>>> @@ -2413,9 +2413,19 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
>>>>  /* This should return a meaningful errno on failure */
>>>>  int lock_packed_refs(int flags)
>>>>  {
>>>> +       static int timeout_configured = 0;
>>>> +       static int timeout_value = 1000;
>>>
>>> I'd personally be more happier with a default value of 100 ms or less
>>> The reason is found in the human nature, as humans tend to perceive
>>> anything faster than 100ms as "instant"[1], while a 100ms is a long time
>>> for computers.
>>>
>>> Now a small default time may lead to to little retries, so maybe it's worth
>>> checking at the very end of the time again (ignoring the computed backoff
>>> times). As pushes to $server usually take a while (connecting, packing packs,
>>> writing objects etc), this may be overcautios bikeshedding from my side.
>>
>> Keep in mind that this 1s is the maximum time to wait. The
>> lock_file_timeout() code from patch 1 starts off at 1ms, grows
>> quadratically, and quits as soon as it succeeds. So in most cases, the
>> user will wait a much smaller amount of time.

Yes, I forgot about that when having an opinion. I agree a one second
time out is reasonable.

> The current code would poll at the following times (in ms), ignoring the
> time taken for the actual polling attempt and ignoring the random component:
>
>     time  backoff  percent
>     ----  -------  -------
>        0        1     N/A
>        1        4     400%
>        5        9     180%
>       14       16     114%
>       30       25      83%
>       55       36      65%
>       91       49      54%
>      140       64      46%
>      204       81      40%
>      285      100      35%
>      385      121      31%
>      506      144      28%
>      650      169      26%
>      819      196      24%
>     1015      225      22%  <- Stop here with the default 1 s timeout

So a configuration of one second only has about twice the attempts
than a 100ms configuration in the worst case, which is nice for the
machine load, and as I said above, not too long for the user.

Thanks for laying out the numbers here, it's more
understandable now.

>     1240      256      21%
>     1496      289      19%
>     1785      324      18%
>     2109      361      17%
>     2470      400      16%
>     2870      441      15%
>     3311      484      15%
>     3795      529      14%
>     4324      576      13%
>     4900      625      13%
>     5525      676      12%
>     6201      729      12%
>     6930      784      11%
>     7714      841      11%
>     8555      900      11%
>     9455      961      10%
>    10416     1000      10%
>    11416     1000       9%
>    12416     1000       8%
>
> From the table, the first backoff that is longer than 100 ms doesn't
> start until 385 ms, and in the worst case, that 121 ms delay would
> increase the *total* wait by only 31%. And the longest backoff within
> the first second is only 196 ms. The backoff doesn't reach its maximum
> value, 1 s, until the process has already been blocked for 10.4 seconds.
>
> Remember, these backoffs are the *maximum* time that the user might wait
> between the time that one process is finished and the time that the
> second process resumes. The *average* wait time will be half of that.
>
> And finally, remember that lock contention should be very rare in the
> first place, and will mostly occur on servers (because normal users are
> unlikely to have lots of parallel processes accessing a single git
> repository). What are the most likely scenarios for lock contention in
> the real world?
>
> * Occasionally, by chance, under normal operations. In most cases, the
> blocking process will finish up within a few milliseconds, the blocked
> process will resume almost immediately, and nobody will notice a thing.
>
> * In a pathological repository that has, say, a million packed
> references, and writing the packed-refs file takes unusually long. Here,
> typical lock contention delays will be long anyway, and adding (worst
> case) 121 ms == 31% to the delay is not unreasonable.
>
> * When the server is struggling with enormous load, or a
> denial-of-service attack, or some other system-wide problem that is
> making processes super slow. In this case it would be counterproductive
> to have *additional* processes waking up every 100 ms.
>
> * When a packed-refs.lock file fails to get cleaned up for some reason.
> In this case the "contention" will never go away on its own, so the
> polling is wasted effort. (Happily, I've almost never seen this happen
> on our servers.)
>
> It would be trivial to increase or decrease the maximum backoff. But I
> think the current value is a reasonable compromise.
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
