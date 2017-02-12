Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C3C1FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 18:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbdBLSlh (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 13:41:37 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36045 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdBLSlg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 13:41:36 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so7596682pgf.3
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 10:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R8/161n154qkRfo7ezyAfnQNUTgZfu1CuEjYviHpuD0=;
        b=YyGa1wg3MDd+q3EyosyE6nwAOfWOZrGldrvEIlxli94vrhrycv83ed7C5sVA+tqLtG
         eMWR5dKG9cznm53WESZKQdvix8srzWOoAmXDOuAilfldhpertnrr2I3wMOeUCpwYQTvq
         hunhLXwx62ehZTuVYI4YJCE+PY8Ns09aXDJ1Cr6Soa96ZeNn01JRF87lOLIR/Tf5rajq
         mIEnnS5tLS41i40FvhT1C7Xl+uish+vQRVpecZMTokofEsimwrJzZmf9MSZ0a7iE64H5
         n4HdBU38AnUWG0+PGOZhL5WgKdcKsL7/gdXr1DQaF6O+ePj8hVLelJ4vSzf7Cw+x6MzJ
         +qVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=R8/161n154qkRfo7ezyAfnQNUTgZfu1CuEjYviHpuD0=;
        b=LhmBwlW2uqzoo7h2D2GUnDmSdHm+o/Yrl1K3Xp4RvXo/DwYnwUn1OJ994+JmApR3zR
         SZ6s0rNMJ6Ea4Bukdmw0rILdboBY8XkRyKQY5OJnmoL2p2Qr980yBDBwNlkxQDfFvk2U
         8R+AZ5sXMQDYSwFHAk4dhn7Gn/didVV8rQTsZ0vwEAReRCv0olGtpbUWGvx6B6B+C0po
         WoXTdYoGxLF+diJEJUmjprPZIntpZOZ96uCfZA4l6UKKHL6f2VltMlh2p/oKVxWZB1aE
         rsOepz0z5C3FNskNIXr4W4+R8WSLynfTgYmEv3eNTdQKTqL5Fwl6G6I4Fi8k3ld/A7Xy
         JkUw==
X-Gm-Message-State: AMke39k+cjjQfhsiloG4u2PAH/7V1Ys1CuqWe4mtFhbUcl7jtGvyCcTCtExSWu0RonAOnQ==
X-Received: by 10.99.158.2 with SMTP id s2mr22365198pgd.116.1486924895215;
        Sun, 12 Feb 2017 10:41:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:644a:2999:a3b7:74ee])
        by smtp.gmail.com with ESMTPSA id u129sm9991085pfb.130.2017.02.12.10.41.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Feb 2017 10:41:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 1/3] handle_revision_opt(): do not update argv[left++] with an unknown arg
Date:   Sun, 12 Feb 2017 10:41:30 -0800
Message-Id: <20170212184132.12375-2-gitster@pobox.com>
X-Mailer: git-send-email 2.12.0-rc1-212-ga9adfb24fa
In-Reply-To: <20170212184132.12375-1-gitster@pobox.com>
References: <xmqqa89sguu4.fsf@gitster.mtv.corp.google.com>
 <20170212184132.12375-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In future steps, we will make it possible for a rev or a revision
range (i.e. what is understood by handle_revision_arg() helper) to
begin with a dash.  The setup_revisions() function however currently
considers anything that begins with a dash to be:

 - an option it itself understands and handles (some take effect by
   setting fields in the revision structure, some others are left
   in the argv[left++] to be handled in later steps);
 - an option handle_revision_opt() understands and tells us to skip;
 - an option handle_revision_opt() found to be incorrect; or
 - an option handle_revision_opt() did not understand, which is
   stuffed in argv[left++].

and does not give a chance to handle_revision_arg() to inspect it.
The handle_revision_opt() function returns a positive count, a
negative count or zero to allow the caller to tell the latter three
cases apart.  A rev that begins with a dash would be thrown into the
last category.

Teach handle_revision_opt() not to touch argv[left++] in the last
case.  Because the other one among the two callers of this function
immediately errors out with the usage string when it returns zero
(i.e. the last case above), there is no negative effect to that
caller.

In setup_revisions(), which is the other caller of this function,
we need to stuff the unknown arg to argv[left++] in this case, to
preserve the current behaviour.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index b37dbec378..4f46b8ba81 100644
--- a/revision.c
+++ b/revision.c
@@ -2016,8 +2016,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->ignore_missing = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
-		if (!opts)
-			unkv[(*unkc)++] = arg;
 		return opts;
 	}
 	if (revs->graph && revs->track_linear)
@@ -2234,6 +2232,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 			if (opts < 0)
 				exit(128);
+			/* arg looks like an opt but something we do not recognise. */
+			argv[left++] = arg;
 			continue;
 		}
 
-- 
2.12.0-rc1-212-ga9adfb24fa

