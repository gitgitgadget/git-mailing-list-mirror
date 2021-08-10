Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D197C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 22:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7279F60EC0
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 22:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbhHJWM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 18:12:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60544 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhHJWM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 18:12:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3546413A9D8;
        Tue, 10 Aug 2021 18:12:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nbd3H7U1arVaIq3r0znIqofKL2+3HHej8fqlnE
        rFu/w=; b=KqDd8REBCc626+8eT655yUuBDwdqAEiFXjWixLwNEXJTk7HCqvn5Ad
        5hmRJm8BAg3WPrsHicsbRmps4Z/c8Kam2pLfDlyZqs7Q4TMKD3ZGV4ElpyUrVBgx
        m1kFsB/tgtKCDI9q19lhjIyPor6ZHsv/16bT2MYeJ7Rii72ar4Tik=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E60213A9D6;
        Tue, 10 Aug 2021 18:12:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 77B5B13A9D4;
        Tue, 10 Aug 2021 18:12:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Tassilo Horn <tsdh@gnu.org>, git@vger.kernel.org
Subject: Re* [PATCH v4] userdiff: improve java hunk header regex
References: <20210810190937.305765-1-tsdh@gnu.org>
        <d3484278-8413-0d10-e6cd-59a7ff04564b@kdbg.org>
Date:   Tue, 10 Aug 2021 15:12:01 -0700
In-Reply-To: <d3484278-8413-0d10-e6cd-59a7ff04564b@kdbg.org> (Johannes Sixt's
        message of "Tue, 10 Aug 2021 22:57:47 +0200")
Message-ID: <xmqq35rhc5la.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDE25E7A-FA27-11EB-BA86-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> I don't see the point in this complicated regex. Please recall that it
> will be applied only to syntactically correct Java text. Therefore, you
> do not have to implement all syntactical corner cases, just be
> sufficiently permissive.

Good suggestion.  We may want to mention the above principle as a
comment near the top of the patterns array.

> What is wrong with
>
> 	"^[ \t]*(([A-Za-z_][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[
> \t]*\\([^;]*)$",
>
> i.e. take every "token" until an identifier followed by an opening
> parenthesis is found. Can types in Java contain parentheses? That would
> make my suggested simplified regex too permissive, but otherwise it
> would do its job, I would think.

Thanks.

---- >8 -------- >8 -------- >8 -------- >8 -------- >8 --------
Subject: userdiff: comment on the builtin patterns

Remind developers that they do not need to go overboard to implement
patterns to prepare for invalid constructs.  They only have to be
sufficiently permissive, assuming that the payload is syntactically
correct.

Text stolen mostly from Johannes Sixt.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 userdiff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git c/userdiff.c w/userdiff.c
index d9b2ba752f..1a6d27fda6 100644
--- c/userdiff.c
+++ w/userdiff.c
@@ -13,6 +13,16 @@ static int drivers_alloc;
 #define IPATTERN(name, pattern, word_regex)			\
 	{ name, NULL, -1, { pattern, REG_EXTENDED | REG_ICASE }, \
 	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
+
+/*
+ * Built-in drivers for various languages, sorted by their names
+ * (except that the "default" is left at the end).
+ *
+ * When writing or updating patterns, assume that the contents these
+ * patterns are applied to are syntactically correct.  You do not have
+ * to implement all syntactical corner cases---the patterns have to be
+ * sufficiently permissive.
+ */
 static struct userdiff_driver builtin_drivers[] = {
 IPATTERN("ada",
 	 "!^(.*[ \t])?(is[ \t]+new|renames|is[ \t]+separate)([ \t].*)?$\n"
