Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4240A201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbdF3UxU (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:20 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35722 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbdF3UxS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:18 -0400
Received: by mail-pg0-f45.google.com with SMTP id j186so68677520pge.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y/p2eOXJYFrtVGFffiEnkqCYeiI6nA6RYmkTOGFu/Uc=;
        b=bdttFSVF2DSiQ0DpxUhKO1rLnChzg/XDG1LyIcK+/I3kdikW3v9Ky1H8Q1NEY8YHa+
         FdDTK4GgLz1lBKNQvvZrUil4HU45qOaDLJ9QjVWcFE9wPQORHQ8mSlJuCKzCb0S1+pfZ
         6IdyHR7IqpJFcTgRMxsP4yAGiGzRaRGKKdGx7vMmLA/3QWFPyBFaapPQKgIO48v+u3AR
         6dn+hX9EKEhJ4aJSyYuf8gnFKzvacTULU4hJWZJtBtPud9Kliy1ALPo01niI6yR6p0gg
         k5vvGitxQSZP8FKZgIUJI8Yjt4iyRHtdvrjW+Ejh+YnAgI2s15cS/fpm0orbWc7bZJDw
         nU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y/p2eOXJYFrtVGFffiEnkqCYeiI6nA6RYmkTOGFu/Uc=;
        b=TFH8nCBqXafH1QCZr/ZSnRDILYqYKfNIzNppgBy1QvUbev0RaE2Pm+C3skQnL0SKEX
         B6NKP9VgNTrpak4U1TeWCPQetaa/w40XOTbtgpqXQ7NfjWLHnHahbAIYJpL13lOzBwAc
         BsIBTH3O7sa2gyov2X4YzxuTBK2jVx0tGDBuUJfJue7aIh++nldWxtfvXR3Zs1MVc34q
         f28Cf+DbVtgGktp2mT2HgH9nZgIkgE81qq4g4IZMRUh929Y3FV3IU0SE1DTCSlqkoAu3
         rUbkad7tl4mcLj+NnG9z2bXmfbZAEZOakzgh5T6bMELzk6+xec94u8KxFhlJurpqRQXN
         TcMQ==
X-Gm-Message-State: AKS2vOx1IvE4HTnwLUZfFNB63P1mU+1I8c+3ub11xqBeqhnNJzdCyi98
        LcyXhJrkRmDMdZcU
X-Received: by 10.98.93.21 with SMTP id r21mr12417774pfb.201.1498855997363;
        Fri, 30 Jun 2017 13:53:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id t5sm15293565pgt.19.2017.06.30.13.53.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 02/25] diff.c: move line ending check into emit_hunk_header
Date:   Fri, 30 Jun 2017 13:52:47 -0700
Message-Id: <20170630205310.7380-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
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

