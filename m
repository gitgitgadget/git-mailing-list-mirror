Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D085C433EF
	for <git@archiver.kernel.org>; Sun, 29 May 2022 18:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiE2Sm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 May 2022 14:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiE2Sm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 May 2022 14:42:57 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D73213E04
        for <git@vger.kernel.org>; Sun, 29 May 2022 11:42:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5423213CBC2;
        Sun, 29 May 2022 14:42:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0z6tzI0Clbrn0YJ8VP+Ky5VMUpzWKp1L4wLpUf
        ggdXg=; b=tGbRU5+4vduxactCbLnEA/SeyFKyXnhTqcRWO8jq5rQpnS/8LKXu9U
        LwvEpZe07wZeotITGMIO9Ko/T12TRvhx8cvvmt2gzLaJJaKjZM4+CMTuTVNljQZl
        6xJIC5QylPxosKtOAYDAPmW1rfDPKaz/RidnEKWCrX2L79k6ckU8E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D0DE13CBC1;
        Sun, 29 May 2022 14:42:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B848213CBC0;
        Sun, 29 May 2022 14:42:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Excluding paths with wildcard not working with add -p
References: <CAHd499D81VN=aGsM6kaNLF2ZMg-Zg10U=qU-j7gQ7uXnqqfdqg@mail.gmail.com>
        <xmqqh758yz4u.fsf@gitster.g>
Date:   Sun, 29 May 2022 11:42:53 -0700
In-Reply-To: <xmqqh758yz4u.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        29 May 2022 11:25:37 -0700")
Message-ID: <xmqq8rqkyyc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26E01AFA-DF7F-11EC-AB47-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Does this command
>
>     git add -p -- . ':^*.cs'
>
> work as you expect?

We used to error out when you give a pathspec with only negative
elements in it, like the one you gave above.  Later, we tweaked this
logic at 859b7f1d (pathspec: don't error out on all-exclusionary
pathspec patterns, 2017-02-07) so that we add an empty string as an
extra element when your pathspec has only negative elements.

At around the same time, we were migrating from "an empty string is
a valid pathspec element that matches everything" to "either a dot
or ":/" is used for that purpose, and an empty string is rejected",
between d426430e (pathspec: warn on empty strings as pathspec,
2016-06-22) and 9e4e8a64 (pathspec: die on empty strings as
pathspec, 2017-06-06).  I think 9e4e8a64 was not careful enough to
turn the empty string 859b7f1d added to either a dot or ":/"

For the purpose of "add -p", I _think_ adding a "dot" is correct,
but depending on the command, the code needs to add ":/".

Here is a quick trial patch, which seems to compile and pass all the
tests we have, but the fact that this lingered with us for the past
5 years is a strong sign that we lack coverage in this area, so it
may be breaking something else in a big way.

 pathspec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git c/pathspec.c w/pathspec.c
index ddeeba7911..1b0ae51aa4 100644
--- c/pathspec.c
+++ w/pathspec.c
@@ -628,8 +628,10 @@ void parse_pathspec(struct pathspec *pathspec,
 	 * that matches everything. We allocated an extra one for this.
 	 */
 	if (nr_exclude == n) {
-		int plen = (!(flags & PATHSPEC_PREFER_CWD)) ? 0 : prefixlen;
-		init_pathspec_item(item + n, 0, prefix, plen, "");
+		if (!(flags & PATHSPEC_PREFER_CWD))
+			init_pathspec_item(item + n, 0, NULL, 0, ":/");
+		else
+			init_pathspec_item(item + n, 0, prefix, prefixlen, ".");
 		pathspec->nr++;
 	}
 
