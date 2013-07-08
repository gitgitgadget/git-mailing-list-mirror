From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 05/22] read-cache: add index reading api
Date: Mon, 08 Jul 2013 13:40:01 +0200
Message-ID: <87mwpxqnzi.fsf@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-6-git-send-email-t.gummerer@gmail.com> <CACsJy8A65JGUtdJnGuC20vUfQLQfrtDzj7Eb8pgP9RTqP1Po_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 13:40:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw9nj-0004D5-Gp
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 13:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab3GHLkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 07:40:09 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:57308 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3GHLkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 07:40:08 -0400
Received: by mail-ea0-f180.google.com with SMTP id k10so2922144eaj.11
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=mO1mSHdqxCmbYNdSrXNSyehZ1nPHLv0lZxnp1lrXjjA=;
        b=lk5wQzntfJcmH8jUESQwVXuTKkuvHm+jgAoBzR3cGZwejhbr5vVW2KpYdcsZ5SOPNm
         4oJSwFD89FlvarlvuKk7Mjg1b/HU+IZh/V377fGi6qJklRr1snuM+IhzWqnnZYH835OW
         c93dAUqFzitOwCKwDTZmI8mxoEtZKiR2jzClyMRDYcR1PpIJ9c8x4awSbalBs7W5qRlQ
         Xr0UNGv0sxnO/Z44CkRnGlCcybY3I8Eg2KRyE4+X7bN2+VDc7YLTGairgFnn/hYkBa2m
         1qwPydP3hEJvAI0Sug1rG82LOQcc2FwcL+qoahCGpXpu2p2x9pOlhkhodn/Dil7IfVtn
         NWug==
X-Received: by 10.15.67.140 with SMTP id u12mr24536553eex.90.1373283604269;
        Mon, 08 Jul 2013 04:40:04 -0700 (PDT)
Received: from localhost ([46.18.27.5])
        by mx.google.com with ESMTPSA id e44sm41460970eeh.11.2013.07.08.04.40.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 04:40:03 -0700 (PDT)
In-Reply-To: <CACsJy8A65JGUtdJnGuC20vUfQLQfrtDzj7Eb8pgP9RTqP1Po_w@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229840>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Jul 7, 2013 at 3:11 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Add an api for access to the index file.  Currently there is only a very
>> basic api for accessing the index file, which only allows a full read of
>> the index, and lets the users of the data filter it.  The new index api
>> gives the users the possibility to use only part of the index and
>> provides functions for iterating over and accessing cache entries.
>>
>> This simplifies future improvements to the in-memory format, as changes
>> will be concentrated on one file, instead of the whole git source code.
>>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>>  cache.h         |  57 +++++++++++++++++++++++++++++-
>>  read-cache-v2.c |  96 +++++++++++++++++++++++++++++++++++++++++++++++--
>>  read-cache.c    | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>>  read-cache.h    |  12 ++++++-
>>  4 files changed, 263 insertions(+), 10 deletions(-)
>>
>> diff --git a/cache.h b/cache.h
>> index 5082b34..d38dfbd 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -127,7 +127,8 @@ struct cache_entry {
>>         unsigned int ce_flags;
>>         unsigned int ce_namelen;
>>         unsigned char sha1[20];
>> -       struct cache_entry *next;
>> +       struct cache_entry *next; /* used by name_hash */
>> +       struct cache_entry *next_ce; /* used to keep a list of cache entries */
>>         char name[FLEX_ARRAY]; /* more */
>>  };
>
> From what I read, doing
>
>     ce = start;
>     while (ce) { do(something); ce = next_cache_entry(ce); }
>
> is the same as
>
>     i = start_index;
>     while (i < active_nr) { ce = active_cache[i]; do(something); i++; }
>
> What's the advantage of using the former over the latter? Do you plan
> to eliminate the latter loop (by hiding "struct cache_entry **cache;"
> from public index_state structure?

Yes, I wanted to eliminate the latter loop, because it depends on the
in-memory format of the index.  By moving all direct accesses of
index_state->cache to an api it gets easier to change the in-memory
format.  I played a bit with a tree-based in-memory format [1], which
represents the on-disk format of index-v5 more closely, making
modifications and partial-loading simpler.

I've tried switching all those loops to api calls, but that would make
the api too bloated because there is a lot of those loops.  I found it
more sensible to do it this way, leaving the loops how they are, while
making future changes to the in-memory format a lot simpler.

[1] https://github.com/tgummerer/git/blob/index-v5api/read-cache-v5.c#L17
