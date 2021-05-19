Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC8C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6C76112F
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhESBKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 21:10:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52883 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhESBKR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 21:10:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87D4013DE6C;
        Tue, 18 May 2021 21:08:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=frxR3y1ksF8h3NXwQbLrZFqFmMOFE0/FcoNwxA
        ku2+I=; b=SMq8dJ0J09scN8VvYnTxYKOR8fsgnXTvbsR/0Pz6jYrS5YH27K3wtt
        Ia6kDgszq4LfpT6NthswpbBLE/MiPm0Br+UnwWfTqhglqlSsdvU2RzQySQ64+sPH
        hDGSogvz25Wz+kQfWXumHUPGUI7jWjuIy+KSKXc56Tdv2Zf3+LY/o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8017013DE6B;
        Tue, 18 May 2021 21:08:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C960A13DE6A;
        Tue, 18 May 2021 21:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] help: colorize man pages
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
        <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
        <60a332fd22dad_14c8d4208ed@natae.notmuch>
        <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
Date:   Wed, 19 May 2021 10:08:54 +0900
In-Reply-To: <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Tue, 18 May 2021 23:49:40 +0000")
Message-ID: <xmqqfsyj1qe1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8A0EEDC-B83E-11EB-A9E8-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> In general, this is made worse because Git doesn't honor the unofficial
> but widely supported NO_COLOR[0], so reading the documentation is
> obligatory.

I vaguely recall that we were contacted by NO_COLOR folks to be
an early supporter of their cause to break the chicken-and-egg
problem they were hagving, and (unhelpfully) answered with "sure,
when we see enough people support it---otherwise we'd end up having
to keep essentially a dead code that supports a convention that is
not all that useful".

> [0] https://no-color.org/

I wonderr if it is just a matter of hooking into want_color(), like this?

 color.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git c/color.c w/color.c
index 64f52a4f93..2516ef7275 100644
--- c/color.c
+++ w/color.c
@@ -373,12 +373,17 @@ int want_color_fd(int fd, int var)
 	 * we always write the same value, but it's still wrong. This function
 	 * is listed in .tsan-suppressions for the time being.
 	 */
-
+	static int no_color = -1;
 	static int want_auto[3] = { -1, -1, -1 };
 
 	if (fd < 1 || fd >= ARRAY_SIZE(want_auto))
 		BUG("file descriptor out of range: %d", fd);
 
+	if (no_color < 0)
+		no_color = !!getenv("NO_COLOR");
+	if (no_color)
+		return 0;
+
 	if (var < 0)
 		var = git_use_color_default;
 
