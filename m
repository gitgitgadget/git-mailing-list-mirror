Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37B41F453
	for <e@80x24.org>; Mon, 24 Sep 2018 15:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbeIXVsI (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 17:48:08 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55099 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIXVsH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 17:48:07 -0400
Received: by mail-pf1-f202.google.com with SMTP id x6-v6so1865920pfn.21
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=coyFQ5g/BKyXMJCFiPgxd6WMBTNiLUYESA3EmaYoAd0=;
        b=lrzQCIWNDzV1gJQXjVNhYU/2nxlnsIB6hPPpzl4VnoDhKKDia1YlZONQrDV9wp07qx
         psUHtvVN22N1Mcp4pvdS0HB3vC5C9vKQHcueP9VE7Z8duceL2sZWZWWw9n4xRA3JJIL1
         W0NbBvHjLVf0ADsmie7vKo2cE4kCeZDnxZLNIWqTnWgOCnQLYKTYQXNtR+CZLpyKEEUt
         uiHjhMd2LHMARykOaBZRjLmToLjTfYiZebQfC3UQ1qcyKymMusCeDqBctZi7a5GqdhqT
         1Ms2Zae6VCjIr665IxDv/aFBVDPxWFaemUqd8LxtQHTQloAZmU8UYbyDyLFo920SxK+Y
         EIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=coyFQ5g/BKyXMJCFiPgxd6WMBTNiLUYESA3EmaYoAd0=;
        b=h1WN1GerxmUEwb8jN7BOkCW6AZu4KiJ15CxMpJNVCoYd2L/zMt1KmEZ17Frp9sSyu5
         9jdbtoLoh2WP/jVyyo/U3RqlJr0yZmneP6DlQUzyoTKRozS0Y82VVvYrts+IOASIErT+
         986iqnJ79+nM+CQ3X/wqltARObSzoRmQCP+ETPnparQTA6juCFozaH7qOTC2+LvybXhR
         66n/3eFlySgo9u6PsBAwoJ+fQeuVfrdMPSY6ue+0m5ZJ/jBi255EE/8Ah4/fSk8Vh7Yp
         icLnBGPk04y2DSo7nS5Ny9atdAx0Z4VvyYBt28tOH85MMPBtBSwGX9bLL2CtRQailzVK
         C1PQ==
X-Gm-Message-State: ABuFfoiQpMDm3mVJ/mdqCxaMG6U/jvrHjiD1DDBLnOZyRKxNtyKnvp1x
        8Njflh4Yzw3V5vK1tUIIo5a6uOl/oI4I2kAO8Gs3LQkLYAsEOJglEaD10WUbTovpXyOW5J4PRcP
        K6qSCwAwOZ3kZp1KQ+A9NS8n3lvrilUuc2haB9XS8Ly9dMkMhcc3bBQW/1mrLEd7TZkw39TpZ5G
        Q5
X-Google-Smtp-Source: ACcGV61Po0rDGwcGnolqxwCaVHWhYODWD8WpNNR4FAW+UsuwoY9uHnjxELqbvYB2RfK0R/l96RNq8o0TOKUm4RiBoXUb
X-Received: by 2002:a63:5d26:: with SMTP id r38-v6mr348675pgb.154.1537803919962;
 Mon, 24 Sep 2018 08:45:19 -0700 (PDT)
Date:   Mon, 24 Sep 2018 08:45:16 -0700
Message-Id: <20180924154516.48704-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH] fetch-pack: approximate no_dependents with filter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever a lazy fetch is performed for a tree object, any trees and
blobs it directly or indirectly references will be fetched as well.
There is a "no_dependents" argument in struct fetch_pack_args that
indicates that objects that the wanted object references need not be
sent, but it currently has no effect other than to inhibit usage of
object flags.

Extend the "no_dependents" argument to also exclude sending of objects
as much as the current protocol allows: when fetching a tree, all trees
it references will be sent (but not the blobs), and when fetching a
blob, it will still be sent. (If this mechanism is used to fetch a
commit or any other non-blob object, all referenced objects, except
blobs, will be sent.) The client neither needs to know or specify the
type of each object it wants.

