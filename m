Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475C61FBF4
	for <e@80x24.org>; Fri, 27 Oct 2017 23:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932535AbdJ0X1M (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 19:27:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:51485 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932492AbdJ0X1G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 19:27:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id n14so5948300pfh.8
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 16:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZpTVNS6Rnst/YKGL2V2gq7tkYXPrpmNoeruqQRYvMRs=;
        b=zbF4Wt7kGYBX1MDQCAcGiKoAasGQStNN9l4b/fBaVE//gushpw85ncUyNjkBHzYTeo
         IIhwdWfKewk+6xSvA8X9242C5VMH6rnFoZCk7dlI2dhJz0iPu/YZowKnRa85dw4bNj7a
         qNThIo34sQzgs5Y6J+NvlcWBiKiCNJiPIFFRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZpTVNS6Rnst/YKGL2V2gq7tkYXPrpmNoeruqQRYvMRs=;
        b=b6ejmb+xVHE1ZxL7YngbEbmXj8e2NcEFKHVAg9dRwtjOdAy4UYVdVtWKBQL/bVC878
         QTHmX1YkePYCnssplBMQzDLVcwzrfe/0KtmxR+ZZY+r0jn5fMrv10YVAxRhrwTyXUGoj
         welxZCVhiJMoXqL23tcwhCio6PdqrvEjFn0CNunpezkYkBE8Wd8Bf6WpUgAM4xEMOSgl
         Ryp7leMdNYVDdKsygW4PuaK3YFoqq9R+qtHk9ZkmG+rjSXUR5KFoax5EDG2eUUuxM4Hr
         5K+hQlhg6yxzH4PgHd+c6drq42FqGPD93/wdqV/WbC785Wf2IHNLvSwd2CRrWVOn0aQR
         TBOw==
X-Gm-Message-State: AMCzsaUmSak1eslqfkpn17JV2dDdBHojn7IXYgnU1w3zKVVK5qkWRVq7
        IqRuMWcP4x8TbNQy35QuayhYKhzLXKU=
X-Google-Smtp-Source: ABhQp+RhvFrqb755Whx8u827OPHuUCz9L/gyvm7SV2SBTy1zuDZ0brFDJ4B08vS/m9gH13T0DrRlSQ==
X-Received: by 10.84.173.4 with SMTP id o4mr1558794plb.3.1509146825359;
        Fri, 27 Oct 2017 16:27:05 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (Guest-GW2.corp.dropbox.com. [205.189.0.166])
        by smtp.gmail.com with ESMTPSA id i129sm15442806pgd.21.2017.10.27.16.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 16:27:04 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v3 4/4] fsmonitor: Delay updating state until after split index is merged
Date:   Fri, 27 Oct 2017 16:26:37 -0700
Message-Id: <5cb81a33c31ffa585861f0d3f5a7c7eef5bd8fe0.1509146542.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
In-Reply-To: <20171027232637.30395-1-alexmv@dropbox.com>
References: <20171027232637.30395-1-alexmv@dropbox.com>
In-Reply-To: <4b488da5e0710e9699f92d2dabe5e3352f3eb394.1509146542.git.alexmv@dropbox.com>
References: <4b488da5e0710e9699f92d2dabe5e3352f3eb394.1509146542.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the fsmonitor extension is used in conjunction with the split index
extension, the set of entries in the index when it is first loaded is
only a subset of the real index.  This leads to only the non-"base"
index being marked as CE_FSMONITOR_VALID.

Delay the expansion of the ewah bitmap until after tweak_split_index
has been called to merge in the base index as well.

The new fsmonitor_dirty is kept from being leaked by dint of being
cleaned up in post_read_index_from, which is guaranteed to be called
after do_read_index in read_index_from.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 cache.h     |  1 +
 fsmonitor.c | 39 ++++++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index 25adcf681..0a4f43ec2 100644
--- a/cache.h
+++ b/cache.h
@@ -348,6 +348,7 @@ struct index_state {
 	unsigned char sha1[20];
 	struct untracked_cache *untracked;
 	uint64_t fsmonitor_last_update;
+	struct ewah_bitmap *fsmonitor_dirty;
 };
 
 extern struct index_state the_index;
diff --git a/fsmonitor.c b/fsmonitor.c
index 4ea44dcc6..417759224 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -49,20 +49,7 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 		ewah_free(fsmonitor_dirty);
 		return error("failed to parse ewah bitmap reading fsmonitor index extension");
 	}
-
-	if (git_config_get_fsmonitor()) {
-		/* Mark all entries valid */
-		for (i = 0; i < istate->cache_nr; i++)
-			istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
-
-		/* Mark all previously saved entries as dirty */
-		ewah_each_bit(fsmonitor_dirty, fsmonitor_ewah_callback, istate);
-
-		/* Now mark the untracked cache for fsmonitor usage */
-		if (istate->untracked)
-			istate->untracked->use_fsmonitor = 1;
-	}
-	ewah_free(fsmonitor_dirty);
+	istate->fsmonitor_dirty = fsmonitor_dirty;
 
 	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
 	return 0;
@@ -239,7 +226,29 @@ void remove_fsmonitor(struct index_state *istate)
 
 void tweak_fsmonitor(struct index_state *istate)
 {
-	switch (git_config_get_fsmonitor()) {
+	int i;
+	int fsmonitor_enabled = git_config_get_fsmonitor();
+
+	if (istate->fsmonitor_dirty) {
+		if (fsmonitor_enabled) {
+			/* Mark all entries valid */
+			for (i = 0; i < istate->cache_nr; i++) {
+				istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
+			}
+
+			/* Mark all previously saved entries as dirty */
+			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
+
+			/* Now mark the untracked cache for fsmonitor usage */
+			if (istate->untracked)
+				istate->untracked->use_fsmonitor = 1;
+		}
+
+		ewah_free(istate->fsmonitor_dirty);
+		istate->fsmonitor_dirty = NULL;
+	}
+
+	switch (fsmonitor_enabled) {
 	case -1: /* keep: do nothing */
 		break;
 	case 0: /* false */
-- 
2.15.0.rc1.413.g76aedb451

