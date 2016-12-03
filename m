Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1FC1FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757143AbcLCAbB (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:01 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36294 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755092AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pg0-f44.google.com with SMTP id f188so112439667pgc.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bhewGVHn/Ir/vrpYglyWFw38QzHhYN0CWbId9aUEz34=;
        b=SI3WXhm6Nptux7zYetuXVjPwWYWRm+aUyEiAQUknGqBDBT2ApGWKgQcK8Nuygu1A72
         ZLHF6mYh4VX4zBjhAMrBNf23HZRveSR3lBWOsoRFMe8layKfT6ZxAQxw7VfMCTN5rIUp
         mgIPuyhJ2q947vy4b0ZHFB4rV8agaAgvklcvlY9EJn0VNwB44BXr/Yb2kNmU3mtQrsPU
         3QGP5uclRFgwLNH2iamUTC2+UxLci88/BwEEJd1tt7IUSI33BgfCc91LUYvVytmtXSez
         sx81S2MZCLRMyzsqOqi+8/2fbqmzBp0K8h+iruCtydnHzDabdTXUHOep2F//7TY8ixE/
         IZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bhewGVHn/Ir/vrpYglyWFw38QzHhYN0CWbId9aUEz34=;
        b=mHD3J+hUvtl8wtcIfCHXRUrxgkdyJO4mFGwUM0nN03+ebQo84fZ7VCmFM4/W8k4/KD
         H+u9bulFDqjMUFXe+eQkNN4a73Z6+kuRuMgN7iHimVhqc+Q/+eCXrCCh6d4nbae+JhK3
         TqZkCs9BEkTZFYiJim3pRsiqN6w3keSa2GUrVtBl9lSc0PLA8wkevcCgVeoKHl7j+9Ov
         kmnJaKCSiJF57IZ1uJRK5xr+oYGn1m76PC2bKR2Jo9aCg1EL5+qUO3eoDoBYe1jpUfAx
         f+pSsB2TsRI+V2gSpyQ20Pa9BkQOFe7bbNOzBHDQmNGSJOxuCLY88K+TUvQMXPUW2wdO
         rk7g==
X-Gm-Message-State: AKaTC01delMuG9lWUfPaVoMPFJyXaE9HgINHcop/+tt7aMNSgb2EQf2Oxzo0YjVknCo/+Mes
X-Received: by 10.84.216.20 with SMTP id m20mr101991400pli.126.1480725042711;
        Fri, 02 Dec 2016 16:30:42 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id i76sm10147732pfk.89.2016.12.02.16.30.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:42 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 08/17] update submodules: add depopulate_submodule
Date:   Fri,  2 Dec 2016 16:30:13 -0800
Message-Id: <20161203003022.29797-9-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement the functionality needed to enable work tree manipulating
commands so that a deleted submodule should not only affect the index
(leaving all the files of the submodule in the work tree) but also to
remove the work tree of the superproject (including any untracked
files).

To do so, we need an equivalent of "rm -rf", which is already found in
entry.c, so expose that and for clarity add a suffix "_or_dir" to it.

That will only work properly when the submodule uses a gitfile instead of
a .git directory and no untracked files are present. Otherwise the removal
will fail with a warning (which is just what happened until now).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h     |  2 ++
 entry.c     |  5 +++++
 submodule.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h |  1 +
 4 files changed, 54 insertions(+)

diff --git a/cache.h b/cache.h
index a50a61a197..b645ca2f9a 100644
--- a/cache.h
+++ b/cache.h
@@ -2018,4 +2018,6 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
 
+extern void remove_directory_or_die(struct strbuf *path);
+
 #endif /* CACHE_H */
diff --git a/entry.c b/entry.c
index c6eea240b6..02c4ac9f22 100644
--- a/entry.c
+++ b/entry.c
@@ -73,6 +73,11 @@ static void remove_subtree(struct strbuf *path)
 		die_errno("cannot rmdir '%s'", path->buf);
 }
 
+void remove_directory_or_die(struct strbuf *path)
+{
+	remove_subtree(path);
+}
+
 static int create_file(const char *path, unsigned int mode)
 {
 	mode = (mode & 0100) ? 0777 : 0666;
diff --git a/submodule.c b/submodule.c
index 62e9ef3872..7bb64d6c69 100644
--- a/submodule.c
+++ b/submodule.c
@@ -324,6 +324,52 @@ void prepare_submodule_repo_env(struct argv_array *out)
 	argv_array_push(out, "GIT_DIR=.git");
 }
 
+int depopulate_submodule(const char *path)
+{
+	int ret = 0;
+	struct strbuf pathbuf = STRBUF_INIT;
+	char *dot_git = xstrfmt("%s/.git", path);
+
+	/* Is it populated? */
+	if (!resolve_gitdir(dot_git))
+		goto out;
+
+	/* Does it have a .git directory? */
+	if (!submodule_uses_gitfile(path)) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+
+		prepare_submodule_repo_env(&cp.env_array);
+		argv_array_pushl(&cp.args, "submodule--helper",
+				 "embed-git-dirs", path, NULL);
+		cp.git_cmd = 1;
+		if (run_command(&cp)) {
+			warning(_("Cannot remove submodule '%s'\n"
+				  "because it (or one of its nested submodules) has a git \n"
+				  "directory in the working tree, which could not be embedded\n"
+				  "the superprojects git directory automatically."), path);
+			ret = -1;
+			goto out;
+		}
+
+		if (!submodule_uses_gitfile(path)) {
+			/*
+			 * We should be using a gitfile by now, let's double
+			 * check as loosing the git dir would be fatal.
+			 */
+			die("BUG: \"git submodule--helper embed git-dirs '%s'\" "
+			    "did not embed the git-dirs recursively for '%s'",
+			    path, path);
+		}
+	}
+
+	strbuf_addstr(&pathbuf, path);
+	remove_directory_or_die(&pathbuf);
+out:
+	strbuf_release(&pathbuf);
+	free(dot_git);
+	return ret;
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
diff --git a/submodule.h b/submodule.h
index 7d890e0464..d8bb1d4baf 100644
--- a/submodule.h
+++ b/submodule.h
@@ -63,6 +63,7 @@ extern void set_config_update_recurse_submodules(int value);
  */
 extern int submodule_is_interesting(const char *path);
 extern int submodules_interesting_for_update(void);
+extern int depopulate_submodule(const char *path);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.11.0.rc2.28.g2673dad