The necessary code change is done in fetch_pack() instead of somewhere
closer to where the "filter" instruction is written to the wire so that
only one part of the code needs to be changed in order for users of all
protocol versions to benefit from this optimization.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This was prompted by a user at $DAY_JOB who had a partial clone
excluding trees, and had a workflow that only required tree objects (and
not blobs).

This will hopefully make partial clones excluding trees (with the
"tree:0" filter) a bit better, in that if an operation requires only
trees to be inspected, the required download is much smaller.
---
 fetch-pack.c             | 14 ++++++++++++++
 fetch-pack.h             |  7 +++++++
 t/t0410-partial-clone.sh | 41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 88a078e9b..c25b0f54c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1598,6 +1598,20 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	if (nr_sought)
 		nr_sought = remove_duplicates_in_refs(sought, nr_sought);
 
+	if (args->no_dependents && !args->filter_options.choice) {
+		/*
+		 * The protocol does not support requesting that only the
+		 * wanted objects be sent, so approximate this by setting a
+		 * "blob:none" filter if no filter is already set. This works
+		 * for all object types: note that wanted blobs will still be
+		 * sent because they are directly specified as a "want".
+		 *
+		 * NEEDSWORK: Add an option in the protocol to request that
+		 * only the wanted objects be sent, and implement it.
+		 */
+		parse_list_objects_filter(&args->filter_options, "blob:none");
+	}
+
 	if (!ref) {
 		packet_flush(fd[1]);
 		die(_("no matching remote head"));
diff --git a/fetch-pack.h b/fetch-pack.h
index 5b6e86880..43ec344d9 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -43,6 +43,13 @@ struct fetch_pack_args {
 	unsigned from_promisor:1;
 
 	/*
+	 * Attempt to fetch only the wanted objects, and not any objects
+	 * referred to by them. Due to protocol limitations, extraneous
+	 * objects may still be included. (When fetching non-blob
+	 * objects, only blobs are excluded; when fetching a blob, the
+	 * blob itself will still be sent. The client does not need to
+	 * know whether a wanted object is a blob or not.)
+	 *
 	 * If 1, fetch_pack() will also not modify any object flags.
 	 * This allows fetch_pack() to safely be called by any function,
 	 * regardless of which object flags it uses (if any).
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 128130066..08a0c3651 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -170,6 +170,47 @@ test_expect_success 'fetching of missing objects' '
 	git verify-pack --verbose "$IDX" | grep "$HASH"
 '
 
+test_expect_success 'fetching of missing blobs works' '
+	rm -rf server repo &&
+	test_create_repo server &&
+	test_commit -C server foo &&
+	git -C server repack -a -d --write-bitmap-index &&
+
+	git clone "file://$(pwd)/server" repo &&
+	git hash-object repo/foo.t >blobhash &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C server config uploadpack.allowanysha1inwant 1 &&
+	git -C server config uploadpack.allowfilter 1 &&
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "origin" &&
+
+	git -C repo cat-file -p $(cat blobhash)
+'
+
+test_expect_success 'fetching of missing trees does not fetch blobs' '
+	rm -rf server repo &&
+	test_create_repo server &&
+	test_commit -C server foo &&
+	git -C server repack -a -d --write-bitmap-index &&
+
+	git clone "file://$(pwd)/server" repo &&
+	git -C repo rev-parse foo^{tree} >treehash &&
+	git hash-object repo/foo.t >blobhash &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C server config uploadpack.allowanysha1inwant 1 &&
+	git -C server config uploadpack.allowfilter 1 &&
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "origin" &&
+	git -C repo cat-file -p $(cat treehash) &&
+
+	# Ensure that the tree, but not the blob, is fetched
+	git -C repo rev-list --objects --missing=print $(cat treehash) >objects &&
+	grep "^$(cat treehash)" objects &&
+	grep "^[?]$(cat blobhash)" objects
+'
+
 test_expect_success 'rev-list stops traversal at missing and promised commit' '
 	rm -rf repo &&
 	test_create_repo repo &&
-- 
2.19.0.444.g18242da7ef-goog

