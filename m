Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7499B1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 13:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfKRNry (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 08:47:54 -0500
Received: from gate3.osm-gmbh.de ([194.77.68.107]:51908 "EHLO
        gate3.osm-gmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfKRNry (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 08:47:54 -0500
Received: from mail.osm-gmbh.de (vmmail.osm-gmbh.de [193.101.76.128])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gate3.osm-gmbh.de (Postfix) with ESMTPS id 228803C0DC;
        Mon, 18 Nov 2019 14:47:50 +0100 (CET)
Received: from wsmn.osm-gmbh.de (wsmn.osm-gmbh.de [193.101.76.193])
        by mail.osm-gmbh.de (OSM Mailserver) with ESMTP id 2567D3DC01E;
        Mon, 18 Nov 2019 14:47:50 +0100 (CET)
Received: by wsmn.osm-gmbh.de (Postfix, from userid 1002)
        id 1901ED756F; Mon, 18 Nov 2019 14:47:50 +0100 (CET)
From:   Martin Nicolay <m.nicolay@osm-ag.de>
To:     git@vger.kernel.org
Cc:     yuelinho777@gmail.com, gitster@pobox.com, mhagger@alum.mit.edu,
        pclouds@gmail.com
Date:   Mon, 18 Nov 2019 14:42:17 +0100
Subject: [PATCH] enable a timeout for hold_lock_file_for_update
Message-Id: <20191118134750.1901ED756F@wsmn.osm-gmbh.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new funktion get_files_lock_timeout_ms reads the config
core.filesLockTimeout analog get_files_ref_lock_timeout_ms.

This value is used in hold_lock_file_for_update instead of the
fixed value 0.
---
While working with complex scripts invoking git multiple times
my editor (emacs with standard version control) detects the
changes and apparently calls "git status". This leads to abort
in "git stash". With this patch and an appropriate value
core.fileslocktimeout this problem goes away.

While it may be possible to patch the elisp scripts of emacs (and
all other similar callers) to call "git status" with
--no-optional-locks it seems to me a better approarch to solve this
problem at its root: calling hold_lock_file_for_update_timeout with
a timeout of 0 ms.

The implementation with the function get_files_lock_timeout_ms is 
adopted from a similar usage of get_files_ref_lock_timeout_ms.

BTW: is there a way to link this version of the patch to the previous
version to reduce the work for reviewers?

 Documentation/config/core.txt |  6 ++++++
 lockfile.c                    | 16 ++++++++++++++++
 lockfile.h                    |  4 +++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 852d2ba37a..230ea02560 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -482,6 +482,12 @@ core.packedRefsTimeout::
 	all; -1 means to try indefinitely. Default is 1000 (i.e.,
 	retry for 1 second).
 
+core.filesLockTimeout::
+	The length of time, in milliseconds, to retry when trying to
+	lock an individual file. Value 0 means not to retry at
+	all; -1 means to try indefinitely. Default is 0 (i.e., don't
+	retry at all).
+
 core.pager::
 	Text viewer for use by Git commands (e.g., 'less').  The value
 	is meant to be interpreted by the shell.  The order of preference
diff --git a/lockfile.c b/lockfile.c
index 8e8ab4f29f..7301f393d6 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -145,6 +145,22 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 	}
 }
 
+/*
+ * Get timeout for hold_lock_file_for_update.
+ */
+long get_files_lock_timeout_ms(void)
+{
+	static int configured = 0;
+
+	static int timeout_ms = 0; /* default */
+	if (!configured) {
+		git_config_get_int("core.fileslocktimeout", &timeout_ms);
+		configured = 1;
+	}
+
+	return timeout_ms;
+}
+
 void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 {
 	if (err == EEXIST) {
diff --git a/lockfile.h b/lockfile.h
index 9843053ce8..a0520e6a7b 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -163,6 +163,8 @@ int hold_lock_file_for_update_timeout(
 		struct lock_file *lk, const char *path,
 		int flags, long timeout_ms);
 
+long get_files_lock_timeout_ms(void);
+
 /*
  * Attempt to create a lockfile for the file at `path` and return a
  * file descriptor for writing to it, or -1 on error. The flags
@@ -172,7 +174,7 @@ static inline int hold_lock_file_for_update(
 		struct lock_file *lk, const char *path,
 		int flags)
 {
-	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
+	return hold_lock_file_for_update_timeout(lk, path, flags, get_files_lock_timeout_ms() );
 }
 
 /*
-- 
2.13.7

