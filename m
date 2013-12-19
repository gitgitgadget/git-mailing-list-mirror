From: Tom Miller <jackerran@gmail.com>
Subject: Re: [PATCH 3/3] fetch --prune: Repair branchname DF conflicts
Date: Wed, 18 Dec 2013 19:48:59 -0600
Message-ID: <20131219014859.GA32240@gmail.com>
References: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
 <1387401776-30994-3-git-send-email-jackerran@gmail.com>
 <xmqq4n65hlko.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 02:49:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtSjy-0004NG-Qd
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 02:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732Ab3LSBtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 20:49:06 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:40826 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3LSBtE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 20:49:04 -0500
Received: by mail-qc0-f169.google.com with SMTP id r5so420464qcx.28
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 17:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OgfdKMdajVNx0x4ZELz0nGm0pffTp0hbKoIyThJHZjE=;
        b=y9h6zQCw3nD9+zZaPmVHbhu4m87kUiIGLUvKXMXGMf34Z8zNxNr1Nmp8GL1WyIO4Y6
         MFjdlhA3XBNKNgtjnaEqPku/z9p/0sKj1ByDYvMD/PGKLzcN+7wcezBf2CO0Gm3jBBiy
         iswqIykrsARnWpXtDl3vRknldaOjQ7nf2VQPkqO1rC5pGkcZBKEdVRAo/57PdpIpfg/6
         /4F34Eywh5JB2YtiLOyw0SgnBr/vyayTF2s/WTifFllP8UL+huZ5w5Xk3r8unE6jokR6
         oDqWkbYPysCbpZBqHB2Os/WBVFZWxbhLKfrCDCLzf9KmP4NrhQGBCtt+Ng3oTUjbTFHP
         HwEQ==
X-Received: by 10.49.41.104 with SMTP id e8mr59740896qel.1.1387417743089;
        Wed, 18 Dec 2013 17:49:03 -0800 (PST)
Received: from gmail.com (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id o5sm6429136qeg.2.2013.12.18.17.49.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2013 17:49:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq4n65hlko.fsf@gitster.dls.corp.google.com>
Received: by 10.229.238.131 with HTTP; Wed, 18 Dec 2013 16:42:21 -0800 (PST)
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239512>

On Wed, Dec 18, 2013 at 3:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Tom Miller <jackerran@gmail.com> writes:
>
>> When a branchname DF conflict occurs during a fetch,
>
> You may have started with a specific case in which you want to
> change the behaviour of current Git, so it may be clear what you
> meant by "branchname DF conflict", but that is true for nobody other
> than you who will read this log message.  Introducing new lingo is
> OK as long as it is necessary, but in a case like this, where you
> have to describe what situation you are trying to address anyway,
> I do not think you need to add a new word to our vocabulary.
>
>         When we have a remote-tracking branch frotz/nitfol from a
>         previous fetch, and the upstream now has branch frotz, we
>         used to fail to remove frotz/nitfol and recreate frotz with
>         "git fetch --prune" from the upstream.
>
> or something like that?

I did not intend to introduce new lingo. I did some searching through
history to see if something like this had been worked on before and
I found a commit by Jeff King that introduced me the the idea of
"DF conflicts"

	> commit fa250759794ab98e6edfbbf2f6aa2cb912e535eb
	> Author: Jeff King <peff@peff.net>
	> Date:   Mon May 25 06:40:54 2009 -0400
	>
	>     fetch: report ref storage DF errors more accurately
	>
	>     When we fail to store a fetched ref, we recommend that the
	>     user try running "git prune" to remove up any old refs that
	>     have been deleted by the remote, which would clear up any DF
	>     conflicts. However, ref storage might fail for other
	>     reasons (e.g., permissions problems) in which case the
	>     advice is useless and misleading.
	>
	>     This patch detects when there is an actual DF situation and
	>     only issues the advice when one is found.
	>
	>     Signed-off-by: Jeff King <peff@peff.net>
	>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

I have no issue with rewording the it to be more clear and to try to
remove any new lingo.

> But what should happen when we do not give --prune to "git fetch" in
> such a situation?  Should it fail, because we still have frotz/nitfol
> and we cannot create frotz without losing it?

You talk about this to some extent in an email from 2009. I have linked
it below for your review.
http://article.gmane.org/gmane.comp.version-control.git/132276

In my opinion, if I supply "--prune" to "fetch" I expect it to be
destructive. It should be noted that the reflog can *not* be used
to recover pruned branches from a remote.

>> --prune should
>> be able to fix it. When fetching with --prune, the fetching process
>> happens before pruning causing the branchname DF conflict to persist
>> and report an error. This patch prunes before fetching, thus
>> correcting DF conflicts during a fetch.
>>
>> Signed-off-by: Tom Miller <jackerran@gmail.com>
>> Tested-by: Thomas Rast <tr@thomasrast.ch>
>
> I wasn't following previous threads closely (was there a previous
> thread???); has this iteration been already tested by trast?

There was a previous thread, but I was just looking for feed back on this
as a WIP. Should I have replied to it with this patchset?

Here is a link to the previous thread.
http://thread.gmane.org/gmane.comp.version-control.git/238530

The commit below should be the same patch he tested. The test was added
by him, and I made it part of this commit. Did I do this wrong?

>> ---
>>  builtin/fetch.c  | 10 +++++-----
>>  t/t5510-fetch.sh | 14 ++++++++++++++
>>  2 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index e50b697..845c687 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -868,11 +868,6 @@ static int do_fetch(struct transport *transport,
>>
>>       if (tags == TAGS_DEFAULT && autotags)
>>               transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
>> -     if (fetch_refs(transport, ref_map)) {
>> -             free_refs(ref_map);
>> -             retcode = 1;
>> -             goto cleanup;
>> -     }
>>       if (prune) {
>>               /*
>>                * We only prune based on refspecs specified
>> @@ -888,6 +883,11 @@ static int do_fetch(struct transport *transport,
>>                                  transport->url);
>>               }
>>       }
>> +     if (fetch_refs(transport, ref_map)) {
>> +             free_refs(ref_map);
>> +             retcode = 1;
>> +             goto cleanup;
>> +     }
>>       free_refs(ref_map);
>>
>>       /* if neither --no-tags nor --tags was specified, do automated tag
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index 5d4581d..a981125 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -614,4 +614,18 @@ test_expect_success 'all boundary commits are excluded' '
>>       test_bundle_object_count .git/objects/pack/pack-${pack##pack    }.pack 3
>>  '
>>
>> +test_expect_success 'branchname D/F conflict resolved by --prune' '
>> +     git branch dir/file &&
>> +     git clone . prune-df-conflict &&
>> +     git branch -D dir/file &&
>> +     git branch dir &&
>> +     (
>> +             cd prune-df-conflict &&
>> +             git fetch --prune &&
>> +             git rev-parse origin/dir >../actual
>> +     ) &&
>> +     git rev-parse dir >expect &&
>> +     test_cmp expect actual
>> +'
>> +
>>  test_done
