Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A161FBF4
	for <e@80x24.org>; Fri, 27 Oct 2017 23:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932476AbdJ0X1F (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 19:27:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:54376 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbdJ0X1D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 19:27:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id n89so5945774pfk.11
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 16:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VRZODSFcInv9jt3eq3RalrbnPs/HZlBExYJAxJEwXkQ=;
        b=X5rMbcl+ohMMBKWXMaLKsyc6VBrNd7GeNZaC2SbxnF4WnDYOSv7Itk6wMvaHrMIsqJ
         rs1NOagOUbfHtwrrt3HgSUWdvwt9vGL5ECoQ6g8EZ2rIrOeQp72JTE9JZbDiqwsSQJeh
         cdb++SeisQ9YzlNziVSlhz0Rao4CryYpS362g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VRZODSFcInv9jt3eq3RalrbnPs/HZlBExYJAxJEwXkQ=;
        b=cPop1/bdeIua0uV/YIekesNYYsnlo70RAuIwb9X78rPwBypDNL4rSI7hDC3/KxPmmR
         ygoCgW1tZHNYFT1hZEGxT7ypSFbMuC7lPWC9cxdk9iPpbe8fnSEuU15UbzNYYQWipU4F
         tbS90op5DmwGTfcjKYLeLVSZ4A0jMCviCVSjRfNcXpikRfPuF6Dd1+m/UWEWkPDvIGhi
         CAdd5OF4sROoSaANDDdGYRXl5BM15LCtcclydOkQi62G8CIZB7s9X4QVevR0f2V+eF8y
         REMqeMspI2rGmHzr++SSw/XKlZ/a4PQF7F5ilVdGs3bW4lKLIwLR0oIK9h+a7nFZDK1b
         Ky2g==
X-Gm-Message-State: AMCzsaUh5xHn4gxXVmRc3waghqUa45vd8TcGkMBB4OTP/xsjO5uFcUQN
        cAEvpe+H1QJDWthD5dVWj1q2BSgWFS8=
X-Google-Smtp-Source: ABhQp+T1S5Z11kpz83yHqQKKIqdOqTbE8hKekPi7av7mr85B8qhjqosyLMKUlBCSLYgiYE//WvwGuw==
X-Received: by 10.99.154.66 with SMTP id e2mr1575671pgo.116.1509146822248;
        Fri, 27 Oct 2017 16:27:02 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (Guest-GW2.corp.dropbox.com. [205.189.0.166])
        by smtp.gmail.com with ESMTPSA id i129sm15442806pgd.21.2017.10.27.16.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 16:27:01 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v3 1/4] fsmonitor: Set the PWD to the top of the working tree
Date:   Fri, 27 Oct 2017 16:26:34 -0700
Message-Id: <4b488da5e0710e9699f92d2dabe5e3352f3eb394.1509146542.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
In-Reply-To: <20171027232637.30395-1-alexmv@dropbox.com>
References: <20171027232637.30395-1-alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fsmonitor command inherits the PWD of its caller, which may be
anywhere in the working copy.  This makes is difficult for the
fsmonitor command to operate on the whole repository.  Specifically,
for the watchman integration, this causes each subdirectory to get its
own watch entry.

Set the CWD to the top of the working directory, for consistency.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 fsmonitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsmonitor.c b/fsmonitor.c
index 7c1540c05..4ea44dcc6 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -121,6 +121,7 @@ static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *que
 	argv[3] = NULL;
 	cp.argv = argv;
 	cp.use_shell = 1;
+	cp.dir = get_git_work_tree();
 
 	return capture_command(&cp, query_result, 1024);
 }
-- 
2.15.0.rc1.413.g76aedb451

