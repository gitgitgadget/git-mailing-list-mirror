Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464D1C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 23:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiGSX23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 19:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiGSX22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 19:28:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFB3643D0
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 16:28:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 959C119DE3F;
        Tue, 19 Jul 2022 19:28:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PjgNDZQCqPMa+R328T1ojqm0k8wL+Hrg5BhupL
        1Uuok=; b=CeJKAygNF81hVP4BdBdyRXETOAVUwDv6Dcwi/oJnh4P0jUR7wHpGC5
        OjmALb80vW1S8/lYLeA+Xq5y56hXtLFSi3z+A91YaYSOAA+ogeKS5HRoRwmg6UqV
        vM5hPJ1e/F8k5KJLELTwJcIWfLpaVonWqkE4lXA7lmFuIGBEczrTw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E6F219DE3E;
        Tue, 19 Jul 2022 19:28:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2704819DE3D;
        Tue, 19 Jul 2022 19:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/6] merge: make restore_state() restore staged state
 too
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <4a8b7c9e06df36444b94b929b2558f40e3f72e81.1655621424.git.gitgitgadget@gmail.com>
        <xmqqsfmw66gq.fsf@gitster.g>
Date:   Tue, 19 Jul 2022 16:28:21 -0700
In-Reply-To: <xmqqsfmw66gq.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        19 Jul 2022 16:14:13 -0700")
Message-ID: <xmqq7d4865t6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AAC0A96-07BA-11ED-93E5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Elijah Newren <newren@gmail.com>
>>
>> merge can be invoked with uncommitted changes, including staged changes.
>> merge is responsible for restoring this state if some of the merge
>> strategies make changes.  However, it was not restoring staged changes
>> due to the lack of the "--index" option to "git stash apply".  Add the
>> option to fix this shortcoming.
>
> Shouldn't this be testable?

I actually take this part (which implied that the change is a good
idea) back.  I think we have clearly documented for the past 17
years that you can have local changes but your index must match the
HEAD before you start your merge.

If "stash apply" vs "stash apply --index" makes any difference,
there is something wrong.  We should be aborting the "git merge"
even before we even start mucking with the working tree and the
index with strategies, no?  I think it is the bug, if this change
makes any difference, to be fixed---we shouldn't be proceeding to
even create a stash with index changes to begin with.

>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>>  builtin/merge.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index 8ce4336dd3f..2dc56fab70b 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -383,14 +383,14 @@ static void reset_hard(const struct object_id *oid, int verbose)
>>  static void restore_state(const struct object_id *head,
>>  			  const struct object_id *stash)
>>  {
>> -	const char *args[] = { "stash", "apply", NULL, NULL };
>> +	const char *args[] = { "stash", "apply", "--index", NULL, NULL };
>>  
>>  	if (is_null_oid(stash))
>>  		return;
>>  
>>  	reset_hard(head, 1);
>>  
>> -	args[2] = oid_to_hex(stash);
>> +	args[3] = oid_to_hex(stash);
>>  
>>  	/*
>>  	 * It is OK to ignore error here, for example when there was
>
> OK.
