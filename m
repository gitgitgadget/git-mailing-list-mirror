Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94512203F2
	for <e@80x24.org>; Wed, 25 Oct 2017 19:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbdJYThw (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 15:37:52 -0400
Received: from siwi.pair.com ([209.68.5.199]:53267 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbdJYThv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 15:37:51 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 299928458A;
        Wed, 25 Oct 2017 15:37:51 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B726B84589;
        Wed, 25 Oct 2017 15:37:50 -0400 (EDT)
Subject: Re: [PATCH 10/13] rev-list: add list-objects filtering support
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
 <20171024185332.57261-11-git@jeffhostetler.com>
 <CAGf8dgK3pW8T4Tst6LZuJxLZTDjk7Ak5iwK0WYBSLrWR1S8YBg@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4afe76f0-a243-126b-b3e0-d2d08640e73d@jeffhostetler.com>
Date:   Wed, 25 Oct 2017 15:37:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAGf8dgK3pW8T4Tst6LZuJxLZTDjk7Ak5iwK0WYBSLrWR1S8YBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/2017 12:41 AM, Jonathan Tan wrote:
> On Tue, Oct 24, 2017 at 11:53 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>>   static void finish_object(struct object *obj, const char *name, void *cb_data)
>>   {
>>          struct rev_list_info *info = cb_data;
>> -       if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
>> +       if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
>> +               if (arg_print_missing) {
>> +                       list_objects_filter_map_insert(
>> +                               &missing_objects, &obj->oid, name, obj->type);
>> +                       return;
>> +               }
>> +
>> +               /*
>> +                * Relax consistency checks when we expect missing
>> +                * objects because of partial-clone or a previous
>> +                * partial-fetch.
>> +                *
>> +                * Note that this is independent of any filtering that
>> +                * we are doing in this run.
>> +                */
>> +               if (is_partial_clone_registered())
>> +                       return;
>> +
>>                  die("missing blob object '%s'", oid_to_hex(&obj->oid));
> 
> I'm fine with arg_print_missing suppressing lazy fetching (when I
> rebase my patches on this, I'll have to ensure that fetch_if_missing
> is set to 0 if arg_print_missing is true), but I think that the
> behavior when arg_print_missing is false should be the opposite - we
> should let has_object_file() perform the lazy fetching, and die if it
> returns false (that is, if the fetching failed).

Right. This is a point where our different approaches need
to come together.  My "is_partial_clone_registered" is essentially
a placeholder for your lazy fetching.  so we can delete this call
when your changes are in.  Basically, you set:
	fetch_if_missing = !arg_print_missing
at the top.

> 
>> +       }
>>          if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
>>                  parse_object(&obj->oid);
>>   }
