Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABF681FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 00:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935968AbdCYAgc (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 20:36:32 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34544 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935906AbdCYAgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 20:36:25 -0400
Received: by mail-pg0-f44.google.com with SMTP id 21so2662869pgg.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 17:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xyeLuyoVNQ7uho1F6OBrtzeS977nVLH8f+z6WvVwofY=;
        b=A92t3mKmJc0yGq+OJi+wwIRFbIrlMsYHWCkyn8TEaqjr2vIlsDKaByRfq713URymbw
         g+Gz83fkCWRgzS5tIwCnbcPWinJkedJAiU+RDE3MrBKwqQYhYH6NmuqCKBCMmODwoJoB
         ms3s286Ofi7JRTP9PtnfztymO92Vu6mLnCDADITztpTyjMqttAwCdaGGnhXIVBY2ZAKp
         ++hzQqsKNIIu2ZXiULYjn9ybWKWiQ+flgp3RnHjvo8ARbE/WS23qR2AwzbNwxlbMen6z
         6jYkOoBL5mzmlyPKfv6Ra3bkdWlHDCXOckj6qGWDabQcCLwNQ4BZYX0PuYgEh+mqhbxx
         6Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xyeLuyoVNQ7uho1F6OBrtzeS977nVLH8f+z6WvVwofY=;
        b=L34DGIeX6/6dr55sz3MEIRT/mgbCN/CBf2H+LO6MR5Q4RSWATHPVi0ku7M5fx3S68q
         IkrarBRvs0+SfAzMIPGThmWosJ8Xl6R6AXFZMmWSsA0G9a/xhuk63jGrDb5UAfDUpgMm
         Gs12wcgzm7ma6H5/zYuf1RbSDPEhe8S7d0w6j4P0RRjwMKQVubdx5I8Y3undz1mTUxB1
         DEWdW5JoHbffYXEgZyqx6pUAMKiBQ8c+m4SYe9znlmcc1SFYFZu41EVC8kzABfl1jPqm
         JtnZ6jmoWU78O1w8KZaMgZdhXGR7x0+MiPhghPJ52gSkD+tYfW4BQFaPHsjV1n+daRuR
         ngEQ==
X-Gm-Message-State: AFeK/H18Jse2qmNYWxdLPPbq7+QKHcn88Dpw9iex4WpSpLeGZQV31m6bMR+wBjV/jLkvMQZM
X-Received: by 10.98.141.82 with SMTP id z79mr12268702pfd.20.1490402183703;
        Fri, 24 Mar 2017 17:36:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id 90sm6769432pfl.24.2017.03.24.17.36.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 17:36:23 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/7] submodule.c: port is_submodule_modified to use porcelain 2
Date:   Fri, 24 Mar 2017 17:36:07 -0700
Message-Id: <20170325003610.15282-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.gdeb397943c.dirty
In-Reply-To: <20170325003610.15282-1-sbeller@google.com>
References: <20170324182902.19280-1-sbeller@google.com>
 <20170325003610.15282-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate 'is_submodule_modified' to the new porcelain format of
git-status. This conversion attempts to convert faithfully, i.e.
the behavior ought to be exactly the same.

As the output in the parsing only distinguishes between untracked files
and the rest, this is easy to port to the new format, as we only
need to identify untracked files and the rest is handled in the "else"
case.

untracked files are indicated by only a single question mark instead of
two question marks, so the conversion is easy.

Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 submodule.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index e72781d9f2..5865795b9f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1060,7 +1060,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	}
 	strbuf_reset(&buf);
 
-	argv_array_pushl(&cp.args, "status", "--porcelain", NULL);
+	argv_array_pushl(&cp.args, "status", "--porcelain=2", NULL);
 	if (ignore_untracked)
 		argv_array_push(&cp.args, "-uno");
 
@@ -1070,11 +1070,12 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	cp.out = -1;
 	cp.dir = path;
 	if (start_command(&cp))
-		die("Could not run 'git status --porcelain' in submodule %s", path);
+		die("Could not run 'git status --porcelain=2' in submodule %s", path);
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
-		if ((buf.buf[0] == '?') && (buf.buf[1] == '?'))
+		/* regular untracked files */
+		if (buf.buf[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 		else
 			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
@@ -1093,7 +1094,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	fclose(fp);
 
 	if (finish_command(&cp) && !ignore_cp_exit_code)
-		die("'git status --porcelain' failed in submodule %s", path);
+		die("'git status --porcelain=2' failed in submodule %s", path);
 
 	strbuf_release(&buf);
 	return dirty_submodule;
-- 
2.12.0.rc1.49.gdeb397943c.dirty

