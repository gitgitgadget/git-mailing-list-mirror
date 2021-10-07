Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CE9C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148F260EBD
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhJGVjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:39:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63744 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhJGVjA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 17:39:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 738ED164429;
        Thu,  7 Oct 2021 17:37:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mikjrEGvdvt35F7z2CkcxUF3vEGTbPmNCG+9PN
        o97Ow=; b=Iw5a/CJJuHqZwXJb5t/qrAlR3Y3BFYR9HGsOLxL3X4l72WSbdyBwDZ
        DSN3lhV+hMeVb5yKUc+yRS0kLxeTLoqnEB/4YTZPJBRw4EwMjLfVwAowf7WMeG4w
        9Uyifd66QBw6xJa7qqst13aeXQmr9cl2GDISi6WSHyyGxyUtzVBC0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B218164428;
        Thu,  7 Oct 2021 17:37:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CB98B164427;
        Thu,  7 Oct 2021 17:37:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: ab/fsck-unexpected-type (and "cat-file replace handling and
 optimization")
References: <xmqqo884tkxd.fsf@gitster.g> <87bl43jit5.fsf@evledraar.gmail.com>
        <YVzLRSa9/vUWJPL0@coredump.intra.peff.net>
Date:   Thu, 07 Oct 2021 14:37:02 -0700
In-Reply-To: <YVzLRSa9/vUWJPL0@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 5 Oct 2021 18:01:41 -0400")
Message-ID: <xmqq8rz4pldt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6591AF0-27B6-11EC-8B76-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't mind rebasing on top if that's easier for Junio, but in that
> case it may make sense to float the test cleanup to the front of the
> series.

Yeah, I would rather not to see such a rebase (and I hate the kind
of churns we seem to be allowing more and more in our codebase that
causes needless textual conflicts.  We should really slow down and
make fewer pointless "clean-up" that disrupts real work).

> diff --cc t/t1006-cat-file.sh
> index a5e7401af8,4a753705ec..0000000000
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@@ -475,9 -332,18 +475,13 @@@ test_expect_success "Size of broken obj
>   	test_cmp expect actual
>   '
>   
> + test_expect_success 'clean up broken object' '
>  -	rm .git/objects/$(test_oid_to_path $bogus_sha1)
> ++	rm .git/objects/$(test_oid_to_path $bogus_short_sha1)
> + '
> + 
>  -bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
>  -bogus_content="bogus"
>  -bogus_size=$(strlen "$bogus_content")
>  -bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
>  -
>   test_expect_success "Type of broken object is correct when type is large" '
>  -	echo $bogus_type >expect &&
>  -	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
>  +	echo $bogus_long_type >expect &&
>  +	git cat-file -t --allow-unknown-type $bogus_long_sha1 >actual &&
>   	test_cmp expect actual
>   '

These look sensible, but ...


> - test_expect_success 'cat-file -t and -s on corrupt loose object' '
> - 	git init --bare corrupt-loose.git &&
> - 	(
> - 		cd corrupt-loose.git &&
> ...
> - 		test_must_fail git fsck 2>err.fsck &&
> - 		grep "^error: inflate: data stream error (" err.fsck
> - 	)

... what's this lossage of the whole new test?

> + test_expect_success 'clean up broken object' '
>  -	rm .git/objects/$(test_oid_to_path $bogus_sha1)
> ++	rm .git/objects/$(test_oid_to_path $bogus_long_sha1)
>   '

Again, this one makes sense.

Thanks.
