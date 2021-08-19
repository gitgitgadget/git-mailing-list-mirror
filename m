Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554B3C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 21:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35AA0610A1
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 21:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhHSVKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 17:10:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56208 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhHSVKV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 17:10:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 760EAD1F75;
        Thu, 19 Aug 2021 17:09:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b/SMndacp3qLXC+d69UIUoa2oLxY2Q8eVnIxS1
        BaMDs=; b=KGbB9Kse4LJruYEl+PQmFPAqklhbkZwcxbe05lmf2RJDTuj1qufHfR
        Gc7PIZTNazA71rj06A0YWFt88twzHcY9gWlJb2l2uGzgEWKcmmukGeBEkqwGTDdV
        91DpJE8ufqbzEjCiQIUQRG7sYNDKFdJvvDgnC/Z5OXbPqdctWgBZc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E41BD1F74;
        Thu, 19 Aug 2021 17:09:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00228D1F73;
        Thu, 19 Aug 2021 17:09:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Williamson <awilliam@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: git format-patch produces invalid patch if the commit adds an
 empty file?
References: <02be6a48411fa100e7d1292fc312f7fcf571f334.camel@redhat.com>
Date:   Thu, 19 Aug 2021 14:09:43 -0700
In-Reply-To: <02be6a48411fa100e7d1292fc312f7fcf571f334.camel@redhat.com> (Adam
        Williamson's message of "Tue, 17 Aug 2021 11:50:42 -0700")
Message-ID: <xmqq5yw1ywdk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6B17592-0131-11EC-AB05-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Williamson <awilliam@redhat.com> writes:

> Hi folks! So I ran into an odd issue with git today. I'm kinda
> surprised I can't find any prior discussion of it, but oh well. The
> situation is this: I ran git format-patch on a commit that adds three
> empty files to a repository - this commit:
> https://github.com/mesonbuild/meson/commit/5c87167a34c6ed703444af180fffd8a45a7928ee
> the relevant lines from the patch file it produced look like this:
>
> ===
>
> diff --git a/test cases/common/56 array methods/a.txt b/test cases/common/56 array methods/a.txt
> new file mode 100644
> index 000000000..e69de29bb
> diff --git a/test cases/common/56 array methods/b.txt b/test cases/common/56 array methods/b.txt
> new file mode 100644
> index 000000000..e69de29bb
> diff --git a/test cases/common/56 array methods/c.txt b/test cases/common/56 array methods/c.txt
> new file mode 100644
> index 000000000..e69de29bb

I do not have very ancient build of Git handy, but I know Git as old
as v1.3.0 (which I consider is one of the two versions of historical
importance, the other being v1.5.3) behaved this way and we haven't
changed it ever since, so I am surprised too to learn that "GNU
patch" cannot grok it.  Even though you didn't mention it, am I
correct to assume that "patch" has a similar issue with a change
that removes an empty file?

I do not think our patch injestion machinery in "git apply" minds if
we added the "--- /dev/null" + "+++ b/<path>" headers (and the
reverse for removal of an empty file) to the current output, and I
am not fundamentally opposed to such a change.

But because it is such a rare event (and a discouraged practice) to
record a completely empty file, I wouldn't place a high priority on
doing so myself.

Thanks.
