Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 921602055E
	for <e@80x24.org>; Thu, 26 Oct 2017 01:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbdJZBbe (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 21:31:34 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:54481 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbdJZBba (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 21:31:30 -0400
Received: by mail-pg0-f65.google.com with SMTP id l24so1397067pgu.11
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 18:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=afiu2a1GeQRq24HGk0m02EGrqVUC+IFBZzj/o74JCwA=;
        b=DQF+MpCtcpYvZavrXbNGAx2BceaJ9bZ6s/23xhKlAJn1Z25D7NAueQQ14mXfj3lZph
         wDSBJBRsc/gPAiWfwg0oijrZO1tH+IxDQMI0NBRl/P0SPDnNIww5s+G4ERjg4+mPhVem
         jPCojzn40Gv95zyv2yH50yVzkpgBBJfJo+i5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=afiu2a1GeQRq24HGk0m02EGrqVUC+IFBZzj/o74JCwA=;
        b=KQ4sEaCc2m7qTwkxyXu7B+KTAUwP30xQkvl90aXWSu87D4gg/NwjLphmo3PKcr84OG
         8Ql4hDMj+6Jrkxh8SbCPlPHVQuaaAWZP6rWOoyeocvk9VGUmNLheMbmoB8zr5hVDnymv
         aXjPGxUqCO9dH8uv2pdhmFwlJKjTWg6FEfkpl4jH6nlEvtzsLEosXIeq7IiGdzs+VQCO
         wJB1pn8Ke9w0kP2XmY3fa9vmeoSS6KeeSfIrXJQoCq8TC82BHMoWZ+e6oXn1Un5J+/cw
         6HvFUN9V6fACdSwM+CnPVKwGohBYzU1GTc2yef5dFutgTaAR37KTGz3UY+8GYSqqh50j
         hXnA==
X-Gm-Message-State: AMCzsaVbPX5Tbv71DPgqzovm7E4I9xmZZ4tf4xA/QgHYq5y+AbLB3Ipr
        UOjeK+JcuWzuTUMQ/H1u6w+yrvq/SYk=
X-Google-Smtp-Source: ABhQp+SQeWz4P16YwmQzYBrk6lR1JJlUhOxJoJEYbvGRbweClC/wLVbRJa28ppTZNt0B/VMQUmzHjg==
X-Received: by 10.101.69.137 with SMTP id o9mr3524009pgq.127.1508981489867;
        Wed, 25 Oct 2017 18:31:29 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id s3sm8159206pfk.7.2017.10.25.18.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 18:31:29 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v2 1/4] fsmonitor: Set the PWD to the top of the working tree
Date:   Wed, 25 Oct 2017 18:31:14 -0700
Message-Id: <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
In-Reply-To: <20171026013117.30034-1-alexmv@dropbox.com>
References: <20171026013117.30034-1-alexmv@dropbox.com>
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
index 7c1540c05..0d26ff34f 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -121,6 +121,7 @@ static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *que
 	argv[3] = NULL;
 	cp.argv = argv;
 	cp.use_shell = 1;
+        cp.dir = get_git_work_tree();
 
 	return capture_command(&cp, query_result, 1024);
 }
-- 
2.15.0.rc1.413.g76aedb451

