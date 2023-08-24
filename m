Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B94EE49AD
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 20:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbjHXUze (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243593AbjHXUzL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 16:55:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE49D1993
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 13:55:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 429F22417C;
        Thu, 24 Aug 2023 16:55:09 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=Ad2bjH9uiJyr45Ow8nRPtmckC
        N5Il0G4IL6oemKB8Ws=; b=w81Ds/FyYt+3UUE+Bz8tV9t95zIkHRlSICR8xlO1d
        A7hIR6B2IoFIv1VMU9i3Fs1RWbU4Tc+Dqs7PvdetKlWIVMjVrjVQmqBtCUbTIEIk
        +D+d5cVow0GvD6DJomPeI0zRFO9nZJHo9t5d8Khg1XZLVisyHd9n68F5MSdqou0m
        Oo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3AE392417B;
        Thu, 24 Aug 2023 16:55:09 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BA9F02417A;
        Thu, 24 Aug 2023 16:55:05 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] rerere: modernize use of empty strbuf
Date:   Thu, 24 Aug 2023 13:54:56 -0700
Message-ID: <20230824205456.1231371-5-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-29-gcd9da15a85
In-Reply-To: <20230824205456.1231371-1-gitster@pobox.com>
References: <20230824205456.1231371-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 80D6F074-42C0-11EE-B79A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back when the code in the handle_conflict() helper function that
hashes the contents stored in the strbuf "one" and "two", including
its terminating NUL, was written, a freshly initialized strbuf had
NULL in its .buf member, so it was an error to say=20

    update(one.buf, one.len + 1)

which was corrected by b4833a2c (rerere: Fix use of an empty
strbuf.buf, 2007-09-26).

But soon after that, b315c5c0 (strbuf change: be sure ->buf is never
ever NULL., 2007-09-27) introduced strbuf_slopbuf mechanism that
ensures that .buf member of a strbuf is *never* NULL.  A freshly
initialized and empty strbuf uses a static piece of memory that has
NUL in it, with its .len member set to 0, so we can always safely
use from offset 0 of .buf[] array for (one.len + 1) bytes.

Simplify the code by essentially reverting the b4833a2c, whose fix
is no longer necessary in the modern world order.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/rerere.c b/rerere.c
index 6bc3c54d3b..69a61aac93 100644
--- a/rerere.c
+++ b/rerere.c
@@ -390,12 +390,8 @@ static int handle_conflict(struct strbuf *out, struc=
t rerere_io *io,
 			strbuf_addbuf(out, &two);
 			rerere_strbuf_putconflict(out, '>', marker_size);
 			if (ctx) {
-				the_hash_algo->update_fn(ctx, one.buf ?
-							 one.buf : "",
-							 one.len + 1);
-				the_hash_algo->update_fn(ctx, two.buf ?
-							 two.buf : "",
-							 two.len + 1);
+				the_hash_algo->update_fn(ctx, one.buf, one.len + 1);
+				the_hash_algo->update_fn(ctx, two.buf, two.len + 1);
 			}
 			break;
 		} else if (hunk =3D=3D RR_SIDE_1)
--=20
2.42.0-29-gcd9da15a85

