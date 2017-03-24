Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D885D1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753672AbdCXS3R (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:29:17 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36493 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965599AbdCXS3M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:29:12 -0400
Received: by mail-pg0-f46.google.com with SMTP id g2so4874686pge.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eKVkK9Q/hETpJDq289YqXKZ2BVU6nwT02lSKoq3kyCc=;
        b=FeFlUSOczdr2i2wLGuwjA+DQQyvtPI9g4NzXHFDk0aBrAt069H5b+LOTh1Kv1OLgUB
         FsBPtTEA+P7LnYL+W49EqGYBiH6L/p/m7eyhgCImdXlcw4FxHuUk+E+7Joxu1IPUpFym
         JinFCAyZnGcfXh1RqcoCEHa6zxnZoMTQsIK7DwbdF2bDROQ+5m5UQq5tJLpu9cNUtvw0
         MZg2jF4tvgkjy8O0TRqQgRxwjCWBCOkygBtP5pTyOayPXC+hSaN7/kfrOM+Qdm4O/S9d
         5h5LGp662tjChlwIb5Xz+K729RwOhdoiTsGlV00RFMocZpmi7HmRZz+7fhbH8fefNf1l
         jijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eKVkK9Q/hETpJDq289YqXKZ2BVU6nwT02lSKoq3kyCc=;
        b=W1MEYWOCOWXMSFUhC6KYPWNA3Frzo2gpKWCIf4lo4cwcQB82zdGRWhy1HGJGuB4urd
         H/LcLRXixL03rg/JSObW56r8HBkKeEXM0q0ckfXz83HWaO5U6EZcLBqT/AeawKmX+gIw
         PAINNy9MZD6apW+0HbRrZTMrclDvAYs6AWZH+oyJIYnWp9b4CJaP7dmsrDaCbOHPGuMe
         a6Iqfnw11ttIajkOd1KqKT5kStKfUIVUh4fNs17PSYSu2zrlHUfIpgYhLi4LsD2Ef1w3
         fKKUYtf0oqpz7WYxgMM1TzqywJrB20VOQPVclyaRAoFPsZC48ULpq6bFEj7lvm14SpkU
         ceiA==
X-Gm-Message-State: AFeK/H0j2XqvGa+BTco8KE+CAeKlMRRgBAIkd+4Ei/IeG61jHn+3tVXw4vEX9eUqrQvNC03S
X-Received: by 10.84.217.216 with SMTP id d24mr12394838plj.80.1490380150718;
        Fri, 24 Mar 2017 11:29:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id i124sm6021840pgd.66.2017.03.24.11.29.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 11:29:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/7] submodule.c: stricter checking for submodules in is_submodule_modified
Date:   Fri, 24 Mar 2017 11:29:00 -0700
Message-Id: <20170324182902.19280-6-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.437.g2b7623d507
In-Reply-To: <20170324182902.19280-1-sbeller@google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
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
index 256f15fde1..467f1de763 100644
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
2.12.1.437.g2b7623d507

