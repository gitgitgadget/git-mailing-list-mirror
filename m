Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F297C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A5422D03
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgLOV0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:26:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53738 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729903AbgLOV0T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 16:26:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F13F9D644;
        Tue, 15 Dec 2020 16:25:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IXOZzs1Wb6d4LcZGbUI7QuTGA/k=; b=aie9qf
        b2eK2Gjr4HgMrtIsunn+OBoaw3flLrVC4gVO0cJHXrtGlfOfNbaF/0cA1r5wXIqR
        JB1fgveH19xz2uo4JBHOf/07B+fTT6NwPr5hizsXizZImBjF0/XBeheGXCLVJ4S8
        YhM+uWjGxqoYDb+uLP2KSYnINfPuMCOUCkFhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NL6V0FV8DycxDu0XOEOOxTIgRKVNfr95
        BW0xybLf4h+AyY27eOpg+PmmzluFl3hux0qpV2E+mgeRhioaScvkQSx+z774YPAN
        GmRJFf9mDsoLzJW+hJFp4b7ktwS7AIh/wRah3J0Aof62+AIHH+0eHSENTeRqMOXJ
        Hpl+ACZEj8Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F3779D643;
        Tue, 15 Dec 2020 16:25:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 182DD9D642;
        Tue, 15 Dec 2020 16:25:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] strmap: make callers of strmap_remove() to call it in void
 context
References: <035d01d6d26e$8c255260$a46ff720$@nexbridge.com>
        <xmqqeejraiw7.fsf@gitster.c.googlers.com>
        <X9glBJnlLMTW6Dns@coredump.intra.peff.net>
        <CABPp-BEnkQahdVJP+rfQho+S_hcS3y-o3cZBUMhU-EQHjJTLOQ@mail.gmail.com>
        <xmqqzh2e7p6l.fsf@gitster.c.googlers.com>
Date:   Tue, 15 Dec 2020 13:25:36 -0800
In-Reply-To: <xmqqzh2e7p6l.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 15 Dec 2020 13:08:18 -0800")
Message-ID: <xmqqtusm7odr.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12C03E2E-3F1C-11EB-8351-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two "static inline" functions, both of which return void, call
strmap_remove() and tries to return the value it returns as their
return value, which is just bogus, as strmap_remove() returns void
itself.  Call it in the void context and fall-thru the control to
the end instead.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 strmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/strmap.h b/strmap.h
index c4c104411b..1e152d832d 100644
--- a/strmap.h
+++ b/strmap.h
@@ -165,7 +165,7 @@ static inline int strintmap_contains(struct strintmap *map, const char *str)
 
 static inline void strintmap_remove(struct strintmap *map, const char *str)
 {
-	return strmap_remove(&map->map, str, 0);
+	strmap_remove(&map->map, str, 0);
 }
 
 static inline int strintmap_empty(struct strintmap *map)
@@ -249,7 +249,7 @@ static inline int strset_contains(struct strset *set, const char *str)
 
 static inline void strset_remove(struct strset *set, const char *str)
 {
-	return strmap_remove(&set->map, str, 0);
+	strmap_remove(&set->map, str, 0);
 }
 
 static inline int strset_empty(struct strset *set)
-- 
2.30.0-rc0-186-g20447144ec

