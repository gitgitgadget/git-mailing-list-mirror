Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD8920188
	for <e@80x24.org>; Sun, 14 May 2017 04:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdENEBb (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:31 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:32883 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdENEB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:29 -0400
Received: by mail-pg0-f44.google.com with SMTP id u187so45853772pgb.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qw5BQ2l8/YdmESJRkmWzSrcRAbpqPti24ep17aAF3oE=;
        b=dsLWCaSY8q/D5Sm3fhtg55ugCM2J9TgV/tm43mBsO+WLWjJd22I/zADJCUSJ1EVMyl
         Drg1GI+Q1dAix5GAj2J5prwp4qHklmeDv1imtiwc4UEWwI2FZ/Tuz7aO+yKjFYNVExgT
         m/fxtoeFFCbX/u10Beo099P72GuV695JfHe6i6eS/qaMtSea1n6pJN1/J3T8sAtbCb/U
         Rb2g6HNO1iYcupTtl8XgAhUssX8+AjwpxoCOEhdVf8soRJPVuyr12tbmwZy9hRHe9u89
         a9PpLPqQJyLhV1Ibk9NLNjVGg9YGQeYhXMEb3Al/zNAQfcoV5pLE74/fFKctqBBp56Nn
         IpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qw5BQ2l8/YdmESJRkmWzSrcRAbpqPti24ep17aAF3oE=;
        b=rKyXyJysZmY8+2Fys8mYqUny39Qv6+tVvNrUx3OvgArsppVcYGGzwbV746UkE25Q9S
         cq8TFM6ZeQjAEjHebxRMuRJOEKIgNPKjJVM5f/k4a12uxwzjJz5oYMS/rGyRUPYig0vW
         OfIgDaYQtgCXuqhXZwp3I5ePndC8dZgpa/33RhAjhI5JleQQnLUQ0Y/lu545Jm+Qj15L
         BKgFGuAj8fuXDHWrzDM87qGJRZrcw7wGMRcKuxrKSoujJPy38yaVEp67EAdfbH7xXiEQ
         eeH8TU7vuwSdVZvkYiMYmTHp+Idyg7GgUz/wpV/XJZay9X1mf2dyhcGPWMqUP6mmu/5L
         lZPg==
X-Gm-Message-State: AODbwcA+9LQfHvvlFogSzohhIdAuRqmCxLBbZcrwGTsB0moGkCypx8A7
        OxtEjO1OcSsReIht
X-Received: by 10.84.192.129 with SMTP id c1mr16019896pld.170.1494734488609;
        Sat, 13 May 2017 21:01:28 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id z21sm12927319pgc.15.2017.05.13.21.01.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/19] diff: move line ending check into emit_hunk_header
Date:   Sat, 13 May 2017 21:01:00 -0700
Message-Id: <20170514040117.25865-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line_0.

This patch moves code that is conceptually part of
emit_hunk_header, but was using output in fn_out_consume,
back to emit_hunk_header.

Meanwhile simplify it by using a function that is designed for it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 3f5bf8b5a4..c2ed605cd0 100644
--- a/diff.c
+++ b/diff.c
@@ -677,6 +677,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	}
 
 	strbuf_add(&msgbuf, line + len, org_len - len);
+	strbuf_complete_line(&msgbuf);
+
 	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
@@ -1315,8 +1317,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		len = sane_truncate_line(ecbdata, line, len);
 		find_lno(line, ecbdata);
 		emit_hunk_header(ecbdata, line, len);
-		if (line[len-1] != '\n')
-			putc('\n', o->file);
 		return;
 	}
 
-- 
2.13.0.18.g183880de0a

