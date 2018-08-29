Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 609991F404
	for <e@80x24.org>; Wed, 29 Aug 2018 20:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeH3A5l (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 20:57:41 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:48068 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH3A5l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 20:57:41 -0400
Received: by mail-yw1-f73.google.com with SMTP id p8-v6so3142963ywl.14
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 13:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/rJ8A7SwSY/CbKyH1cYYfzeL+g0/ZWoCx88QvHQeZMs=;
        b=WkRatqRSkSGQ0E5RUXbdzRsBPCZKHKn3BXToY5tK6cQJB+1E713/+eYAeZ8NzLNIx1
         Ly3saIHtJjYqXSfwnVesETg4T1yMwOkotE1Ghpogzgcsr1Gov3oz9nt2uFWS419cdh1m
         v6JX4KkBssPZ8kXxp/6ACbSNECNCJ+pAE0hgdKuySOPj4DPeQ2SSeuC5k09jh+MWzpZF
         4lGphbAISj69ubZ1csZXqMyuIt0otjT6SCyJBJoPj5fVb/y2iwk5drcwvkb6D3+JoWOJ
         o0pMw8E6vss/uZ7xcAeyJaeMuwjb8G4TL2w9DmGODmJ+7DZVPakkdyTxM82Kc3NLizE+
         NHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/rJ8A7SwSY/CbKyH1cYYfzeL+g0/ZWoCx88QvHQeZMs=;
        b=Xsa0KzyZ5KJUFmbSC/vq2sNbJlF+DEA1hNad4IqOoOMoXzefrF18s5joT57zuuRdJ9
         vVFue5MPGTFRNI66sPicP77/BxH2fv2LuSsdcRrqnxS2d5RgVwUdR+7CHdYXSnxIVJ1f
         CtavFMR8WHCh2YP5rWm6vPXWEmXtSJ26+TiVzjUpkoDBHJX7vyF5MAiYz4wrG70e+VGT
         U1cwcczbo9hUTk/uOF2XQS801WWRRM4tuNV/Knu1mXvxqbv+ZDMLZmnQbTT2SpB191WF
         b9+pYcQiBdRNYTvJO6ZJoJbA5jqv2vAomuI9PJ8ARChjk+rFpUhw1VatZZebC6stGBjO
         M93A==
X-Gm-Message-State: APzg51BCkXZGFLROG6p8tuMz0lTTMfB73uFkIj98WZOqL3eGwVkhfPDM
        khbU5PY5iVevO72ZZW86jLTBhet/IFgIdo4GUIHaPmUdPZeqBPvRhmPgOKQOtCCOUj6K6sgeG81
        W/tIFz+03Ia+ldySoed3MtFy1RY8yreEVs4aRq5OMWsDiUsUkfYa6xIA=
X-Google-Smtp-Source: ANB0VdbNyg3loqJJet3c+DdMrNZXMo4vCrq4jPX06mOyxlceTf8NFaBCWeyae9HQJDFmqOOKVL4i/Gn6uw==
X-Received: by 2002:a81:7d83:: with SMTP id y125-v6mr2540877ywc.51.1535576341869;
 Wed, 29 Aug 2018 13:59:01 -0700 (PDT)
Date:   Wed, 29 Aug 2018 22:58:55 +0200
Message-Id: <20180829205857.77340-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 1/3] patch-delta: fix oob read
From:   Jann Horn <jannh@google.com>
To:     git@vger.kernel.org, jannh@google.com
Cc:     gitster@pobox.com,
        "=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?=" 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If `cmd` is in the range [0x01,0x7f] and `cmd > top-data`, the
`memcpy(out, data, cmd)` can copy out-of-bounds data from after `delta_buf`
into `dst_buf`.

This is not an exploitable bug because triggering the bug increments the
`data` pointer beyond `top`, causing the `data != top` sanity check after
the loop to trigger and discard the destination buffer - which means that
the result of the out-of-bounds read is never used for anything.

Also, directly jump into the error handler instead of just breaking out of
the loop - otherwise, data corruption would be silently ignored if the
delta buffer ends with a command and the destination buffer is already
full.

Signed-off-by: Jann Horn <jannh@google.com>
---
 patch-delta.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/patch-delta.c b/patch-delta.c
index 56e0a5ede..283fb4b75 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -51,13 +51,13 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 			if (unsigned_add_overflows(cp_off, cp_size) ||
 			    cp_off + cp_size > src_size ||
 			    cp_size > size)
-				break;
+				goto bad_length;
 			memcpy(out, (char *) src_buf + cp_off, cp_size);
 			out += cp_size;
 			size -= cp_size;
 		} else if (cmd) {
-			if (cmd > size)
-				break;
+			if (cmd > size || cmd > top - data)
+				goto bad_length;
 			memcpy(out, data, cmd);
 			out += cmd;
 			data += cmd;
@@ -75,6 +75,7 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 
 	/* sanity check */
 	if (data != top || size != 0) {
+		bad_length:
 		error("delta replay has gone wild");
 		bad:
 		free(dst_buf);
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

