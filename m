Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2626BC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAFE62076A
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vePonoyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgEOQJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 12:09:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63661 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOQJd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 12:09:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E34EC4D26D;
        Fri, 15 May 2020 12:09:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u3JXuyd+uVF5sV2RJtFYNbHunKM=; b=vePono
        yqV1Gvj9PG61mkaXNG9yUKMObiFor9tDivrBiOXnXCzy0qML3J4hv4wpvhZvmW/h
        XquIXmGxJn+UIt1bTFCq3gzccpeZFTGnCf4EgDcbAkLVPEHif6XII7gcb4+eVNG3
        3WXZa99aflpNtpjE2LQxYzCn0FEeiFzOXyq50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j3oh3A1SDoslDbRwRtbUzXb3lJ50uzsA
        dpr2kntKQxQsQPdfQXtyAPgdUfm19Mc7EZxhmOqOFdDzE362PP8mSS7izks6BoyW
        FRg/ROesomqjph3g0VlcnTJ/s0TQKO5RcuQN5uBLYnly3aA3rWuwUS3Jq6DjyeJC
        4iqgJ+NJPrM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA1124D26C;
        Fri, 15 May 2020 12:09:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62B374D26A;
        Fri, 15 May 2020 12:09:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] trace2: log progress time and throughput
References: <20200512214420.36329-1-emilyshaffer@google.com>
        <8f159f13-ed61-61ea-8e9a-c1ffbc5fddb3@gmail.com>
        <xmqqzha9md5d.fsf@gitster.c.googlers.com>
Date:   Fri, 15 May 2020 09:09:28 -0700
In-Reply-To: <xmqqzha9md5d.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 15 May 2020 08:27:42 -0700")
Message-ID: <xmqqtv0hmb7r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74B98B5C-96C6-11EA-A8BB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <stolee@gmail.com> writes:
> ...
>> This trace2_region_leave() needs to be conditional on the progress
>> being non-null. The pattern used by consumers of the progress API is:
>>
>> 	if (my_progress_condition)
>> 		start_progress(&progress);
>>
>> 	do {
>> 		display_progress(&progress, count);
>> 	} while (condition);
>>
>> 	stop_progress(&progress);
>>
>> The condition to show progress or not is conditional on an option that
>> is external to the progress API.
>>
>> The fix for this patch is simple: make the trace2_region_leave() be
>> conditional on "p_progress && *p_progress".

Oops.  That means that we need to apply the fix before -rc1 to
'master' X-<.

Something like this?

-- >8 --
Subject: progress: call trace2_region_leave() only after calling _enter()
From: Derrick Stolee <dstolee@microsoft.com>

A user of progress API calls start_progress() conditionally and
depends on the display_progress() and stop_progress() functions to
become no-op when start_progress() hasn't been called.

As we added a call to trace2_region_enter() to start_progress(), the
calls to other trace2 API calls from the progress API functions must
make sure that these trace2 calls are skipped when start_progress()
hasn't been called on the progress struct.  Specifically, do not
call trace2_region_leave() from stop_progress() when we haven't
called start_progress(), which would have called the matching
trace2_region_enter().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 progress.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/progress.c b/progress.c
index 6d2dcff0b6..3eda914518 100644
--- a/progress.c
+++ b/progress.c
@@ -329,13 +329,9 @@ void stop_progress(struct progress **p_progress)
 			trace2_data_intmax("progress", the_repository,
 					   "total_bytes",
 					   (*p_progress)->throughput->curr_total);
-	}
 
-	trace2_region_leave("progress",
-			    p_progress && *p_progress
-				? (*p_progress)->title
-				: NULL,
-			    the_repository);
+		trace2_region_leave("progress", (*p_progress)->title, the_repository);
+	}
 
 	stop_progress_msg(p_progress, _("done"));
 }




