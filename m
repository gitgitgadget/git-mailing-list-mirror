Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8BCC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 17:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbiHQRNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 13:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbiHQRNh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 13:13:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9487689
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 10:13:30 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 097941B5381;
        Wed, 17 Aug 2022 13:13:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=88Ah0IzU4pALKeU85qcV3u1dJVIcxKc8qzFJWr5+gZg=; b=moLp
        GmFN1xQcJMzmgAgyJNUJGQusPepsTGMRCQwFK9+sgazbrGDTHi8idtsp0qxs2oYl
        pr1ZKjNKAn1WnFSUW1v8LMJe8PxVNwkZih4q3QPW52rIyrgr7k+5OqRt2CH8xuvt
        flXJx0mUrTgzKvO4MDQmhC2KSi8Y8kjx+ZoMwHs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0316A1B5380;
        Wed, 17 Aug 2022 13:13:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A60E61B537F;
        Wed, 17 Aug 2022 13:13:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org,
        vdye@github.com
Subject: Re: [PATCH v1 1/2] builtin/grep.c: add --sparse option
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220817075633.217934-2-shaoxuan.yuan02@gmail.com>
        <80f24382-1188-d450-d1e2-42f68c08e60b@github.com>
Date:   Wed, 17 Aug 2022 10:13:25 -0700
Message-ID: <xmqqh72ayeru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E84CC166-1E4F-11ED-907C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 8/17/2022 3:56 AM, Shaoxuan Yuan wrote:
>> Add a --sparse option to `git-grep`. This option is mainly used to:
>> 
>> If searching in the index (using --cached):
>> 
>> With --sparse, proceed the action when the current cache_entry is
>
> This phrasing is awkward. It might be better to reframe to describe the
> _why_ before the _what_

Thanks for an excellent suggestion.  As a project participant, I
could guess the motivation, but couldn't link the parts of the
proposed log message to what I thought was being said X-<.  The
below is much clearer.

>   When the '--cached' option is used with the 'git grep' command, the
>   search is limited to the blobs found in the index, not in the worktree.
>   If the user has enabled sparse-checkout, this might present more results
>   than they would like, since the files outside of the sparse-checkout are
>   unlikely to be important to them.

Great.  As an explanation of the reasoning behind the design
decision, I do not think it is bad to go even stronger than "might
... would like" and assume or declare that those users who use
sparse-checkout are the ones who do NOT want to see the parts of the
tree that are sparsed out.  And based on that assumption, "grep" and
"grep --cached" should not bother reporting hit from the part that
the user is not interested in.

By stating the design and the reasoning behind that decision clearly
like so, we allow future developers to reconsider the earlier design
decision more easily.  In 7 years, they may find that the Git users
in their era use sparse-checkout even when they still care about the
contents in the sparsed out area, in which case the basic assumption
behind this change is no longer valid and would allow them to make
"grep" and "grep --cached" behave differently.

>   Change the default behavior of 'git grep' to focus on the files within
>   the sparse-checkout definition. To enable the previous behavior, add a
>   '--sparse' option to 'git grep' that triggers the old behavior that
>   inspects paths outside of the sparse-checkout definition when paired
>   with the '--cached' option.

Yup.  Is that "--sparse" or "--unsparse"?  We are busting the sparse
boundary and looking for everything, and calling the option to do so
"--sparse" somehow feels counter-intuitive, at least to me.

Thanks.
