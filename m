Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A6520370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbdJEUdH (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:33:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52619 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbdJEUdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:33:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id k4so4406351wmc.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eqN+8W8UU6Y63bcjuSNet5caA254MGuSKwClbb5VExk=;
        b=LWJNu+869nFQxB+4klBLERjNrM1gkiwsu/XgXQjBhu1YR/Lq/oHzo8HsDjhaiDQzBX
         kgJ6awULQd+A/MoCoUHbPJ7UEpzr9cKYfP5PKzYxIW1DNa4V2vIXBgMi5yLw9O0jEFrn
         ve2qQ8Lx4CybRnTKfnaMxq/TSYs2xsMcIwUtx5DjQmsx717C5fe1lk4p57kBRrpIupyD
         V0bR8wXfR8rjkjEtY0T/aTwv2Wemg4giOp3hoDW7HJ7PfgkJsjXEbdS6w8ocRIpN0HoO
         GmaUZzwqwmbE3ILOFJz1sjHVzQ/0dpFYIiELYjxtSI64AMpZvaDeKaiRHK+rFKJiC4yU
         3Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqN+8W8UU6Y63bcjuSNet5caA254MGuSKwClbb5VExk=;
        b=C/PBAZdN1p1ACho8J6qvSXEoumQmlT2BsLqupNYRMs3LvBFXEezZZTlGOVZFyeJe7T
         up6hf2Ct3R0dR0Q9dzBDkj6JKc8jmZyMaZ59z0YzleW6ywC7qqT3meafdPBoUnXXCMpb
         JMJAEW/z46EwYEvlhkKrptWqkLjmU+hr+fKNvMTH7Bq8QapPjEQ3X6VtG+7l5YTuhzHW
         avJxpeUNAg36ZE+XSzK7QmhczttLDDepmmdHhCv5olFgZoEDAzGAR7OmSznMnPkxvdFg
         gER91lV8g+TC3TmgkI1/N4RRcew/uLjYu21OUYj2q7StC13TEkAU2xRiSv7sdDZDLxQw
         Eguw==
X-Gm-Message-State: AMCzsaX6jJD5Iu3RuzPidN/8ZeDuytAJIJjPvfE4xva5L8FYG4Q4IthQ
        g17YJetjQ21bnfwAv2CPnJglfVbA
X-Google-Smtp-Source: AOwi7QA1RvGPAPwVIGWec/aE2mSD6VxXa7aI8f7g41tWAg1y+g2TZ8IHUFLV2MX3eF1DeqtogPMxDg==
X-Received: by 10.28.184.141 with SMTP id i135mr251171wmf.143.1507235581223;
        Thu, 05 Oct 2017 13:33:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:33:00 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/12] read_cache: roll back lock in `update_index_if_able()`
Date:   Thu,  5 Oct 2017 22:32:14 +0200
Message-Id: <1da9447e4c8ea0c1137c97f6122b48c06a95b1c7.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <cover.1507228170.git.martin.agren@gmail.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`update_index_if_able()` used to always commit the lock or roll it back.
Commit 03b866477 (read-cache: new API write_locked_index instead of
write_index/write_cache, 2014-06-13) stopped rolling it back in case a
write was not even attempted. This change in behavior is not motivated
in the commit message and appears to be accidental: the `else`-path was
removed, although that changed the behavior in case the `if` shortcuts.

Reintroduce the rollback and document this behavior. While at it, move
the documentation on this function from the function definition to the
function declaration in cache.h.

If `write_locked_index(..., COMMIT_LOCK)` fails, it will roll back the
lock for us (see the previous commit).

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v2: New patch.

 cache.h      | 4 ++++
 read-cache.c | 5 ++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 0e26224b9..8c2493766 100644
--- a/cache.h
+++ b/cache.h
@@ -734,6 +734,10 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *, unsigned int);
 
+/*
+ * Opportunistically update the index but do not complain if we can't.
+ * The lockfile is always committed or rolled back.
+ */
 extern void update_index_if_able(struct index_state *, struct lock_file *);
 
 extern int hold_locked_index(struct lock_file *, int);
diff --git a/read-cache.c b/read-cache.c
index 0090ab886..92ea5df96 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2176,14 +2176,13 @@ static int has_racy_timestamp(struct index_state *istate)
 	return 0;
 }
 
-/*
- * Opportunistically update the index but do not complain if we can't
- */
 void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
 {
 	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
 	    verify_index(istate))
 		write_locked_index(istate, lockfile, COMMIT_LOCK);
+	else
+		rollback_lock_file(lockfile);
 }
 
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
-- 
2.14.2.666.gea220ee40

