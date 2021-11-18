Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE42C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449A261B2B
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhKRQxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52814 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhKRQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AE5012190C
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HsKLjsAUt13nezPJ4q8AKg2AgiIXfDiTolWNPplO1q8=;
        b=PElFBjX0ueFWWK0WPBGpt3VlYghXeS07m+7D87ZE23xi+xM49O8+L/3rJLDl35XbYGp9A/
        cUA/PZ0U3DEhpAK+L3xwEvSy1V97x4oKnic0v8uQwXG/XjIqLmS59EAUUorFmYuFyHCOvn
        xbTXPeDIDHjBFz9UL5tc5T+Qy89ixOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HsKLjsAUt13nezPJ4q8AKg2AgiIXfDiTolWNPplO1q8=;
        b=vB7YKDcbPnhKr3+/4wyg2wrODYqDa6+08Eg6OMivquaDl/+I3JraXZERRKDMrIVKAnLTm0
        0/LPxO7pYsZNuCDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 9E300A3B9F;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BF5DD1F2CBD; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 22/27] bisect: Move count_distance()
Date:   Thu, 18 Nov 2021 17:49:35 +0100
Message-Id: <20211118164940.8818-23-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move count_distance() function as stochastic bisection will need to
call weight() from it and the move avoids forward declaration. No code
changes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c | 92 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4107161c086c..8e47c3fb4b9e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -42,52 +42,6 @@ static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *term_bad;
 static const char *term_good;
 
-/* Remember to update object flag allocation in object.h */
-#define COUNTED		(1u<<16)
-
-/*
- * This is a truly stupid algorithm, but it's only
- * used for bisection, and we just don't care enough.
- *
- * We care just barely enough to avoid recursing for
- * non-merge entries.
- */
-static int count_distance(struct commit_list *entry)
-{
-	int nr = 0;
-
-	while (entry) {
-		struct commit *commit = entry->item;
-		struct commit_list *p;
-
-		if (commit->object.flags & (UNINTERESTING | COUNTED))
-			break;
-		if (!(commit->object.flags & TREESAME))
-			nr++;
-		commit->object.flags |= COUNTED;
-		p = commit->parents;
-		entry = p;
-		if (p) {
-			p = p->next;
-			while (p) {
-				nr += count_distance(p);
-				p = p->next;
-			}
-		}
-	}
-
-	return nr;
-}
-
-static void clear_counted_flag(struct commit_list *list)
-{
-	while (list) {
-		struct commit *commit = list->item;
-		commit->object.flags &= ~COUNTED;
-		list = list->next;
-	}
-}
-
 define_commit_slab(commit_weight, void *);
 static struct commit_weight commit_weight;
 
@@ -169,6 +123,52 @@ static int count_interesting_parents(struct commit *commit)
 	return count;
 }
 
+/* Remember to update object flag allocation in object.h */
+#define COUNTED		(1u<<16)
+
+/*
+ * This is a truly stupid algorithm, but it's only
+ * used for bisection, and we just don't care enough.
+ *
+ * We care just barely enough to avoid recursing for
+ * non-merge entries.
+ */
+static int count_distance(struct commit_list *entry)
+{
+	int nr = 0;
+
+	while (entry) {
+		struct commit *commit = entry->item;
+		struct commit_list *p;
+
+		if (commit->object.flags & (UNINTERESTING | COUNTED))
+			break;
+		if (!(commit->object.flags & TREESAME))
+			nr++;
+		commit->object.flags |= COUNTED;
+		p = commit->parents;
+		entry = p;
+		if (p) {
+			p = p->next;
+			while (p) {
+				nr += count_distance(p);
+				p = p->next;
+			}
+		}
+	}
+
+	return nr;
+}
+
+static void clear_counted_flag(struct commit_list *list)
+{
+	while (list) {
+		struct commit *commit = list->item;
+		commit->object.flags &= ~COUNTED;
+		list = list->next;
+	}
+}
+
 static inline int approx_halfway(struct commit_list *p, int nr)
 {
 	int diff;
-- 
2.26.2

