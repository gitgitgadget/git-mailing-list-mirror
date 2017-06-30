Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D87201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 19:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbdF3TOU (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 15:14:20 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35366 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbdF3TOS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 15:14:18 -0400
Received: by mail-pg0-f48.google.com with SMTP id j186so67742865pge.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jNz9+JoWxCJpO4uI//CxxHMIIw1WK3Ph2SnfBwTiTmo=;
        b=c1Ezph8EK19CZJAOAgzQtOlvxrHf7dyhvS4Rx/zZwXQ09jHYJVfkku5wdgr/xo8qi5
         M+WgeJ8vwH+2q2WMWpzdPrOwmvM2frJazCtIzzf1TJj6ElN2+bo1Z6j7QNTqX4g4WOsk
         tCI3ovdaJhA46+Rs80pWHWaOhOuDQtjum2engAUs6tuRjedbUWhW7qZoUfKC+M2guhNS
         7gUd4URo3f0HkfSoBDa+Yjh4PkltSo7tDoOVMClKsmM35h/V2pljMvoXYoUZiHbvvs36
         o//SozN7/ni6a6Qnd4EAS0PFPbjtUfjGkFnBDkZY0jkOFu8sWezqfMWhc9rvJQda6AT/
         c2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jNz9+JoWxCJpO4uI//CxxHMIIw1WK3Ph2SnfBwTiTmo=;
        b=sQpHb3cLCTb45URGL4/e0tU/qsjpfYjW5dOLw7LIMqa6DU1Wlixn4eplpNfwv2eV+w
         JDnjaJ0F/cFLIcMVeHNhGC9GsYIFSw3ZM/OpRCZjn6tzM/pGol0d1d0XS4nBRrMd65dV
         Yy92gfSXxQ5yvv5kbyt8NrUm3U1geleQZtv8l+0Kf+m0/pHcZubjAwmlXvT5Jz7iv9SA
         d64SZLnaxDHJUDNmfu3R9zuJicSQg8C7Q26k5Mtny24zXG3mb85cD+xHdcw9kLRrID9n
         wXWcevINb00snQN8Ljz2FhhsKiBYFjw0AkC1gjlenIO0Vl7wrN2LbagcSB5Cku8f+1JW
         7YLw==
X-Gm-Message-State: AKS2vOxgDTXKoU+c55+KXy7Tn5KFHfO/PB5vWw1E5BMiyGUlFs15ufTu
        VaVPlq0RvAFxT8Dt
X-Received: by 10.84.140.107 with SMTP id 98mr26450402pls.97.1498850057300;
        Fri, 30 Jun 2017 12:14:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id a187sm14846200pgc.37.2017.06.30.12.14.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 12:14:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com
Subject: [PATCHv3 2/3] patch-ids.c: use hashmap correctly
Date:   Fri, 30 Jun 2017 12:14:06 -0700
Message-Id: <20170630191407.5381-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630191407.5381-1-sbeller@google.com>
References: <20170629235336.28460-1-sbeller@google.com>
 <20170630191407.5381-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As eluded to in the previous patch, the code in patch-ids.c is using
the hashmaps API wrong.

Luckily we do not have a bug, as all hashmap functionality that we use
here (hashmap_get) passes through the keydata.  If hashmap_get_next were
to be used, a bug would occur as that passes NULL for the key_data.

So instead use the hashmap API correctly and provide the caller required
data in the compare function via the first argument that always gets
passed and was setup via the hashmap_init function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 patch-ids.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index 815c115811..b4166b0f38 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -35,10 +35,10 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
  * the side of safety.  The actual value being negative does not have
  * any significance; only that it is non-zero matters.
  */
-static int patch_id_cmp(const void *unused_cmp_data,
+static int patch_id_cmp(struct diff_options *opt,
 			struct patch_id *a,
 			struct patch_id *b,
-			struct diff_options *opt)
+			const void *unused_keydata)
 {
 	if (is_null_oid(&a->patch_id) &&
 	    commit_patch_id(a->commit, opt, &a->patch_id, 0))
@@ -59,7 +59,7 @@ int init_patch_ids(struct patch_ids *ids)
 	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
 	diff_setup_done(&ids->diffopts);
 	hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp,
-		     NULL, 256);
+		     &ids->diffopts, 256);
 	return 0;
 }
 
@@ -95,7 +95,7 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
 	if (init_patch_id_entry(&patch, commit, ids))
 		return NULL;
 
-	return hashmap_get(&ids->patches, &patch, &ids->diffopts);
+	return hashmap_get(&ids->patches, &patch, NULL);
 }
 
 struct patch_id *add_commit_patch_id(struct commit *commit,
-- 
2.13.0.31.g9b732c453e

