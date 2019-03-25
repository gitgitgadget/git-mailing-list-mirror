Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E6120248
	for <e@80x24.org>; Mon, 25 Mar 2019 16:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfCYQ3f (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 12:29:35 -0400
Received: from siwi.pair.com ([209.68.5.199]:17567 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCYQ3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 12:29:35 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9EC463F4020;
        Mon, 25 Mar 2019 12:29:33 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:9c07:30b3:cc1f:41dc] (unknown [IPv6:2001:4898:8010:2:853b:30b3:cc1f:41dc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 54C823F4021;
        Mon, 25 Mar 2019 12:29:33 -0400 (EDT)
Subject: Re: [PATCH v3 1/1] trace2: write to directory targets
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <cover.1552519463.git.steadmon@google.com>
 <cover.1553202340.git.steadmon@google.com>
 <ce5258610ffbc2e498ff33336c5c89b69468d4fd.1553202340.git.steadmon@google.com>
 <87bm21coco.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <11e8e140-c2b6-8234-e6a3-affe69286cbf@jeffhostetler.com>
Date:   Mon, 25 Mar 2019 12:29:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <87bm21coco.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/23/2019 4:44 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Mar 21 2019, Josh Steadmon wrote:
> 
>> When the value of a trace2 environment variable is an absolute path
>> referring to an existing directory, write output to files (one per
>> process) underneath the given directory. Files will be named according
>> to the final component of the trace2 SID, followed by a counter to avoid
>> potential collisions.
> 
[...]
> 
> The reason I'm raising this is that it seems like sweeping an existing
> issue under the rug. We document that the "sid" is "unique", and it's just:
> 
>      <nanotime / 1000 (i.e. *nix time in microseconds)>-<pid>
> 
> So that might be a lie, and in particular I can imagine that say if
> every machine at Google is logging traces into some magic mounted FS
> that there'll be collisions there.
> 
> But then let's *fix that*, because we're also e.g. going to have other
> consumers of these traces using the sid's as primary keys in a logging
> system.
> 
> I wonder if we should just make it a bit longer, human-readable, and
> include a hash of the hostname:
> 
>      perl -MTime::HiRes=gettimeofday -MSys::Hostname -MDigest::SHA=sha1_hex -MPOSIX=strftime -wE '
>          my ($t, $m) = gettimeofday;
>          my $host_hex = substr sha1_hex(hostname()), 0, 8;
>          my $htime = strftime("%Y%m%d%H%M%S", localtime);
>          my $sid = sprintf("%s-%6d-%s-%s",
>              $htime,
>              $m,
>              $host_hex,
>              $$ & 0xFFFF,
>          );
>          say $sid;
>      '
> 
> Which gets you a SID like:
> 
>      20190323213918-404788-c2f5b994-19027
> 
> I.e.:
> 
>      <YYYYMMDDHHMMSS>-<microsecond-offset>-<8 chars of sha1(hostname -f)>-<pid>
> 
> There's obviously ways to make that more compact, but in this case I
> couldn't see a reason to, also using UTC would be a good idea.
> 
> All the trace2 tests pass if I fake that up. Jeff H: Do you have
> anything that relies on the current format?
I'm using the SID hierarchy to track parent and child processes,
but the actual format of an individual SID-component is mostly a
black box.

I used the microseconds+pid as unique enough.  And events for new
commands will mostly just append to an existing index, rather than
being a random insert like you'd get for a GUID.

I didn't use a GUID here because that seemed overkill and a little
bit more expensive, but perhaps that was just premature optimization
on my part.


So, a new fixed width format like you suggested above would be fine.
I wonder though, if we're moving towards a stronger SID, there's no
reason to keep the PID in it.  Which makes me wonder about the value
of sha(hostname) too.  Perhaps, just make it a GUID or some combination
of the UTC date and a GUID ( <YYMMDDHHMMSS>-<microseconds>-<GUID> ) or
something like that.

If it helps, we can change how I'm reporting the SID between parent
and child processes, so that the SID field in the JSON events is
just the SID of the current process and have a peer field with the
SID-hierarchy.  This latter field would only need to be added to the
"version" or "start" event.  This might make post-processing a little
easier.  Not sure it matters one way or the other.

I'm open to suggestions here.

Jeff

