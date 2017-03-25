Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E781FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 00:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935946AbdCYAga (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 20:36:30 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34541 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935889AbdCYAgY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 20:36:24 -0400
Received: by mail-pg0-f52.google.com with SMTP id 21so2662745pgg.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 17:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xcCt0GQppQtufs9C6vXvxBtEdrEfisTK9Ig7nFrTtQ0=;
        b=cWCue2LVEF7++ARCt8XYQQtV3OEmnmDxBaVyNEc1tqKnef6RTXSlcMpbPEmRdX3HvT
         TJ5By1NbCS84igtg2u3oRiPznVFldMvy9pRtUFx0xMFhkP3sUnjPeBHWmr55SFAK5XJl
         QV8qgwVHtrG2n5i4v9rqqqXrmNCT+eIUypAPIF1AD+GW0IjZgCWJPyesOzhYCLUOWu86
         Osv6zNLK+MYrorjHxbH/yifbY7r3yNijB5Kqq+QubzZhrrc0zHpeMFzHKHGis57F568V
         zdeAeS32lrBHZ8z3zHwYAvcbBdhFfZzjXY3GRhll1GezLUFncKSzLfDOQiuVytsJsNaW
         KKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xcCt0GQppQtufs9C6vXvxBtEdrEfisTK9Ig7nFrTtQ0=;
        b=tbpc4uwPbZV0qHt/tXvEToyyezNDgXAZOc4aNo4x1E/Zs6/vcUeXTClsanXlTdUgFK
         1vHD7Jx1aKTWtPyFLbwwXBovgd+PDhbmqiNBRgOE0Dt/ND2bTWubU0r30PaTMxZOvrwz
         BjoqdXtjJXXaR4doGt/x99HsMPh0clln840TQR6kIW3gX5MNskFgW6N4liO+cy5GOw9u
         Mo25jt9TCSBlfmJopi3ycpscvvr3UGvO+SL4vFbnQM69VLkpfMQdAANh+LQzwGhW6PZF
         lTXMODSTL5LYqY8NXnpkqVJFwJozRusnYyDFg959V1HqQNzKbO4440QIiq2o8n3ZlL84
         szSQ==
X-Gm-Message-State: AFeK/H1YYtqrn2cKmXgJCKXfvTqcs7EC1m+y4FdD7WmGztqm48d2JP/Mo0ESFgjSarn08GmG
X-Received: by 10.98.9.29 with SMTP id e29mr12450924pfd.101.1490402182651;
        Fri, 24 Mar 2017 17:36:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id i3sm6748025pfg.117.2017.03.24.17.36.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 17:36:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/7] submodule.c: convert is_submodule_modified to use strbuf_getwholeline
Date:   Fri, 24 Mar 2017 17:36:06 -0700
Message-Id: <20170325003610.15282-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.gdeb397943c.dirty
In-Reply-To: <20170325003610.15282-1-sbeller@google.com>
References: <20170324182902.19280-1-sbeller@google.com>
 <20170325003610.15282-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of implementing line reading yet again, make use of our beautiful
library function to read one line.  By using strbuf_getwholeline instead
of strbuf_read, we avoid having to allocate memory for the entire child
process output at once.  That is, we limit maximum memory usage.
Also we can start processing the output as it comes in, no need to
wait for all of it.

Once we know all information that we care about, we can terminate
the child early. In that case we do not care about its exit code as well.
By just closing our side of the pipe the child process will get a SIGPIPE
signal, which it will not report nor do we report it in finish_command,
ac78663b0d (run-command: don't warn on SIGPIPE deaths, 2015-12-29).

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                 | 30 ++++++++++++++----------------
 t/t7506-status-submodule.sh | 18 +++++++++++++++++-
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/submodule.c b/submodule.c
index 93e3fefd39..e72781d9f2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1041,12 +1041,12 @@ int fetch_populated_submodules(const struct argv_array *options,
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
-	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
+	FILE *fp;
 	unsigned dirty_submodule = 0;
-	const char *line, *next_line;
 	const char *git_dir;
+	int ignore_cp_exit_code = 0;
 
 	strbuf_addf(&buf, "%s/.git", path);
 	git_dir = read_gitfile(buf.buf);
@@ -1072,29 +1072,27 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	if (start_command(&cp))
 		die("Could not run 'git status --porcelain' in submodule %s", path);
 
-	len = strbuf_read(&buf, cp.out, 1024);
-	line = buf.buf;
-	while (len > 2) {
-		if ((line[0] == '?') && (line[1] == '?'))
+	fp = xfdopen(cp.out, "r");
+	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
+		if ((buf.buf[0] == '?') && (buf.buf[1] == '?'))
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 		else
 			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 
 		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
 		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
-		     ignore_untracked))
-			break;
-
-		next_line = strchr(line, '\n');
-		if (!next_line)
+		     ignore_untracked)) {
+			/*
+			 * We're not interested in any further information from
+			 * the child any more, neither output nor its exit code.
+			 */
+			ignore_cp_exit_code = 1;
 			break;
-		next_line++;
-		len -= (next_line - line);
-		line = next_line;
+		}
 	}
-	close(cp.out);
+	fclose(fp);
 
-	if (finish_command(&cp))
+	if (finish_command(&cp) && !ignore_cp_exit_code)
 		die("'git status --porcelain' failed in submodule %s", path);
 
 	strbuf_release(&buf);
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d31b34da83..51f8d0d034 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -177,8 +177,24 @@ test_expect_success 'status with added file in modified submodule with .git file
 	test_i18ngrep "modified:   sub (new commits, modified content)" output
 '
 
+test_expect_success 'status with a lot of untracked files in the submodule' '
+	(
+		cd sub
+		i=0 &&
+		while test $i -lt 1024
+		do
+			>some-file-$i
+			i=$(( $i + 1 ))
+		done
+	) &&
+	git status --porcelain sub 2>err.actual &&
+	test_must_be_empty err.actual &&
+	rm err.actual
+'
+
 test_expect_success 'rm submodule contents' '
-	rm -rf sub/* sub/.git
+	rm -rf sub &&
+	mkdir sub
 '
 
 test_expect_success 'status clean (empty submodule dir)' '
-- 
2.12.0.rc1.49.gdeb397943c.dirty

