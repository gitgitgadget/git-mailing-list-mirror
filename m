Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74311C25B06
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345858AbiHITJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345305AbiHITJM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA06D2528E
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v5so6750782wmj.0
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gTVrfw6c+DAIGXClzrasR9FDs8MgAeUuIjvq4B7+jUM=;
        b=LkpaK6owA14Z3VxapQjMuDRcbkc+z1FJdgaslqpxlCvbsiMDMMq/FzCAyNk3nN36Ee
         cMU+JBXK0yrQVcMo9nEMdy1AxSaZFA1x2TqYsN4TSxGcfFaY9XcpYBvI8QuNdYI708/G
         ssdykP8D7mvwebiJuWHZ1yWLzomM7bNsjMchcEp3Mqfs0zMYIQM9/eu6MF19Ki3/WO0k
         SawfmW/KWFHCyvjpTf3EGmBq6zwGpiQlryUBUP1U9wx3KJSqzJS75GfhDXEMGTWyAWyc
         F/xuEdec2obI9dZ/lvLzUSfdt2Dwuk4lGpTMbS+weYDDH1a20sjfw+PJJLeNtZW2nW1a
         Gt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gTVrfw6c+DAIGXClzrasR9FDs8MgAeUuIjvq4B7+jUM=;
        b=6bcRQbRS+9e/8sDHPxai5OX0j7mDavo4I4TTjG++r49S/C2oawRJMJ6t+JHOBUuByy
         xfNDTqX7rSz0V2NKizQXVs1FoD4atgXlqTggLEiKdYQq+c68cBHZDAplQCX5YO/2BBJ1
         Y/8tj2b8zHH1JU56bNv6cbELqNJvj6VA/JyyneFNLKnX0j1UiTjFTkrcj6UW/GtKhA/l
         /pN1UnvEgt+ODYEfANjEwDa1YXuSnyw66w1q+BzMuCQDyrrLitX1c2YVmggODbMp3BU2
         fMdli6Ec6kVBeXYufoDm+2l5h+y1lKiPzmv1yciMEb6FS0tnefGkZ0xFD5f3KBTAJqjq
         +Ozg==
X-Gm-Message-State: ACgBeo1na7HoWqr5qpH75vFMLH+avZD9S4xiYjVRqogst8AjYiJhsUsj
        NAsCC5OTKWKMEeMRjft4QR0tlCMJFFc=
X-Google-Smtp-Source: AA6agR7sSMskizppOnWdZ+3ZOA4UqRB0Six+490TIYHhMuFuOlNomufAvrYM9HFhcSdsZYvvaIwMow==
X-Received: by 2002:a05:600c:35c5:b0:3a5:664d:c556 with SMTP id r5-20020a05600c35c500b003a5664dc556mr2824446wmq.22.1660071335293;
        Tue, 09 Aug 2022 11:55:35 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:34 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 13/14] sequencer: use the "resolve" strategy without forking
Date:   Tue,  9 Aug 2022 20:54:28 +0200
Message-Id: <20220809185429.20098-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5f22b7cd37..0e5e6cbb24 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -37,6 +37,7 @@
 #include "reset.h"
 #include "branch.h"
 #include "log-tree.h"
+#include "merge-strategies.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -2314,9 +2315,16 @@ static int do_pick_commit(struct repository *r,
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(r, opts->strategy,
-					 opts->xopts_nr, (const char **)opts->xopts,
-					common, oid_to_hex(&head), remotes);
+
+		if (!strcmp(opts->strategy, "resolve")) {
+			repo_read_index(r);
+			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
+		} else {
+			res |= try_merge_command(r, opts->strategy,
+						 opts->xopts_nr, (const char **)opts->xopts,
+						 common, oid_to_hex(&head), remotes);
+		}
+
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
-- 
2.37.1.412.gcfdce49ffd

