Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9623202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbdF3AH3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:07:29 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36566 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdF3AH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:26 -0400
Received: by mail-pg0-f47.google.com with SMTP id u62so55118180pgb.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y/p2eOXJYFrtVGFffiEnkqCYeiI6nA6RYmkTOGFu/Uc=;
        b=RQjrwR+WzZejhyk3fnQXcVD88VPHYbaYAq6lx7xNVWnxXQX2uI6lvyL9kyqqrYbyNj
         X2oLErU/hHp1t6YCQT04W4r85TFLdaLDhj8GZbpK1DSbrh/3csXgKiLrk+hXzHVr0846
         fALE5blGikZgGYsEEbJtRGE9mD2PAxLri0AG9QE4uYv/+NTyfu381GceWPMqzParli1h
         AUVu3ubk4T6K5Yogbik2L+YBPPTYZnYKlDf/8gikkJ+m+hbtvUJq314j2FzyMsenepe1
         3c2iF8hKHVzeIe1zdAi2gDY8E4QtXYTXLZpD12F6ySVsmPIS7QqOuu6oMBgHTO8RbtCJ
         tU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y/p2eOXJYFrtVGFffiEnkqCYeiI6nA6RYmkTOGFu/Uc=;
        b=SUldXurll3D/mXMSe8t4w1RslAlhTqbWt+s9SF1Wk8F/L3hsXP5tQuVN/2AmafyoQO
         bCYC8KZi1jz6TDXx39WJE8lj6DoB3skcEFdjbgN80BSbXJC6VzSqzudrrYVe2gpl4Vjh
         HnbFS5vKP/bhHLmbmdyR5nKj0qfAANUh879xyfv3ImrpuNmbBFbWte9wuOOjQUtp2MoE
         WFRIIbTxS/Gsg/k8cHdFm2Cg9ujIcLwgwKyCBF3y2vBpSMUCFj6IfxA6hhmurkxN82D4
         6y+hao9+267XOujUClIoBnfTDGcrGdzSGD+rlYzArZD5QGrxTQ89IJAyKHhvHwhNDlwL
         CFIg==
X-Gm-Message-State: AKS2vOxfc957MxDa0UsyMc6OgzPUdbqL7ZDPkJTTx27zqPR1pKwehSb3
        dZJ00adJPaxCDpRO
X-Received: by 10.98.80.198 with SMTP id g67mr19735497pfj.146.1498781245675;
        Thu, 29 Jun 2017 17:07:25 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id v3sm14096946pfi.73.2017.06.29.17.07.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/25] diff.c: move line ending check into emit_hunk_header
Date:   Thu, 29 Jun 2017 17:06:47 -0700
Message-Id: <20170630000710.10601-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The emit_hunk_header() function is responsible for assembling a
hunk header and calling emit_line() to send the hunk header
to the output file.  Its only caller fn_out_consume() needs
to prepare for a case where the function emits an incomplete
line and add the terminating LF.

Instead make sure emit_hunk_header() to always send a
completed line to emit_line().

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 2874dfc6fc..94fdb57927 100644
--- a/diff.c
+++ b/diff.c
@@ -678,6 +678,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
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
2.13.0.31.g9b732c453e

