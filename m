Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3953BC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12CA861159
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbhKJXn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbhKJXn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 18:43:26 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706B8C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 15:40:38 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id w12-20020ac80ecc000000b002a7a4cd22faso3351062qti.4
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 15:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kYwsQyfWh93yrOZ0Wev58wDmvJJ2JF4o53YSIU+sLm0=;
        b=YvlD+SR0ssBpjuxLPnVQ3DcW8P9xr61Y3EDODoP51IPgNfcmztLbtvyLsZFmRm6FLM
         ydZXuK4xMnNSlzlQHsA7V3NxizVI6Koy9AUk6Nt1/Y/M9bvAmxkyKDd02sZuZECvREGs
         CMf4ohNz0YDHMHDqFxRIrQqp++k0pDin3hw7A0ulG4+iRkkv+6LV+IZNxwPN0cwaFZeE
         J8POeqjBlwjos1J8aH0X8/idnmNv3G32n7aHhY0p6bKCV6qCS/QeX3N+hWGVNAxa2wq4
         HMI16tUQAOH7QejS/ZDbO8O9HKMeKP91wufPUKJBFsOiOpBTo8lSQ5dxRQwtsAmfrb6z
         fKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kYwsQyfWh93yrOZ0Wev58wDmvJJ2JF4o53YSIU+sLm0=;
        b=lDiZXUFlCFSRB7SLLrvGJMqCklPEipRqV39yeTwwhavNyyvoPKvF5+6N41Iina98fU
         ftwv9xzDUbOfoYkwQ4uS8s4cIcBrgf3Sra/GDX6A0K49Rj/sBnLW+K0z8YYHeGC1gnV0
         MJgkGAqwuWREFvHXijE6A4Ldtp1QcZXANNFPDTUq/HVwv3mUYbjKhbpJh/XSuaS9Enen
         dyr0JKy/eM0p0caeqgGyL20Ofj8PS0vy+JNmHNlCOBVWHECY12JiPZ1qj4Dj4b4qAcEP
         x+JuHGYJ+aj63+coXfIE2ybeKPMbQoet4nOgWK4k4J7FzNEeRHnbIAyqnCxFP3CMNv7n
         VZ7A==
X-Gm-Message-State: AOAM530QZp2HK9uadjmVsoVnyp72A70YE656jZj8YkiYNjEzcGv1o1Za
        KMIO9gmqqyQbCdydKKjDtf7eqXOSlW71LZ+0kHA+m0d7AEr1XYVHgLwtIJu/XcCW+lyyo95GMqA
        e4UhleTjqBwMBKUt0YNP9uuaEAhJ8indSBewq/guRjwSymCkJ5s+J0BbncWWadRyssJqrNf7FOj
        eP
X-Google-Smtp-Source: ABdhPJwg4JVkXZS4U3onM5nCtypND1kNGgTYW3Pus2W7O2cQ5+Ts6olGRwO4W/Fs/rXPbl3GFs0tSdcfgRfwqt4rgha2
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:622a:307:: with SMTP id
 q7mr3210454qtw.330.1636587637532; Wed, 10 Nov 2021 15:40:37 -0800 (PST)
Date:   Wed, 10 Nov 2021 15:40:33 -0800
Message-Id: <20211110234033.3144165-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH] packfile: avoid overflowing shift during decode
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unpack_object_header_buffer() attempts to protect against overflowing
left shifts, but the limit of the shift amount should not be the size of
the variable being shifted. It should be the size minus the size of its
contents. Fix that accordingly.

This was noticed at $DAYJOB by a fuzzer running internally.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
In next, d6a09e795d ("odb: guard against data loss checking out a huge
file", 2021-11-03) (merged as fe5160a170 ("Merge branch
'mc/clean-smudge-with-llp64' into next", 2021-11-03)) ameliorates this
situation by dying if the left shift overflows, but this patch is still
worthwhile as it makes a bad header be reported as a bad header, not a
fatal left shift overflow.
---
 packfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 89402cfc69..972c327e29 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1068,7 +1068,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	size = c & 15;
 	shift = 4;
 	while (c & 0x80) {
-		if (len <= used || bitsizeof(long) <= shift) {
+		if (len <= used || (bitsizeof(long) - 7) <= shift) {
 			error("bad object header");
 			size = used = 0;
 			break;
-- 
2.34.0.rc0.344.g81b53c2807-goog

