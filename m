Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62C120958
	for <e@80x24.org>; Tue, 21 Mar 2017 00:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbdCUAS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 20:18:26 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36628 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753207AbdCUASZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 20:18:25 -0400
Received: by mail-pf0-f171.google.com with SMTP id o126so72554132pfb.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RiC37rNPR4a6uru5/EwXzzxZEL0IM2Ie7OOtTBN7fvk=;
        b=SEiJhbmi7/TEu7UWuLyU37V8OZkKR3gcOxXyZOLhGtT1YCeqAqBU8XF9SKP+6MjTsn
         xrA+VXiz7O6GcLmuJgp68vY+D+45pLSQi749EEEF7G/Vsmz/YvwEuZu35X/LVQbnKrtN
         kLxikMyu4PvVr/mmze5X7noWqPFPaTbufRZpmFHY4dfJGxjw6d4wCqv18WBrW3+xW1b9
         3Sxdk+171TyqRpTAlJ4GofmaSGYIxLj2zCazVr74Sihz/aqD+pwEtoWbU269kzmbCOx+
         vlTbP3rXWrv5nEBTHPMChRmUricBvwTy1KnnkmwS0RAHklRd5Q5sb76PdoMPgWJLJo9E
         ByQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RiC37rNPR4a6uru5/EwXzzxZEL0IM2Ie7OOtTBN7fvk=;
        b=HbDwbJ1FRyZmUBDoT0u/FBKelcXSWEFR3Zyy3pdADWOufuznBNqU9Ta5AeQg7BN9gr
         RMgN4/w6IhWl5LKF+lqw+ok42iS6cge8BnExyu0dUT2rstWZ3KL+ExYcPlcfnZinKedb
         O6x7rk7x3/bo6sZDCpEOjDJzb+LeXzNf/AnnYuKsL5Jss/0T6LL1Ysn8QNww1UksKYsV
         cX199DJ4GC5Of7oLj9F7Q4XqvMnZpa/LPdx1KyONQo3MVcUFYK6mHOg3Q8E38nafVPwa
         qixFIKv4S84QZkyKas0umCM49ejVL5C+tscldxz+3RNCnP7qoIYcG9/+aGTQMLlqReWV
         sLoA==
X-Gm-Message-State: AFeK/H2qgeC5bQXgLnlKqrXwjXDQYeRl+NMNuYYvrlmv3V7VvLlCSW6PAFma5uFr4+NoPOwx
X-Received: by 10.84.232.70 with SMTP id f6mr7078020pln.102.1490055123992;
        Mon, 20 Mar 2017 17:12:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:38a6:f549:ebc4:4d51])
        by smtp.gmail.com with ESMTPSA id m6sm35545336pgn.58.2017.03.20.17.12.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 17:12:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, mfick@codeaurora.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] submodule.c: port is_submodule_modified to use porcelain 2
Date:   Mon, 20 Mar 2017 17:11:54 -0700
Message-Id: <20170321001156.21915-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.402.g0501f7a28e
In-Reply-To: <20170321001156.21915-1-sbeller@google.com>
References: <20170321001156.21915-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate 'is_submodule_modified' to the new porcelain format of
git-status.

As the old porcelain only reported ' M' for submodules, no
matter what happened inside the submodule (untracked files,
changes to tracked files or move of HEAD), the new API
properly reports the different scenarios.

In a followup patch we will make use of these finer grained
reporting for git-status.

While porting this to the new API, add another extension
point that will get used in the future: When a submodule
is broken (e.g. the .git file pointing to a wrong directory,
not containing a git dir, as fallout of e.g. f8eaa0ba98
(submodule--helper, module_clone: always operate on absolute
paths, 2016-03-31)), we can chose to not die and report it
differently.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 85 +++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3200b7bb2b..81d44cb7e9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1041,67 +1041,80 @@ int fetch_populated_submodules(const struct argv_array *options,
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
-	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *argv[] = {
-		"status",
-		"--porcelain",
-		NULL,
-		NULL,
-	};
 	struct strbuf buf = STRBUF_INIT;
 	unsigned dirty_submodule = 0;
-	const char *line, *next_line;
 	const char *git_dir;
+	int error_code = 0;
 
 	strbuf_addf(&buf, "%s/.git", path);
-	git_dir = read_gitfile(buf.buf);
-	if (!git_dir)
-		git_dir = buf.buf;
-	if (!is_directory(git_dir)) {
-		strbuf_release(&buf);
-		/* The submodule is not checked out, so it is not modified */
-		return 0;
+	git_dir = resolve_gitdir_gently(buf.buf, &error_code);
 
+	if (!git_dir) {
+		switch (error_code) {
+		case READ_GITFILE_ERR_STAT_FAILED:
+		case READ_GITFILE_ERR_NOT_A_FILE:
+			/* We may have an uninitialized repo here */
+			return 0;
+		default:
+		case READ_GITFILE_ERR_OPEN_FAILED:
+		case READ_GITFILE_ERR_READ_FAILED:
+		case READ_GITFILE_ERR_INVALID_FORMAT:
+		case READ_GITFILE_ERR_NO_PATH:
+		case READ_GITFILE_ERR_NOT_A_REPO:
+		case READ_GITFILE_ERR_TOO_LARGE:
+			/*
+			 * All these other error codes are indicating
+			 * a broken submodule. We do not know what is
+			 * right here. Resolve again triggering die()
+			 * inside of the parsing.
+			 */
+			read_gitfile_gently(buf.buf, NULL);
+			die("BUG: read_gitfile_gently should have died.");
+		}
 	}
+
 	strbuf_reset(&buf);
 
+	argv_array_pushl(&cp.args, "status", "--porcelain=2", NULL);
 	if (ignore_untracked)
-		argv[2] = "-uno";
+		argv_array_push(&cp.args, "-uno");
 
-	cp.argv = argv;
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
 	cp.dir = path;
 	if (start_command(&cp))
-		die("Could not run 'git status --porcelain' in submodule %s", path);
+		die("Could not run 'git status --porcelain=2' in submodule %s", path);
 
-	len = strbuf_read(&buf, cp.out, 1024);
-	line = buf.buf;
-	while (len > 2) {
-		if ((line[0] == '?') && (line[1] == '?')) {
+	while (strbuf_getwholeline_fd(&buf, cp.out, '\n') != EOF) {
+		/* regular untracked files */
+		if (buf.buf[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-				break;
-		} else {
-			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-			if (ignore_untracked ||
-			    (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))
-				break;
+
+		/* regular unmerged and renamed files */
+		if (buf.buf[0] == 'u' ||
+		    buf.buf[0] == '1' ||
+		    buf.buf[0] == '2') {
+			if (buf.buf[5] == 'S') {
+				/* nested submodule handling */
+				if (buf.buf[6] == 'C' || buf.buf[7] == 'M')
+					dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+				if (buf.buf[8] == 'U')
+					dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+			} else
+				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 		}
-		next_line = strchr(line, '\n');
-		if (!next_line)
-			break;
-		next_line++;
-		len -= (next_line - line);
-		line = next_line;
+
+		if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED &&
+		    dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+				break;
 	}
 	close(cp.out);
 
 	if (finish_command(&cp))
-		die("'git status --porcelain' failed in submodule %s", path);
+		die("'git status --porcelain=2' failed in submodule %s", path);
 
 	strbuf_release(&buf);
 	return dirty_submodule;
-- 
2.12.0.402.g4b3201c2d6.dirty

