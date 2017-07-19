Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C72520288
	for <e@80x24.org>; Wed, 19 Jul 2017 17:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755326AbdGSRNA (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 13:13:00 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33361 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753840AbdGSRM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 13:12:59 -0400
Received: by mail-pg0-f54.google.com with SMTP id k14so2996100pgr.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=54xdhynvPj9Hp5LdggROQPoC9+CccXnZ6w2cz2ySKXE=;
        b=fLvekMJydWaUYzW9HRarb9c2uJV5qAcSU/Ddy3P6CjsI0Svi0yNIYsDmp0kTVI2Dly
         m5DLo/gOEMT6tgNYDCoF0F6cJxm2Pu/3irDsQG008VlGmo9ySXtvy1eFBGrEFLiScglu
         4l4GG3vFtoSRxR76E7OckmkbGm8la1PrKpqbHMUAjNwp0jnWvGNQqo37ua8xqc83zlnR
         YXs6n+s/A1rP0Hr9HbE3pEujig9in2W9shG1BkZdHXmXlvx+gOUJlPpmDkYFznQPJHNq
         pOpkNx7GrEy50nedxdBf7ghLfegseBD9vGgHjprkrWTYIRvD4EevrEOzlsazF9r/YFmy
         wFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=54xdhynvPj9Hp5LdggROQPoC9+CccXnZ6w2cz2ySKXE=;
        b=UOIxoNjUe5V47qVtwZjPqRJhTPCkq4L1DDl55gI+I1BcxG8KPZo82hHaZMwB0ZATC8
         LUhAqpgKVBtEdzs+C/Cziv80iunKTmjblngxCsLW1kJYMlUQye2MO0A6VuXsOEZ87w4V
         zCQQ7liOrXKrZ9Z+u4n3V3tAT9TsqUpnBi4IA4XWoHZxqWCM/36iFWkPQXGxKn2ml2xG
         cFBZA+c0uSDN2eixGCarlMcCdqyIKMlZ3iu1Tu5fV+wmZ5j/FsavsyY4FZ7AM283EwXU
         SSu6K+0whc4QS9UPWaZUXhcAEdxYV0de63TZ5n9dOqO+U+rC9Qrr5duaRb62mrCULOsJ
         nNZw==
X-Gm-Message-State: AIVw110TwEW3fgtHnd5bnGxBhcyxfUNDjeZWz5/X50QF3DnqQDhEOwgo
        C4yBITSTxsb1x1XFYnJVPQ==
X-Received: by 10.98.7.87 with SMTP id b84mr848350pfd.216.1500484378667;
        Wed, 19 Jul 2017 10:12:58 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id s17sm778198pfg.166.2017.07.19.10.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Jul 2017 10:12:57 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Johannes.Schindelin@gmx.de
Subject: [PATCH] sha1_file: use access(), not lstat(), if possible
Date:   Wed, 19 Jul 2017 10:12:51 -0700
Message-Id: <20170719171251.11906-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.284.gd933b75aa4-goog
In-Reply-To: <alpine.DEB.2.21.1.1707191450570.4193@virtualbox>
References: <alpine.DEB.2.21.1.1707191450570.4193@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In sha1_loose_object_info(), use access() (indirectly invoked through
has_loose_object()) instead of lstat() if we do not need the on-disk
size, as it should be faster on Windows [1].

[1] https://public-inbox.org/git/alpine.DEB.2.21.1.1707191450570.4193@virtualbox/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks for the information - here's a patch. Do you, by any chance, know
of a web page (or similar thing) that I can cite for this?
---
 sha1_file.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index fca165f13..81962b019 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2920,20 +2920,19 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 
 	/*
 	 * If we don't care about type or size, then we don't
-	 * need to look inside the object at all. Note that we
-	 * do not optimize out the stat call, even if the
-	 * caller doesn't care about the disk-size, since our
-	 * return value implicitly indicates whether the
-	 * object even exists.
+	 * need to look inside the object at all. We only check
+	 * for its existence.
 	 */
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
-		const char *path;
-		struct stat st;
-		if (stat_sha1_file(sha1, &st, &path) < 0)
-			return -1;
-		if (oi->disk_sizep)
+		if (oi->disk_sizep) {
+			const char *path;
+			struct stat st;
+			if (stat_sha1_file(sha1, &st, &path) < 0)
+				return -1;
 			*oi->disk_sizep = st.st_size;
-		return 0;
+			return 0;
+		}
+		return has_loose_object(sha1) ? 0 : -1;
 	}
 
 	map = map_sha1_file(sha1, &mapsize);
-- 
2.14.0.rc0.284.gd933b75aa4-goog

