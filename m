Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CD8C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 18:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244224AbiAZSqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 13:46:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59959 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244178AbiAZSqU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 13:46:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C0FC169F06;
        Wed, 26 Jan 2022 13:46:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DVhorwNdtsl2uDLOFbFXMitJ2JADpYFCJ8Dfec
        3tVww=; b=pdM0rQpYNDY7tV4GkgWGB2KguLvVv2t4/a/bk2kZFYPJvM2dki8HsZ
        S4A2FEurQ2vr6ryEe5EkCQdJmQrgOxFSiYCjCPIq7NMQTvJbVaNLXBoQK8Y19Cbj
        nigeUoJHmb2zpPP38If/VY8dQyDr35+0kFbJ7rCmtaoenlzMGu59U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94168169F05;
        Wed, 26 Jan 2022 13:46:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E971169F04;
        Wed, 26 Jan 2022 13:46:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Michael Herrmann <michael@herrmann.io>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: A puzzle: reset --hard and hard links
References: <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net>
        <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
        <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com>
        <xmqqk0ep57ou.fsf@gitster.g>
        <CABrKpmB7UEGzLCiNHQtY5-Dt16jLkpcpBEx3o8y9OBGZ418keA@mail.gmail.com>
        <xmqqfspc3k8k.fsf@gitster.g>
        <CABrKpmDjrTPhL_55YaXEAVTEmu8iZEsKUJYab7OgK0=w9d_7MA@mail.gmail.com>
        <220125.865yq8ghae.gmgdl@evledraar.gmail.com>
        <87pmog2bbf.fsf@igel.home>
        <CABrKpmAcNsexcmHK5kZvZr_NBm7TWWU=wVQExHwWSPpprptdQw@mail.gmail.com>
        <YfCue6m4gqGEWqDj@camp.crustytoothpaste.net>
Date:   Wed, 26 Jan 2022 10:46:15 -0800
In-Reply-To: <YfCue6m4gqGEWqDj@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Wed, 26 Jan 2022 02:14:19 +0000")
Message-ID: <xmqqsftas5c8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EA65C7E-7ED8-11EC-B412-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Thanks, this is helpful context and it explains why you'd want this
> behavior.  If you're involved with the project, it may be helpful to
> point out to other project members that this occurs and suggest that the
> scripts avoid running "git reset --hard".  For example, it may be easy
> to avoid if "git status --porcelain" produces empty output.  I've heard
> stories about Chromium's build times and I'm sure such an optimization
> would be welcome.

I am not sure about that.  If the ONLY problem is that hardlinks to
UNMODIFIED paths are severed by "reset --hard" when it is not necessary
in order to ensure that HEAD and the working tree matches in content
without clobbering anything unrelated, then adding an internal call
to refresh before "git reset --hard" would neatly solve it, and
there should not be a need for end-user workaround like that.

But it does not change the fact that we try to avoid clobbering
anything unrelated to the path we are updating when we need to
update the contents of the working tree files, and the way we do so
is to call checkout_entry(), which does unlink() followed by
creat().  So even though you may be able to teach "git reset --hard"
to refrain from severing extra hardlinks when it does not have to,
it will do so when the contents of the path must be changed.

To be quite honest, I am not sure if the patch below is safe either.
I doubt that the lack of "update-index --refresh" in the "reset
--hard" command was a mistake; rather, I suspect that it was
deliberately omitted to avoid some problems, which I do not offhand
recall.

 builtin/reset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git c/builtin/reset.c w/builtin/reset.c
index b97745ee94..8adc1be75b 100644
--- c/builtin/reset.c
+++ w/builtin/reset.c
@@ -83,6 +83,7 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 	}
 
 	read_cache_unmerged();
+	refresh_cache(REFRESH_QUIET);
 
 	if (reset_type == KEEP) {
 		struct object_id head_oid;
