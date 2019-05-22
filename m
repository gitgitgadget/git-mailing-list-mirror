Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ED641F462
	for <e@80x24.org>; Wed, 22 May 2019 20:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfEVUI1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 16:08:27 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43369 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfEVUI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 16:08:27 -0400
Received: by mail-pg1-f201.google.com with SMTP id x13so2299567pgl.10
        for <git@vger.kernel.org>; Wed, 22 May 2019 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TRGInoi7EI4ePQsltgTb1IAWDAkoCqpHEq4n7mf9xHQ=;
        b=evXoMvps8xot4mOegIXtturOzEVecrHZMRAmLv8r6mhN980IULJptxRtYBP87spWSA
         S/Fq4/dewZQzwHZSmlgznlNsRqfaQK2n0BCBudf3Q3Rh1pvCgwrJAXb2j8a1TuXJeGX9
         J8ChZ2tVwyYNGI31s66Rohh36XqTaBJK5UeFCjlYFQlIf+gPdeu55IimoY867q203UDs
         /AM7+zgjRkthUDbocHiacq+cV6yZsAejchlva+9lWvLpvFk90UM2QMYnVNSs8CA5cUQa
         kAMTlIVq9hBl4A3ZYTWPV2n2A1Yn/hoXcgdwl3mOrhH7PIPOD3CvUcVeiqydBcG6CN/l
         1Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TRGInoi7EI4ePQsltgTb1IAWDAkoCqpHEq4n7mf9xHQ=;
        b=Cgl8OjOI8wdMGzR91UrBvR33GTFskdpSdVE3Cm4qeU8moEGlTanv0SrtgbrMfcSAPD
         RudlBzQ/B34I13NqYo48W6Z1MyZHIkP2PpbkuHjsAbwTIeigy7ZOJJLF6qbLV0e+9fG4
         od1vcGKMl7EyHI0PytL501d9Ah9iJPgH7RSW7WeYiezI0VzoTA76KgJN+Za3wangKkp0
         Mfr6mFeV0W0sDYdQLwrjO8M+p3+hbEvBAS875Q6AiwvhJWjvisszvrjvvWMxew/gseZ1
         2yLNHNl9ovKv/paugL4GhAIXvPpJ6hyCr99FNOaV2KhYp8juYUDUiFoS08wVZfms74fH
         xEYA==
X-Gm-Message-State: APjAAAWgZPOLbkrUX6dGWFCJRL7R5+7LEwjmoaph23igH8wQgTDQCpxn
        +sYzWvS25nuUepCt5we/hZEE1f+ry0xGwF+wVRPfvm3HcYUl5AMCF4pzNJgsx4JTCb8OK0MBH17
        K4Age0pXuVJaCWhb4T7dD/UQqqgvY/TRr/IeTyuda6zTxjtS402HaeR95wUSMaa8ckb7d4wRBBo
        yB
X-Google-Smtp-Source: APXvYqyfTeutYEcMpUxKDVe4lj0LoxIQ9C1QlmA9f+G/RWOXAjpNpmvbV7daz2YVEi5+J1inAkmGpX0+0M2M7h1vo4Vr
X-Received: by 2002:a65:6449:: with SMTP id s9mr89787323pgv.90.1558555706292;
 Wed, 22 May 2019 13:08:26 -0700 (PDT)
Date:   Wed, 22 May 2019 13:08:22 -0700
Message-Id: <20190522200822.176870-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] fetch-pack: send server options after command
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, if any server options are specified during a protocol v2
fetch, server options will be sent before "command=fetch". Write server
options to the request buffer in send_fetch_request() so that the
components of the request are sent in the correct order.

The protocol documentation states that the command must come first. The
Git server implementation in serve.c (see process_request() in that
file) tolerates any order of command and capability, which is perhaps
why we haven't noticed this. This was noticed when testing against a
JGit server implementation, which follows the documentation in this
regard.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 3f24d0c8a6..1c10f54e78 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1115,7 +1115,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	    server_supports_v2("server-option", 1)) {
 		int i;
 		for (i = 0; i < args->server_options->nr; i++)
-			packet_write_fmt(fd_out, "server-option=%s",
+			packet_buf_write(&req_buf, "server-option=%s",
 					 args->server_options->items[i].string);
 	}
 
-- 
2.21.0.1020.gf2820cf01a-goog

