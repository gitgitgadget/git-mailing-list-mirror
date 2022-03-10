Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71393C433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245112AbiCJRg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiCJRgY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:36:24 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E6418C795
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:35:22 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 88A3B5A12B;
        Thu, 10 Mar 2022 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646933721;
        bh=7VLueFEbbs0vhyNcvB8Ou4O9wtpDEONFhHScpNaOm+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DCCh9AjLuEqwPWFYNI1th31J8XodGSv23do35mW680bsF+BvO4hd1eBXE0qLSFrYn
         1ZW12hzjIi/xnJo3UPpHFGEZzo8Nqqc2vjSnunDxl7ysFdVjgbopSMgBikTti079M7
         koNGkJMPjAgJCQ/lqdIuwUE6/3v9pVLLYO9dXHVjz7brLbivw0ywtmihA9Zr2cnT+E
         scGQXzYNxfRinoCl7mOAwjTaqgnxug0WopSWxoRu5mgcCh7ZEV/8sfGHfym3NcwvOn
         7zi2P907nYwOBMYMYW/SgIeJR/Gigquq5DC1VTx8/HWEDavq3XwNYv5txhqVb5QItl
         yTv/XnkRsYz5NlZjz6hx+UdNkDkk5eUGWmVYPUMIfKajB7sQGXqyFBWEcouMrRS+Tk
         3HYFojQFAqnN+67SixGAdMTyyXKDDT53MyjcC4nkIi/CKwKg7ZzhZRo0ijI9N/phyF
         tTYRik8Ce8iM6RSvVPyT3Ppanq3msn/glbpQl60xdNJLorBekVM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/6] builtin/stash: fill in all commit data
Date:   Thu, 10 Mar 2022 17:32:32 +0000
Message-Id: <20220310173236.4165310-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_stash_info doesn't ensure that all entries are filled in in all
cases.  However, we'll want to use this information to write new
commits, and when we do so, we'll need all the information to be
present.  Fill in all the commit information whenever we call this
function.

Note that the behavior of info->has_u doesn't change here.  If we
previously read a tree a refs/stash^3:, then refs/stash^3 must be a
treeish.  We already here assume that the other parents specifically
commits, so it should be safe to do so here as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/stash.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 2aa06cc91d..128f0a01ef 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -124,6 +124,7 @@ static void free_stash_info(struct stash_info *info)
 static void assert_stash_like(struct stash_info *info, const char *revision)
 {
 	if (get_oidf(&info->b_commit, "%s^1", revision) ||
+	    get_oidf(&info->i_commit, "%s^2", revision) ||
 	    get_oidf(&info->w_tree, "%s:", revision) ||
 	    get_oidf(&info->b_tree, "%s^1:", revision) ||
 	    get_oidf(&info->i_tree, "%s^2:", revision))
@@ -166,7 +167,8 @@ static int get_stash_info_1(struct stash_info *info, const char *commit, int qui
 
 	assert_stash_like(info, revision);
 
-	info->has_u = !get_oidf(&info->u_tree, "%s^3:", revision);
+	info->has_u = !get_oidf(&info->u_commit, "%s^3", revision) &&
+		      !get_oidf(&info->u_tree, "%s^3:", revision);
 
 	end_of_rev = strchrnul(revision, '@');
 	strbuf_add(&symbolic, revision, end_of_rev - revision);
