Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970C11FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 05:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753511AbdBHFOo (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 00:14:44 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33748 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbdBHFOn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 00:14:43 -0500
Received: by mail-pf0-f196.google.com with SMTP id e4so10792569pfg.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 21:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=zZ2b3l0wgutX76Fb5FSoCnaeKWizV6d2e4k+6ZXQhVY=;
        b=fQPf5tg9fWVSSFW7kwk2gM30BsgQ9cAXcGYWPCC5XErjHLk1FxPD5h31sk99NM9DpY
         ouLckry0mVY0M8bPK9Zbihn+L3vFm9wD6s9cHcONc6MAMMVA/q43d96aCrKZXi+E/8Tg
         J4EU9IMTuJ0aKIDKwMQJzvuLlCMgw42yu/jE48IlYtfZWLGBtW5RFA0Kwx5U3gruhaII
         Yxoeo0c56PcK46AYyokDJ73kxpZJEZvJqQN3cvJ6WDAhUR+ey5CnMJOyK8LV/pMI8yiL
         677YE/clSQZuTXVPvn88g1heIgM5gpN/4UXEQZCiTNv2p51vksxiU66wPDWGDRtc16+q
         Ej0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=zZ2b3l0wgutX76Fb5FSoCnaeKWizV6d2e4k+6ZXQhVY=;
        b=EKWmzrCuYJugfAEfgS9D+uGruGPyveZaa6tjzZeDSWWbqti0O30jQeWpESTrWNVGpZ
         UDLyDiSEXjOwsV90KgJvvuyO1ba4kjfIIEP0ua3rfykpm3iht/yv53RPXJ2hWsqUQDyY
         I337HLYD0kN7Rtcsbydoga+F8q7tpGho+5tq4toW2Vg5GGk2Lf2/nHuPxg2YzTRKtpau
         1BlRBE4RR5mDDQrSobKzaBlECzBP0yx5UI+lq1+u2973tz6k3JFjLfzpFoGcS77VwNNh
         zhggkHt7MmVUOGx6ghf8XUXbKen/h+koP8Ky4I25HZ8K+wAyRoWFIwjario7e6YRvVwz
         y/ew==
X-Gm-Message-State: AIkVDXIy0X2zthMAzSEdXUfE5pDcCTM+lV8S/IefwQ5HhgGPABUGaJmBu/Mw6r0V2UITpw==
X-Received: by 10.98.211.220 with SMTP id z89mr23805844pfk.3.1486530882665;
        Tue, 07 Feb 2017 21:14:42 -0800 (PST)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id n73sm15768137pfa.9.2017.02.07.21.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 21:14:42 -0800 (PST)
Date:   Tue, 7 Feb 2017 21:14:40 -0800 (PST)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/2] pathspec: don't error out on all-exclusionary pathspec
 patterns
Message-ID: <alpine.LFD.2.20.1702072113380.25002@i7.lan>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Feb 2017 21:08:15 -0800
Subject: [PATCH 2/2] pathspec: don't error out on all-exclusionary pathspec patterns

Instead of erroring out and telling the user that they should add a 
positive pattern that covers everything else, just _do_ that.

For commands where we honor the current cwd by default (ie grep, ls-files 
etc), we make that default positive pathspec be the current working 
directory.  And for commands that default to the whole project (ie diff, 
log, etc), the default positive pathspec is the whole project.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 pathspec.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index ecad03406..d8f78088c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -522,7 +522,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 
 	pathspec->nr = n;
-	ALLOC_ARRAY(pathspec->items, n);
+	ALLOC_ARRAY(pathspec->items, n+1);
 	item = pathspec->items;
 	prefixlen = prefix ? strlen(prefix) : 0;
 
@@ -546,10 +546,16 @@ void parse_pathspec(struct pathspec *pathspec,
 		pathspec->magic |= item[i].magic;
 	}
 
-	if (nr_exclude == n)
-		die(_("There is nothing to exclude from by :(exclude) patterns.\n"
-		      "Perhaps you forgot to add either ':/' or '.' ?"));
-
+	/*
+	 * If everything is an exclude pattern, add one positive pattern
+	 * that matches everyting. We allocated an extra one for this.
+	 */
+	if (nr_exclude == n) {
+		if (!(flags & PATHSPEC_PREFER_CWD))
+			prefixlen = 0;
+		init_pathspec_item(item + n, 0, prefix, prefixlen, "");
+		pathspec->nr++;
+	}
 
 	if (pathspec->magic & PATHSPEC_MAXDEPTH) {
 		if (flags & PATHSPEC_KEEP_ORDER)
-- 
2.12.0.rc0.1.g02555c1b2.dirty

