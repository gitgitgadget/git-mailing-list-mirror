Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F755C4332F
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 23:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiLAXde (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 18:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiLAXdR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 18:33:17 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91BF2182D
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 15:32:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o5so5363608wrm.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 15:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vUz/v1R+h6mc83iVwVVBPZc9+n3WMhNQXT2iiEy00lw=;
        b=JUq1YmwLw9/hF71n+9m1J4q/okn9UQodShd0q25dbZlKGh85m5NR1g5p8fb09Tn5pG
         KrZI6w0EBRF+VslD+1dkcOlPhPh2wrc6b/3OT0dYyYse4LcOF1CZ/rjdsAaCW5kCVWWe
         ixA1451e4sUkRG3lOHSoEApSiSKiw7e+IZlT6XhqwvudhMvGNlK6Az4gHXFTwpK54gpk
         jz/hSy8Vqkzx2YBkQ80WqLqSIrscYvpHDEDAPqOqE36pRv2jKJcoSLH2n5eTvdI0YWQO
         5AIYQlMxE0HLjCu3wuSjlYcWnhq9hIfqqq115yS7QOd1q1V204XEt/slY+Bd3rS0EY81
         Pk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUz/v1R+h6mc83iVwVVBPZc9+n3WMhNQXT2iiEy00lw=;
        b=r+k5RVFzxG8cEc4Ejz4sFJ0Vi80VsBg9qGD8xJKHDnGwhUD8n7tGlwB3jRb4NpETmK
         9JU/JiSi5ZiGKo5b7vu+RUzF5TytUD4uQFSn0MjNTAMDPTnpYfEXGBAQkHDdqcUB2oFd
         n8atKsdbXz1JEKaHddujECm+cigHxiDBPdYCMWyc1u/3D3qVMMxdaHdK0GsIK268Axni
         a9+XEvRGtyodCEEx1+4856bqZ1jBUwH3cYtinSuEHkfWybaMZ20ViEDO4k+uX1Azo8qM
         na+xB1NIsLf0hJnMdVGxAivN7EXp8zZ6f2+h40jEfULZFn6h9cFLG7B+aC4a5t/CAQWo
         PvPw==
X-Gm-Message-State: ANoB5pmp8gaLAXnrO/oPSr2CSxXxD9R+tSoYo1sm2TxS6XwnE09w4eEl
        UroPnJj8V3zS1jMCltNJiOyOejgle48=
X-Google-Smtp-Source: AA0mqf4CQXoSDIFDyCMpo9Bo2tThcCqL7m1w2c+6+9SDeUWPt+kM/owc/fAU7TbBqvtnQJyscxl6cg==
X-Received: by 2002:adf:f990:0:b0:242:3353:26ef with SMTP id f16-20020adff990000000b00242335326efmr4045820wrr.248.1669937536030;
        Thu, 01 Dec 2022 15:32:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d6b0f000000b002421ed1d8c8sm5412869wrw.103.2022.12.01.15.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:32:15 -0800 (PST)
Message-Id: <pull.1437.git.1669937534944.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Dec 2022 23:32:14 +0000
Subject: [PATCH] fsmonitor: fix race seen in t7527
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhostetler@github.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhostetler@github.com>

Fix racy tests in t7527 by forcing the use of cookie files during all
types of queries.  There were originaly observed on M1 macs with file
system encryption enabled.

There were a series of simple tests, such as "edit some files" and
"create some files", that started the daemon with GIT_TRACE_FSMONITOR
enabled so that the daemon would emit "event: <path>" messages to the
trace log.  The test would make worktree modifications and then grep
the log file to confirm it contained the expected trace messages.
The greps would occasionally racily-fail.  The expected messages
were always present in the log file, just not yet always present
when the greps ran.

NEEDSWORK: One could argue that the tests should use the `test-tool
fsmonitor-client query` and search for the expected pathnames in the
output rather than grepping the trace log, but I'll leave that for a
later exercise.

The racy tests called `test-tool fsmonitor-client query --token 0`
before grepping the log file.  (Presumably to introduce a small delay
and/or to let the daemon sync with the file system following the last
modification, but that was not always sufficient and hence the race.)

When the query arg is just "0", the daemon treated it as a V1
(aka timestamp-relative request) and responded with a "trivial
response" and a new token, but without trying to catch up to the
the file system event stream.  So the "event: <path>" messages
may or may not yet be in the log file when the grep commands
started.

FWIW, if the tests had sent `--token builtin:0:0` instead, it would
have forced a slightly different code path in the daemon that would
cause the daemon to use a cookie file and let it catch up with the
file system event stream.  I did not see any test failures with this
change.

Instead of modifying the test, I updated the fsmonitor--daemon to
always use a cookie file and catch up to the file system on any
query operation, regardless of the format of the request token.
This is safer.

FWIW, I think the effect of the race was limited to the test.
Commands like `git status` would always do a full scan when getting a
trivial response.  The fact that the daemon was slighly behind the
file system when it generated the response token would cause a second
`git status` to get a few extra paths that the client would have to
examine, but it would not be missing paths.

FWIW, I also think that an earlier version of the code always did
the cookie file for all types of queries, but it was optimized out
during a round of reviews or rework and we didn't notice the race.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
    fsmonitor: fix race seen in t7527
    
    Fix racy tests in t7527 by forcing the use of cookie files during all
    types of queries. There were originaly observed on M1 macs with file
    system encryption enabled.
    
    There were a series of simple tests, such as "edit some files" and
    "create some files", that started the daemon with GIT_TRACE_FSMONITOR
    enabled so that the daemon would emit "event: " messages to the trace
    log. The test would make worktree modifications and then grep the log
    file to confirm it contained the expected trace messages. The greps
    would occasionally racily-fail. The expected messages were always
    present in the log file, just not yet always present when the greps ran.
    
    NEEDSWORK: One could argue that the tests should use the test-tool
    fsmonitor-client query and search for the expected pathnames in the
    output rather than grepping the trace log, but I'll leave that for a
    later exercise.
    
    The racy tests called test-tool fsmonitor-client query --token 0 before
    grepping the log file. (Presumably to introduce a small delay and/or to
    let the daemon sync with the file system following the last
    modification, but that was not always sufficient and hence the race.)
    
    When the query arg is just "0", the daemon treated it as a V1 (aka
    timestamp-relative request) and responded with a "trivial response" and
    a new token, but without trying to catch up to the the file system event
    stream. So the "event: " messages may or may not yet be in the log file
    when the grep commands started.
    
    FWIW, if the tests had sent --token builtin:0:0 instead, it would have
    forced a slightly different code path in the daemon that would cause the
    daemon to use a cookie file and let it catch up with the file system
    event stream. I did not see any test failures with this change.
    
    Instead of modifying the test, I updated the fsmonitor--daemon to always
    use a cookie file and catch up to the file system on any query
    operation, regardless of the format of the request token. This is safer.
    
    FWIW, I think the effect of the race was limited to the test. Commands
    like git status would always do a full scan when getting a trivial
    response. The fact that the daemon was slighly behind the file system
    when it generated the response token would cause a second git status to
    get a few extra paths that the client would have to examine, but it
    would not be missing paths.
    
    FWIW, I also think that an earlier version of the code always did the
    cookie file for all types of queries, but it was optimized out during a
    round of reviews or rework and we didn't notice the race.
    
    Signed-off-by: Jeff Hostetler jeffhostetler@github.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1437%2Fjeffhostetler%2Ffsmonitor-t7527-race-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1437/jeffhostetler/fsmonitor-t7527-race-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1437

 builtin/fsmonitor--daemon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 6f30a4f93a7..6607130c9f4 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -710,6 +710,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 				  "fsmonitor: unsupported V1 protocol '%s'"),
 				 command);
 		do_trivial = 1;
+		do_cookie = 1;
 
 	} else {
 		/* We have "builtin:*" */
@@ -719,6 +720,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 					 "fsmonitor: invalid V2 protocol token '%s'",
 					 command);
 			do_trivial = 1;
+			do_cookie = 1;
 
 		} else {
 			/*

base-commit: 7452749a781d84244ecd08c6f6ca7e5df67dfce8
-- 
gitgitgadget
