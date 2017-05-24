Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80B320209
	for <e@80x24.org>; Wed, 24 May 2017 21:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164173AbdEXVlF (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:41:05 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35566 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164152AbdEXVkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:40:55 -0400
Received: by mail-pf0-f169.google.com with SMTP id n23so147413523pfb.2
        for <git@vger.kernel.org>; Wed, 24 May 2017 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RmApIL+ORZfUZYpkp6dQT9lqXo2ai9QUsj0YnF5Ivfo=;
        b=CZB8f/Y265Oq3fvEMYXk9PWgNWF3hJfhZbkk8HH9l9NrQtRupZj1PtLbFO40b+v5W9
         l2W07cIg0t7k0aljfHanoQQ+/5IP55oghFv4a0aVVmD35UCTwWL6lsbZhTfwSNM95B3z
         0a6duN0ZbkvxTxT3qBBkRkMZ7KHXL/yl4OK1cfxo+oHaORMKOAiDSNXmEVrXAzy8Q+t1
         IX2yP1s6yIp6F8BnQYqFgT5DajDZ5I8+nrX3fObZ7S0IKoX+WwEQ7FJS8AFgRbyY0zXP
         XhK/PWnX6WNSHX5m+6NN4X7mLH8a3NCafCjPckZ6uMfpxxn7W8fgVmKtTjDQlTCnQMWy
         mRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RmApIL+ORZfUZYpkp6dQT9lqXo2ai9QUsj0YnF5Ivfo=;
        b=ATUYmsQvuFXQ9p4Fj6tlbDunfFfNtsnm/lmgZtHV20AQE3rpqtUfwLtDUlJb6ZjG77
         VXnJTGDpRT1TMrmhumSSc9xqBykeJ7q5i9AYMyMnNiEc0b3LF67rXQlZPLPO+a40G8A5
         /qHYKIQtQ9Pb7CXjccdsWx3sCkug+EDDC8xFhK4kevoAg/fXT0M1YhLC911VAxIJvLGg
         m5Qxl3Ox3cHM2FIuqcaZ6HOtOlVgN7ijPZCoEsz45sct1fuhVBT0x4HU4i85+1UisGzf
         58sTDJKFMFQW7sn2c4W6okjawJ9fLtvohO/kWOWdL0AKm/qZy48vtloruDq/o2dQunYs
         CrBQ==
X-Gm-Message-State: AODbwcBmiUdpH7TvVQibg7QigsV8zCwLFu+hGlKMCGZW50Sio+jErjQo
        YyBgAGBmXe9oC9bw
X-Received: by 10.99.109.129 with SMTP id i123mr41022082pgc.103.1495662043856;
        Wed, 24 May 2017 14:40:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:70df:e59:d409:fbba])
        by smtp.gmail.com with ESMTPSA id e76sm8448027pfh.121.2017.05.24.14.40.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 14:40:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 02/17] diff: move line ending check into emit_hunk_header
Date:   Wed, 24 May 2017 14:40:21 -0700
Message-Id: <20170524214036.29623-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170524214036.29623-1-sbeller@google.com>
References: <20170523024048.16879-1-sbeller@google.com/>
 <20170524214036.29623-1-sbeller@google.com>
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
2.13.0.18.g7d86cc8ba0

