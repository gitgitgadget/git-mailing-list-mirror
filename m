Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578CDC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbiHITJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345226AbiHITJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323EE220FE
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l4so15268994wrm.13
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FV1BT2+eT/x2XQS8lK21txyXDhDJgU1I8PQ/6zob1zM=;
        b=qUVpsJ2FFXTRhnMGHlboZ7CN6Lp/f+v8qWCa96YQP0F+/2/RyLeaXc2Hpwp1DsXV51
         UbfSB1fMcSPsUSunmrUDyErbXrLnfi/iSFpD4za3Du8KCIICEkjUP+HNd9bsboLMyfAj
         5LNEepotbyFzjST+MViieXxJdrWIRlN2CAaiWLcaUHZI8gOYi0Eio6YNmvW6r0zKtBwG
         Zfiv48ijC3Kny2KiI7HjKplUkyemSO7N7hm6ZRyFQL6QUWNg0KqqwhQpVlJgZvVRewcm
         VTKP2hfu1F2+A9xP0v8fkq+LN/+neaV68e9QPLK6XZZ4iJZSUUxDqO9vjxYhE9SRwAyP
         GTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FV1BT2+eT/x2XQS8lK21txyXDhDJgU1I8PQ/6zob1zM=;
        b=Q5lj71HTqoWEsbLyO57VAXzkX2dIys3IOs//UOw+fazHlUYmdHNKFx6+zQ9C3lZj3L
         8BWYu3cusl3lIOT+jk50mDPc8oWl/GhpY+fFhDjv/wwNqt5a4eOcRH2QuBC2o2gsrqNm
         87eEDq1NSPWHwmqdfU1dgbLKT2/DNrSdcYWi/FkQSzhji/46PaoBfEmvu4X2tlxU1h6W
         vFopfLaPyaQ8R9+vvt5Ck6/gAkoazCbV9KFNJtUqkjs9FTUz2WT6klgW4NK3TpU58FB3
         4du4a0pOmJwwNajNksmZZhZw+j9wCsT6lY6VE1j4QbPdjrXNcP3QWXrF50KXVWUO1u7b
         wcLQ==
X-Gm-Message-State: ACgBeo30HqLdELMTz+e0fjnlfRuONAEFPfhCCe4bywvOWXWYKPQEJL4b
        0UeRk/8EZ4TIdNEyuVCWnIp2KIYgONg=
X-Google-Smtp-Source: AA6agR4fHmAUnEn42SMMXtqaa+qqV6KD+yuW7/8SRRU9m7UeX4ApVJtryVkPjmlj76HoGj8kL3bbWA==
X-Received: by 2002:adf:f286:0:b0:21e:f0dc:3df0 with SMTP id k6-20020adff286000000b0021ef0dc3df0mr15365419wro.377.1660071333830;
        Tue, 09 Aug 2022 11:55:33 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:33 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 11/14] merge: use the "resolve" strategy without forking
Date:   Tue,  9 Aug 2022 20:54:26 +0200
Message-Id: <20220809185429.20098-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index f7c92c0e64..0ab2993ab2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -44,6 +44,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "merge-strategies.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -774,6 +775,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
 		return clean ? 0 : 1;
+	} else if (!strcmp(strategy, "resolve")) {
+		return merge_strategies_resolve(the_repository, common,
+						head_arg, remoteheads);
 	} else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
-- 
2.37.1.412.gcfdce49ffd

