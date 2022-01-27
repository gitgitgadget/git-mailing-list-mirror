Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6F8C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 00:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiA0A5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 19:57:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51218 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiA0A5P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 19:57:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EEEE104905;
        Wed, 26 Jan 2022 19:57:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dCvLuerXrwwUu4FSwkEWoKzF3Yck79U4pJxI3g
        YapI8=; b=p+Opl59cX9RE+9xZcN5tJGI+saQzNz01Un8DrC4+InPahykvspVNuU
        ExqGmecFfab5fWsA/or0lncMoSaIPtEOyk0fpaiV4jaXSb5i11XphSGyFzvd4nSE
        GHgWkO1PY7rnt7Rdtsej7598LkUhA+uLL3IQ8n3IV6LwK9yPmGnTk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 173E7104904;
        Wed, 26 Jan 2022 19:57:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71CE9104903;
        Wed, 26 Jan 2022 19:57:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http API: fix dangling pointer issue noted by GCC 12.0
References: <patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com>
        <xmqqczkengsg.fsf@gitster.g>
Date:   Wed, 26 Jan 2022 16:57:12 -0800
In-Reply-To: <xmqqczkengsg.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        26 Jan 2022 16:50:07 -0800")
Message-ID: <xmqq8rv2nggn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10809C2C-7F0C-11EC-A1F6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am puzzled by this error.  The assignment is the only one that
> assigns a real pointer to the .finished member, and until
> finish_active_slot() is called on the slot, the loop would not
> leave.  I would understand the error if slot->finished is used after
> the function returns to the caller, but I do not think it is the
> case.

IOW, I am wondering if this is a mistaken compiler that needs to be
told not to raise a false warning.

If the motivation behind the original "do not get fooled by a reused
slot still working on somebody else's request---instead return when
our request is done" was indeed what I speculated, then the pointer
slot->finished when we leave this function should not matter to
anybody.  Would the following patch make the compiler realize that
we never smuggle a local variable's address out of this function via
a pointer in the structure?

 http.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git c/http.c w/http.c
index 229da4d148..85437b1980 100644
--- c/http.c
+++ w/http.c
@@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot *slot)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
+
+	if (slot->finished == &finished)
+		slot->finished = NULL;
 }
 
 static void release_active_slot(struct active_request_slot *slot)
