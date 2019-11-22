Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E17CC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 08:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC8A20708
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 08:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfKVIya (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:54:30 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34192 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKVIya (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 03:54:30 -0500
X-Greylist: delayed 1041 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 03:54:29 EST
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92.3)
        (envelope-from <glandium@glandium.org>)
        id 1iY4R6-0007cs-Iu; Fri, 22 Nov 2019 17:37:04 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 2/2] revision: free topo_walk_info before creating a new one in init_topo_walk
Date:   Fri, 22 Nov 2019 17:37:04 +0900
Message-Id: <20191122083704.29267-2-mh@glandium.org>
X-Mailer: git-send-email 2.24.0.dirty
In-Reply-To: <20191122083704.29267-1-mh@glandium.org>
References: <20191122083704.29267-1-mh@glandium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

init_topo_walk doesn't reuse an existing topo_walk_info, and currently
leaks the one that might exist on the current rev_info if it was already
used for a topo walk beforehand.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 revision.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)


The FREE_AND_NULL() -> xmalloc dance could be avoided, but I figured the
function ought to be reused in the future to clear the rev_info. I was
thinking to add a call in reset_revision_walk instead, but
reset_revision_walk doesn't take an argument at all currently.


diff --git a/revision.c b/revision.c
index 765a56ae33..7e23c5ed08 100644
--- a/revision.c
+++ b/revision.c
@@ -3211,10 +3211,26 @@ static void compute_indegrees_to_depth(struct rev_info *revs,
 		indegree_walk_step(revs);
 }
 
+static void reset_topo_walk(struct rev_info *revs)
+{
+	struct topo_walk_info *info = revs->topo_walk_info;
+
+	clear_prio_queue(&info->explore_queue);
+	clear_prio_queue(&info->indegree_queue);
+	clear_prio_queue(&info->topo_queue);
+	clear_indegree_slab(&info->indegree);
+	clear_author_date_slab(&info->author_date);
+
+	FREE_AND_NULL(revs->topo_walk_info);
+}
+
 static void init_topo_walk(struct rev_info *revs)
 {
 	struct topo_walk_info *info;
 	struct commit_list *list;
+	if (revs->topo_walk_info)
+		reset_topo_walk(revs);
+
 	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
 	info = revs->topo_walk_info;
 	memset(info, 0, sizeof(struct topo_walk_info));
-- 
2.24.0.dirty

