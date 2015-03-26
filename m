From: Petr Stodulka <pstodulk@redhat.com>
Subject: Re: [BUG] [PATCH] infinite loop due to broken symlink
Date: Thu, 26 Mar 2015 10:32:05 +0100
Message-ID: <5513D215.4070806@redhat.com>
References: <5510399D.4020007@redhat.com> <55133C63.2010805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 10:32:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb49E-0000N0-EJ
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 10:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbbCZJcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 05:32:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54678 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbbCZJcK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 05:32:10 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2Q9W8K3028406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Mar 2015 05:32:08 -0400
Received: from [10.34.4.110] (unused-4-110.brq.redhat.com [10.34.4.110])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2Q9W5bN021323
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Mar 2015 05:32:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <55133C63.2010805@alum.mit.edu>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266319>


On 25.3.2015  23:53 Michael Haggerty wrote:
> On 03/23/2015 05:04 PM, Petr Stodulka wrote:
>> git goes into an infinite loop due to broken symlink (minimal reproducer
>> [0]).  Affected code is in function
>> "resolve_ref_unsafe" in file refs.c - notice 'stat_ref'. There is comment
>> about problem with race condition, hovewer in that case it's regular broken
>> symlink which cause infinite loop.
> Thanks for the bug report. I can confirm the problem. In fact, I noticed
> the same problem when I was working on a refactoring in the area, but I
> still haven't submitted those patches. Luckily, modern Git doesn't use
> symlinks in the loose reference hierarchy, so most users will never
> encounter this problem.
>
> In fact I think it is only the open() call that can lead to the infinite
> loop. Meanwhile, there is another problem caused by falling through the
> symlink-handling code, namely that st reflects the lstat() of the
> symlink rather than the stat() of the file that it points to.
>
> My approach was to run stat() on the path if the symlink-handling code
> falls through. You can see my work in progress in my GitHub repo [1].
>
Yes, I thought up about similar solution, but I wasn't sure about this way
because of race condition (I don't know well code of git yet). In the case
of approved lstat/stat patch, I am more familiar with this solution.
>> Possible patch could be something
>> like this:
>>
>> -------------------------------------------------------
>> diff --git a/refs.c b/refs.c
>> index e23542b..9efe8d2 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1356,6 +1356,7 @@ static struct ref_dir *get_loose_refs(struct
>> ref_cache *refs)
>>   /* We allow "recursive" symbolic refs. Only within reason, though */
>>   #define MAXDEPTH 5
>>   #define MAXREFLEN (1024)
>> +#define MAXLOOP 1024
>>
>>   /*
>>    * Called by resolve_gitlink_ref_recursive() after it failed to read
>> @@ -1482,6 +1483,7 @@ const char *resolve_ref_unsafe(const char
>> *refname, int resolve_flags, unsigned
>>          char buffer[256];
>>          static char refname_buffer[256];
>>          int bad_name = 0;
>> +    int loop_counter = 0;
>>
>>          if (flags)
>>                  *flags = 0;
>> @@ -1546,7 +1548,8 @@ const char *resolve_ref_unsafe(const char
>> *refname, int resolve_flags, unsigned
>>                  if (S_ISLNK(st.st_mode)) {
>>                          len = readlink(path, buffer, sizeof(buffer)-1);
>>                          if (len < 0) {
>> -                               if (errno == ENOENT || errno == EINVAL)
>> +                               if (loop_counter++ < MAXLOOP &&
>> +                    (errno == ENOENT || errno == EINVAL))
>>                                          /* inconsistent with lstat;
>> retry */
>>                                          goto stat_ref;
>>                                  else
>> @@ -1579,7 +1582,7 @@ const char *resolve_ref_unsafe(const char
>> *refname, int resolve_flags, unsigned
>>                   */
>>                  fd = open(path, O_RDONLY);
>>                  if (fd < 0) {
>> -                       if (errno == ENOENT)
>> +                       if (loop_counter++ < MAXLOOP && errno == ENOENT)
>>                                  /* inconsistent with lstat; retry */
>>                                  goto stat_ref;
>>                          else
>> -------------------------------------------------------
>>
>> If I understand well that simple check of broken symlink is not possible
>> due to race conditions.
> This change also prevents the infinite loop, in fact in a more failproof
> way that doesn't depend on errno values being interpreted correctly. I
> would suggest a few stylistic changes, like for example here [2]. On the
> other hand, this change doesn't solve the lstat()/stat() problem.
>
> Nevertheless, I wouldn't object to a fix like this being accepted in
> addition to the stat() fix when it's ready. It doesn't hurt to wear both
> a belt *and* suspenders.
>
> Michael
>
> [1] https://github.com/mhagger/git, branch "wip/refactor-resolve-ref".
>      See especially commit d2425d8ac8cf73494b318078b92f5b1c510a68fb.
> [2] https://github.com/mhagger/git, branch "ref-broken-symlinks"
>
When stat/lstat  is ready, probably this will not be valuable anymore, 
but it
could be reliable 'stop' for some unexpected/unknown possibly ways in 
future.

Petr.
