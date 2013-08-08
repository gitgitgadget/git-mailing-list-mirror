From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 12/19] read-cache: read index-v5
Date: Thu, 8 Aug 2013 09:09:40 +0700
Message-ID: <CACsJy8Bf=SW-Lt6Xr+1LU_dQ_Rqj-3BLSCmqrOjP1RJTkBunZw@mail.gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
 <1373650024-3001-13-git-send-email-t.gummerer@gmail.com> <CACsJy8DDRN5aTOzxuiGSa6UjbBiVUYwHjPcnN+8mw4xKmvkx-A@mail.gmail.com>
 <87k3jxrjs9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 04:10:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7FgW-0002a0-MI
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 04:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389Ab3HHCKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 22:10:12 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:35014 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757605Ab3HHCKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 22:10:11 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so4543431oah.20
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 19:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HN20OfBA+6izWJq0poy6Ey9bH3lEG9xniNHqMxhPnm8=;
        b=AHKt98k8fF5iGFAHOPm+ZoBYNBumHAwaDw4EPDDUzvPZuZmdXVmcFWQ64UJw0CYi1m
         L9reklOajwzbPUvrEwQKOwQ3yrSRqJX4bD13gGZbOm1RhZJXuJJhieoO+p+Jz6ICBGf8
         ePmPKFQn5HUjOohA7ABsgQasA1Tbh2ujb7UG8TXpX4kiWR/U/Qk7X8VJRPULB1Kwnnjh
         uG5Rd8QLcUQRc3YQxuNEzRGLuxaOtW5FRR9oZy700yUebzVwMCy1z7FV1jkMXHXiDucY
         WS19moHa8IpbQ8BkAX37ZYs9Yaknge6mCyYH6uWUYa+zszS8e0uoyVmnXriMyksD7g5N
         +VnA==
X-Received: by 10.182.165.133 with SMTP id yy5mr4733873obb.89.1375927810770;
 Wed, 07 Aug 2013 19:10:10 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Wed, 7 Aug 2013 19:09:40 -0700 (PDT)
In-Reply-To: <87k3jxrjs9.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231856>

On Wed, Aug 7, 2013 at 3:23 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>> +static void ce_queue_push(struct cache_entry **head,
>>> +                            struct cache_entry **tail,
>>> +                            struct cache_entry *ce)
>>> +{
>>> +       if (!*head) {
>>> +               *head = *tail = ce;
>>> +               (*tail)->next = NULL;
>>> +               return;
>>> +       }
>>> +
>>> +       (*tail)->next = ce;
>>> +       ce->next = NULL;
>>> +       *tail = (*tail)->next;
>>
>> No no no. "next" is for name-hash.c don't "reuse" it here. And I don't
>> think you really need to maintain a linked list of cache_entries by
>> the way. More on read_entries comments below..
>
> You're right, I don't need it for the reading code.  I do need to keep a
> list of cache-entries for writing though, where a linked list is best
> suited for the task.  I'll use a next_ce pointer for that.

Hmm.. yeah you need to maintain temporary structures before writing
out direntries, then fileentries table. We can't just write as we
traverse through the cache in one go. Maybe a new field in cache_entry
for the linked list, or maintain the linked list off cache_entry..
whichever is easier for you.

> I've tried implementing both versions with the internal tree structure,
> see below for timings.
>
> simpleapi is the code that was posted to the list, HEAD uses a
> tree-structure for the directories internally, and replaces strcmp with
> cache_name_compare and leaves out the prefix.  This tree uses dummy
> entries for the sub-directories.
>
> Dummy entries are single NUL-bytes mixed with the cache-entries, which
> should give optimal performance.  I haven't thought much about
> corruption of the index, but I don't think we would need any additional
> crc checksums or similar.
>
> The performance advantage seems very slim to none when using the dummy
> entries to avoid the comparison though, so I don't think it makes sense
> to make the index more complicated for a very small speed-up.

Agreed.

> Test                                        simpleapi         HEAD                     this tree
> -------------------------------------------------------------------------------------------------------------
> 0003.2: v[23]: update-index                 3.22(2.61+0.58)   3.20(2.56+0.61) -0.6%    3.22(2.67+0.53) +0.0%
> 0003.3: v[23]: grep nonexistent -- subdir   1.65(1.36+0.27)   1.65(1.34+0.30) +0.0%    1.67(1.34+0.31) +1.2%
> 0003.4: v[23]: ls-files -- subdir           1.50(1.20+0.29)   1.54(1.18+0.34) +2.7%    1.53(1.22+0.30) +2.0%
> 0003.6: v4: update-index                    2.69(2.28+0.39)   2.70(2.21+0.47) +0.4%    2.70(2.27+0.41) +0.4%
> 0003.7: v4: grep nonexistent -- subdir      1.33(0.98+0.34)   1.36(1.01+0.33) +2.3%    1.34(1.03+0.30) +0.8%
> 0003.8: v4: ls-files -- subdir              1.21(0.86+0.33)   1.23(0.91+0.30) +1.7%    1.22(0.90+0.30) +0.8%
> 0003.10: v5: update-index                   2.12(1.58+0.52)   2.20(1.67+0.52) +3.8%    2.19(1.66+0.51) +3.3%
> 0003.11: v5: ls-files                       1.57(1.21+0.34)   1.55(1.20+0.33) -1.3%    1.52(1.21+0.29) -3.2%
> 0003.12: v5: grep nonexistent -- subdir     0.08(0.06+0.01)   0.07(0.04+0.02) -12.5%   0.07(0.04+0.02) -12.5%
> 0003.13: v5: ls-files -- subdir             0.07(0.04+0.01)   0.06(0.05+0.00) -14.3%   0.07(0.05+0.01) +0.0%
-- 
Duy
