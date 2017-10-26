Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408492055E
	for <e@80x24.org>; Thu, 26 Oct 2017 01:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbdJZBbl (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 21:31:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:54850 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbdJZBbe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 21:31:34 -0400
Received: by mail-pf0-f194.google.com with SMTP id n89so1293709pfk.11
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 18:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gNTsBidMFQpLexEdBO+M6qTbUKaQanik9e0AiouFgTY=;
        b=LDlZ/2NAXrdaVT8dLvc+at7j0VpC8gSAmAVy+WjBEshjWsanriagm2PkIK8inUiEaN
         W1RhZ3OW7hXJxwn0wUUMNLSkMMKiB4xSA5yQo9V52vRKJwUx+E4CDEz+8MLYb8eWmuWL
         SdYC3qUmyN3ptB1CFpmE0FR6dAR7gUeIP/25w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gNTsBidMFQpLexEdBO+M6qTbUKaQanik9e0AiouFgTY=;
        b=iAFHkmFAbEKprLTwVzVWyPPUC8yzfzIIdGswv2UFC/sQIvf49Q5w+YEoikLgfaLf8b
         PooGcfHV+RBY9e09wJsvpA1HG4LJUzIeGbpUXyE1UjsOpFeQN1eXEwsdF+9Wculu3flM
         D5g1sBo2SAZ8TUYfsSLY69w/juYxSFNdblIZ5oHmlbbljATCPu12FUVZFMUS/07Wyi72
         z3ZjhqF7kfH7nxdmJGDgr03T6xnhZY81tDx2VEp2e1j0eOta+obWSaoM+cJVMBTi1JCp
         mJYR5WYdUkSXG5LGWxQVF8FisUqMjZLHswGLPysAoPFEb52sJsZfifhGCTtp9NwpT5CY
         yJNA==
X-Gm-Message-State: AMCzsaVXpxcLCB5pbkjdE6BW+vnh6CL9G1B5j6sHOjysSVZa5nyuD+vm
        ChFh6+Ifr+TCDqe2Ln3ax/BS5tsbrNI=
X-Google-Smtp-Source: ABhQp+ROp9Z1XkL/wL3DpvaJ+NcmBSaGiDJwpxjc/yRLAnKl9VNRr+NLHY1RdrlWyI2EQ4iylNwvHw==
X-Received: by 10.99.172.25 with SMTP id v25mr3469135pge.182.1508981492955;
        Wed, 25 Oct 2017 18:31:32 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id s3sm8159206pfk.7.2017.10.25.18.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 18:31:32 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v2 4/4] fsmonitor: Delay updating state until after split index is merged
Date:   Wed, 25 Oct 2017 18:31:17 -0700
Message-Id: <38fa281fb175c086a5b1f1d3747597a9924e9f46.1508981451.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
In-Reply-To: <20171026013117.30034-1-alexmv@dropbox.com>
References: <20171026013117.30034-1-alexmv@dropbox.com>
In-Reply-To: <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com>
References: <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com>
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
index 0d26ff34f..fad9c6b13 100644
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

