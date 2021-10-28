Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2084C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 01:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9B16117A
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 01:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhJ1Bep (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 21:34:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53660 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhJ1Beo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 21:34:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D9B215C3A6;
        Wed, 27 Oct 2021 21:32:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3Jh8Mm4eQ6XJE97v7V0J2bBWU2Akfa/fb6xusW
        mqPmc=; b=igJCQmgwTPWTAN8LEYhI0mu7/T+640kEBHkOnnym3NtRxzDlamlQmy
        Svx9/piN4YilwPNV/d1mfpWcK6waYuzmuAKNA9hZSerXxioJ8HG2szxTf5TtPzJE
        7aQ93aChl2fnAStmCZZd3nWeRffhLntmsEIdgiFLL+rVlzbqM7c5E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 866D715C3A5;
        Wed, 27 Oct 2021 21:32:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EDC8815C3A1;
        Wed, 27 Oct 2021 21:32:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Peter Hunkeler <phunsoft@gmx.net>,
        Git Mailinglist <git@vger.kernel.org>
Subject: Re: Git not commiting anything if file created and "git add"ed in
 pre-commit hook is the only file in the staging area
References: <0165d68f-79a7-d8b7-1bba-89a1449e87a7@gmx.net>
        <YXnNvyi62j5gcxQV@camp.crustytoothpaste.net>
        <YXnVuhyPuFFfJ8zq@coredump.intra.peff.net>
Date:   Wed, 27 Oct 2021 18:32:13 -0700
In-Reply-To: <YXnVuhyPuFFfJ8zq@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 27 Oct 2021 18:42:02 -0400")
Message-ID: <xmqqy26erl2a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E181346E-378E-11EC-A131-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> The commit history does not explain why we must do this _after_ invoking
>> run_status, but if the comment is incorrect and we re-read it
>> immediately, then this problem would go away.  I lack the relevant
>> context to determine whether this is appropriate, but if folks think
>> this is advisable, then I can write up a patch this weekend.  It should
>> be relatively trivial.
>
> There's some related discussion of this area in:
>
>   https://lore.kernel.org/git/CADv3qkGq3jA8iXsjhrqfsUX=gW+KOuLyeVgDzmku1tUpsMdvtw@mail.gmail.com/
>
> I don't find it particularly enlightening as to the history, but it does
> point to other people wanting to re-read before run_status().

Ah, OK.  Because we call run_status() to see if there is anything
"committable" is there in the part of the changes that the user
prepared (before hooks futzed with the index), and reject if (for
example) there is nothing to commit, we deliberately refuse the case
where the invoker of "git commit" does *nothing* and the only change
between HEAD and the index to be committed after the hook runs is
what was done by the hook.  IOW, the current behaviour was designed
specifically to handle the case that started this thread.

Interesting.  I think the reasoning makes sense, and having to say
allow-empty, and being able to bypass by saying allow-empty, is a
feature from the point of view of that design.


