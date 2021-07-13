Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1565C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8773661289
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhGMVUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 17:20:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54442 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbhGMVUq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 17:20:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94D38C7196;
        Tue, 13 Jul 2021 17:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0xpw+BQ7d0z6VkdjKgHQkNQGrx12AQ/GrXMZmS
        QBjKg=; b=h6TDn7i8sdHhjZq1n6ko28IQCIOt9J8ZTXXVpxjd7vBkz51aApINKq
        w5yo1Ew90tXrtE3kE98dLweG4y/UaAiLmyo5AAU13dNP6P/oQWQ9EdQLVvfAjjVo
        sZp6ObEPrKEX2OLAiMp4o8yFUDannFYTE33gzVH9X8rFImzT/4mjE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C336C7194;
        Tue, 13 Jul 2021 17:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18FD5C7193;
        Tue, 13 Jul 2021 17:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] load_ref_decorations(): fix decoration with tags
References: <YOzY+qNFM2GsgKMO@coredump.intra.peff.net>
        <20210713074018.232372-1-martin.agren@gmail.com>
        <YO1GNWjMol8JV8MR@coredump.intra.peff.net>
Date:   Tue, 13 Jul 2021 14:17:53 -0700
In-Reply-To: <YO1GNWjMol8JV8MR@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 13 Jul 2021 03:52:21 -0400")
Message-ID: <xmqqpmvl29ry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C988A95E-E41F-11EB-ABD7-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> The reason this happens is in the loop where we try to peel the tags, we
>> won't necessarily have parsed that first object. If we haven't, its
>> `tag` will be NULL, so nothing will be displayed, and its `tagged` will
>> also be NULL, so we won't peel any further.
>
> Thanks, nicely explained.

Yup, nicely explained indeed.

>> Note how this commit could have been done as an optimization before
>> 88473c8bae: When our peeling hits a non-tag, we won't parse that tagged
>> object only to immediately end the loop.
>
> Yep, thanks for mentioning this, as it's somewhat subtle.

It is too subtle that I am not sure what the paragraph wants to say.

Before 88473c8b, we had a fully parsed object in obj and entered the
while() loop iff the outermost object is a tag, then we find the
underlying object via obj->tagged.  We parse that underlying object
to find if it is a tag, and break out if it is not.

By "this commit", I assume that the above mean the change in this
fix, i.e. parse 'obj' if it has not been parsed before looking at
its tagged field.  But I am not sure how that would have been an
optimization before 88473c8b that gave a parsed tag object 'obj'
upon entry to the loop.

Puzzled.

In any case, let's talk about this patch in the context to which it
is designed to be applied, i.e. post 88473c8b3c8b.

When we come here, we have done oid_object_info() plus
lookup_object_by_type() to obtain 'obj' and we know its type.
Then we enter the loop.

 	while (obj->type == OBJ_TAG) {
+		if (!obj->parsed)
+			parse_object(the_repository, &obj->oid);

And we parse if it hasn't been parsed.  THat is why we can ...

 		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			break;

... look at its tagged member.

-		if (!obj->parsed)
-			parse_object(the_repository, &obj->oid);
 		add_name_decoration(DECORATION_REF_TAG, refname, obj);

And the updated 'obj' (i.e. direct referent of the tag object) is
fed to add_name_decoration().  And then we move to the next
iteration.

Now, do we know what type of object 'obj' is at this point?  We
did parse the outermost tag upon entry to this loop, we replaced
'obj' variable with the referent by following the .tagged member,
but we haven't parsed that object or ran oid_object_info() on it.

Puzzled.

 	}
