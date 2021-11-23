Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30E2C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhKWMLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbhKWMLK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:11:10 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4845C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:08:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a9so38548478wrr.8
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mRrjrtSRClIYpPqQbrJlgYzbg0WcQhhhWixbd/iyzLc=;
        b=FTfetNcOaDWIOOfQBQ/VG1MnRlpTjs4a+LHgPNhHJdu6KyT+trvr3rPHO6dRuhrKYf
         Bg+Iu1peDgfQhKQwfR/XxLHFpmYPmOzfNmCywEFGmParaCcE893kCrDQdaPRAaza5uEE
         0edhyys7/2CPsko28LJcRAgk16FzU2BTUwvBZYcC7dwvuqdTPW/+Lwck31bRMBJ2w4QQ
         RpraguVzatJDoNw8erIuDEfkg3vPFD8sbpuAxuoYT+3HFHJZ9Bhw97+9Zdk+vTFPqEzv
         vSDdGzq7Va1Qic/DhvXty78mllJmc0thlB6OfKiRynYNq9earOSmQQUK5/3ADJHCrAtr
         Q74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mRrjrtSRClIYpPqQbrJlgYzbg0WcQhhhWixbd/iyzLc=;
        b=FdZnryR3HuZgKz3CgcvQDo2lA6oMoU20SPsE22u8mX1iF+rq27oRGtsCpAodeJnXAa
         nMUNrKU7NONGdJgMhInO6UxrFaQ7oqHlSqYs/s9+76azCopdVN2A1p2XNjn6QbRXxCbI
         GC6TomA05EmUraN5J1OZnk76wcdSo8UAre7cmFwCiDDn0OPvc1JXZx6EUsB32CyZUM0U
         4VVXCGMItC+G5egsw6uoegPVxTXTBpgBt5qJQ9R26dgnqZX0voVCxvuLAVX6PfYInGd7
         zrfvvIJK3v4mKBJOZHrt9GMPSXPZ+4+msR9gbw88f+9iYAdPcw19nzSoYlpdDKQjcsCu
         m/SQ==
X-Gm-Message-State: AOAM5308F0kvXLubZEzGTUV2W4lIbBIeSh4tRBbY0C8OtAK6w+97HLVW
        yBIr0MhnYOQZy8iNnsgFaawe7y7oieKtog==
X-Google-Smtp-Source: ABdhPJw/fm4Hs17Hh6q0gLN3XmIEaOBw0VhJDtRvUjsft/jP2Ej6z7sN5uIkWaPlreLsKnzEFeCXGg==
X-Received: by 2002:a5d:6347:: with SMTP id b7mr6488770wrw.36.1637669280129;
        Tue, 23 Nov 2021 04:08:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m9sm1220299wmq.1.2021.11.23.04.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:07:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/9] run-command API users: use strvec_pushv(), not argv assignment
Date:   Tue, 23 Nov 2021 13:06:30 +0100
Message-Id: <patch-v2-3.9-61e4eb8e173-20211123T115551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate those run-command API users that assign directly to the "argv"
member to use a strvec_pushv() of "args" instead.

In these cases it did not make sense to further refactor these
callers, e.g. daemon.c could be made to construct the arguments closer
to handle(), but that would require moving the construction from its
cmd_main() and pass "argv" through two intermediate functions.

It would be possible for a change like this to introduce a regression
if we were doing:

      cp.argv = argv;
      argv[1] = "foo";

And changed the code, as is being done here, to:

      strvec_pushv(&cp.args, argv);
      argv[1] = "foo";

But as viewing this change with the "-W" flag reveals none of these
functions modify variable that's being pushed afterwards in a way that
would introduce such a logic error.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-patch.c                | 4 ++--
 daemon.c                   | 2 +-
 http-backend.c             | 2 +-
 http.c                     | 5 +++--
 remote-curl.c              | 2 +-
 run-command.c              | 2 +-
 t/helper/test-subprocess.c | 2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 8c41cdfe39b..573eef0cc4a 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -413,7 +413,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		strvec_push(&args, ps->items[i].original);
 
 	setup_child_process(s, &cp, NULL);
-	cp.argv = args.v;
+	strvec_pushv(&cp.args, args.v);
 	res = capture_command(&cp, plain, 0);
 	if (res) {
 		strvec_clear(&args);
@@ -431,7 +431,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 
 		setup_child_process(s, &colored_cp, NULL);
 		xsnprintf((char *)args.v[color_arg_index], 8, "--color");
-		colored_cp.argv = args.v;
+		strvec_pushv(&colored_cp.args, args.v);
 		colored = &s->colored;
 		res = capture_command(&colored_cp, colored, 0);
 		strvec_clear(&args);
diff --git a/daemon.c b/daemon.c
index b1fcbe0d6fa..8df21f2130c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -922,7 +922,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 #endif
 	}
 
-	cld.argv = cld_argv.v;
+	strvec_pushv(&cld.args, cld_argv.v);
 	cld.in = incoming;
 	cld.out = dup(incoming);
 
diff --git a/http-backend.c b/http-backend.c
index 3d6e2ff17f8..4dd4d939f8a 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -480,7 +480,7 @@ static void run_service(const char **argv, int buffer_input)
 		strvec_pushf(&cld.env_array,
 			     "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
 
-	cld.argv = argv;
+	strvec_pushv(&cld.args, argv);
 	if (buffer_input || gzipped_request || req_len >= 0)
 		cld.in = -1;
 	cld.git_cmd = 1;
diff --git a/http.c b/http.c
index f92859f43fa..229da4d1488 100644
--- a/http.c
+++ b/http.c
@@ -2126,8 +2126,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 
 	ip.git_cmd = 1;
 	ip.in = tmpfile_fd;
-	ip.argv = preq->index_pack_args ? preq->index_pack_args
-					: default_index_pack_args;
+	strvec_pushv(&ip.args, preq->index_pack_args ?
+		     preq->index_pack_args :
+		     default_index_pack_args);
 
 	if (preq->preserve_index_pack_stdout)
 		ip.out = 0;
diff --git a/remote-curl.c b/remote-curl.c
index d69156312bd..0dabef2dd7c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1061,7 +1061,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	client.in = -1;
 	client.out = -1;
 	client.git_cmd = 1;
-	client.argv = client_argv;
+	strvec_pushv(&client.args, client_argv);
 	if (start_command(&client))
 		exit(1);
 	write_or_die(client.in, preamble->buf, preamble->len);
diff --git a/run-command.c b/run-command.c
index f40df01c772..620a06ca2f5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1039,7 +1039,7 @@ int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
 				 const char *const *env, const char *tr2_class)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	cmd.argv = argv;
+	strvec_pushv(&cmd.args, argv);
 	cmd.no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
 	cmd.git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
 	cmd.stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
diff --git a/t/helper/test-subprocess.c b/t/helper/test-subprocess.c
index 92b69de6352..ff22f2fa2c5 100644
--- a/t/helper/test-subprocess.c
+++ b/t/helper/test-subprocess.c
@@ -15,6 +15,6 @@ int cmd__subprocess(int argc, const char **argv)
 		argv++;
 	}
 	cp.git_cmd = 1;
-	cp.argv = (const char **)argv + 1;
+	strvec_pushv(&cp.args, (const char **)argv + 1);
 	return run_command(&cp);
 }
-- 
2.34.0.831.gd33babec0d1

