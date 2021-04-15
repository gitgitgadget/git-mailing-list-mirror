Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575AFC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 18:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160286109D
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 18:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhDOSYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 14:24:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59751 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbhDOSYw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 14:24:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B94A1228E5;
        Thu, 15 Apr 2021 14:24:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GBDgofsDxHaQl/cANQRlmDPBXpA=; b=nDeDNK
        FWc6WI7hdYI1i75EsIwCZtWSXFScJyCH9q8FUllyWBSn9D/yMwjDGZ7lt96eQeLz
        6Ovl1BcLSksnLlH69UUTdE1acNHpqKwWr+Fiqm5ACA+Xvujf80ZYkqeyrIDB58rB
        wfMgqb1fJtjvV7RjvqzZNYIGgXdJTU6lFmvqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k1dYKthStDv39KB/Kq5GG4E/eSy6SZ8f
        UYWj/Y4xJY1wVV78dgyltFCSOhzVaDaFPJFossrdDNacB62D9FxoWBJW6qEnmlaX
        25RIG1zpCqmIwwLLvag09z3++6QerTXqXZ3Iff5f63fyA7inAZkaoV8g80o8t8C4
        xvr+tUpKjPM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 843C01228E3;
        Thu, 15 Apr 2021 14:24:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CCF5B1228E1;
        Thu, 15 Apr 2021 14:24:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Why isn't 'jch' based on 'next'?
References: <YHgDYl3cMx9+Hqa7@generichostname>
Date:   Thu, 15 Apr 2021 11:24:25 -0700
In-Reply-To: <YHgDYl3cMx9+Hqa7@generichostname> (Denton Liu's message of "Thu,
        15 Apr 2021 02:12:02 -0700")
Message-ID: <xmqqlf9jqucm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF8D9650-9E17-11EB-BE0A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Out of curiosity, why is 'jch' not based on 'next' but instead, it
> recreates the same merge commits on top of 'master'. What is the
> advantage of this?

The 'jch' point is merely a convenient "I personally have no problem
using this tree" point on 'seen', so I'll talk about 'seen'.

It is the second or third time I answer this exact question, and we
should add the answer to Documentation/howto/maintain-git.txt (or
MaintNotes on the todo branch), perhaps.

The history of 'next' can become quite messy due to many reasons:

 - A topic that has already been merged to 'next' but not graduated
   to 'master' may need some fix-up, in which case, 'next' will have
   another merge of the same topic into it.

 - A mismerge of a topic into 'next' may be discovered long after it
   happened, and a single-parent commit is made directly on 'next'
   to correct it.

 - When 'master' advances, it is merged back to 'next'.

 - A topic that looked promising may turn out to be a bad idea and
   the merge of the topic into 'next' get reverted out of 'next'.

 - A topic that looked nice may want to do a wholesale replacement,
   not an incremental refinement, and a merge of the topic into
   'next' get reverted and then the newer iteration of the topic
   gets merged to 'next' (this last case is rare, but it sometimes
   happens, like once every few cycles).

But we know which topic must be in 'next' all the time.  You can ask
'seen' which ones they are:

   $ git log --oneline --first-parent 'master..seen^{/^### match next}'

So if we reset 'seen' at 'master' and merge the tip of these topics
into it, the tree of the empty commit that is marked with "### match
next" marker should match the tree of 'next', or something is still
wrong (most likely, a mismerge).  Also, the order topics are merged
into 'next' may not be necessarily the order they appear in 'seen'.
Every time I rebuild 'seen' from 'master', I have a chance to reorder
these topics so that the ones that are expected to graduate sooner
come near the bottom.

By ensuring "### match next" and 'next' matches, even though they
came to their trees in different route, I can spot a mismerge that
is waiting to happen soon when a topic graduates to 'master'.
