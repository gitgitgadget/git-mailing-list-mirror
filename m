Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60E5E203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 15:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755854AbdGXPlP (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 11:41:15 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32909 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932666AbdGXPlH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 11:41:07 -0400
Received: by mail-pg0-f66.google.com with SMTP id 123so1471005pgj.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SBhlTwSbLGvfSqnrcQDVDu+4C7TgF63hqT+2B8QOgJ0=;
        b=pq7VfjuyM6AXwwdkjaOZArjio5z5BF9JwDaZ0Jso3+H1l4y1Jp/fdezneBco+gT21y
         x/uuHRiTuf/OcnGI2LDlX0XOfNOnPq7lt+d1G45r7ql9BLiKp6qNcSAJi7lAXpCoVkfI
         LGR6l/4ChloA6Ravlwo9f5C7lTJwtrOoA7RXhtqGNS9jTmtwf5PpYdQUg5SiumUWseTo
         O9uLnW12N+nS2gk4ihpfN9hF2OI1REG0pm4QdT3nFTEdzRlwYE0KeBXH6yrRTAwnnCiU
         YkVZ8kSC8WljXhTw3kcy1QhBWsKS5HbKXe/g3rm28A1tiydl69M6l6FytzIECu30+ImI
         Hi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SBhlTwSbLGvfSqnrcQDVDu+4C7TgF63hqT+2B8QOgJ0=;
        b=Pz6Y3x9YIAOGK0YUQf2qC86yXXssEPAp1AyDK97fixMJciVeaGWYP8kWcSs1aUuoxW
         OVq0D5ljB881+6NDrwNah/3kZGbac26H538LqC4jMbX8azTpeNfBK3GUB4OKyKxb4c3F
         GlEvTZfO+4s0CubXe9AUVzITQ+Z8dpR0206wmS3eo3koxk2wtc4qMaGYZXBUo0huCnCz
         eqC4hoUxVfV1OsM9+QZZKZUtIwyM0EzohdCXB6wUKr1EJd4agguBxXwNeb7j71VXxukx
         TIIR0kn94yj53JTHLQPHnpD0YuUwHzLsq9DAXzPx7gXT3jQPUvDncb8f8Y5h44vMzX8P
         e+Og==
X-Gm-Message-State: AIVw113r/oK2JKaVde+Yy55vrM+wB+mrFwDEF1ijENAitSYUBpXOwNbL
        4bCVmrx+GX2v07zap4Q=
X-Received: by 10.98.71.203 with SMTP id p72mr16869556pfi.106.1500910866594;
        Mon, 24 Jul 2017 08:41:06 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:728c:b841:29d6:b2a9:b53c:f664])
        by smtp.gmail.com with ESMTPSA id c191sm25508626pga.15.2017.07.24.08.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jul 2017 08:41:06 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH/RFC] branch: warn user about non-existent branch
Date:   Mon, 24 Jul 2017 21:11:19 +0530
Message-Id: <20170724154119.2926-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.23.g14d9f4c6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The inexistence of the branch trying to be renamed wasn't checked
and was left for 'rename_ref' to point out. It's better to do it
explicitly as it leads to unconventional behaviour in the following
case,

        $ git branch -m foo master
        fatal: A branch named 'master' already exists.

It's conventional to report that the 'foo' doesn't exist rather than
repoting that 'master' exists, the same way the 'mv' command does.

        $ mv foo existing_file
        mv: cannot stat 'foo': No such file or directory

Further, there's no way for 'master' being overwritten with 'foo',
as it doesn't exist. Reporting the existence of 'master' is germane
only when 'master' is *really* going to be overwritten.

So, report the inexistence of the branch explicitly  before reporting
existence of new branch name to be consistent with it's counterpart,
the widely used, the 'mv' command.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 I'm sending this patch as I didn't want to leave this thread
 open ended. I'm not yet sure if this is a good thing to do.
 This patch is open to comments, as the prvious ones I've sent
 have been.

 builtin/branch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index a3bd2262b..0a9112335 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -473,6 +473,10 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
 
+	/* Check for existence of oldref before proceeding */
+	if(!ref_exists(oldref.buf))
+		die(_("Branch '%s' does not exist."), oldname);
+
 	/*
 	 * A command like "git branch -M currentbranch currentbranch" cannot
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
-- 
2.13.2.23.g14d9f4c6d

