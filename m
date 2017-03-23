Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4560220323
	for <e@80x24.org>; Thu, 23 Mar 2017 00:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbdCWAnj (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 20:43:39 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35035 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdCWAni (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 20:43:38 -0400
Received: by mail-pf0-f169.google.com with SMTP id 20so50063469pfk.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 17:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8yify7a/gDIL/o0Jsa9e4wWXndxlLDUj5gHCEcZvrzI=;
        b=NZDjw2c5fhM4wZZKUtYbysq9Qrbm+Jp6zcmdVGrmUd7QKvV5fRaIpTT0wPj3obRczp
         DnaeIzxYXH0sC/6VGKsSzHCBuQDstUJBxFOj5UX4PKA6rE871Wv3zUW3NzjeqzvsE+hd
         qt985HehqtHy5sGW+J1S6VIJzJr6lZw4F45BVkoT+vRowOnSS5cm77KDWdZaHqkCRoPA
         iY7ROLFn57TANXeGK5PUiR6rN9QlSnOvvKYP9hBqRGSaUNTbOKcdY7Cjd9myACPJ+5tb
         dsoy26QZ92l5o/UyPDjByWfSzBfcIuRQ46jYsbJvkAp9litt18/XPgLJHzozBvTPD6sk
         M3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8yify7a/gDIL/o0Jsa9e4wWXndxlLDUj5gHCEcZvrzI=;
        b=UuPfwFjGdvhjarQH+2z00IL2mLHJXPfcHt0QJm1slSHsTlic6VMphUg4LZA9jZsQFD
         bTOlhnzl7WKPV9NYJhn2Gp9Wz41u6hKpxBsJIV1Uj3au+CwT9FiRr50WpmKTXORrZWWa
         jcWsJKbuHiEX3ORdZnMIjTR4I5f2Yd8Bi7pAwuIYY5QaOW+ZWVmYkulGCFttOcllWuG/
         tj4zTqH3gGr+9n/d9zJIVs/sTZZ+nv3tLsFg+4Taw0T5irZEu3Vl8KfgfI6STHhMUE9Y
         7gNjSWt6dlyBLYpH93vjyFkd1xT4I6UuH0UfHcVwD6Q9KMkT7tgiBehgCCtKo7btPadc
         WMvg==
X-Gm-Message-State: AFeK/H3yH/M/W3paCtPblaEZRpbdRT2WZCWFqf59dFoqgzKnJSCbD2HcCDEx/K43jFYBTA6B
X-Received: by 10.98.153.198 with SMTP id t67mr49787901pfk.1.1490229815946;
        Wed, 22 Mar 2017 17:43:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1959:c634:6437:385])
        by smtp.gmail.com with ESMTPSA id m21sm6148496pgh.4.2017.03.22.17.43.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 17:43:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] submodule.c: port is_submodule_modified to use porcelain 2
Date:   Wed, 22 Mar 2017 17:43:27 -0700
Message-Id: <20170323004329.15892-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.432.gfe308fe33c.dirty
In-Reply-To: <20170323004329.15892-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com>
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

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 53 ++++++++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3200b7bb2b..d355ddb46b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1041,17 +1041,9 @@ int fetch_populated_submodules(const struct argv_array *options,
 
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
 
 	strbuf_addf(&buf, "%s/.git", path);
@@ -1066,42 +1058,45 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	}
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
2.12.1.432.gfe308fe33c.dirty

