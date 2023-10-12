Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1A5CDB47E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 16:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379509AbjJLQ6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 12:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344025AbjJLQ6X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 12:58:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CA390
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 09:58:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D007A19D321;
        Thu, 12 Oct 2023 12:58:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S7ueUNGlwAUI
        abZq0UYCUbP75s1LmvjD86p49tR82r4=; b=FvUN4FtqY7JyRCSxN3hRe4iO4XxB
        S8J5Rj1yakqYDLJmoMiREAkkt/T1M0HOBScIrQqnI6kNzje+WiI+6bILWNXXPGYC
        LACw+M+CrSxMCx6BQKYU1PlTtxFbV9v2LIcDQsQhXLiaqu6P1jB6W2CcmQ9dKDz4
        TuiBZxe5C14skAQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7A1419D320;
        Thu, 12 Oct 2023 12:58:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FC7C19D31D;
        Thu, 12 Oct 2023 12:58:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Thiel <sebastian.thiel@icloud.com>
Cc:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
In-Reply-To: <0E44CB2C-57F2-4075-95BE-60FBFDD3CEE2@icloud.com> (Sebastian
        Thiel's message of "Thu, 12 Oct 2023 12:55:19 +0200")
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
        <xmqqttqytnqb.fsf@gitster.g>
        <0E44CB2C-57F2-4075-95BE-60FBFDD3CEE2@icloud.com>
Date:   Thu, 12 Oct 2023 09:58:19 -0700
Message-ID: <xmqqttqvg4lw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8BE6F294-6920-11EE-89BD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Thiel <sebastian.thiel@icloud.com> writes:

> ### What about a `$` syntax in `.gitignore` files?
>
> I looked into adding a new prefix, `$` to indicate the following path i=
s
> precious or=E2=80=A6 valuable. It can be escaped with `\$` just like `\=
!`.=20

I have been regretting that I did not make the quoting syntax not
obviously extensible in f87f9497 (git-ls-files: --exclude mechanism
updates., 2005-07-24), which technically was a breaking change (as a
relative pathname that began with '!' were not special, but after
the change, it became necessary to '\'-quote it).  A relative
pathname that begins with '$' would be now broken the same way, but
hopefully the fallout would be minor.  I presume you picked '$'
exactly because of this reason?

I do not think it will be the end of the world if we don't do so,
but it would be really really nice if we at least explored a way (or
two) to make a big enough hole in the syntax to not just add
"precious", but leave room to later add other traits, without having
to worry about breaking the backward compatibility again.  A
simplest and suboptimal way may be to declare that a path that
begins with '$' now needs '\'-quoting (just like your proposal),
reserve '$$' as the precious prefix, and '$' followed by any other
byte reserved for future use, but there may be better ideas.

> *Unfortunately*, users can't just add a local `.git/info/exclude` file =
with
> `$.config` in it and expect `.config` to be considered precious as the =
pattern
> search order will search this last as it's part of the exclude-globals.

That it nothing new and is the same for ignored files.  The lower
precedence files do not override higher precedence files.

> Thus, to make this work, projects that ship the `.gitignore` files woul=
d *have
> to add patterns* that make certain files precious.

Not really.  They do not have to do anything if they are content
with the current Git ecosystem.  And users who have precious stuff
can mark them in the.git/info/excludes no?  The only case that is
problematic is when the project says 'foo' is ignored and expendable
but the user thinks otherwise.  So to make this work, projects that
ship the ".gitignore" files have to avoid adding patterns to ignore
things that it may reasonably be expected for its users to mark
precious.

> Such opted-in projects would produce `.gitignore` files like these:
>
>     .*
>     $.config

I would understand if you ignored "*~" or "*.o", but why ignore ".*"?

THanks.
