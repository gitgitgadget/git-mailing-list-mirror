Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C887C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 17:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62306024A
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 17:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhBQRvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 12:51:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62984 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhBQRvU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 12:51:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9DE1D121E6F;
        Wed, 17 Feb 2021 12:50:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KzT/WUuZJN5lYVuceOGZ/1OjFXg=; b=JIjoG0
        43RFJazyA4+apQQ/j8Monq5ZbqR3IPhvorgHD1qfkSrbDtIZxeahje8YaKnkR//5
        pYbX7Doheijgt3eRSoqrDa02KZeVq9XiLS+iUIAFoKRZoaxPIZUBURFIOqnkhkTr
        Ozdek5KFB97iS15b5YUdVhfQ//ONxIO8K4RLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kQYhTrcz8rdQLb1VpNeylMdwURBzoyUG
        ohUAalXnlHuXQgO919i9SCNj1kLprUmg8n2pCckb57z0JPHYYWEQ+T40FBci257d
        jPJ/Nmw5WpauJcNEKIntVnT7c+CrSTE+JEZTBrk4/Qe2BiswfGeYduo+WlbINXyu
        90ZyPUawDeU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 96120121E6D;
        Wed, 17 Feb 2021 12:50:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E1781121E6A;
        Wed, 17 Feb 2021 12:50:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] stash show: teach --include-untracked and
 --only-untracked
References: <cover.1612855690.git.liu.denton@gmail.com>
        <cover.1613459474.git.liu.denton@gmail.com>
        <85b81f2f06bd1b40ee2de220cc84dd74b425daf3.1613459475.git.liu.denton@gmail.com>
        <xmqqczwzpxsz.fsf@gitster.c.googlers.com>
        <YCz7gOlXDTTd5urZ@generichostname>
Date:   Wed, 17 Feb 2021 09:50:31 -0800
In-Reply-To: <YCz7gOlXDTTd5urZ@generichostname> (Denton Liu's message of "Wed,
        17 Feb 2021 03:18:24 -0800")
Message-ID: <xmqq4kiamvmg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A24B74A6-7148-11EB-A3E1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Junio,
>
> On Tue, Feb 16, 2021 at 12:22:52PM -0800, Junio C Hamano wrote:
>>  builtin/stash.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git c/builtin/stash.c w/builtin/stash.c
>> index c788a3e236..7e0204bd8a 100644
>> --- c/builtin/stash.c
>> +++ w/builtin/stash.c
>> @@ -807,10 +807,11 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
>>  		init_tree_desc(&tree_desc[i], tree[i]->buffer, tree[i]->size);
>>  	}
>>  
>> +	/* mimic "git read-tree W U" without "-m" */
>>  	unpack_tree_opt.head_idx = -1;
>>  	unpack_tree_opt.src_index = &the_index;
>>  	unpack_tree_opt.dst_index = &the_index;
>> -	unpack_tree_opt.fn = twoway_merge;
>> +	unpack_tree_opt.fn = NULL;
>
> Perhaps it would be even more clear if we just removed this line
> entirely, otherwise it may give future readers a false impression that
> .fn is significant in any way.

Assignment of something concrete like "twoway_merge" to .fn when it
is a no-op was misleading, but between NULL or uninitialized, both
state clear that it is not used, so I am OK with either.

> Aside from that, both of your SQUASH??? commits look good to me. Thanks
> for tying up the loose ends.

We may want to write a custom unpack_trees() callback for this, and
use it here to catch "this third tree claims to be untracked, but
why does it have an entry that overlaps and/or D/F-conflicts with
the entry from the working tree side?" that you talked about in the
log message, but I think it is better to leave it for future [*], as
the feature should already be usable in its current shape.

Thanks.


[Footnote]

 * Yes, I didn't say "we can leave it", but said "it is better to
   leave it"; as long as we do not declare victory too early and end
   up shipping a half-baked unusable mess, I think it is better to
   wrap a topic early and plan to make it nicer in a future
   follow-up.

   To encourage such future refinements, however, you may add a
   NEEDSWORK comment in the code as a reminder for our future
   selves.
