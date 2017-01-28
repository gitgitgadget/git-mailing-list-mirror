Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285C31F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdA1CCf (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:02:35 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34061 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdA1CCb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:31 -0500
Received: by mail-pf0-f171.google.com with SMTP id e4so76789747pfg.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i35Xm2TlDHR5fsKx6d+9+X3Hi2d37v6QsWkBfH0cppo=;
        b=JrvzzdZ2yuAqhA4EI+9UBS2JdFcawJSiRFhdYKvIL8E4VQPKFvtW3W8KjI+aeRo2y0
         vSfC6mrllkXd+j5cpD2mGX7TPYQ3whiLNrSuPqwDD3cWvPKT+9BRTzEZkNBfvL9hEjrT
         qSkvWad+tLgERIiFprZ9s85dp+H6136dw/0BR2Dm1enhiNoJYaZppxV2V9TScS3AABw4
         7MpfTsaI3NIynGaDd3u9JtzeWtRHr5hSoXM+FdkWec8YkXg9ijX6kg+xQIO/0FKQ1ouO
         ME8UHq3U2zzIVQuI9+uRyYvVR7XZDeZkFww8kWZRX84Ak2yIpuLjTucNIktDSx+EbHxV
         YbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i35Xm2TlDHR5fsKx6d+9+X3Hi2d37v6QsWkBfH0cppo=;
        b=Y92K5TBNg63vVqgEvxywRXge0ArwOI9HDrLKgjHyJRwogmktJ0yqQdun04EZm8p13Z
         MWyoxOr4pAFYN2n28VV6pB7TSNbKkT+q8+8BhtQY1cSaDGhQixzhogE92QPebBEdUGZR
         8GotF6ABzPDHC3IRK1bBYkDdPs7n31pO2XMHV6dgUU5STu5sXH8w3+ByKDJ6s/DODQXB
         GXCoRhql4v4SDSQ4nn8UFeHb9BTJnjiYLjXbBdk7DUXNwsISURVoGEnudnOhTleD6euD
         BVcwbX8gSBe5Ro/P88tKlhqIahUxk4B9Rt2oHGgWFnhdOz2yXvIvucAe2ibOMjSosA0/
         Y2TQ==
X-Gm-Message-State: AIkVDXKj3+B4FPiXUrUT6Ot7/vXg/MvBdkmJANpHVVOiUXAyL1r7Sr1iCWT1u5P7pGBjt/NE
X-Received: by 10.84.143.34 with SMTP id 31mr16284453ply.81.1485568950445;
        Fri, 27 Jan 2017 18:02:30 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:29 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 02/27] attr.c: use strchrnul() to scan for one line
Date:   Fri, 27 Jan 2017 18:01:42 -0800
Message-Id: <20170128020207.179015-3-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 1fcf042b8..04d24334e 100644
--- a/attr.c
+++ b/attr.c
@@ -402,8 +402,8 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	for (sp = buf; *sp; ) {
 		char *ep;
 		int more;
-		for (ep = sp; *ep && *ep != '\n'; ep++)
-			;
+
+		ep = strchrnul(sp, '\n');
 		more = (*ep == '\n');
 		*ep = '\0';
 		handle_attr_line(res, sp, path, ++lineno, macro_ok);
-- 
2.11.0.483.g087da7b7c-goog

