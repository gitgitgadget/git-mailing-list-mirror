Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B76C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 09:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FC9320790
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 09:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgJLJSD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 12 Oct 2020 05:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgJLJSB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 05:18:01 -0400
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12069C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 02:18:01 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id 097BA3AB0CA
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 09:18:01 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id 01507160037
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 09:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id E796616003E
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 09:18:00 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L4rqhD4BAdGz for <git@vger.kernel.org>;
        Mon, 12 Oct 2020 09:18:00 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id 5BD73160037
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 09:18:00 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <michal@isc.org>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/3] merge-base, xdiff: zero out xpparam_t structures
Date:   Mon, 12 Oct 2020 11:17:49 +0200
Message-Id: <20201012091751.19594-2-michal@isc.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012091751.19594-1-michal@isc.org>
References: <20201001120606.25773-1-michal@isc.org>
 <20201012091751.19594-1-michal@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

xpparam_t structures are usually zero-initialized before their specific
fields are assigned to, but there are three locations in the tree where
that does not happen.  Add the missing memset() calls in order to make
initialization of xpparam_t structures consistent tree-wide and to
prevent stack garbage from being used as field values.

Signed-off-by: Michał Kępień <michal@isc.org>
---
 builtin/merge-tree.c | 1 +
 xdiff/xhistogram.c   | 2 ++
 xdiff/xpatience.c    | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index e72714a5a8..de8520778d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -109,6 +109,7 @@ static void show_diff(struct merge_list *entry)
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
 
+	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index c7b35a9667..e694bfd9e3 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -235,6 +235,8 @@ static int fall_back_to_classic_diff(xpparam_t const *xpp, xdfenv_t *env,
 		int line1, int count1, int line2, int count2)
 {
 	xpparam_t xpparam;
+
+	memset(&xpparam, 0, sizeof(xpparam));
 	xpparam.flags = xpp->flags & ~XDF_DIFF_ALGORITHM_MASK;
 
 	return xdl_fall_back_diff(env, &xpparam,
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 3c5601b602..20699a6f60 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -318,6 +318,8 @@ static int fall_back_to_classic_diff(struct hashmap *map,
 		int line1, int count1, int line2, int count2)
 {
 	xpparam_t xpp;
+
+	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = map->xpp->flags & ~XDF_DIFF_ALGORITHM_MASK;
 
 	return xdl_fall_back_diff(map->env, &xpp,
-- 
2.28.0

