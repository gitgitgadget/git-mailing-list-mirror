Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7842F1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 17:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeDMRBh (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 13:01:37 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:55514 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbeDMRBg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 13:01:36 -0400
Received: from localhost.localdomain (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id B5174335C30;
        Fri, 13 Apr 2018 17:01:34 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [RFC PATCH] checkout: Force matching mtime between files
Date:   Fri, 13 Apr 2018 19:01:29 +0200
Message-Id: <20180413170129.15310-1-mgorny@gentoo.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently git does not control mtimes of files being checked out.  This
means that the only assumption you could make is that all files created
or modified within a single checkout action will have mtime between
start time and end time of this checkout.  The relations between mtimes
of different files depend on the order in which they are checked out,
filesystem speed and timestamp precision.

Git repositories sometimes contain both generated and respective source
files.  For example, the Gentoo 'user syncing' repository combines
source ebuild files with generated metadata cache for user convenience.
Ideally, the 'git checkout' would be fast enough that (combined with low
timestamp precision) all files created or modified within a single
checkout would have matching timestamp.  However, in reality the cache
files may end up being wrongly 'older' than source file, requiring
unnecessary recheck.

The opposite problem (cache files not being regenerated when they should
have been) might also occur.  However, it could not be solved without
preserving timestamps, therefore it is out of scope of this change.

In order to avoid unnecessary cache mismatches, force a matching mtime
between all files created by a single checkout action.  This seems to be
the best course of action.  Matching mtimes do not trigger cache
updates.  They also match the concept of 'checkout' being an atomic
action.  Finally, this change does not break backwards compatibility
as the new result is a subset of the possible previous results.

For example, let's say that 'git checkout' creates two files in order,
with respective timestamps T1 and T2.  Before this patch, T1 <= T2.
After this patch, T1 == T2 which also satisfies T1 <= T2.

A similar problem was previously being addressed via git-restore-mtime
tool.  However, that solution is unnecessarily complex for Gentoo's use
case and does not seem to be suitable for 'seamless' integration.

The patch integrates mtime forcing via adding an additional member of
'struct checkout'.  This seemed the simplest way of adding it without
having to modify prototypes and adjust multiple call sites.  The member
is set to the current time in check_updates() function and is afterwards
enforced by checkout_entry().

The patch uses utime() rather than futimes() as that seems to be
the function used everywhere else in git and provided some MinGW
compatibility code.

Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 cache.h        |  1 +
 entry.c        | 12 +++++++++++-
 unpack-trees.c |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index bbaf5c349..9f0a7c867 100644
--- a/cache.h
+++ b/cache.h
@@ -1526,6 +1526,7 @@ struct checkout {
 	const char *base_dir;
 	int base_dir_len;
 	struct delayed_checkout *delayed_checkout;
+	time_t checkout_mtime;
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
diff --git a/entry.c b/entry.c
index 2101201a1..7ee5a6d28 100644
--- a/entry.c
+++ b/entry.c
@@ -411,6 +411,7 @@ int checkout_entry(struct cache_entry *ce,
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
+	int ret;
 
 	if (topath)
 		return write_entry(ce, topath, state, 1);
@@ -473,5 +474,14 @@ int checkout_entry(struct cache_entry *ce,
 		return 0;
 
 	create_directories(path.buf, path.len, state);
-	return write_entry(ce, path.buf, state, 0);
+	ret = write_entry(ce, path.buf, state, 0);
+
+	if (ret == 0 && state->checkout_mtime != 0) {
+		struct utimbuf t;
+		t.modtime = state->checkout_mtime;
+		if (utime(path.buf, &t) < 0)
+			warning_errno("failed utime() on %s", path.buf);
+	}
+
+	return ret;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index e73745051..e1efefb68 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -346,6 +346,7 @@ static int check_updates(struct unpack_trees_options *o)
 	state.quiet = 1;
 	state.refresh_cache = 1;
 	state.istate = index;
+	state.checkout_mtime = time(NULL);
 
 	progress = get_progress(o);
 
-- 
2.17.0

