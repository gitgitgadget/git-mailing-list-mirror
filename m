Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A355C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 02:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBPC4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 21:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPC4R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 21:56:17 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC8846093
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 18:56:16 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r18so397869pgr.12
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 18:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXcnbsv40A1ooaP0dv/zQstk+YMoja0lTkkzGeVxLkM=;
        b=I4YRcCIcZqgF2EokySDsljib96qZKXHsylW7VeKYyKwWvyqpPLEuql15HR3iMOdzDJ
         3Ko1EK4Skru4d+ES5IML7stwCUnPNebo5Yry9CD3/hFit6qYb8pku1zxWZkCj9eVneQq
         8T6qKfzNmV6Mq8nsjUkNRqaZ+CV0JnMUhpM548aDG52s7gYfH2hBbkuZ4QS2NESUvMAE
         32kMNgXcQWhcFO2KGg4VdUcOoIOwnUd3djE3ZoWcXsdUyxdS508R5j/KB0eg3dKpJeO7
         jyZvDi5eu0aOI5O6QlKnIHVUfjqOD8z8hKi93oB45bwrrafz1TshJd1kVdLXxfpFZA8I
         8V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RXcnbsv40A1ooaP0dv/zQstk+YMoja0lTkkzGeVxLkM=;
        b=IctuGIfXdPrpQ230swaTBKNiegB1e6+ikJKLxnGhLaG9TPhuLl2kljArhV9//mMw4Q
         7fyW7VCdXDxEsYgISsI44zd9AiyHaw/imUjW+loDx/cZuLIIbumh1o901tn04SNEz4h5
         793hUqnWgTCv3pXICU3+nN32eFnXHi8cE8GBaVoawzTCdnZI/u6M442xoQ4kuBiHtYhe
         AztvT+g0bqPHvpFXKT1r3HsxWb6GMfQAGsVSdMUhRyL+rWMHgFTSEy+oVMZfVcGeK8WV
         L0xrPQNLbbPRzEFqk4nI9DW3cMxONIfrDElyWSdLdRxCnfDDlUo3JC9RWg1kz/d2mMEH
         i8lg==
X-Gm-Message-State: AO0yUKVFkHZMsz4NkD2MQ/5VuqHxZkttGOYXwBhGkaCY8PMSMIx0ObaW
        Zq5qUOF1OqVnCZLdNz0jJEr+xNp/6vI=
X-Google-Smtp-Source: AK7set8m6aPIJf8qcSFMx5YnLtPUfxGYJ0eJU6skOI86AYRt2h9e9qtJzsXU2Kt6tA9EKiqdhZnUUQ==
X-Received: by 2002:aa7:9f98:0:b0:5a8:9f71:315b with SMTP id z24-20020aa79f98000000b005a89f71315bmr3682208pfr.4.1676516175277;
        Wed, 15 Feb 2023 18:56:15 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id v17-20020aa78091000000b0058db8f8bce8sm54960pff.166.2023.02.15.18.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 18:56:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Cc:     rsbecker@nexbridge.com, Jeff King <peff@peff.net>
Subject: [PATCH] test-genzeros: avoid raw write(2)
References: <000001d94165$3d1cf2f0$b756d8d0$@nexbridge.com>
        <Y+0eIlsIxRr+1RYp@coredump.intra.peff.net>
        <000801d9416e$4bf844b0$e3e8ce10$@nexbridge.com>
        <xmqqwn4iycbt.fsf@gitster.g>
        <Y+05tTHdj2Jzenge@coredump.intra.peff.net>
        <xmqqwn4itmb1.fsf@gitster.g>
Date:   Wed, 15 Feb 2023 18:56:14 -0800
In-Reply-To: <xmqqwn4itmb1.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        15 Feb 2023 17:45:54 -0800")
Message-ID: <xmqqo7putj1t.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test helper feeds 256kB of data at once to a single invocation
of the write(2) system call, which may be too much for some
platforms.

Call our xwrite() wrapper that knows to honor MAX_IO_SIZE limit and
cope with short writes due to EINTR instead, and die a bit more
loudly by calling die_errno() when xwrite() indicates an error.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    Junio C Hamano <gitster@pobox.com> writes:

    > Jeff King <peff@peff.net> writes:
    >
    >> So yeah, this seems like an obvious good fix. Using write_or_die() might
    >> be even better, as it would report errors rather than quietly returning
    >> non-zero.
    >
    > Maybe.  Let me cook up a version with a proposed log message.

    I ended up avoiding write_or_die() primarily because there is
    nothing "Git" about this helper, which is a poor-man's emulation
    of "dd if=/dev/zero".  It felt a bit too much to pull cache.h in
    as dependency for it.

 t/helper/test-genzeros.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
index 8ca988d621..47af843b68 100644
--- a/t/helper/test-genzeros.c
+++ b/t/helper/test-genzeros.c
@@ -17,15 +17,16 @@ int cmd__genzeros(int argc, const char **argv)
 
 	/* Writing out individual NUL bytes is slow... */
 	while (count < 0)
-		if (write(1, zeros, ARRAY_SIZE(zeros)) < 0)
-			return -1;
+		if (xwrite(1, zeros, ARRAY_SIZE(zeros)) < 0)
+			die_errno("write error");
 
 	while (count > 0) {
-		n = write(1, zeros, count < ARRAY_SIZE(zeros) ?
-			  count : ARRAY_SIZE(zeros));
+		n = xwrite(1, zeros,
+			   count < ARRAY_SIZE(zeros)
+			   ? count : ARRAY_SIZE(zeros));
 
 		if (n < 0)
-			return -1;
+			die_errno("write error");
 
 		count -= n;
 	}
-- 
2.39.2-501-gd9d677b2d8

