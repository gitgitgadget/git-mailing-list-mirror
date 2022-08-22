Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F50C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 04:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiHVEHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 00:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHVEG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 00:06:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CDC22539
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 21:06:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED4CB1B5B42;
        Mon, 22 Aug 2022 00:06:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3AMl4VcW1v6r
        lTk3CEWha4Jh//11OTJbd2ip3lY9mI4=; b=kq9dVAoE34vwXp2PiLixbV+AzNsD
        6bIUFgn3XFTAQHk/duoEItO06h55FqBf2JxkI+LmegtMCjVBvpP5hpxPfv61jgYY
        kyk/UUbfztvhOUv8gJm1ShxO1iK1U9U0reB1NHnXOVJRAoXtzzDfKVutrvETWNpo
        HeWxETpup6YclgY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3D721B5B41;
        Mon, 22 Aug 2022 00:06:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8EE7A1B5B3D;
        Mon, 22 Aug 2022 00:06:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, meta@public-inbox.org
Subject: Re: `git patch-id --stable' vs quoted-printable
References: <20220822022503.M873583@dcvr>
Date:   Sun, 21 Aug 2022 21:06:52 -0700
In-Reply-To: <20220822022503.M873583@dcvr> (Eric Wong's message of "Mon, 22
        Aug 2022 02:25:03 +0000")
Message-ID: <xmqqczcsgbvn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DB16FA4C-21CF-11ED-B682-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> While poking around at the newish patchid indexing support in
> public-inbox[1], I noticed an inconsistency in how it seems to
> mishandle quoted-printable messages.
> ...
> So, I'm wondering if the search indexing code of public-inbox
> should s/^$/ /mgs before feeding stuff to `git patch-id'; and/or
> if `git patch-id' should be assuming empty lines and lines with a
> single SP are the same...

I suspect that QP is a red herring.  I haven't looked at relevant
code at all for a while, but what I think is going on is:

 * patch-id algorithm was written back when "unified" format of
   "diff" did not have the extension of GNU origin to allow an empty
   context line to be expressed as a truely empty line, not a single
   whitespace that signals it is a context line, followed by the
   contents of the line that is empty

 * "git apply" hence "git am" was taught to grok the empty context
   line extention, https://pubs.opengroup.org/onlinepubs/9699919799/utili=
ties/diff.html
   has this:

      It is implementation-defined whether an empty unaffected line is
      written as an empty line or a line containing a single <space> char=
acter.

   IIRC, this was added after GNU diff started emitting such an
   output (--suppress-blank-empty) and people complained that such a
   patch is not understood by us.

 * "git diff" was updated to allow this with diff.suppressBlankEmpty
   configuration , but that is never turned on by default.

So, if a patch producer runs "git diff" with diff.suppressBlankEmpty
turned on, "git am" accepts it, and then you run "git show" without
the configuration, then the "shape" of the patch text would be
slightly different.  I do not offhand know if we added configuration
support to "patch-id", but even with a configuration knob, because
once you turn incoming e-mail into a commit, the single bit (i.e.
whether suppressBlankEmpty was in use or not) is forever lost, it
would not be of much help.  After all, the incoming patch can be
hand munged to use both "single whitespace and the end of line" and
"a completely empty line" to record an empty context line, and "am"
has to take such a patch happily.

I *think* the right thing to do is for patch-id that takes text
input to normalize the empty context line into one form or the other
(as a conservatist, I would say we should probably pretend as if an
empty context line is always expressed as a single whitespace on a
line by itself) before computing the ID.

Ren=C3=A9, do you remember if you used diff.suppressBlankEmpty
configuration when generating the patch in question at:

    https://public-inbox.org/git/6727daf1-f077-7319-187e-ab4e55de3b2d@web=
.de/raw

by the way?

Thanks.
