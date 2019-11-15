Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MISSING_SUBJECT,
	PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 514321F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 16:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfKOQLz (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 11:11:55 -0500
Received: from gate3.osm-gmbh.de ([194.77.68.107]:35706 "EHLO
        gate3.osm-gmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfKOQLz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 11:11:55 -0500
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2019 11:11:54 EST
Received: from mail.osm-gmbh.de (vmmail.osm-gmbh.de [193.101.76.128])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gate3.osm-gmbh.de (Postfix) with ESMTPS id ADE203C090;
        Fri, 15 Nov 2019 17:03:30 +0100 (CET)
Received: from wsmn.osm-gmbh.de (wsmn.osm-gmbh.de [193.101.76.193])
        by mail.osm-gmbh.de (OSM Mailserver) with ESMTP id AD7463DC01E;
        Fri, 15 Nov 2019 17:03:30 +0100 (CET)
Received: by wsmn.osm-gmbh.de (Postfix, from userid 1002)
        id A64EBD756F; Fri, 15 Nov 2019 17:03:30 +0100 (CET)
Date:   Fri, 15 Nov 2019 17:03:30 +0100
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, mhagger@alum.mit.edu, gitster@pobox.com,
        yuelinho777@gmail.com
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20191115160330.A64EBD756F@wsmn.osm-gmbh.de>
From:   martin@wsmn.osm-gmbh.de (Martin Nicolay)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 7f5bb47a3b5b7a5443009078d936ab62dfa1fd85 Mon Sep 17 00:00:00 2001
From: Martin Nicolay <m.nicolay@osm-ag.de>
Date: Fri, 15 Nov 2019 16:41:20 +0100
Subject: [PATCH] enable a timeout for hold_lock_file_for_update

The new funktion get_files_lock_timeout_ms reads the config
core.fileslocktimeout analog get_files_ref_lock_timeout_ms.

This value is used in hold_lock_file_for_update instead of the
fixed value 0.
---
While working with complex scripts invoking git multiple times my
editor detects the changes and calls "git status". This leads to
aborts in "git-stash". With this patch and an appropriate value
core.fileslocktimeout this problem goes away.

 lockfile.c | 15 +++++++++++++++
 lockfile.h |  4 +++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index 8e8ab4f29f..ac19de8937 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -145,6 +145,21 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 	}
 }
 
+long get_files_lock_timeout_ms(void)
+{
+	static int configured = 0;
+
+	/* The default timeout is 100 ms: */
+	static int timeout_ms = 100;
+
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

