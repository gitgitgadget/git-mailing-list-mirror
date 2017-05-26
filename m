Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E93871FA14
	for <e@80x24.org>; Fri, 26 May 2017 19:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944623AbdEZTL1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:11:27 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32863 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938058AbdEZTKa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:10:30 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so19467749pfh.0
        for <git@vger.kernel.org>; Fri, 26 May 2017 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qPAtSxNL9GyTKfRgUZkexn79qglib+hRiGvXuUPw1sY=;
        b=BeO2bT9mf3pDYqsRxPrEP0Qm7iQJExJZXthoVLVXi60l/auYjnTlZVF/L9X35LxpSN
         3ep39jDOYPnr/otuUb6L6eHpxBqKEukN3uuLpweCqNW+/8oW+XOKu4ranFksi5N5J6eu
         DJQ3RC0gX2hHYoYfC2XJPsLISNNxfpL9JpQMbl7yIqz/ERg/J8nhsghgdD/8L8k5Zlb2
         xkeEOshDTmCcQf+/qYaB3FQiKGQgeCwD7RxknvcuiEhaJRtJtAtLM5oeE18SkdgcAtV7
         0b63lN347hoe4mwfG52B/swG+m7FzqkcUByU+5GBT5zDKnYY87FT7uEUEdT3zuNwv5Nf
         /60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qPAtSxNL9GyTKfRgUZkexn79qglib+hRiGvXuUPw1sY=;
        b=J1+J+iGqgM2lpfhsUxumvCqzZoxfzglQvic6fJI5iWugz6BdXlB52yOPRpq8OCx33/
         LT4fkYekxqeO2uxThpcxToaFfbp00mKVf+6R4W7eJmuIRwQEvvz+36t/EWL4Qh39Cg8U
         PVCwASKc++OZ4SEDEXhlpgccVqpUjIGwUH2PihjKmNObudh8syEmEaO4pvBS8MBItMxj
         Ag/XbaqWO72/e8VVo2niuurFCXxcduCfAt1i++R8M7f2YzmcE+VIv8lLu1k4uLjCwUiy
         ZrU2rsLZfJ2kSyka3IJw2QGqtEDLfrpSMhle43n+LeZrCsdh9/k1ENZrM5R0mJtA58wq
         ie/w==
X-Gm-Message-State: AODbwcD/C7wVut4ipGiqzj9uwYmGBg7Q6gFoDBEpyJIehQmqdMBcbvAY
        2nGA7Z5Au/2IV8sx
X-Received: by 10.98.75.6 with SMTP id y6mr4192986pfa.157.1495825829496;
        Fri, 26 May 2017 12:10:29 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:818a:1f3a:57c6:8d29])
        by smtp.gmail.com with ESMTPSA id p4sm5199690pgf.21.2017.05.26.12.10.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 12:10:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/8] builtin/push.c: respect 'submodule.recurse' option
Date:   Fri, 26 May 2017 12:10:16 -0700
Message-Id: <20170526191017.19155-8-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.g582985b1e4
In-Reply-To: <20170526191017.19155-1-sbeller@google.com>
References: <20170526191017.19155-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The closest mapping from the boolean 'submodule.recurse' set to "yes"
to the variety of submodule push modes is "on-demand", so implement that.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c                 |  4 ++++
 t/t5531-deep-submodule-push.sh | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index a597759d8f..258648d5fd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -498,6 +498,10 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		const char *value;
 		if (!git_config_get_value("push.recursesubmodules", &value))
 			recurse_submodules = parse_push_recurse_submodules_arg(k, value);
+	} else if (!strcmp(k, "submodule.recurse")) {
+		int val = git_config_bool(k, v) ?
+			RECURSE_SUBMODULES_ON_DEMAND : RECURSE_SUBMODULES_OFF;
+		recurse_submodules = val;
 	}
 
 	return git_default_config(k, v, NULL);
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 57ba322628..712c595fd8 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -126,6 +126,27 @@ test_expect_success 'push succeeds if submodule commit not on remote but using o
 	)
 '
 
+test_expect_success 'push succeeds if submodule commit not on remote but using auto-on-demand via submodule.recurse config' '
+	(
+		cd work/gar/bage &&
+		>recurse-on-demand-from-submodule-recurse-config &&
+		git add recurse-on-demand-from-submodule-recurse-config &&
+		git commit -m "Recurse submodule.recurse from config junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Recurse submodule.recurse from config for gar/bage" &&
+		git -c submodule.recurse push ../pub.git master &&
+		# Check that the supermodule commit got there
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master &&
+		# Check that the submodule commit got there too
+		cd gar/bage &&
+		git diff --quiet origin/master master
+	)
+'
+
 test_expect_success 'push recurse-submodules on command line overrides config' '
 	(
 		cd work/gar/bage &&
-- 
2.13.0.17.g582985b1e4

