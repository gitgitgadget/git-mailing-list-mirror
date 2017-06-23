Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3809E2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 01:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754022AbdFWB3d (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:33 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34006 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbdFWB3c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:32 -0400
Received: by mail-pg0-f52.google.com with SMTP id e187so15004963pgc.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w0jvwr6CIYYUYZwrunGDCdyjbHZGs9MYjKodHKIEnWQ=;
        b=AF5MDkolFg+46k+mKYYUmL94M6mynOpgdD7P6Tf8KX6Jpz3rdKtDnoc6RZ3j1e0WT4
         3Qn3jcFtzzLOa0EQ240v0D9/9llFBHBA9LGQEGPuq1gUyDptuAl3PK2/lJSEN41rZyAH
         RwLx+9EwzYIvPC5/qeIPWrGVX5kD2Q/g5it0NVW9ZqI6ZGkneM8W/Y5LSKX24yb13etH
         CiNcrVqPDBL9w7dJkhznInKvBJkbhYBXn8I5WiEteF2TRGh0HA/wgGnvBDe9F5KGujPt
         D9A8hdLGIDYE/4ZwucJ7MR/HoQP7oFOLJnpVOOVesq6Z4vsVDuZMQZYqxoLpClyTO2QW
         fjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w0jvwr6CIYYUYZwrunGDCdyjbHZGs9MYjKodHKIEnWQ=;
        b=LiZcnlrByLaLh87evhj5sRMcwlhxGnTO6myQNGNP3pR14WNA8OaFj+18jkrAqfOtbA
         fM1Ud7pViR55Bj96I4PUROsIno1tnVd+das2vkn+g0Us5OoP2BzAGM0+u4WkAW3+m7yI
         QB8GPpu3qk79L5ZuKZclChtXhgZQ7b8hfEJ48Xp4U05ANVPsNEVj78Q/wJvQOuyTlxoj
         mzUJAecq9/1aq59qa11qX4ran6sod1m9dr2VAa8s/cG2szsBr+4fQRxPfZfKyA9c9w/P
         pxuMmgXq+MJWJqIbfz37c0x/RQzM+L6h5Bfv7MFQnC+waMPd0WThH/TY9LhmlgQfvu3G
         RmPg==
X-Gm-Message-State: AKS2vOxYjTTGCkPIuBfeBei58jIk2rE462fj7Sl5mKrHfB5x08Dhmq2X
        m7CbV8mLZrbc1raK
X-Received: by 10.99.153.26 with SMTP id d26mr5541589pge.241.1498181371288;
        Thu, 22 Jun 2017 18:29:31 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id c205sm6210657pfb.74.2017.06.22.18.29.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 02/25] diff.c: move line ending check into emit_hunk_header
Date:   Thu, 22 Jun 2017 18:28:56 -0700
Message-Id: <20170623012919.28693-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
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
2.12.2.575.gb14f27f917

