Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F8B207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbcIMEqT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:19 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34822 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbcIMEqT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:19 -0400
Received: by mail-pf0-f170.google.com with SMTP id z123so5534511pfz.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZTQzNdYfzfOtuPndIPFRDCXaS0MNpSzU3yR5n8H3xcE=;
        b=NSsrpGb1wzP41mmxdpaCe1AWdwSltZxBZL19Pd/lsNyVwP6CvRZ4GRBw5sUVHrCk8e
         nc9Qnzp5Ft82PVcVJSweHts2JyScak+y1cbFhSimYLVP2qbAj1mCl1AI1U8zeSb0PxPb
         YwW/jw4MM/7lLUe+15m3lAK9HngUWbEWNyLqtnrLs4RPpgW39tcy0eG3X0Wzk23LLbHa
         HF8CrBt6K6qV92kEIDjNc+xtLrAwrTdqKdyL3m+0r+GuXqJZEcov/ygTvt78UeFm+QY3
         bUwcI0HtP5wZdv/4XhFNay7319K9k9FdIymq4Y4/CDo5CrpWKy/ukArt3HUuxF/B8ilf
         +gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZTQzNdYfzfOtuPndIPFRDCXaS0MNpSzU3yR5n8H3xcE=;
        b=hjHFL1WvEhUqWcMf8XaWPdPQL0JaK2Qi/gHmh6g6Q7vRZLHQO20SUI4njzHp2wJx1a
         gGI0uMtlcg9j2TFT3ZaTU+lbzlHGY4M+e2w4FXxPFWow5f2jZNbRwOUHGWMHH6yweyzd
         AzBwumx58yqJuoSV6TX5iwwptgX3WkjFhqmke2KlaadkUgfMS2mKq3gxZbe35e/AS8i3
         rV0sQ4kIQarl1oDFOIbx5HDtYroFuiJmDnix3u3QxcKdusclwskfQoNHdBRMAMU6q+YY
         BH1SxV5m3Z3SECcw8a8BOmA3zYmfBffU6H65/ra1nfZMBdG4Z9SjcUJJzKln/vsrxDsk
         g/ew==
X-Gm-Message-State: AE9vXwMhN30lmMkT4SQwqKuc96OpDvEroOmj5OaCoydQP3EswVSRTEBvb97EV3dSkPcLxFLi
X-Received: by 10.98.97.7 with SMTP id v7mr39867187pfb.49.1473741978134;
        Mon, 12 Sep 2016 21:46:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id f23sm13946770pfj.72.2016.09.12.21.46.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:17 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 01/17] diff: move line ending check into emit_hunk_header
Date:   Mon, 12 Sep 2016 21:45:57 -0700
Message-Id: <20160913044613.1037-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.21.g1da280f.dirty
In-Reply-To: <20160913044613.1037-1-sbeller@google.com>
References: <20160913044613.1037-1-sbeller@google.com>
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

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index cc8e812..aa50b2d 100644
--- a/diff.c
+++ b/diff.c
@@ -610,6 +610,9 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	}
 
 	strbuf_add(&msgbuf, line + len, org_len - len);
+	if (line[org_len - 1] != '\n')
+		strbuf_addch(&msgbuf, '\n');
+
 	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
@@ -1247,8 +1250,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		len = sane_truncate_line(ecbdata, line, len);
 		find_lno(line, ecbdata);
 		emit_hunk_header(ecbdata, line, len);
-		if (line[len-1] != '\n')
-			putc('\n', o->file);
 		return;
 	}
 
-- 
2.10.0.21.g1da280f.dirty

