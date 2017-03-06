Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24DB620133
	for <e@80x24.org>; Mon,  6 Mar 2017 23:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbdCFXQb (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 18:16:31 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33607 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbdCFXQa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 18:16:30 -0500
Received: by mail-pg0-f45.google.com with SMTP id 25so71493582pgy.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 15:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kv2LM54DgKqnql7/SRllL5VfzqdMDcFVDxhoQpK88jY=;
        b=Tfpf9LhxbWgWh6tnP39h/SI64W2j5WT28/WdLzTjnSTGVM8SyJjs6G0g9tUSDWcIW1
         A63Fif6bheLdN67wgbLXZUXBKUM0p/pHuokcyYiM0D/3wV/yVg0in5WAqvHxeie5Lw90
         5UCsQJDPek7nf22IfLxdfqMvKptlDsVbFnQmWrkMezwt33FfxtKzEDRYkK9JaKg67O9s
         kTRBNzcboY/xRQ7Rh8WY9itaPjz4btdrks3EIHx/Oa5a3JqYjl29bIIpMMlvzVxv8A6w
         nYiFWVUXLEltF2+fopzUnFgQ4WxRELUzvSZEYvP3EECsrMi3/DmIiyT9jz5LAY2LlE2N
         SfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kv2LM54DgKqnql7/SRllL5VfzqdMDcFVDxhoQpK88jY=;
        b=YffY5vt0kFb/T3USRtMZnxvIDz/wAXp1Z2vPRLzgDs/4apiHjNHgKSI9eTiBf8ibPl
         WwrYvce3snuRiU3jtmHtFTV8tPjLW9Q/Bn/IpXQHKesoZc1JEbUJLH79OH/ynXrVwjGC
         kbkqP2GLdDZ3Zg1kvw2N9xXFUgXNLAv7VMXN3GKu8qOI1NLdkyL/GAwxS9OPJ/wpo3EM
         EO7OwcNAQ85vE2Eqiaf9DrLxQMDm/0oObcgiTTyAJPjsw4U1XpIoqllsQA6Jvw8GpbY0
         oDrm7yt6G1m0zwVHiPCY+0WEx3QzchnCETjcDX5Ph5i3Ym6WgxhlNILCNPS95QBZzAh7
         3vMw==
X-Gm-Message-State: AMke39kRAPToM+oWYJj2UIQ7jt3UaIRFJcZJfnuulP4msg2kA5xSsjmquhMtJir7MHJZZOJo
X-Received: by 10.84.129.67 with SMTP id 61mr30695102plb.16.1488841642075;
        Mon, 06 Mar 2017 15:07:22 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id f3sm28517152pga.34.2017.03.06.15.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 15:07:21 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, peff@peff.net
Subject: [RFC PATCH] grep: fix bug when recursing with relative pathspec
Date:   Mon,  6 Mar 2017 15:07:17 -0800
Message-Id: <20170306230717.29095-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.rc1.440.g5b76565f74-goog
In-Reply-To: <20170224235100.52627-1-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the --recurse-submodules flag with a relative pathspec which
includes "..", an error is produced inside the child process spawned for
a submodule.  When creating the pathspec struct in the child, the ".."
is interpreted to mean "go up a directory" which causes an error stating
that the path ".." is outside of the repository.

While it is true that ".." is outside the scope of the submodule, it is
confusing to a user who originally invoked the command where ".." was
indeed still inside the scope of the superproject.  Since the child
process launched for the submodule has some context that it is operating
underneath a superproject, this error could be avoided.

This patch fixes the bug by passing the 'prefix' to the child process.
Now each child process that works on a submodule has two points of
reference to the superproject: (1) the 'super_prefix' which is the path
from the root of the superproject down to root of the submodule and (2)
the 'prefix' which is the path from the root of the superproject down to
the directory where the user invoked the git command.

With these two pieces of information a child process can correctly
interpret the pathspecs provided by the user as well as being able to
properly format the its output relative to the directory the user
invoked a git command from.

Signed-off-by: Brandon Williams <bmwill@google.com>
---

After taking a closer look at this bug I determined that I did a poor job at
thinking of all the corner cases when implementing a recursive grep.  As it
turns out I think we really need to pass on the prefix information to the child
process so that it has enough context to do path matching and to format its
output.  Unfortunately I don't know the best way to pass on this information
without breaking other commands that rely on the GIT_PREFIX being overridden
during discovery.  Maybe we'll need to add in another env var to account for
that?  For the purposes of showing how to fix this bug while still getting the
test suite to pass, I have git respect the GIT_PREFIX env var only if the
super_prefix is set (which it should only be used in submodule operations at
this point in time).  Its a pretty hacky fix, so I'm up for other suggestions
on how to properly pass on this information to the child process.


 builtin/grep.c                     | 39 ++++++++++++--------
 git.c                              |  2 --
 setup.c                            |  5 +++
 t/t7814-grep-recurse-submodules.sh | 73 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 17 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2c727ef49..acecad0e0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -310,10 +310,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 {
 	struct strbuf pathbuf = STRBUF_INIT;
 
-	if (opt->relative && opt->prefix_length) {
-		quote_path_relative(filename + tree_name_len, opt->prefix, &pathbuf);
-		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
-	} else if (super_prefix) {
+	if (super_prefix) {
 		strbuf_add(&pathbuf, filename, tree_name_len);
 		strbuf_addstr(&pathbuf, super_prefix);
 		strbuf_addstr(&pathbuf, filename + tree_name_len);
@@ -321,6 +318,13 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 		strbuf_addstr(&pathbuf, filename);
 	}
 
+	if (opt->relative && opt->prefix_length) {
+		char *name = strbuf_detach(&pathbuf, NULL);
+		quote_path_relative(name + tree_name_len, opt->prefix, &pathbuf);
+		strbuf_insert(&pathbuf, 0, name, tree_name_len);
+		free(name);
+	}
+
 #ifndef NO_PTHREADS
 	if (num_threads) {
 		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, sha1);
@@ -345,12 +349,14 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
 
+	if (super_prefix)
+		strbuf_addstr(&buf, super_prefix);
+	strbuf_addstr(&buf, filename);
+
 	if (opt->relative && opt->prefix_length) {
-		quote_path_relative(filename, opt->prefix, &buf);
-	} else {
-		if (super_prefix)
-			strbuf_addstr(&buf, super_prefix);
-		strbuf_addstr(&buf, filename);
+		char *name = strbuf_detach(&buf, NULL);
+		quote_path_relative(name, opt->prefix, &buf);
+		free(name);
 	}
 
 #ifndef NO_PTHREADS
@@ -399,13 +405,12 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 }
 
 static void compile_submodule_options(const struct grep_opt *opt,
-				      const struct pathspec *pathspec,
+				      const char **argv,
 				      int cached, int untracked,
 				      int opt_exclude, int use_index,
 				      int pattern_type_arg)
 {
 	struct grep_pat *pattern;
-	int i;
 
 	if (recurse_submodules)
 		argv_array_push(&submodule_options, "--recurse-submodules");
@@ -523,9 +528,8 @@ static void compile_submodule_options(const struct grep_opt *opt,
 
 	/* Add Pathspecs */
 	argv_array_push(&submodule_options, "--");
-	for (i = 0; i < pathspec->nr; i++)
-		argv_array_push(&submodule_options,
-				pathspec->items[i].original);
+	for (; *argv; argv++)
+		argv_array_push(&submodule_options, *argv);
 }
 
 /*
@@ -549,6 +553,11 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	prepare_submodule_repo_env(&cp.env_array);
 	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
 
+	if (opt->relative && opt->prefix_length)
+		argv_array_pushf(&cp.env_array, "%s=%s",
+				 GIT_PREFIX_ENVIRONMENT,
+				 opt->prefix);
+
 	/* Add super prefix */
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
 			 super_prefix ? super_prefix : "",
@@ -1206,7 +1215,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (recurse_submodules) {
 		gitmodules_config();
-		compile_submodule_options(&opt, &pathspec, cached, untracked,
+		compile_submodule_options(&opt, argv + i, cached, untracked,
 					  opt_exclude, use_index,
 					  pattern_type_arg);
 	}
diff --git a/git.c b/git.c
index b367cf668..b05108afd 100644
--- a/git.c
+++ b/git.c
@@ -361,8 +361,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	if (!help && get_super_prefix()) {
 		if (!(p->option & SUPPORT_SUPER_PREFIX))
 			die("%s doesn't support --super-prefix", p->cmd);
-		if (prefix)
-			die("can't use --super-prefix from a subdirectory");
 	}
 
 	if (!help && p->option & NEED_WORK_TREE)
diff --git a/setup.c b/setup.c
index 1b534a750..0de379319 100644
--- a/setup.c
+++ b/setup.c
@@ -936,10 +936,15 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	const char *prefix;
+	const char *env_prefix;
 
 	prefix = setup_git_directory_gently_1(nongit_ok);
+	env_prefix = getenv(GIT_PREFIX_ENVIRONMENT);
+
 	if (prefix)
 		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
+	else if (env_prefix && get_super_prefix())
+		prefix = env_prefix;
 	else
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 67247a01d..d8ed3d64f 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -227,6 +227,79 @@ test_expect_success 'grep history with moved submoules' '
 	test_cmp expect actual
 '
 
+test_expect_success 'grep using relative path' '
+	test_when_finished "rm -rf parent sub" &&
+	git init sub &&
+	echo "foobar" >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+
+	git init parent &&
+	echo "foobar" >parent/file &&
+	git -C parent add file &&
+	mkdir parent/src &&
+	echo "foobar" >parent/src/file2 &&
+	git -C parent add src/file2 &&
+	git -C parent submodule add ../sub &&
+	git -C parent commit -m "add files and submodule" &&
+
+	# From top works
+	cat >expect <<-\EOF &&
+	file:foobar
+	src/file2:foobar
+	sub/file:foobar
+	EOF
+	git -C parent grep --recurse-submodules -e "foobar" >actual &&
+	test_cmp expect actual &&
+
+	# Relative path to top errors out
+	cat >expect <<-\EOF &&
+	../file:foobar
+	file2:foobar
+	../sub/file:foobar
+	EOF
+	git -C parent/src grep --recurse-submodules -e "foobar" -- .. >actual &&
+	test_cmp expect actual &&
+
+	# Relative path to submodule errors out
+	cat >expect <<-\EOF &&
+	../sub/file:foobar
+	EOF
+	git -C parent/src grep --recurse-submodules -e "foobar" -- ../sub >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep from a subdir' '
+	test_when_finished "rm -rf parent sub" &&
+	git init sub &&
+	echo "foobar" >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+
+	git init parent &&
+	mkdir parent/src &&
+	echo "foobar" >parent/src/file &&
+	git -C parent add src/file &&
+	git -C parent submodule add ../sub src/sub &&
+	git -C parent submodule add ../sub sub &&
+	git -C parent commit -m "add files and submodules" &&
+
+	cat >expect <<-\EOF &&
+	src/file:foobar
+	src/sub/file:foobar
+	sub/file:foobar
+	EOF
+	git -C parent grep --recurse-submodules -e "foobar" >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	file:foobar
+	sub/file:foobar
+	EOF
+	git -C parent/src grep --recurse-submodules -e "foobar" >actual &&
+	test_cmp expect actual
+'
+
 test_incompatible_with_recurse_submodules ()
 {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
-- 
2.12.0.rc1.440.g5b76565f74-goog

