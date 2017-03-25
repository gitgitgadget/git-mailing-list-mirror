Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D5B1FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 00:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936656AbdCYAgl (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 20:36:41 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32970 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935889AbdCYAgb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 20:36:31 -0400
Received: by mail-pg0-f46.google.com with SMTP id w20so2676689pgc.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 17:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4qXztpdEtIDFYGB7u9F0avxEzDyFmfNwFXiQqwI3OmM=;
        b=qviau0N1bf/tux9k5Gc8cwOz6oFj8vvorfJjOcgVT9XZVBKjgQI1H0PHo7fvIZe7+f
         BmyZSr3wLOMSR4hCe/+BpjdmOBEYff9jcb7s3tH6CaxOrI33NNfzAhom4FIevTPJAi6d
         1SzzJrcrJVunB5wZGPUncgO90J5akWi3IDWOfx99eb538SoF13qxXW8ZsAELj0+2qz1a
         tFiRJZclZHHB1Uwf7Ad2zDeLnNOQa9Z3BEUWgPnKgZWkWYDuOwDWvbI3nID4E/s5jP6C
         473NKsfLifXMs0mWsD7uodFC7WgwVQFSgf6os789AjcFAK4NTWcOVsOx2Z9WDwzPcoEN
         c2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4qXztpdEtIDFYGB7u9F0avxEzDyFmfNwFXiQqwI3OmM=;
        b=HwoflhiT6OLlRCE3M6x+QB3gXvKAj/qUeF5KFx8vSyR2WxRZQP4pQBB8gQB5T3RXou
         KHBRzIJFnR2kVgBpV8v6FXEZJp6pa6JhHqdhxE2Gk1M9qKrZgPtzBDsHGZyGkD3f24dy
         IBSKkp1QVhGXDk2Jg+4H/NG1+r2A03vdbbKYb08p8Y6j8j2ls8k36ouJ7lEq9OTcy094
         OE0dGqrmkv4xeWeO3LhC4Rc3KVNK3hPNL7m2NIyzDIuAE01FW5+0znRYNmVui1eXv+lY
         W35oNu4cvwRizCcbUiSDZwpCDCEbAC+S8Qp24pZsE5RyuqdflKFVg4CKCmhv9OlgpEvU
         KP7w==
X-Gm-Message-State: AFeK/H3JEs7R3LMKIwXKGEGx8gVQ/LJixqaisYZQCRNQWREcqwLVUfyE3pP9EKAQGDHMjbI2
X-Received: by 10.98.144.69 with SMTP id a66mr12932563pfe.30.1490402184769;
        Fri, 24 Mar 2017 17:36:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id m194sm6723416pga.62.2017.03.24.17.36.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 17:36:24 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/7] submodule.c: stricter checking for submodules in is_submodule_modified
Date:   Fri, 24 Mar 2017 17:36:08 -0700
Message-Id: <20170325003610.15282-6-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.gdeb397943c.dirty
In-Reply-To: <20170325003610.15282-1-sbeller@google.com>
References: <20170324182902.19280-1-sbeller@google.com>
 <20170325003610.15282-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By having a stricter check in the superproject we catch errors earlier,
instead of spawning a child process to tell us.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5865795b9f..fa21c7bb72 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1052,11 +1052,12 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	git_dir = read_gitfile(buf.buf);
 	if (!git_dir)
 		git_dir = buf.buf;
-	if (!is_directory(git_dir)) {
+	if (!is_git_directory(git_dir)) {
+		if (is_directory(git_dir))
+			die(_("'%s' not recognized as a git repository"), git_dir);
 		strbuf_release(&buf);
 		/* The submodule is not checked out, so it is not modified */
 		return 0;
-
 	}
 	strbuf_reset(&buf);
 
-- 
2.12.0.rc1.49.gdeb397943c.dirty

