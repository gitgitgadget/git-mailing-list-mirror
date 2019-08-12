Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1BB1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 21:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfHLVfr (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 17:35:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38684 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfHLVfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 17:35:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id z14so12902160pga.5
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 14:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=YY96A52tihJFS6J0AenEACSrUCVrg3kxBvzolC3vf40=;
        b=rTU0G61e+TZDdTbFi8q804oO2w6q+nz2tP7BHOoU3cmdS4rNRpWEcDJa00CsLcAnTi
         G0487alp/gatT12jcpUp8esK9G2uwUHJaWYGWs0puMOYAkVLZDfftQvA+fiJ4qkcN/36
         5YWRU+Cqp0mvgvyjdvWjhOX3GQi42ejy1I2h3b/MfyZ39QOj3LF3YzOP4VpitBtesqbk
         c9OroldAASRzOmUxB24lrgxX/MXTk6b2KcY7DVuJN3lCD3saUWlTHnxOWSNvNN0QU4Ab
         U7wyvo5fijp0hGCHOtXm4tFT+vsUQxA527o4scflZe815lRCs7ZVzetMEV1S/HES4Zkz
         JsqA==
X-Gm-Message-State: APjAAAX61K8AMkGlzBH3yB6kUy9abOJikS+v8BwFH/Eif97SNbA04MNT
        55Mm9bdy1GHtFFiu9nuPMmBNWw==
X-Google-Smtp-Source: APXvYqzv+P+Td1ArzqfoVe3POp02XfndSSKSJ3IsdKMZyMO/mccFvAwjKdpUYJWhF/Tct+5QYkWbKQ==
X-Received: by 2002:aa7:8007:: with SMTP id j7mr37282311pfi.154.1565645745605;
        Mon, 12 Aug 2019 14:35:45 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id v63sm112254216pfv.174.2019.08.12.14.35.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 14:35:44 -0700 (PDT)
Subject: [PATCH v2 3/5] fetch: Add the fetch.jobs config key
Date:   Mon, 12 Aug 2019 14:34:46 -0700
Message-Id: <20190812213448.2649-4-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812213448.2649-1-palmer@sifive.com>
References: <20190812213448.2649-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peff@peff.net, e@80x24.org, chriscool@tuxfamily.org,
        gitster@pobox.com, jonathantanmy@google.com, tboegi@web.de,
        bwilliams.eng@gmail.com, jeffhost@microsoft.com,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows users to default to parallel fetches, so they don't have to
pass --fetch-jobs=N on the command line every time.  The implementation
matches submodule.fetchjobs by die()ing on invalid job counts.

I couldn't find any documentation for submodule.fetchjobs, so I didn't
write any for this one.  I've tested this in my config and in
conjunction with the command-line argument.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 builtin/fetch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fa12ad44e7d9..4c5f2ea3a931 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -104,6 +104,13 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.jobs")) {
+		max_children_for_fetch = git_config_int(k, v);
+		if (max_children_for_fetch < 0)
+			die(_("negative values not allowed for fetch.jobs"));
+		return 0;
+	}
+
 	return git_default_config(k, v, cb);
 }
 
-- 
2.21.0

