Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424EEECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 21:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiH2Vis (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiH2Vik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 17:38:40 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3F580F76
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 14:38:39 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r69so8894395pgr.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 14:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date;
        bh=jr7BwHTVU/SQNOtkb/4fbBnH/KiuQEe4iBSFUJBmJjY=;
        b=qw3Uom1w234bb34VRUnNXWzzcKfYpbpxnOrdQEreXpCy2unH7fm4wg6pwJb50Vhq6p
         ZMnXf/USB3GtgmVc5ucdJbmTTxKg28mvFa1Kd0WZG5eb2wY5F0rPoErLwB7tShk0T+Jj
         xUREMchxur508jusLry3x+4LWSy8AXzFE4DpKREBHSgx25YszKlMOPytrNKAKt/s9f6J
         taUsRSNZlvU8I8uY78nwEnLROMjZnXWbDY1xUkRili0CbwlJftworXQ4uHRpsZUiIBeW
         7+i29Ao0VfRwdUuTzWC3aRlxWTQzBqUYXNwyuU70WVeHAC+D7yyMQADfZCeg3D4RNK0T
         SM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date;
        bh=jr7BwHTVU/SQNOtkb/4fbBnH/KiuQEe4iBSFUJBmJjY=;
        b=VtCY30EmCYNAcvtGlerGEGznBYh3VOWZMiJ1F+NQKnpXN1VsZkqTx+xhKwlLbXjKGt
         9+sIljcQxqwAoo/qwu29AajmLotB7fMFjEsMQgYPMm65QmVs+qUapMKzPC+huRveDZLN
         yMvRQYpUqYbSTfXQ5dujcSH+/f12J7v4IJn9ncTkfXUmVongNPgDf5O0xGNrmaZQKd/6
         Q3MAmXRizLy/kc0gLGidwySCMxa+9K8cWletXsaeKELdG0f6mIOGtgL/RO5vh5YbVFNs
         uHFDspHqvqDJOuL3eCdRnnbzfQ7C/8Bux0SpXTWTLalJQ2ZWjfO+4MBOaV2QB9I8cdck
         Yvcg==
X-Gm-Message-State: ACgBeo39+5Cno4pwQUIxxHJNHwUzG5T+zhw9sxTti1zoSp/w+NW5Zklu
        NZdcV1gQu/Xw+Mr+T3vtFkRhg8YvsSM=
X-Google-Smtp-Source: AA6agR5VVtTsOVe75v0q8kRmMAnyldqr6aNJh6qkGHqJaifdLM4XMkde8xdZlHssW3//YFAWmMSVBA==
X-Received: by 2002:a65:6a83:0:b0:42b:344a:3546 with SMTP id q3-20020a656a83000000b0042b344a3546mr15705096pgu.612.1661809118638;
        Mon, 29 Aug 2022 14:38:38 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i22-20020a631316000000b0041c30f78fa6sm150561pgl.69.2022.08.29.14.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 14:38:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/3] pretty: separate out the logic to decide the use of in-body from
Date:   Mon, 29 Aug 2022 14:38:35 -0700
Message-Id: <20220829213837.13849-2-gitster@pobox.com>
X-Mailer: git-send-email 2.37.2-621-gd3a800faf0
In-Reply-To: <20220829213837.13849-1-gitster@pobox.com>
References: <20220826213203.3258022-1-gitster@pobox.com>
 <20220829213837.13849-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pretty-printing the log message for a given commit in the
e-mail format (e.g. "git format-patch"), we add an in-body "From:"
header when the author identity of the commit is different from the
identity of the person whose identity appears in the header of the
e-mail (the latter is passed with them "--from" option).

Split out the logic into a helper function, as we would want to
extend the condition further.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pretty.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 6d819103fb..cf418a6b20 100644
--- a/pretty.c
+++ b/pretty.c
@@ -477,6 +477,14 @@ static void append_line_with_color(struct strbuf *sb, struct grep_opt *opt,
 	}
 }
 
+static int use_in_body_from(const struct pretty_print_context *pp,
+			    const struct ident_split *ident)
+{
+	if (ident_cmp(pp->from_ident, ident))
+		return 1;
+	return 0;
+}
+
 void pp_user_info(struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
@@ -503,7 +511,7 @@ void pp_user_info(struct pretty_print_context *pp,
 		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
 
 	if (cmit_fmt_is_mail(pp->fmt)) {
-		if (pp->from_ident && ident_cmp(pp->from_ident, &ident)) {
+		if (pp->from_ident && use_in_body_from(pp, &ident)) {
 			struct strbuf buf = STRBUF_INIT;
 
 			strbuf_addstr(&buf, "From: ");
-- 
2.37.2-621-gd3a800faf0

