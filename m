Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40F7C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCEC560F92
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbhH3SKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:10:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59465 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbhH3SKH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 14:10:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37A0614DD3B;
        Mon, 30 Aug 2021 14:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wHtkUNs2dVk3Y7vbrerHa+nOPt7nz3qZJgEIL0
        MZ+wY=; b=sMzwkA1JpcczywsIqtx1vjRZa2lpF2ZTl80rLtkveZMwJsvfJJ7TnE
        2S87Pr6cfi3ak4FOj+GdepsKq/XDmXOAwNRVY/HbN03Op1UK/hx6ivo/HSbOtv0C
        uIDUQHunvARp75kPhjbw1zs1XrpJP8fkqUh5Ropgl1zR/u1TInbps=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FA2E14DD3A;
        Mon, 30 Aug 2021 14:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5CCFA14DD06;
        Mon, 30 Aug 2021 14:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <xmqqsfyq501v.fsf@gitster.g>
Date:   Mon, 30 Aug 2021 11:09:08 -0700
In-Reply-To: <xmqqsfyq501v.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        30 Aug 2021 10:12:28 -0700")
Message-ID: <xmqq7dg24xff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FE4F7FA-09BD-11EC-8858-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Since 19b2517f95a0 (diff-merges: move specific diff-index "-m" handling
>> to diff-index, 2021-05-21) git diff-index no longer accepts --cc. This
>> breaks gitk: it invokes
>>
>>    git diff-index --cached -p -C --cc --no-commit-id -U3 HEAD
>>
>> to show the staged changes (when the line "Local changes checked in to
>> index but not committed" is selected).
>>
>> The man page of git diff-index does not mention --cc as an option. I
>> haven't fully grokked the meaning of --cc, so I cannot tell whether this
>> absence has any significance (is deliberate or an omission).
>>
>> Is gitk wrong to add --cc unconditionally? Should it do so only when
>> there are conflicts? Or not at all?
>
> I think --cc is designed to naturally fall back to -p when there is
> only one parent.  Use of both -p and --cc has also long been an
> acceptable combination, and even if we say the later --cc overrides
> -p, there is no reason not to show single parent patch here with
> --cc.

Another tangent.

I think the use of --cc with diff-index can make sense in another
way.

    $ echo "# both" >>COPYING
    $ git add COPYING
    $ echo "# work" >>COPYING

Now we have one extra line at the end in both the index and the
working tree file, with yet another at the end of the latter.

    $ git diff-index --cc HEAD

is a way to show combined diff to go to the working tree version
starting from HEAD and starting from the index (I needed to use an
old version because the 'maint' and upwards are broken as reported).

    $ rungit v1.5.3 diff-index --cc HEAD
    diff --cc COPYING
    index 8b9c100,536e555..0000000
    --- a/COPYING
    +++ b/COPYING
    @@@ -358,4 -358,3 +358,5 @@@ proprietary programs.  If your program 
      consider it more useful to permit linking proprietary applications with the
      library.  If this is what you want to do, use the GNU Lesser General
      Public License instead of this License.
     +# both
    ++# work

Now the way "gitk" used is with "--cached", so there is no multi-way
comparisons to be combined, and it is natural to fall back to "-p",
so it is a different issue, but since we invented "--cc" to
originally emulate, and to later improve, the output from gitk,
I am reasonably sure that its use of "--cc" should be supported.
