Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407BE2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbcKOXHH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:07:07 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35906 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934857AbcKOXHF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:07:05 -0500
Received: by mail-pg0-f41.google.com with SMTP id f188so71371680pgc.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LXY/NnR9FQ5P2H2XdKucX4rxIw9hUc8Kb2Ni8faCcpA=;
        b=l61Rh+oxffuGlPJ7Ey25CMZh0xUMPib4YrgAoYfm2tuHdiW7X2PDSK3vn8ystZ1vkA
         dwY8K/UqpgRTqrwJru/LhyjTmi+EcmevHi8Q3YwEfiJ3alZxm6F384MYhwSxC85NM+hx
         FPx9cyfPKVK8Wpl1z2C7qLZFfqT5crRuAb0hg1vLpOikyxaEGHfDsuWAwSqAd7gfO8Ie
         yr+iaSkdY1peRj06lHlxAPSABRtimnLt1xGqHAEU2X+QhqLo3utXKS+Vdapg9EEeInw3
         E3Sb3arFu1nhfEyt7VJkmgFubK8Klv9Uq77cnTb/H0MFP5UFYj9ATtK8o784DOOsbB/+
         KEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LXY/NnR9FQ5P2H2XdKucX4rxIw9hUc8Kb2Ni8faCcpA=;
        b=gsASApliY+WbTiU41uqszBHuNqB7oPkxHzWcL3Jzn5CLl1VJfjuldDWtrkKsaIX6L3
         5sesz1vw8KWIbdWJ78vCay1JspgjcUMEXlnyGYRdWT1pnh/PLWi4rSmE0NnlV6I1OlNj
         keRXn5kamKxEmRNt67dU9EklOelEH6RvWj0p78RZpZBtCnOC3HzVgB9D9Dk6YmP08Ugy
         B6ER+ip4YsHECEmQFppwUk1yW43/A9sxwC+mCrF33V6I9rSXbiUc2B0DoU3pokUNZ8WN
         zkRW/TQky5Yja7BjKli8WJVBT1hfDMcgT1VRrkg2CXUAx3KImWVJdaZWd24bw/5enPgK
         zlqg==
X-Gm-Message-State: ABUngveLzbWOZn2h1hxl3W68X9zMnobEAGa+r1sZPOBQkpChMREYLvQmq7UOgjMeVbnj2VaW
X-Received: by 10.98.204.138 with SMTP id j10mr61549pfk.83.1479251224512;
        Tue, 15 Nov 2016 15:07:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id c2sm46312912pfl.66.2016.11.15.15.07.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:07:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/16] update submodules: add depopulate_submodule
Date:   Tue, 15 Nov 2016 15:06:43 -0800
Message-Id: <20161115230651.23953-9-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement the functionality needed to enable work tree manipulating
commands to that a deleted submodule should not only affect the index
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
 entry.c     |  8 ++++++++
 submodule.c | 25 +++++++++++++++++++++++++
 submodule.h |  1 +
 4 files changed, 36 insertions(+)

diff --git a/cache.h b/cache.h
index a50a61a..65c47e4 100644
--- a/cache.h
+++ b/cache.h
@@ -2018,4 +2018,6 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
 
+void remove_subtree_or_die(const char *path);
+
 #endif /* CACHE_H */
diff --git a/entry.c b/entry.c
index c6eea24..019826b 100644
--- a/entry.c
+++ b/entry.c
@@ -73,6 +73,14 @@ static void remove_subtree(struct strbuf *path)
 		die_errno("cannot rmdir '%s'", path->buf);
 }
 
+void remove_subtree_or_die(const char *path)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_addstr(&sb, path);
+	remove_subtree(&sb);
+	strbuf_release(&sb);
+}
+
 static int create_file(const char *path, unsigned int mode)
 {
 	mode = (mode & 0100) ? 0777 : 0666;
diff --git a/submodule.c b/submodule.c
index d34b721..0fa4613 100644
--- a/submodule.c
+++ b/submodule.c
@@ -308,6 +308,31 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	strbuf_release(&sb);
 }
 
+int depopulate_submodule(const char *path)
+{
+	int ret = 0;
+	char *dot_git = xstrfmt("%s/.git", path);
+
+	/* Is it populated? */
+	if (!resolve_gitdir(dot_git))
+		goto out;
+
+	/* Does it have a .git directory? */
+	if (!submodule_uses_gitfile(path)) {
+		warning(_("cannot remove submodule '%s' because it (or one of "
+			  "its nested submodules) uses a .git directory"),
+			  path);
+		ret = -1;
+		goto out;
+	}
+
+	remove_subtree_or_die(path);
+
+out:
+	free(dot_git);
+	return ret;
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
diff --git a/submodule.h b/submodule.h
index 3df6881..8518cf3 100644
--- a/submodule.h
+++ b/submodule.h
@@ -65,6 +65,7 @@ extern void set_config_update_recurse_submodules(int value);
  */
 extern int submodule_is_interesting(const char *path, const unsigned char *sha1);
 extern int submodules_interesting_for_update(void);
+extern int depopulate_submodule(const char *path);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.10.1.469.g00a8914

