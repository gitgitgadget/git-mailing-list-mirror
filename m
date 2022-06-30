Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF4C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiF3Xby (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiF3Xbx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:31:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B9F57216
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:31:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36B941A9C42;
        Thu, 30 Jun 2022 19:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r9+1QgcyBvoAHtizoqEJFUUqTljNEktWqKC68I
        WOIsU=; b=OVBlaeydMa3NM3r06XdqxMuDZbqYoEKPUQqZ3fD/K3F12S081CW8JN
        f087k2m+i/9zKW5waKOoybcZTF8FN/M7D4dozWjggW9BYUrhFN+VdvQV9g4asMIy
        f4DZFBA7xDTZz+/5BkWj3y45Yw53MM8kI9D2xrCrfYw3Wq8gO1wmg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 300521A9C41;
        Thu, 30 Jun 2022 19:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0E191A9C40;
        Thu, 30 Jun 2022 19:31:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/3] ident: rename commit_rewrite_person() to
 rewrite_ident_line()
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
        <20220630142444.651948-3-siddharthasthana31@gmail.com>
Date:   Thu, 30 Jun 2022 16:31:43 -0700
In-Reply-To: <20220630142444.651948-3-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Thu, 30 Jun 2022 19:54:43 +0530")
Message-ID: <xmqqa69tbue8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD8F4036-F8CC-11EC-946E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> We will be using commit_rewrite_person() in git-cat-file to rewrite
> ident line in commit/tag object buffers.
>
> Following are the reason for renaming commit_rewrite_person():
> - the function can be used not only on a commit buffer, but also on a
>   tag object buffer, so having "commit" in its name is misleading.
> - the function works on the ident line in the commit/tag object buffers,
>   just like "split_ident_line()". Since these functions are related they
>   should have similar terms for uniformity.

"ident" is good (so is "person" in the original).

"rewrite" is not quite good, as you do not convey what kind of
rewrite you are doing (it is not likely that you are upcasing their
names, but from "rewrite" you cannot tell that is the case).  We
should have "mailmap" somewhere in its name.

"line" is not good at all.  This function receives an entire buffer,
not just a single line that was located by the caller and rewrites
that line.  "buffer" might be an improvement over "line", but as I
alluded to in my review on [1/3], I think this function should limit
itself only to the header part of the commit/tag buffer, so "header"
would be the word you want in its name.

Once we say "mailmap", there is not much point in saying ident or
person (as "mailmap" is only about the ident/person).  So

  int apply_mailmap_to_header(struct strbuf *, struct string_list *mailmap)

or something?

> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: John Cai <johncai86@gmail.com>

I think these are the other way around.  With help from two people,
you wrote the patch and the final step before sending it out to the
list is your sign-off.  Chronologically, in the above, your sign-off
should come at the end.
