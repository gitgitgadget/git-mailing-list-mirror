Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4BA20986
	for <e@80x24.org>; Sat,  8 Oct 2016 00:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753684AbcJHAEL (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 20:04:11 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33070 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbcJHAEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 20:04:09 -0400
Received: by mail-pf0-f177.google.com with SMTP id 190so30063625pfv.0
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kSxViZVlzHC3p0Fz7tec/WsyrvBUSoEGr+z6gBkYUrQ=;
        b=a5EqfkTpUy+qoUAw/FeyS/Mml7PFzLwk95nE7taW2ZIOhAA0tttE9OdaKJ8P3t288J
         0evxNVr7E5+dTpTQT8NrPjQMxJNbYdH/oRS9jD5MpzWNBWGlsBQtZA+tlXqinsMnNyPF
         7/GNDs79F4f5N3+oEYlzMu+xAEq+Rw+OOcOU9T+odyrynkdu64inlDDLE5LpkN5gu32F
         oGsfqlUySTVabyF1Ac17P8aNjaXdrcW+XT4YZzUxRTRD30Efpo56K79y+/6173giJYSV
         5OF6rBPsxo7ImAlAEw+gLOCJZJQJS17UtZWovYDou4tbNxdMdPwcTQ2aoZtzdMHLMifS
         Ngqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kSxViZVlzHC3p0Fz7tec/WsyrvBUSoEGr+z6gBkYUrQ=;
        b=gzV4gajpFgjInjvYNm/F9kuku+0Yd2LTV6lOKVo+qoW1/b+bQJFQFZZ+u64ZM4H/yh
         HuqajIsvJTn9ANo3UnJ37oAhbqLerrEKCP+J+oL61FHot/NKg49uF3RTFAocv2IQ5r/X
         XTXmpFf02ftN5Hgh1UI6pTyQfHSv30mDSg3A4pFQ/O6eHbkrvV+IiSGdjhCM87UFWnBK
         m1PeLkCDYCfmcJhu0q/Eou/7Dag1kW2IFoptLRT0EXoHxWLrkRtrrCN1tWGpbkAmflJC
         1ymwlVbcQ4nJWcAQeB3Y+TRLb998xAQBiKRMtjXhX/7wnELbLLIIRLb0wzViLEWgF0lM
         vA3Q==
X-Gm-Message-State: AA6/9Rk/c59plbCTSQrOtFKum5TF0ka/sBDOj0u4sPyrh5HvQGIBGRClnbFUTawrekPxuK1O
X-Received: by 10.98.32.209 with SMTP id m78mr33318188pfj.45.1475884741823;
        Fri, 07 Oct 2016 16:59:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d089:b29b:e5d9:e1f1])
        by smtp.gmail.com with ESMTPSA id b197sm16642760pfb.52.2016.10.07.16.59.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Oct 2016 16:59:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] remote.c: free previous results when looking for a ref match
Date:   Fri,  7 Oct 2016 16:58:57 -0700
Message-Id: <20161007235857.20382-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.353.g1629400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 remote.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/remote.c b/remote.c
index ad6c542..5f9afb4 100644
--- a/remote.c
+++ b/remote.c
@@ -833,6 +833,8 @@ static int match_name_with_pattern(const char *key, const char *name,
 		strbuf_add(&sb, value, vstar - value);
 		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
 		strbuf_addstr(&sb, vstar + 1);
+		if (*result)
+			free(*result);
 		*result = strbuf_detach(&sb, NULL);
 	}
 	return ret;
@@ -1262,6 +1264,8 @@ static char *get_ref_match(const struct refspec *rs, int rs_nr, const struct ref
 		 */
 		if (!send_mirror && !starts_with(ref->name, "refs/heads/"))
 			return NULL;
+		if (name)
+			free(name);
 		name = xstrdup(ref->name);
 	}
 	if (ret_pat)
-- 
2.10.1.353.g1629400

