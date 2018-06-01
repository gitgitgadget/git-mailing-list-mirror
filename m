Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DD9D1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 20:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbeFAUB4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 16:01:56 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33191 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeFAUBz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 16:01:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so1457439pfi.0
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qCb8VfFVx8fTREcnMv+r0Yh5ID8g4bJouiFjf93WUH8=;
        b=nqzomN9X9d5Gl9h0upD9WBGnJ/TzH4ynZfv0iGwrqDPSNkMhYxaZQ3yFzCIFZYEgA7
         OluraZNpDMZl8tpZdLCsq9563OVBFxIMHCWRDsIb9QPuesg9ZW9ez7HWyi0WodYQVYl4
         0C/k3tquPVcZVF6lFOS/0e8Cug7dsdkFnypuQYJcMVwc9RNIzZFK88Dp3QYo4ic3EfiU
         7WmcMHQTK1hxvdWoeCcVXt+EPk1mW0RSYqjWZKLCAYRMPO3yZQxyToyLYqulRwIPdfrr
         ZqY/G19RKCvGyWLWqQMOx5UEslK136MsPpwIxMYS3xJ131LW+6jzEeWz+X/FSt1HAa9D
         sBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qCb8VfFVx8fTREcnMv+r0Yh5ID8g4bJouiFjf93WUH8=;
        b=Qh43rQAmZOv/mGQfOnd9OznwSdrKgQzpi4zQl0nK97WsVjSgyWnf4n0Ml8YyadNLRN
         LMfEUq9lc0xKY39F8PAiLXXCaX8QHs9gj6Hoo9JcRDXvBHxx9Eb3yhLiORNDewNxpklm
         4FgzxtmOCDTwtWra0VBW0lxs1n1kh6F5RyT1Jc406Ucw0CtK6uglFRFY//NHJhs5SVGO
         hgtx48YIpZKiQpP0tSEEvl995F3V3gy6nYeuAvKfLDi7EsJvpBiE2PmkWEHnaBpeFPYb
         eDUJuqRvf8gESq/aQD6bxcPetvR0NP6L0Xsz5/72fs7gMszCB86nQJRzUGTyOCMVEBcf
         m8zA==
X-Gm-Message-State: ALKqPwcE6gbMQBAEhJv9TWJv4uooOc+OYK9UCuOvSfAhtoZDLGAz5gLd
        jsJos2VQWWrX/15rpXxV+GLDrqC5wbA=
X-Google-Smtp-Source: ADUXVKImQ17Q4VXohunbxYMF3DGGHu/m0iejUsqxHO/UqeKu+If0+9LyEUAZD0j7ue99Dkj+8KKRrA==
X-Received: by 2002:a62:568f:: with SMTP id h15-v6mr12189874pfj.131.1527883312737;
        Fri, 01 Jun 2018 13:01:52 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k84-v6sm44616709pfh.110.2018.06.01.13.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 13:01:51 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] sequencer.c: plug mem leak in git_sequencer_config
Date:   Fri,  1 Jun 2018 13:01:46 -0700
Message-Id: <20180601200146.114919-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180601200146.114919-1-sbeller@google.com>
References: <20180601200146.114919-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index b98690ecd41..aba03e9429a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -175,6 +175,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 			warning(_("invalid commit message cleanup mode '%s'"),
 				  s);
 
+		free(s);
 		return status;
 	}
 
-- 
2.17.0.582.gccdcbd54c44.dirty

