Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2AA620958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933321AbdCWWeT (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:34:19 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36626 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932811AbdCWWeS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:34:18 -0400
Received: by mail-io0-f172.google.com with SMTP id l7so6832659ioe.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uSm/aJrfjymxP+60udetLmY0ZmvtCISssK68/NmQRgk=;
        b=FL5vPsyWLR7ypoqIVuZomLzl6CM/Vmg9hif47IZKA9Lnctd2g8hsWRTByFxKvWvJOA
         Bbue0/CCzNukNw1GTQ4HlaxuwE1BYp6/q7zRIn2X2lqwZMX/fThnqrhb3PNSoF+y4WO/
         lyLQT+x9HoAfFzzYl3oqdcOa8DAMG3+d7ACGjeMFf9cKwo34CqEDnXObK1woThwjnc8y
         wvVpfqtYsvaRu9q3iLOGmb5banZ0vRsZazFwHAsoojanPyPwmNMmJbDjVUBpq+p/LFTE
         8x8Rb3IcHx5IiqWrIIXlwpxYewGMLKV0/OXNNLy8ys9RdupFtN3VD4t2qwLZVRWmpwyk
         outQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uSm/aJrfjymxP+60udetLmY0ZmvtCISssK68/NmQRgk=;
        b=B8Ytx3o3DKLh7C7hxaoGnaLjowVTtRORc7U8lgN+OF+iE3uYOcZizetWrkARC8RlAg
         4+qpjo9/RUFhKOV7XklkzmkZ4m1mu89fCw/JpMucszM6eAFGgTwitiWQKFcykpL/m03W
         /yZNT3G4yGudUwMVyveDNmNnhfij0Ozk7X76c413yX2XQYl3mdM1zfzL7YtbQUgs+7Ow
         PWbat/6WQOEIOL3NBPMcpVH88quhsMJjveRUPLTSwubWpjjX2mCW3gk/9+Z5n/uSCFpc
         ZMuOTEpL4lstX+9VhWWP/4RLt9S++fdN+9M2/4NEtNGsEadpYBpBNSWzq5NFjnQjijJF
         YU4w==
X-Gm-Message-State: AFeK/H0WKTHMPJZEkSoDrzRzUA0ywNmQpBIf2AwKxn75EjF//hE9jv4hT0jvpbdmsRSsAzwA
X-Received: by 10.107.15.163 with SMTP id 35mr5001585iop.204.1490308457290;
        Thu, 23 Mar 2017 15:34:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id a22sm9543itb.29.2017.03.23.15.34.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 15:34:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/7] submodule.c: factor out early loop termination in is_submodule_modified
Date:   Thu, 23 Mar 2017 15:33:35 -0700
Message-Id: <20170323223338.32274-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323223338.32274-1-sbeller@google.com>
References: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
 <20170323223338.32274-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier for a follow up patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index da1db90dda..93d6f08b50 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1072,16 +1072,14 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 
 	while (strbuf_getwholeline_fd(&buf, cp.out, '\n') != EOF) {
 		/* regular untracked files */
-		if (buf.buf[0] == '?') {
+		if (buf.buf[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-				break;
-		} else {
+		else
 			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-			if (ignore_untracked ||
-			    (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))
-				break;
-		}
+
+		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
+		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) || ignore_untracked))
+			break;
 	}
 	close(cp.out);
 
-- 
2.12.1.438.gb674c4c09c

