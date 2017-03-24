Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37FBF1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965616AbdCXS3P (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:29:15 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36448 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965598AbdCXS3K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:29:10 -0400
Received: by mail-pf0-f173.google.com with SMTP id o126so4301735pfb.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WlUE45k8/Ze93kypwE5DExWpJQHi8nxh4y8f3AmhN0s=;
        b=ef2sW3bDqEc2Q/javZTqSqhbBHnq0S3rgEdt5OkmhQkAbiUWHlHRhWQQz4Tv7WCnZG
         rMM02UmflenhVRVXKDBengQ/haFtA8c0NxDPgDRZcUWC8+dp5mXyVXYbWecIn//C3A+r
         zwPPe13QVG8MMUMcADCf1X9Pu8QoPlrrqFkI+toDwaUZCKZtdGG2GZW7ghURPe6PdT1O
         BB4dWKhdo8706M8d9FfPz0UDgYeXPKnEaZ2lxqf2SlyHglLgIlrnrj4q1Y/WFJsD73IX
         WpevpF7cemkH1xnb0WKFMfshlk6Mjj/kVT7KwBSmpYW1mI9fv93jUgn+amvmlnIimcEv
         aHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WlUE45k8/Ze93kypwE5DExWpJQHi8nxh4y8f3AmhN0s=;
        b=Cb08Bhs90YfbnJEi1jkWnR97rPkwAQfDPPL0s/WnwREfGBcpKEvT7WSySsF0McIkk5
         T+wIOli41c6Eay+yiL/0KZyfxCpgpVDw5GW6LdDRaqW6zDvsKZlyE7RfkyscwuBqWjjv
         exyw3DIs3LQ1GOGEZTkWsKx71+z+HvbMho/12J9GRbzt0XGSBnvfqgWR26hIPmT0/mEq
         /DhTaC3A2q/oVMWlYFwCI6EFoSRbFYrV4luHAUcCEjg1UGtt/VGem2WGNqRch4aNsrMv
         K+QKv0/wr6fnOBXBmZFCT4Lm5R2HXDt3X32JX4ifSom6qNZcdJJSb+mnzmU3AZUgxIig
         h6nw==
X-Gm-Message-State: AFeK/H3UTQ5xa3AJFHn8+X/5rS1e+IvjxVwyWfEcG7vHT91ym8VdFqTxu4eSqeAUe3d+RRxu
X-Received: by 10.84.238.22 with SMTP id u22mr12724841plk.137.1490380148503;
        Fri, 24 Mar 2017 11:29:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id a62sm6003540pgc.60.2017.03.24.11.29.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 11:29:07 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/7] submodule.c: convert is_submodule_modified to use strbuf_getwholeline
Date:   Fri, 24 Mar 2017 11:28:58 -0700
Message-Id: <20170324182902.19280-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.437.g2b7623d507
In-Reply-To: <20170324182902.19280-1-sbeller@google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of implementing line reading yet again, make use of our beautiful
library function to read one line.  By using strbuf_getwholeline instead
of strbuf_read, we avoid having to allocate memory for the entire child
process output at once.  That is, we limit maximum memory usage.
Once we know all information that we care about, we can terminate
the child early. In that case we do not care about its exit code as well.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/submodule.c b/submodule.c
index e52cb8a958..0c43f9f2b1 100644
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
@@ -1072,28 +1072,27 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
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
-		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) || ignore_untracked))
-			break;
-
-		next_line = strchr(line, '\n');
-		if (!next_line)
+		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) || ignore_untracked)) {
+			/*
+			 * We're not interested in any further information from
+			 * the child any more, no output nor its exit code.
+			 */
+			kill(cp.pid, SIGTERM);
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
-- 
2.12.1.437.g2b7623d507

