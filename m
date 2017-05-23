Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 427372023D
	for <e@80x24.org>; Tue, 23 May 2017 02:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935984AbdEWClI (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:08 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35166 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935966AbdEWClF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:05 -0400
Received: by mail-pf0-f178.google.com with SMTP id n23so99563124pfb.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RmApIL+ORZfUZYpkp6dQT9lqXo2ai9QUsj0YnF5Ivfo=;
        b=MTqEUqx+wXtqvF1UGCjv5Tox45SDRqMPZBOb5iBKtNKw0wMM+tyefS/e/mKo2lOYpN
         Lts2XSrgkC9UGREYHKrvPLRn+ULE2srqa1GyyJPHE2mFORngXyzfdca+99/1r1rcR2aT
         h4DtRQDzCwzQTEXoVkKw4Gc0SxsRp24WQGIS2YUXTEnoz08SUDQlHE8giZUNSVVLlPFU
         L8aKjJCQbx3zwDq0840vaTQ+QrE59UxxlWpwpR96JvLQ8iWe0xCCwfNr3SqpmKsmWkOj
         kWeUEtwmnFsR2ywXsysGt2a3wJfslVzNMkjeVGf0HFsneveIo1hbnFtRUF3m4OkZ/+sH
         F59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RmApIL+ORZfUZYpkp6dQT9lqXo2ai9QUsj0YnF5Ivfo=;
        b=jofOMGFvUkngDaSoGiXU3AEOL0bjKYaSSICYvFtXigfs4rYYjkKfmQWaJNWDIpIIxX
         eJvxr5KrYin3zg1oFRQkBPiS/w+4CM/AzNlS4xIOEO8lAFfz8pgp261sIVHxeeGihDoP
         1zyZOaPYXQMK6+Yqk2qGnWcr0UbD+O5DHisx38vJJswaAeDLA4/v8Lr9fEh7tDO11ZR1
         9XPvuuajZRuDbF+Y8KKDbUL4C83uIjNZHWwUrQkSljdY8FrKMByMrjPzlqnSmoSAPlMt
         XYz5DizX1jhoFvu6KjLPKoRXYkHGET2ok5zDusHsLnXmMhxL6E5U0WwxBQNW7sAxw+/f
         1RYg==
X-Gm-Message-State: AODbwcAkecnqoAYnjbGXr2VdVguGfpbcuCe9+pXLJhJvrO5bwWvZs3+b
        K6KbOQKSjD8ZA1Oo
X-Received: by 10.99.1.85 with SMTP id 82mr29788182pgb.164.1495507264615;
        Mon, 22 May 2017 19:41:04 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id q28sm28531868pgc.0.2017.05.22.19.41.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 02/17] diff: move line ending check into emit_hunk_header
Date:   Mon, 22 May 2017 19:40:33 -0700
Message-Id: <20170523024048.16879-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170523024048.16879-1-sbeller@google.com>
References: <20170518193746.486-1-sbeller@google.com>
 <20170523024048.16879-1-sbeller@google.com>
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

