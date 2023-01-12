Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66747C5479D
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 02:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjALCsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjALCsV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 21:48:21 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707D76550
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:48:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 17so18867782pll.0
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4KBBAYFWSgI2TuIMbcVp/NVFdCopRz2u5ggs+RKtDA=;
        b=TXOgHpXfUbxQWomWvUsVD/Lvo3uX5F70oOAM2TOabfeSf/aPpI2CdwV5zHUk5E+73a
         7dvWat/lic1alvVdTcIJvCyCDbMjF6a2ekspK9YFzN4fXpxD2EmvdWhRe7YT9brhYIE/
         YImKzna2j7kyq7w/vKab6342PvhAI2e21e+bIa701FdjbuXG471fNv4d+aUrQuf7ABbK
         Q1Eb6l9qA+G6Viz6AoemD1+oyg1eekgyBDuQhmprAFY+9ZCUJYWjnaPFz+Aihxp0qsjO
         PqSbWFcETxz9HiDDZ2BU9KbuwJmp0c6Xbq1NBuSQD4KMYJO2kMbsXpL+BnKi03cV4RTb
         yScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4KBBAYFWSgI2TuIMbcVp/NVFdCopRz2u5ggs+RKtDA=;
        b=VGVoQXdxyHV05AcCyba9JPxCu6knYIr1JqbrE9YLZghvW+Fgg2ZfJp4x4n2Ml4mstx
         Z/IEkUOkmh0jEXpz4WiW6ksyAgAdeMdoLId7AK07erq2HuXVf1MYG/mgrRBz9ojOdqTV
         jVgI0dHc5WFroWblQdl9bpxAjP2xUUHBzmDdZygZhseil7HI7uJjApVieUJKLu2FHGB3
         aqwbJvfRJRkKN5u7HhaKT3QdH6KBPfthDuI2SwktbGUusVaj2B+X/VTJmLoDfymnZ7p+
         qzOjPjMBxsfOHBli+3pNnysYEa6fke5uBiE24X67KpMVqV4NBNppXMBxuuBdwEycB4FR
         KzPg==
X-Gm-Message-State: AFqh2kpLS6UwhFRi4G3ayedM56Bpiubcn1deoaN8AcSNvWSkiTCIHYP5
        dE1QsmSUF7ST6tid5nsP7ds=
X-Google-Smtp-Source: AMrXdXsuslK0pHAwSS+Htws/h1u9LrqB2mwHNDXEVpSIGfZ2PJw4WCRZoM9IZHMvsrTbzTQpnK0Y6w==
X-Received: by 2002:a17:903:258e:b0:189:38a1:8c04 with SMTP id jb14-20020a170903258e00b0018938a18c04mr4702062plb.50.1673491699936;
        Wed, 11 Jan 2023 18:48:19 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b001926392adf9sm10855227plh.271.2023.01.11.18.48.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2023 18:48:19 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com,
        sunshine@sunshineco.com
Subject: [PATCH v4 1/5] notes.c: cleanup 'strbuf_grow' call in 'append_edit'
Date:   Thu, 12 Jan 2023 10:48:05 +0800
Message-Id: <f00a7596587bbf2d055dbf77a19506be1a6350fd.1673490953.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.386.g6952793f2d9.dirty
In-Reply-To: <cover.1673490953.git.dyroneteng@gmail.com>
References: <cover.1673490953.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Let's cleanup the unnecessary 'strbuf_grow' call in 'append_edit'. This
"strbuf_grow(&d.buf, size + 1);" is prepared for insert a blank line if
needed, but actually when inserting, "strbuf_insertstr(&d.buf, 0,
"\n");" will do the "grow" for us.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 80d9dfd25c..e57f024824 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -618,7 +618,6 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		enum object_type type;
 		char *prev_buf = read_object_file(note, &type, &size);
 
-		strbuf_grow(&d.buf, size + 1);
 		if (d.buf.len && prev_buf && size)
 			strbuf_insertstr(&d.buf, 0, "\n");
 		if (prev_buf && size)
-- 
2.38.1.386.g6952793f2d9.dirty

