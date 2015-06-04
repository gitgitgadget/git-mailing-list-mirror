From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH mh/lockfile-retry] lockfile: replace random() by rand()
Date: Thu, 04 Jun 2015 10:40:48 +0200
Message-ID: <55700F10.8030806@kdbg.org>
References: <55695770.2040303@kdbg.org> <xmqq7frqat0m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 10:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Qhy-0008Fq-Ev
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 10:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbbFDIk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 04:40:58 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:15179 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752777AbbFDIkv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 04:40:51 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3m2LD05C01z5tl9;
	Thu,  4 Jun 2015 10:40:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 510935242;
	Thu,  4 Jun 2015 10:40:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqq7frqat0m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270761>

Am 30.05.2015 um 19:12 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> There you have it: Look the other way for a while, and people start
>> using exotic stuff... ;)
>
> Is it exotic to have random/srandom?  Both are in POSIX and 4BSD;
> admittedly rand/srand are written down in C89 and later, so they
> might be more portable, but I recall the prevailing wisdom is to
> favor random over rand for quality of randomness and portability, so
> I am wondering if it may be a better approach to keep the code as-is
> and do a compat/random.c based on either rand/srand (or use posix
> sample implementation [*1*]).

For our purposes here, the linear congruence of rand() is certainly 
sufficient. At this time, compatibility functions for random/srandom 
would just mean a lot of work for little gain.

>
>
> [Reference]
>
> *1* http://pubs.opengroup.org/onlinepubs/9699919799/functions/rand.html
>
>
>
>>
>> This is a build breakage of master on Windows. There are also a few
>> new test suite failures. On of them is in t1404#2, indicating that
>> a DF conflict takes a different error path. I haven't debugged, yet.
>> The lock file retry test fails, too. I'll report back as time permits.
>>
>>   lockfile.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lockfile.c b/lockfile.c
>> index 5a93bc7..ee5cb01 100644
>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -191,7 +191,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
>>   		return lock_file(lk, path, flags);
>>
>>   	if (!random_initialized) {
>> -		srandom((unsigned int)getpid());
>> +		srand((unsigned int)getpid());
>>   		random_initialized = 1;
>>   	}
>>
>> @@ -218,7 +218,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
>>
>>   		backoff_ms = multiplier * INITIAL_BACKOFF_MS;
>>   		/* back off for between 0.75*backoff_ms and 1.25*backoff_ms */
>> -		wait_us = (750 + random() % 500) * backoff_ms;
>> +		wait_us = (750 + rand() % 500) * backoff_ms;
>>   		sleep_microseconds(wait_us);
>>   		remaining_us -= wait_us;
>

-- Hannes
