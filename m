Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DC8C433FE
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 15:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbiBAPuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 10:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240649AbiBAPt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 10:49:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF53C06173D
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 07:49:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m14so32648178wrg.12
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 07:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6+i3H2rSSrIPQ2aapeTktosDsuxeH/UDRURYPQmWO3Q=;
        b=dSWYtpU1udHHRJ0yreNSxWMhEMA7e5G+ACG5HIv/FLsVKTc14YZiJHIG3TWe98S7Bb
         f7WauTRgXKsl4lp3PT911gB9MfmYtsKUeEYb6FEhjRH21FpbB2WQIWrXtVyt716eMFRs
         EQ0vUQejH1ERltW1+ofUEurc5Pds5fzTW5YOQmfBhs6onK22ZDt5uKg9Wd/sv+dh1p7x
         JglZfBGMTFe1b9iPxn2N48l5/76N3wfDr2WABgNkLz38R9eU62nfen7jTF8rf5FHemUb
         rBpcHAk19UfzSsnp6T6EWv3MVi9QRzZeJPYdtiPN0lAMOPpiFSUcIfwWKbWmU1cqlN/n
         EQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6+i3H2rSSrIPQ2aapeTktosDsuxeH/UDRURYPQmWO3Q=;
        b=J9xCDLK8gKGgGdBKYS8io+J8clK+7ric65Q8K/AhuAZajELiNM0RlfyLN4104l7JHd
         rQL4pEFexsVQvs0tUL494bl7rimthcDzJ8MNZJjw3bvyYgqbyPtLYr4wiCE9/mTRpZzu
         FldZMzCZxxxedIFJ45OAgYLr4vs+D6nqYne7uqdL1ueq0daGdycNZc27IIrrP4bCqsQf
         2uDna7SN00OD5qyeOs6rSfARgx5dz52Htw+9bUGl2/+XLVY2j1M9CboP2/DTbxkS0f47
         4GCU2ky8I40GGeKQ+S4RA+IHJsB6N+rNUtej1y+DCu1HcsGdnz+0fFkLYibdey3CFpuP
         ZuMw==
X-Gm-Message-State: AOAM532So2LgeF4PpF8h5PffrEai606pyVlpv9ZfAfxWGIv+2VeiqZoV
        Xvr24jM24aw65RtSyQXkEx8bAq2E4z0=
X-Google-Smtp-Source: ABdhPJxwp21Ap8xexc+zPphZYKuXGZIQaqOpqOGACWLFkjI/aTd9g4uujwQvGBujMQ2oaKdcuqzLDw==
X-Received: by 2002:a5d:48c9:: with SMTP id p9mr21146364wrs.1.1643730597182;
        Tue, 01 Feb 2022 07:49:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm2335739wmr.3.2022.02.01.07.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 07:49:56 -0800 (PST)
Message-Id: <a3c1999936d241fdec2a958cd5a4ebc21f4c7aec.1643730593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 15:49:49 +0000
Subject: [PATCH 2/6] fetch-pack: add partial clone refiltering
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Allow refetching with a new partial clone filter by not attempting to
find or negotiate common commits with the remote, and always forcing
a full filtered fetch.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 fetch-pack.c | 57 ++++++++++++++++++++++++++++++++++------------------
 fetch-pack.h |  1 +
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index dd6ec449f2d..dd670441656 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -312,19 +312,21 @@ static int find_common(struct fetch_negotiator *negotiator,
 		const char *remote_hex;
 		struct object *o;
 
-		/*
-		 * If that object is complete (i.e. it is an ancestor of a
-		 * local ref), we tell them we have it but do not have to
-		 * tell them about its ancestors, which they already know
-		 * about.
-		 *
-		 * We use lookup_object here because we are only
-		 * interested in the case we *know* the object is
-		 * reachable and we have already scanned it.
-		 */
-		if (((o = lookup_object(the_repository, remote)) != NULL) &&
-				(o->flags & COMPLETE)) {
-			continue;
+		if (!args->refilter) {
+			/*
+			* If that object is complete (i.e. it is an ancestor of a
+			* local ref), we tell them we have it but do not have to
+			* tell them about its ancestors, which they already know
+			* about.
+			*
+			* We use lookup_object here because we are only
+			* interested in the case we *know* the object is
+			* reachable and we have already scanned it.
+			*/
+			if (((o = lookup_object(the_repository, remote)) != NULL) &&
+					(o->flags & COMPLETE)) {
+				continue;
+			}
 		}
 
 		remote_hex = oid_to_hex(remote);
@@ -694,6 +696,9 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 
 	save_commit_buffer = 0;
 
+	if (args->refilter)
+		return;
+
 	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
@@ -1022,9 +1027,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	int agent_len;
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
-
-	negotiator = &negotiator_alloc;
-	fetch_negotiator_init(r, negotiator);
+	unsigned is_refiltering = 0;
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -1094,10 +1097,14 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (server_supports("filter")) {
 		server_supports_filtering = 1;
 		print_verbose(args, _("Server supports %s"), "filter");
-	} else if (args->filter_options.choice) {
+	} else if (args->filter_options.choice || args->refilter) {
 		warning("filtering not recognized by server, ignoring");
 	}
 
+	if (server_supports_filtering && args->refilter) {
+		is_refiltering = 1;
+	}
+
 	if (server_supports("deepen-since")) {
 		print_verbose(args, _("Server supports %s"), "deepen-since");
 		deepen_since_ok = 1;
@@ -1115,9 +1122,16 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports_hash(the_hash_algo->name, NULL))
 		die(_("Server does not support this repository's object format"));
 
+	negotiator = &negotiator_alloc;
+	if (is_refiltering) {
+		fetch_negotiator_init_noop(negotiator);
+	} else {
+		fetch_negotiator_init(r, negotiator);
+	}
+
 	mark_complete_and_common_ref(negotiator, args, &ref);
 	filter_refs(args, &ref, sought, nr_sought);
-	if (everything_local(args, &ref)) {
+	if (!is_refiltering && everything_local(args, &ref)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
@@ -1575,7 +1589,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct strvec index_pack_args = STRVEC_INIT;
 
 	negotiator = &negotiator_alloc;
-	fetch_negotiator_init(r, negotiator);
+	if (args->refilter)
+		fetch_negotiator_init_noop(negotiator);
+	else
+		fetch_negotiator_init(r, negotiator);
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
@@ -1601,7 +1618,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
-			if (everything_local(args, &ref))
+			if (!args->refilter && everything_local(args, &ref))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
diff --git a/fetch-pack.h b/fetch-pack.h
index 7f94a2a5831..68df2230c55 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -42,6 +42,7 @@ struct fetch_pack_args {
 	unsigned update_shallow:1;
 	unsigned reject_shallow_remote:1;
 	unsigned deepen:1;
+	unsigned refilter:1;
 
 	/*
 	 * Indicate that the remote of this request is a promisor remote. The
-- 
gitgitgadget

