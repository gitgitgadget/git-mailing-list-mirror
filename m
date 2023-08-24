Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3809EE49AB
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 20:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243626AbjHXUze (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243606AbjHXUzI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 16:55:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4709A1993
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 13:55:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D152031529;
        Thu, 24 Aug 2023 16:55:05 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=yCruabo+UPctXf4ahL2oJ5XQX
        eQxw8aF3LVd7MXaA4g=; b=CgEeZ7rgCbmbxriBu9dXWrL2z2hKRxUKnhLUtMjAe
        kv/y8uT/UvJtkeGMekRfjCzuW3wbzTawnRQbDm+kaN39iBlv9FFgU+KhsF7jrA7A
        24A5wfgxCnLXJGh26pvW38ilVBRMpM8mZQJqoi/Zb5/0jYYD3RiSmNjR0pwTeDtH
        As=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C94CB31528;
        Thu, 24 Aug 2023 16:55:05 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3DA8C31526;
        Thu, 24 Aug 2023 16:55:02 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] rerere: try_merge() should use LL_MERGE_ERROR when it means an error
Date:   Thu, 24 Aug 2023 13:54:55 -0700
Message-ID: <20230824205456.1231371-4-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-29-gcd9da15a85
In-Reply-To: <20230824205456.1231371-1-gitster@pobox.com>
References: <20230824205456.1231371-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 7EBF9C14-42C0-11EE-BB53-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the preimage or the postimage files cannot be read, the
try_merge() helper function returns LL_MERGE_CONFLICT.  To all of
its callers, this does not make them do wrong things per-se, as they
are only checking if the result is 0 and LL_MERGE_CONFLICT is not 0.

But it is an error if we fail to read the input we expect to be able
to read; return LL_MERGE_ERROR instead.  This does not change any
behaviour---it just makes the code use the "correct" constant to
signal an error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index 4ce1270a94..6bc3c54d3b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -617,7 +617,7 @@ static int try_merge(struct index_state *istate,
=20
 	if (read_mmfile(&base, rerere_path(id, "preimage")) ||
 	    read_mmfile(&other, rerere_path(id, "postimage"))) {
-		ret =3D LL_MERGE_CONFLICT;
+		ret =3D LL_MERGE_ERROR;
 	} else {
 		/*
 		 * A three-way merge. Note that this honors user-customizable
--=20
2.42.0-29-gcd9da15a85

