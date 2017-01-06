Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC79C1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 21:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756059AbdAFVDz (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 16:03:55 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34541 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755353AbdAFVDi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 16:03:38 -0500
Received: by mail-pg0-f43.google.com with SMTP id 14so10476919pgg.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 13:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GJR83IiR7czsP56YCP8cN1qCB9st73kmGS/MhJ+S/5Q=;
        b=S1kR8dyT7130dvkVYq5yLDqDP81tW+VrWhNbH+SzcjUiSI5xM2E3H+cO6ngckt2pm8
         apFWglHvsiA51s02DP2WvIcn99e5/I04yPB++6AQ6lFZoGecahUwuBTylHNONQ1eqMIe
         OGTT8UCGR25Z+znk3TQIeTaY5y4Ni1KfvelLuJxhmSjo8aZxsaMcNLZrBSS89W7Q4WN4
         iuTTLbgX+HNfDDAHswQV/9F09qcQaKNcV6jJaFdqAWumgQ0Vxz3Jr5o/NVgLaMn+AQH9
         vSoiOueBU+cjpgiW3jnsGYH1e0shz+gZqwiaV6GCNtkWWX3zgi6VZN4UPhqSup87kidD
         LCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GJR83IiR7czsP56YCP8cN1qCB9st73kmGS/MhJ+S/5Q=;
        b=IztMPeI+lAjjRmohFSmHodHA5QZkCFnSqSYZhVycN/axDGcAZVNtl5/H5rj1cssuFn
         3/dNX1oeE1FvjLojOu6HNuSDqGySSnSq1FJWfjTwQtTer2zkLOFdsSiSaek/4d9SRwgo
         pmwT3sNvCRh2y4vPIOCflMosUDq7BsVuolSEpqu2Z5GnTSHcOlrMfTpeTji76k9d/EO4
         35dHoSegdMyq5sViHQOxsbEFAm4GfkIk0vawIGBhqk3ORyvtkHK9VN3+gHLwMATSnZzm
         p9mgEHQwta/nZ3p396Fy9uJJCP+8mFRgkJpgKdEls5Sgl+4ixzlqyYvqX+cZSYrlWdg5
         gqVg==
X-Gm-Message-State: AIkVDXIOFT/skGPZO6gEhYeon3Th6auqI8CfNRGHOflziqcqoqjEYk1DfGNxV3tf1FchKRJW
X-Received: by 10.84.131.165 with SMTP id d34mr173515420pld.41.1483736617300;
        Fri, 06 Jan 2017 13:03:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:b5c6:5d9b:cb8b:89ed])
        by smtp.gmail.com with ESMTPSA id p68sm161826403pfd.11.2017.01.06.13.03.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Jan 2017 13:03:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] unpack-trees: factor file removal out of check_updates
Date:   Fri,  6 Jan 2017 13:03:29 -0800
Message-Id: <20170106210330.31761-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.31.g919a8d0.dirty
In-Reply-To: <20170106210330.31761-1-sbeller@google.com>
References: <CAGZ79kaM=Uosm7KAvAP-8w59Tyfc7LZiV3ZOr=PZnBgMCzr2AA@mail.gmail.com>
 <20170106210330.31761-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes check_updates shorter and easier to understand.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 971d091fd0..b954ec1233 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -237,30 +237,50 @@ static void display_error_msgs(struct unpack_trees_options *o)
 }
 
 /*
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
  */
 static void unlink_entry(const struct cache_entry *ce)
 {
 	if (!check_leading_path(ce->name, ce_namelen(ce)))
 		return;
 	if (remove_or_warn(ce->ce_mode, ce->name))
 		return;
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
 
+static int remove_workingtree_files(struct unpack_trees_options *o,
+				    struct progress *progress)
+{
+	int i;
+	unsigned cnt = 0;
+	struct index_state *index = &o->result;
+
+	for (i = 0; i < index->cache_nr; i++) {
+		const struct cache_entry *ce = index->cache[i];
+
+		if (ce->ce_flags & CE_WT_REMOVE) {
+			display_progress(progress, ++cnt);
+			if (o->update && !o->dry_run)
+				unlink_entry(ce);
+		}
+	}
+
+	return cnt;
+}
+
 static struct progress *get_progress(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
 	struct index_state *index = &o->result;
 
 	if (!o->update || !o->verbose_update)
 		return NULL;
 
 	for (; cnt < index->cache_nr; cnt++) {
 		const struct cache_entry *ce = index->cache[cnt];
 		if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
 			total++;
 	}
 
 	return start_progress_delay(_("Checking out files"),
@@ -273,39 +293,32 @@ static int check_updates(struct unpack_trees_options *o)
 	int i, errs = 0;
 
 	struct progress *progress = NULL;
 	struct index_state *index = &o->result;
 	struct checkout state = CHECKOUT_INIT;
 
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
 	state.istate = index;
 
 	progress = get_progress(o);
 
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
-	for (i = 0; i < index->cache_nr; i++) {
-		const struct cache_entry *ce = index->cache[i];
 
-		if (ce->ce_flags & CE_WT_REMOVE) {
-			display_progress(progress, ++cnt);
-			if (o->update && !o->dry_run)
-				unlink_entry(ce);
-		}
-	}
+	cnt = remove_workingtree_files(o, progress);
 	remove_marked_cache_entries(index);
 	remove_scheduled_dirs();
 
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_UPDATE) {
 			if (ce->ce_flags & CE_WT_REMOVE)
 				die("BUG: both update and delete flags are set on %s",
 				    ce->name);
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
 				errs |= checkout_entry(ce, &state, NULL);
 			}
-- 
2.11.0.31.g919a8d0.dirty

