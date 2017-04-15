Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB9C61FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 14:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbdDOOlS (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 10:41:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34714 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbdDOOlR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 10:41:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id z129so17272wmb.1
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 07:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uiE038kZWCnDbAJjrocXGLTE7eZqHFbAg5UexIZ/zok=;
        b=gJ558KqB95sOufb09RkEkN61bTzXusyTA7ObpOfUmG96hF0CCkq11Uu6BfT2YC3Xh7
         dPpTeGU3/RWCPUaFatIFaPdBLQARfhpYRigRP2UCilPA2YWY2IoeIPI+hZSad44mT+tK
         HKEsGK8feoqp66pO6rRf2osPrcmGX2ReNOiUNsYSypqXWDtZREApewxWeP0r3gM13GP1
         zNzdt+mK/MRI3KHC0Cngmx+WcLqgYzLMdWtasXhu0h8Nw+NN1iY9yQWwdPuvEO7JRh0B
         1Yg3CRgPV3fsVLd2P9L2QmWHLfbFqToRIg1nrp8x26kmRskZskr0Hm1Bv+jSQzpwMYvY
         4R2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uiE038kZWCnDbAJjrocXGLTE7eZqHFbAg5UexIZ/zok=;
        b=sPzNM3jUrQ6u+jwTnLZdQ+nQp8tQuo+LIpYIsKJ6YLXiOZeg0H9tPtPXrmVvis1onN
         BJy/PjJispgzbQkI7+fmUE98x+es1i23DZC82Xo1ja/mF2w6Ez9lXfhMxBT8MxhLZ8A6
         YboWnVg/iXGa09Iqmfmx9qkQnoAV08uf65xYk/Qt9B3bKIzVetCY5wHkyWOiIdXOB42Q
         x6wXUr0z5enFuo1IXIkHWNlNBu7k7SCXQqBgaLENCXmX0nnz8XTuCxjEKBp1DJwJuy0w
         HOnSU+K0JfPlmzHoAiZXGe1ndF14gXFf3E+mTQGIMB4UBsNc0Vi7S2RNwbWOrj3u1fv/
         UzGw==
X-Gm-Message-State: AN3rC/6xO6FDb8CJ+l0/96fz6s/UOyzrlg1tnlPqUauHlAtBPQY+D2+g
        Tm39uqD7RH3peg==
X-Received: by 10.28.0.201 with SMTP id 192mr2827713wma.126.1492267276228;
        Sat, 15 Apr 2017 07:41:16 -0700 (PDT)
Received: from localhost ([151.54.23.249])
        by smtp.gmail.com with ESMTPSA id b10sm2797532wme.22.2017.04.15.07.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Apr 2017 07:41:15 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/3] builtin/am: obey --signoff also when --rebasing
Date:   Sat, 15 Apr 2017 16:41:01 +0200
Message-Id: <20170415144103.11986-2-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.765.g2bf946761b
In-Reply-To: <20170415144103.11986-1-giuseppe.bilotta@gmail.com>
References: <20170415144103.11986-1-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signoff is handled in parse_mail(), but not in parse_mail_rebasing(),
since the latter is only used when git-rebase calls git-am with the
--rebasing option, and --signoff is never passed in this case.

In order to introduce (in the upcoming commits) support for `git-rebase
--signoff`, we must make gi-am obey it also in the rebase case. This is
trivially fixed by moving the conditional addition of the signoff from
parse_mail() to the caller am_run(), after either of the parse_mail*()
functions were called.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 builtin/am.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f7a7a971fb..d072027b5a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1321,9 +1321,6 @@ static int parse_mail(struct am_state *state, const char *mail)
 	strbuf_addbuf(&msg, &mi.log_message);
 	strbuf_stripspace(&msg, 0);
 
-	if (state->signoff)
-		am_signoff(&msg);
-
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
 
@@ -1848,6 +1845,9 @@ static void am_run(struct am_state *state, int resume)
 			if (skip)
 				goto next; /* mail should be skipped */
 
+			if (state->signoff)
+				am_append_signoff(state);
+
 			write_author_script(state);
 			write_commit_msg(state);
 		}
-- 
2.12.2.765.g2bf946761b

