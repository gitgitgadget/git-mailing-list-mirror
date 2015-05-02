From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring
 the packed-refs lock
Date: Sat, 02 May 2015 07:19:28 +0200
Message-ID: <55445E60.6010205@alum.mit.edu>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu> <1430491977-25817-3-git-send-email-mhagger@alum.mit.edu> <CAGZ79kZnhv+aW_GW8mBDyhfv_k54ScAFsHQz=8zfHBUJ8WrVUw@mail.gmail.com> <20150501182257.GA27728@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat May 02 07:19:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoPq7-0004VM-1b
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 07:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbbEBFTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 01:19:35 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59708 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750794AbbEBFTe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 May 2015 01:19:34 -0400
X-AuditID: 12074412-f79e46d0000036b4-10-55445e63203c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id AF.77.14004.36E54455; Sat,  2 May 2015 01:19:31 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97E83.dip0.t-ipconnect.de [79.201.126.131])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t425JSNY017557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 2 May 2015 01:19:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <20150501182257.GA27728@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqJsc5xJq0HWBxaLrSjeTRUPvFWaL
	Hy09zBabN7ezOLB4LNhU6vGsdw+jx8VLyh6fN8kFsERx2yQllpQFZ6bn6dslcGdMed/PUvBQ
	v6LlmnYD406lLkZODgkBE4n5/x+xQNhiEhfurWfrYuTiEBK4zCgx//4KKOc8k8Ti1ZOYQKp4
	BbQlNh26wgpiswioShzvbGEHsdkEdCUW9TSD1YgKBEm0XpvKCFEvKHFy5hOwDSICjhJHfk1n
	A7GZBWIkHh3pBpsjLJAgseP+VnaIZU8YJU7O3gaW4BTQk7jccZMVokFd4s+8S8wQtrxE89bZ
	zBMYBWYh2TELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluilppRuYoSE
	s9AOxvUn5Q4xCnAwKvHwftByCRViTSwrrsw9xCjJwaQkyivPBRTiS8pPqcxILM6ILyrNSS0+
	xCjBwawkwisbBZTjTUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHgUJLgLYgF
	ahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxWp8MTBaQVI8QHvlQNp5iwsSc4Gi
	EK2nGBWlxHnFQRICIImM0jy4sbAk9YpRHOhLYd5HMUBVPMAEB9f9CmgwE9Dg87ccQAaXJCKk
	pBoYD2tI7kmYxiWkezaq378i6s23F4wfRZSTOReqly6epfSA0zmoMURRo+4ag+C92x5bheJT
	OjoOHS/9IPD52X3R/133zj1xDOh1uGbeZeKXpTltw4bgqSzJ22QXhJ02DJ2/889W 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268218>

On 05/01/2015 08:22 PM, Jeff King wrote:
> On Fri, May 01, 2015 at 10:51:47AM -0700, Stefan Beller wrote:
> 
>>> diff --git a/refs.c b/refs.c
>>> index 47e4e53..3f8ac63 100644
>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -2413,9 +2413,19 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
>>>  /* This should return a meaningful errno on failure */
>>>  int lock_packed_refs(int flags)
>>>  {
>>> +       static int timeout_configured = 0;
>>> +       static int timeout_value = 1000;
>>
>> I'd personally be more happier with a default value of 100 ms or less
>> The reason is found in the human nature, as humans tend to perceive
>> anything faster than 100ms as "instant"[1], while a 100ms is a long time
>> for computers.
>>
>> Now a small default time may lead to to little retries, so maybe it's worth
>> checking at the very end of the time again (ignoring the computed backoff
>> times). As pushes to $server usually take a while (connecting, packing packs,
>> writing objects etc), this may be overcautios bikeshedding from my side.
> 
> Keep in mind that this 1s is the maximum time to wait. The
> lock_file_timeout() code from patch 1 starts off at 1ms, grows
> quadratically, and quits as soon as it succeeds. So in most cases, the
> user will wait a much smaller amount of time.
> 
> The factors that go into this timeout length are really:
> 
>   1. If there's a stale lockfile, the user will have to wait the whole
>      period. How long do we keep retrying before giving up?
> 
>   2. How long do we typically hold the lock for? Aside from absurd
>      cases, writing out the packed-refs file isn't that expensive. But
>      while holding the packed-refs lock, we may actually be iterating
>      the loose refs, which can be rather slow on a cold-cache.
> 
> If we want to improve _responsiveness_ in the normal case, I think it's
> not the max timeout we want to tweak but the resolution of retries.
> That's set in patch 1 by the maximum backoff multiplier, which can put
> us up to 1s between retries. It might make sense to drop that to 500ms
> or even less.

Thanks for the discussion.

100 ms seems to be considered an acceptable delay between the time that
a user, say, clicks a button and the time that the button reacts. What
we are talking about is the time between the release of a lock by one
process and the resumption of another process that was blocked waiting
for the lock. The former is probably not under the control of the user
anyway, and perhaps not even observable by the user. Thus I don't think
that a perceivable delay between that event and the resumption of the
blocked process would be annoying. The more salient delay is between the
time that the user started the blocked command and when that command
completed. Let's look in more detail.

The current code would poll at the following times (in ms), ignoring the
time taken for the actual polling attempt and ignoring the random component:

    time  backoff  percent
    ----  -------  -------
       0        1     N/A
       1        4     400%
       5        9     180%
      14       16     114%
      30       25      83%
      55       36      65%
      91       49      54%
     140       64      46%
     204       81      40%
     285      100      35%
     385      121      31%
     506      144      28%
     650      169      26%
     819      196      24%
    1015      225      22%  <- Stop here with the default 1 s timeout
    1240      256      21%
    1496      289      19%
    1785      324      18%
    2109      361      17%
    2470      400      16%
    2870      441      15%
    3311      484      15%
    3795      529      14%
    4324      576      13%
    4900      625      13%
    5525      676      12%
    6201      729      12%
    6930      784      11%
    7714      841      11%
    8555      900      11%
    9455      961      10%
   10416     1000      10%
   11416     1000       9%
   12416     1000       8%

>From the table, the first backoff that is longer than 100 ms doesn't
start until 385 ms, and in the worst case, that 121 ms delay would
increase the *total* wait by only 31%. And the longest backoff within
the first second is only 196 ms. The backoff doesn't reach its maximum
value, 1 s, until the process has already been blocked for 10.4 seconds.

Remember, these backoffs are the *maximum* time that the user might wait
between the time that one process is finished and the time that the
second process resumes. The *average* wait time will be half of that.

And finally, remember that lock contention should be very rare in the
first place, and will mostly occur on servers (because normal users are
unlikely to have lots of parallel processes accessing a single git
repository). What are the most likely scenarios for lock contention in
the real world?

* Occasionally, by chance, under normal operations. In most cases, the
blocking process will finish up within a few milliseconds, the blocked
process will resume almost immediately, and nobody will notice a thing.

* In a pathological repository that has, say, a million packed
references, and writing the packed-refs file takes unusually long. Here,
typical lock contention delays will be long anyway, and adding (worst
case) 121 ms == 31% to the delay is not unreasonable.

* When the server is struggling with enormous load, or a
denial-of-service attack, or some other system-wide problem that is
making processes super slow. In this case it would be counterproductive
to have *additional* processes waking up every 100 ms.

* When a packed-refs.lock file fails to get cleaned up for some reason.
In this case the "contention" will never go away on its own, so the
polling is wasted effort. (Happily, I've almost never seen this happen
on our servers.)

It would be trivial to increase or decrease the maximum backoff. But I
think the current value is a reasonable compromise.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
