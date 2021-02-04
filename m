Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9F6C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 06:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F6C64E06
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 06:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhBDGpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 01:45:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51546 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhBDGpR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 01:45:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70B07A3A41;
        Thu,  4 Feb 2021 01:44:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JTDzC5iA8klyQJMmGiafaeUwwV4=; b=O2w+Mr
        7Evd9UUVgxMLKD8N9YR+x+n5Akxv8y0wj3EKAi4efWmDpRW5BLV6zVhnNRoX1VSe
        7owZ0XT0y3LlKJk0riS9XIiZB89mps7Z+4yRhMRwJStwsubQVOld49oLy8kNqZBg
        7FZwO5kkLI9GHor5+nDx+2btOKtJZSCGUPLHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UF6kM3nIeetZKTVr3f0sxdHzsFQ5ryxd
        1sMXfy1Yq/TryLnoACqEa8k7b/xhodYITeA3zI6h4voJP9L5OUFvxPvbLQntCLYR
        gGH4uxy0ElWIx+JFpdiioM6hXom4xNNfiguuSAGM201juNisvyMPgjCppaQmBQ/z
        Kz7pTBUqkZ0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 666B7A3A40;
        Thu,  4 Feb 2021 01:44:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E7164A3A3F;
        Thu,  4 Feb 2021 01:44:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 8/8] shortlog: allow multiple groups to be specified
References: <20200927083933.GA2222823@coredump.intra.peff.net>
        <20200927084015.GH2465761@coredump.intra.peff.net>
        <xmqqbleejhhq.fsf@gitster.c.googlers.com>
Date:   Wed, 03 Feb 2021 22:44:34 -0800
In-Reply-To: <xmqqbleejhhq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 28 Dec 2020 03:29:53 -0800")
Message-ID: <xmqqy2g48h7x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7185340E-66B4-11EB-ADD7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Now that shortlog supports reading from trailers, it can be useful to
>> combine counts from multiple trailers, or between trailers and authors.
>> This can be done manually by post-processing the output from multiple
>> runs, but it's non-trivial to make sure that each name/commit pair is
>> counted only once.
>>
>> This patch teaches shortlog to accept multiple --group options on the
>> command line, and pull data from all of them. That makes it possible to
>> run:
>>
>>   git shortlog -ns --group=author --group=trailer:co-authored-by
>>
>> to get a shortlog that counts authors and co-authors equally.
>
> As I recently had a chance to revisit an old thread back in v2.3.3
> days, I recalled that I wished something like this was available,
>
>   https://lore.kernel.org/git/xmqqd24g6uf1.fsf@gitster.dls.corp.google.com/
>
> where I wished to have a way to count non-author contributions
> easily to list them.
>
> I am not comfortable with the idea of changing the release
> announcement script immediately before the new release, so I'll do
> v2.30.0 with the old "authorship only" script, but I'll play with
> the new shortlog feature plus ideas from the old thread to see if we
> can give more credit to non author contributors.

But now it is a good time to do so, as it is not immediately before
a new release.

Here is what I am planning to use for the next release due in mid
March.  We list those who had contribution in the part of the
history before the last release and in the part of the history since
the last release, and run "comm" on these two sets to derive "new
folks" vs "continued supporters".  The list of contributors were
only counting the commit authors in the previous announcement, but
with the "shortlog --group" feature, we can give folks credit for
all kinds of *-by roles.

diff --git a/Announce b/Announce
index 491516b..d6ec20c 100755
--- a/Announce
+++ b/Announce
@@ -44,8 +44,22 @@ esac
 
 vername=$(echo "$vername" | tr "-" ".")
 
-git log --use-mailmap --format='%aN,' "$previous" | sort -u >"$tmpbase.prev"
-git log --use-mailmap --format='%aN,' "$previous..$commit" | sort -u >"$tmpbase.this"
+people () {
+	git shortlog -s --no-merges \
+		--group=author \
+		--group=trailer:co-authored-by \
+		--group=trailer:reviewed-by \
+		--group=trailer:mentored-by \
+		--group=trailer:helped-by \
+		--group=trailer:reported-by \
+		"$@" |
+	sed -e 's/^[ 	0-9]*[ 	]//' -e 's/$/,/' |
+	sort -u
+}
+
+people "$previous" >"$tmpbase.prev"
+people "$previous..$commit" >"$tmpbase.this"
+
 comm -12 "$tmpbase.prev" "$tmpbase.this" >"$tmpbase.old"
 comm -13 "$tmpbase.prev" "$tmpbase.this" >"$tmpbase.new"
 

