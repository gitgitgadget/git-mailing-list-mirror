Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CEF620189
	for <e@80x24.org>; Sun, 19 Jun 2016 03:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbcFSDNk (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 23:13:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36876 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbcFSDNj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 23:13:39 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9DE320189;
	Sun, 19 Jun 2016 03:13:38 +0000 (UTC)
Date:	Sun, 19 Jun 2016 03:13:38 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: [PATCH] prune: keep files created after process start
Message-ID: <20160619031338.GA5161@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Avoid pruning files which were written after the prune process
starts, as it possible to concurrently create new objects while
"git prune" is running.

Tested on git.git by starting "git prune" in one terminal,
creating a random loose object via "git hash-object --stdin -w"
in a different terminal, and ensuring the loose object remains
after "git prune" completes.

Signed-off-by: Eric Wong <e@80x24.org>
---
 I'm somewhat surprised this check didn't already exist;
 but maybe nobody else runs prune manually, anymore.

 builtin/prune.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 8f4f052..d4cd054 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -14,6 +14,7 @@ static const char * const prune_usage[] = {
 static int show_only;
 static int verbose;
 static unsigned long expire;
+static time_t start;
 static int show_progress = -1;
 
 static int prune_tmp_file(const char *fullpath)
@@ -21,7 +22,7 @@ static int prune_tmp_file(const char *fullpath)
 	struct stat st;
 	if (lstat(fullpath, &st))
 		return error("Could not stat '%s'", fullpath);
-	if (st.st_mtime > expire)
+	if (st.st_mtime > expire || st.st_ctime >= start)
 		return 0;
 	if (show_only || verbose)
 		printf("Removing stale temporary file %s\n", fullpath);
@@ -47,7 +48,7 @@ static int prune_object(const unsigned char *sha1, const char *fullpath,
 		error("Could not stat '%s'", fullpath);
 		return 0;
 	}
-	if (st.st_mtime > expire)
+	if (st.st_mtime > expire || st.st_ctime >= start)
 		return 0;
 	if (show_only || verbose) {
 		enum object_type type = sha1_object_info(sha1, NULL);
@@ -111,6 +112,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	};
 	char *s;
 
+	start = time(NULL);
 	expire = ULONG_MAX;
 	save_commit_buffer = 0;
 	check_replace_refs = 0;
