Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC9BC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 04:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiBJEmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 23:42:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiBJEl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 23:41:57 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9681A6
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 20:41:58 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id n4-20020a17090ade8400b001b8bb511c3bso3070428pjv.7
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 20:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f+vtkyIZlv9i3ilY9wRatiFyrKMDOpZkUHyk9HR8YRc=;
        b=Is+EyJ6kcDZeF/TOo2M4UP2P50VRYUfdpxoZukwRJsWxpdrqgkz2om2ZHgwTsYu1Wi
         FprzC/Rcp3aQMgWc23CHRRaFsRw8PuGIlEFGI/iCRjh1d2a8fL3c1bA6t73VYNoxb/sa
         4g5pXE3V+w3a762WrFv9TzVkx3MLQPTqGfZQ/DeE1aOfnefONl4dlGizbf1l1v3V8ZFS
         ahqQrobu3G4drM9zNu+jh3CQ3zy2fSWVRwhWEOnvL/5uWoCKLRU1pwTjA139fGF6F4q1
         hsA3E8ky0lwW1SQ4Jr8Aw7AAuef7F/573vSvvdZ2i4O8iRb0sLJU2XzB5Xq30wsCrEXu
         jeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f+vtkyIZlv9i3ilY9wRatiFyrKMDOpZkUHyk9HR8YRc=;
        b=Ci5RvjarBpyrIYg5ICjYY5voP4ifUERYbsCppcAhPEaoGXRPlf1AQ3ADVG4tckhqjo
         TtsEz+1jGo9+8fjsVyWcIKEfpkSX75FiqBlNZh/Xb+uvCB0iFOAdnqrK5rGSGXM+nqDK
         h8GUDLNileVe45Wzvw2jR6JBThk02O/acx2yrcB9PnAN7gVbQz+O5bfAqpOCxmrOqTae
         Z23Hj6NjzxQGHOUhvullQk+QhVlGqrHtVAP0h2psWgqzkkdDXySlEW2sEQ2RFdr2N6bp
         w64CknncYgPxNL7A+2OzRc982XdiEvlwN1IwwV6zfSEPujQB5gOp/A/p4towR6Zqnsxz
         LmWg==
X-Gm-Message-State: AOAM532CgOoDAHDc/eS1SDuFAzPdkrDmGQHs5krReVW5xK0di5KXmsN0
        HRnpizk1Cuc6cagHXex5q6omwOWzOJx4nXmrHA3IB+L+/ILPEvUiZtQ8Z2nPBRGQzdPpwSZDvGE
        tAXHVTlmU1cMzHF0sLJdqoLm4xSKdSC5IefOcMsz5fbz6Dej6dYHGDwQoCg9kI5k=
X-Google-Smtp-Source: ABdhPJyCfPnfAXmD8jy1YG7+o0SJokluR8gQzO/vWO1MU0shjWb3pnt3fyToyHtt/AFwOjFxqM0t27xVenBNJg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:f606:: with SMTP id
 n6mr5629397plg.32.1644468117523; Wed, 09 Feb 2022 20:41:57 -0800 (PST)
Date:   Thu, 10 Feb 2022 12:41:45 +0800
In-Reply-To: <20220210044152.78352-1-chooglen@google.com>
Message-Id: <20220210044152.78352-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 1/8] submodule: inline submodule_commits() into caller
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When collecting the string_list of changed submodule names, the new
submodules commits are stored in the string_list_item.util as an
oid_array. A subsequent commit will replace the oid_array with a struct
that has more information.

Prepare for this change by inlining submodule_commits() (which inserts
into the string_list and initializes the string_list_item.util) into its
only caller. This simplifies the code and makes it easier for the caller
to add information to the string_list_item.util.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5ace18a7d9..49f9dc5d23 100644
--- a/submodule.c
+++ b/submodule.c
@@ -782,19 +782,6 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 	return submodule_from_path(the_repository, null_oid(), ce->name);
 }
 
-static struct oid_array *submodule_commits(struct string_list *submodules,
-					   const char *name)
-{
-	struct string_list_item *item;
-
-	item = string_list_insert(submodules, name);
-	if (item->util)
-		return (struct oid_array *) item->util;
-
-	/* NEEDSWORK: should we have oid_array_init()? */
-	item->util = xcalloc(1, sizeof(struct oid_array));
-	return (struct oid_array *) item->util;
-}
 
 struct collect_changed_submodules_cb_data {
 	struct repository *repo;
@@ -830,9 +817,9 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		struct oid_array *commits;
 		const struct submodule *submodule;
 		const char *name;
+		struct string_list_item *item;
 
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
@@ -859,8 +846,11 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		if (!name)
 			continue;
 
-		commits = submodule_commits(changed, name);
-		oid_array_append(commits, &p->two->oid);
+		item = string_list_insert(changed, name);
+		if (!item->util)
+			/* NEEDSWORK: should we have oid_array_init()? */
+			item->util = xcalloc(1, sizeof(struct oid_array));
+		oid_array_append(item->util, &p->two->oid);
 	}
 }
 
-- 
2.33.GIT

