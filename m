From: XZS <d.f.fischer@web.de>
Subject: [PATCH/RFC/GSoC 1/2] count recursion depth
Date: Thu, 21 Apr 2016 11:15:21 +0200
Message-ID: <821b86c5276488425e60c5c559394c919daba282.1459946531.git.d.f.fischer@web.de>
References: <cover.1459946531.git.d.f.fischer@web.de>
Cc: XZS <d.f.fischer@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 11:15:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atAiL-0006aU-FB
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 11:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbcDUJPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 05:15:48 -0400
Received: from mout.web.de ([212.227.15.4]:58486 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbcDUJPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 05:15:40 -0400
Received: from storm.fritz.box ([95.116.240.233]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LqDTc-1bNocm0T0S-00djfa; Thu, 21 Apr 2016 11:15:32
 +0200
X-Mailer: git-send-email 2.8.0
In-Reply-To: <cover.1459946531.git.d.f.fischer@web.de>
In-Reply-To: <cover.1459946531.git.d.f.fischer@web.de>
References: <cover.1459946531.git.d.f.fischer@web.de>
X-Provags-ID: V03:K0:xYLBObcjRRPyOv+qtF2LxBG33+yuE8c+nDlVluKIEB1hb4QXrwa
 I1/8PFMdHtKVETeu+5x8SjK50gBH/ZRzmes62iyUa6m2aC2VfrAYbQ+W2tHIuDxP+5/FHvm
 FAYh1obES3mGT3f15bAid5/MOtPx7lWRDam5nQpijocwddMLtJOV/Y0U0i7a2I3w+4UBPlk
 YYkobq6ZmH7UU29vfRe+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bCRU8YOwo64=:l6YZ3u/fxmZxMyKVA/S1xG
 5OedKQ/vxTMO3Ep5OPj6Pj5c1MjLMZUE//tfQCfopQFdOJhhuDfjTx5uyJdkTNNkaYNVBxcEy
 cYE8tnGIvZpbbOqnHnA30w5Ufup+aUcC5ZxGd/vuyxds+GyeXQgSx26+wr3NIEnp6ICC6SULf
 ua4VfHQ/IA3GNzA8ABd7LF/Eq50HDa2BquTZ5aV95G07qI2Hf6N6FK4L/5ZWTYNUzc3HHtD8m
 tRyAMPn5iD23a0tD0xp9spI3ce6JY4d1+pdW7z31uvHBEMTLLdyytuXWvP1G+9EOKUkgUwAjQ
 lX0lQ5knTz0qTnahB5JmvRRMhCX6AmWPcsi4zd9ltq36NMgzs8968jbZ2xxXF4h7yxlx71DI3
 e4b+aDKuCf0JxxRODzDcaH9yAY62Wq9wI2CSdHDLmclCiVQiO1iH77LaUh1z3T56MWmfPW3jd
 L335W62orS9fvrQb1Rrh5WRVK7MgYfwJa9H280DcFQVhoc27sAfZ8jd7FeTrty1/LxITwOK7t
 yMmAEELv5JNjPYGtIDRukQhDvstbpPPdTpYXl0Aoycunr5hPeNqOvppwUdjkIMIjRbq9EmA9u
 dKrD9f2nx3vlkjcAivK/jnYtsCN5yLQAEqqYF09XmGWxPPPFeCEAmQQrl8Km2OrgpoebZZAAx
 8owrAeZSirC+w423K51hUnQzVSajkz2kVKNGZJDeNzSLN9w5d4iXkpdmWyMOqn3UbOGcM75d+
 GR4gJ7s9jtqXbhVxwQfn9GqhlJk/h1gjiqQ/UaAeyM3V2VJv6Vg83/ZkVs4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292101>

Some commands may want to act differently when called transitively by
other git commands in contrast to when called by the user directly. The
variable recursion_depth provides all built-ins with a way to tell these
cases apart.

Scripts can use the underlying environment variable GIT_RECURSION_DEPTH
to the same purpose.

Wrappers around git can intentionally set GIT_RECURSION_DEPTH to ensure
a command acts as if it was called internally.

Signed-off-by: XZS <d.f.fischer@web.de>
---
 cache.h                    |  1 +
 git.c                      | 17 +++++++++++++++++
 t/t0001-init.sh            |  1 +
 t/t0120-recursion-depth.sh | 17 +++++++++++++++++
 4 files changed, 36 insertions(+)
 create mode 100755 t/t0120-recursion-depth.sh

diff --git a/cache.h b/cache.h
index 9f09540..105607c 100644
--- a/cache.h
+++ b/cache.h
@@ -1777,6 +1777,7 @@ struct startup_info {
 	const char *prefix;
 };
 extern struct startup_info *startup_info;
+extern int recursion_depth;
 
 /* merge.c */
 struct commit_list;
diff --git a/git.c b/git.c
index 968a8a4..0bcc7b4 100644
--- a/git.c
+++ b/git.c
@@ -25,6 +25,7 @@ static const char *env_names[] = {
 };
 static char *orig_env[4];
 static int save_restore_env_balance;
+int recursion_depth;
 
 static void save_env_before_alias(void)
 {
@@ -630,12 +631,28 @@ static void restore_sigpipe_to_default(void)
 	signal(SIGPIPE, SIG_DFL);
 }
 
+static int get_recursion_depth(void)
+{
+	const char *envrec = getenv("GIT_RECURSION_DEPTH");
+	return envrec ? strtol(envrec, NULL, 10) : 0;
+}
+
+static int set_recursion_depth(int depth)
+{
+	char number[10]; // TODO compute length
+	snprintf(number, sizeof(number), "%i", depth);
+	return setenv("GIT_RECURSION_DEPTH", number, 1);
+}
+
 int main(int argc, char **av)
 {
 	const char **argv = (const char **) av;
 	const char *cmd;
 	int done_help = 0;
 
+	recursion_depth = get_recursion_depth();
+	set_recursion_depth(recursion_depth + 1);
+
 	cmd = git_extract_argv0_path(argv[0]);
 	if (!cmd)
 		cmd = "git-help";
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index a5b9e7a..69e7532 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -93,6 +93,7 @@ test_expect_success 'No extra GIT_* on alias scripts' '
 		sed -n \
 			-e "/^GIT_PREFIX=/d" \
 			-e "/^GIT_TEXTDOMAINDIR=/d" \
+			-e "/^GIT_RECURSION_DEPTH=/d" \
 			-e "/^GIT_/s/=.*//p" |
 		sort
 	EOF
diff --git a/t/t0120-recursion-depth.sh b/t/t0120-recursion-depth.sh
new file mode 100755
index 0000000..5aeb71a
--- /dev/null
+++ b/t/t0120-recursion-depth.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='recursion counter'
+
+. ./test-lib.sh
+
+test_expect_success 'recursion counter is 1 on direct run' '
+	git config alias.one "!echo \$GIT_RECURSION_DEPTH" &&
+	test "$(git one)" -eq 1
+'
+
+test_expect_success 'recursion counter is greater 1 on transitive run' '
+	git config alias.two "!git one" &&
+	test "$(git two)" -gt 1
+'
+
+test_done
-- 
2.8.0
