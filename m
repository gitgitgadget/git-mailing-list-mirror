Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D4B1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 18:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfGYSMM (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 14:12:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59273 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGYSMM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 14:12:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3133D892D7;
        Thu, 25 Jul 2019 14:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XhSkeBAAvMziKqU/J5dzuzd4Ev0=; b=rB1G9T
        7XP/hqzZ+WDyY0Ftl+t9xJufc2eqchso8wL3+JuNZIzEsmYyZdSQt0opTKUf7+MJ
        J2Ot9zJlFRa0ijXd8BHs9QBP6fbE5nNnYyccgDhJPjW92tWDw8RIcyNU7B6JPelU
        8po1UoJgPMfZL3jOe1gCMN2XKfIksEmmn0X5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ACGwiL0i+ZTJyeY95QmTsetfzOPcizpX
        AWYQpBVmM7VeZecB92zxlhteaa0SIdy0beE78S0rnjzgvDnOnoUaqI+kFkWODWFL
        zjo4Xk1pAtuM+jmibXvb1rRqcMudBsoBZC5s2JGn3pTRZttEpvyqeox76Odp4H6T
        r7cFhWgTjGk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25882892D6;
        Thu, 25 Jul 2019 14:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 533F9892D2;
        Thu, 25 Jul 2019 14:12:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/19] Cleanup merge API
References: <20190725174611.14802-1-newren@gmail.com>
Date:   Thu, 25 Jul 2019 11:12:07 -0700
In-Reply-To: <20190725174611.14802-1-newren@gmail.com> (Elijah Newren's
        message of "Thu, 25 Jul 2019 10:45:52 -0700")
Message-ID: <xmqqblxioufc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7B9ED5E-AF07-11E9-89A5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Before writing a replacement merge strategy for recursive, I decided
> to first cleanup the merge API -- streamlining merge-recursive.h and
> making it more readable.  It includes some fixes I noticed along the
> way, and the last two patches were some forgotten changes of mine I
> rediscovered that had minor textual conflicts before I rebased them on
> this series.
>
>     While there are minor textual and semantic dependencies between
>     these patches (preventing me from splitting up this series), they
>     are logically separate and can be reviewed independently.

Nice.

> Stuff I'd most welcome review on:
>   * Is cache-tree.c the right place for write_tree_from_memory()?
>     [see patch 7]  Should there be docs on how it differs from
>     write_index_as_tree(), already found in cache-tree?  What does
>     the latter even do?

write_index_as_tree() is supposed to write the contents of an index
state as a tree object, and return the object ID for the resulting
tree.  It is the primary interface designed to be used by
write-tree.

> Stuff I didn't address:
>   * All current callers (3 of them?) of merge_recursive() always pass
>     ... I'm guessing the first did in an attempt to
>     exactly match the git-merge-recursive.py scripts' behavior.

That matches my recollection.  
