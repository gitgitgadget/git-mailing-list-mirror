Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1816C203F2
	for <e@80x24.org>; Wed, 25 Oct 2017 19:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdJYTZa (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 15:25:30 -0400
Received: from siwi.pair.com ([209.68.5.199]:33230 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdJYTZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 15:25:29 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9E32B84585;
        Wed, 25 Oct 2017 15:25:28 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 38C1384584;
        Wed, 25 Oct 2017 15:25:28 -0400 (EDT)
Subject: Re: [PATCH 03/13] list-objects: filter objects in
 traverse_commit_list
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
 <20171024185332.57261-4-git@jeffhostetler.com>
 <CAGf8dg+_AewifMR8wnrQdJKXK0GuwdhMb8QAMrGoVCJzhysiRw@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <69ca62a0-ac4a-f821-0652-4340ce7b2fb1@jeffhostetler.com>
Date:   Wed, 25 Oct 2017 15:25:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAGf8dg+_AewifMR8wnrQdJKXK0GuwdhMb8QAMrGoVCJzhysiRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/2017 12:05 AM, Jonathan Tan wrote:
> On Tue, Oct 24, 2017 at 11:53 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> +enum list_objects_filter_result {
>> +       LOFR_ZERO      = 0,
>> +       LOFR_MARK_SEEN = 1<<0,
> 
> Probably worth documenting, something like /* Mark this object so that
> it is skipped for the rest of the traversal. */
> 
>> +       LOFR_SHOW      = 1<<1,
> 
> And something like /* Invoke show_object_fn on this object. This
> object may be revisited unless LOFR_MARK_SEEN is also set. */
> 
>> +};
>> +
>> +/* See object.h and revision.h */
>> +#define FILTER_REVISIT (1<<25)
> 
> I think this should be declared closer to its use - in the sparse
> filter code or in the file that uses it. Wherever it is, also update
> the chart in object.h to indicate that we're using this 25th bit.
> 
>> +
>> +enum list_objects_filter_type {
>> +       LOFT_BEGIN_TREE,
>> +       LOFT_END_TREE,
>> +       LOFT_BLOB
>> +};
>> +
>> +typedef enum list_objects_filter_result list_objects_filter_result;
>> +typedef enum list_objects_filter_type list_objects_filter_type;
> 
> I don't think we typedef enums in Git code.
> 
>> +
>> +typedef list_objects_filter_result (*filter_object_fn)(
>> +       list_objects_filter_type filter_type,
>> +       struct object *obj,
>> +       const char *pathname,
>> +       const char *filename,
>> +       void *filter_data);
>> +
>> +void traverse_commit_list_worker(
>> +       struct rev_info *,
>> +       show_commit_fn, show_object_fn, void *show_data,
>> +       filter_object_fn filter, void *filter_data);
> 
> I think things would be much clearer if a default filter was declared
> (matching the behavior as of this patch when filter == NULL), say:
> static inline default_filter(args) { switch(filter_type) { case
> LOFT_BEGIN_TREE: return LOFR_MARK_SEEN | LOFR_SHOW; case
> LOFT_END_TREE: return LOFT_ZERO; ...
> 
> And inline traverse_commit_list() instead of putting it in the .c file.
> 
> This would reduce or eliminate the need to document
> traverse_commit_list_worker, including what happens if filter is NULL,
> and explain how a user would make their own filter_object_fn.
> 
>> +
>> +#endif /* LIST_OBJECTS_H */
>> --
>> 2.9.3
>>

I'll give that a try.  Thanks!

Jeff
