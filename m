Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71023CA0FE4
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 16:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbjIAQEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343563AbjIAQEX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 12:04:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504DD10EC
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 09:04:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8D3A2570D;
        Fri,  1 Sep 2023 12:04:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=vqAtdK9NIkaBZ1EaRX7HG4Xjhwtlc6o0iH4qNa
        AM7Hc=; b=td4MEbb1gG26so+qaT7mfZ63XDEP1o1wZYJF5GCQ+DjnsmvUew6Wut
        snagsAaE29hsCL1d4U54r8EkqTlS0bU4CZzqKLrW3NNFwJCpNrJhVE8Dvc5sZXoo
        NNnfJ8jRHUNMaf2e61j/6JgkE0s+d9k2wBbfZjxO30L4Wce+4E+B8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E12182570C;
        Fri,  1 Sep 2023 12:04:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D5882570B;
        Fri,  1 Sep 2023 12:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        git@vger.kernel.org
Subject: Re: Is there a way to get the "format-patch" formatted file name?
In-Reply-To: <xmqqwmx9ritx.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        01 Sep 2023 08:53:14 -0700")
References: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
        <xmqqo7inw2na.fsf@gitster.g>
        <24e10903-29a0-497a-c8d8-b26c02de7336@redhat.com>
        <ZPHEOYyyX+l3AGP1@ugly> <xmqqwmx9ritx.fsf@gitster.g>
Date:   Fri, 01 Sep 2023 09:04:15 -0700
Message-ID: <xmqqsf7xribk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 339E3C6E-48E1-11EE-AB9D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> We can just invent a new label (e.g. "Filesystem-safe-subject:"),
> pass the subject string to pretty.c:format_sanitized_subject() and
> emit the result next to the existing "Subject:" with that label, and
> we can even do so unconditionally without breaking anybody.

Such a change would be quite small and simple.

 mailinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git c/mailinfo.c w/mailinfo.c
index 931505363c..b0eb646f4e 100644
--- c/mailinfo.c
+++ w/mailinfo.c
@@ -5,6 +5,7 @@
 #include "utf8.h"
 #include "strbuf.h"
 #include "mailinfo.h"
+#include "pretty.h"
 
 static void cleanup_space(struct strbuf *sb)
 {
@@ -1166,11 +1167,16 @@ static void handle_info(struct mailinfo *mi)
 		}
 
 		if (!strcmp(header[i], "Subject")) {
+			struct strbuf san = STRBUF_INIT;
+
 			if (!mi->keep_subject) {
 				cleanup_subject(mi, hdr);
 				cleanup_space(hdr);
 			}
 			output_header_lines(mi->output, "Subject", hdr);
+			format_sanitized_subject(&san, hdr->buf, hdr->len);
+			output_header_lines(mi->output, "Filesystem-Safe-Subject", &san);
+			strbuf_release(&san);
 		} else if (!strcmp(header[i], "From")) {
 			cleanup_space(hdr);
 			handle_from(mi, hdr);
