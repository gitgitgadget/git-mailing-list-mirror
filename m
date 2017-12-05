Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EFF220A40
	for <e@80x24.org>; Tue,  5 Dec 2017 16:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbdLEQCr (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:02:47 -0500
Received: from siwi.pair.com ([209.68.5.199]:12209 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753092AbdLEQCp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:02:45 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4A390844E0;
        Tue,  5 Dec 2017 11:02:44 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 04E41844DE;
        Tue,  5 Dec 2017 11:02:43 -0500 (EST)
Subject: Re: [PATCH v5 08/10] sha1_file: support lazily fetching missing
 objects
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20171121210720.21376-1-git@jeffhostetler.com>
 <20171121210720.21376-9-git@jeffhostetler.com>
 <CAP8UFD2Q075aKG0yEbOy-W2+NSa6n8AEVu=yWn9q=xSnQwn5=g@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2d1958ed-c6f2-2111-dec5-a1dd3c842f7d@jeffhostetler.com>
Date:   Tue, 5 Dec 2017 11:02:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2Q075aKG0yEbOy-W2+NSa6n8AEVu=yWn9q=xSnQwn5=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/2/2017 1:29 PM, Christian Couder wrote:
> On Tue, Nov 21, 2017 at 10:07 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>> From: Jonathan Tan <jonathantanmy@google.com>
[...]
>>   int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
>>   {
[...]
>>
>> -       if (!find_pack_entry(real, &e)) {
>> -               /* Most likely it's a loose object. */
>> -               if (!sha1_loose_object_info(real, oi, flags))
>> -                       return 0;
>> +retry:
>> +       if (find_pack_entry(real, &e))
>> +               goto found_packed;
>>
>> -               /* Not a loose object; someone else may have just packed it. */
>> -               if (flags & OBJECT_INFO_QUICK) {
>> -                       return -1;
>> -               } else {
>> -                       reprepare_packed_git();
>> -                       if (!find_pack_entry(real, &e))
>> -                               return -1;
>> -               }
>> +       /* Most likely it's a loose object. */
>> +       if (!sha1_loose_object_info(real, oi, flags))
>> +               return 0;
>> +
>> +       /* Not a loose object; someone else may have just packed it. */
>> +       reprepare_packed_git();
>> +       if (find_pack_entry(real, &e))
>> +               goto found_packed;
>> +
>> +       /* Check if it is a missing object */
>> +       if (fetch_if_missing && repository_format_partial_clone &&
>> +           !already_retried) {
>> +               fetch_object(repository_format_partial_clone, real);
>> +               already_retried = 1;
>> +               goto retry;
>>          }
>>
>> +       return -1;
>> +
>> +found_packed:
>>          if (oi == &blank_oi)
[...]
> 
> The above is adding 2 different gotos into this function while there
> are quite simple ways to avoid them. See
> https://public-inbox.org/git/CAP8UFD2THRj7+RXmismUtUOpXQv4wM7aZsejpd_FHEOycP+ZJA@mail.gmail.com/
> and the follow up email in the thread.

Personally, I'm OK with limited goto's like these.  Yes, they are ugly,
but not that complicated.  Alternatively, we could put everything between
the 2 labels in a while (1) {...} and replace the goto's with break's and
continue's.  I think it would be better to revisit this later, as I'd
rather not start refactoring sha1_file.c in the middle of what is already
a 30+ commit patch series (for the 3 parts of partial clone).

Thoughts?
Jeff

