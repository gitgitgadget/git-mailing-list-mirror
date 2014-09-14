From: Cole Minnaar <cole.minnaar@gmail.com>
Subject: [PATCH/RFC 2/2] submodule: modify clone command to recursively shallow clone submodules
Date: Sun, 14 Sep 2014 12:38:37 +0200
Message-ID: <0a7689bea41b2a4714380bb7b351e92f31a64e7b.1410691049.git.cole.minnaar@gmail.com>
References: <ede7b63c6028591281a7eefea5e9cd45cccd0a93.1410691049.git.cole.minnaar@gmail.com>
Cc: Cole Minnaar <cole.minnaar@gmail.com>, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 12:38:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT7Cm-0007Kt-7N
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 12:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbaINKir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 06:38:47 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34781 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbaINKiq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 06:38:46 -0400
Received: by mail-wg0-f47.google.com with SMTP id y10so2608521wgg.30
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rq9U5wW1cQYkStApVT5XddRxrp1ZmvCB5F4/K9oKuEk=;
        b=Gkg+HEdt9ZJom9OTGy+7YX4gkjnO+d7r6hyEMCgYGfTNxbM2cKaK7LzdEahzSlYNOz
         HnYDaSKllZbkF9Q53HYucFB6/KKKnV02caIopn95BHl1PgPjPn82+mh1XlDJ2wFn/7tf
         Z5Nk1DSvuwxUaKFn4vdUL6QBM3csvkw8or3jhs1dE0flo+5JX3SleA3TZ7PBzWYCPsCi
         U+c1ZHdzmUIvM8GMFc09cfOkEjknBxrbfwGQl9XYh9y3boSq90NlIi5J+BVO6vusO9C2
         FappgLZgi38qZkAk8bG65QJrxFICspdkI84ngiZ4DQyRKO3iu7xTyIQsUBlOuuqXTa5X
         lpGA==
X-Received: by 10.180.89.243 with SMTP id br19mr14709791wib.41.1410691124762;
        Sun, 14 Sep 2014 03:38:44 -0700 (PDT)
Received: from localhost.localdomain (196-210-108-164.dynamic.isadsl.co.za. [196.210.108.164])
        by mx.google.com with ESMTPSA id wr8sm10703076wjb.20.2014.09.14.03.38.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Sep 2014 03:38:44 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.238.gce1d3a9.dirty
In-Reply-To: <ede7b63c6028591281a7eefea5e9cd45cccd0a93.1410691049.git.cole.minnaar@gmail.com>
In-Reply-To: <ede7b63c6028591281a7eefea5e9cd45cccd0a93.1410691049.git.cole.minnaar@gmail.com>
References: <ede7b63c6028591281a7eefea5e9cd45cccd0a93.1410691049.git.cole.minnaar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257014>

When cloning a repository that contains submodules and specifying the
`--depth` option to the 'git clone' command, the top level repository will be
cloned with the specified depth, but all submodules within the
repository will be cloned in their entirety.

Modified 'git clone' to pass the `--depth` option, if specified, to any
submodule clone commands.
Modified 'git clone' to pass the `--no-single-branch`, if specified, to any
submodule clone commands.

Signed-off-by: Cole Minnaar <cole.minnaar@gmail.com>
---
 Documentation/git-clone.txt |  5 ++++-
 builtin/clone.c             | 15 +++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 0363d00..f2fd8c8 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -178,7 +178,8 @@ objects from the source repository into a pack in the cloned repository.
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-	specified number of revisions.
+	specified number of revisions. If `--recursive` was also specified,
+	the depth value will be passed to all submodules within when cloning.
 
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
@@ -192,6 +193,8 @@ objects from the source repository into a pack in the cloned repository.
 	initial cloning.  If the HEAD at the remote did not point at any
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
+	If `--recursive` was also specified, this option will be passed
+	to all submodules when cloning.
 
 --recursive::
 --recurse-submodules::
diff --git a/builtin/clone.c b/builtin/clone.c
index dd4092b..c906d8e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -48,6 +48,7 @@ static int option_verbosity;
 static int option_progress = -1;
 static struct string_list option_config;
 static struct string_list option_reference;
+statis struct argv_array argv_submodule_cmd = ARGV_ARRAY_INIT;
 
 static int opt_parse_reference(const struct option *opt, const char *arg, int unset)
 {
@@ -100,10 +101,6 @@ static struct option builtin_clone_options[] = {
 	OPT_END()
 };
 
-static const char *argv_submodule[] = {
-	"submodule", "update", "--init", "--recursive", NULL
-};
-
 static char *get_repo_path(const char *repo, int *is_bundle)
 {
 	static char *suffix[] = { "/.git", "", ".git/.git", ".git" };
@@ -663,8 +660,14 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive)
-		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+	if (!err && option_recursive) {
+		argv_array_pushl(&argv_submodule_cmd, "submodule", "update", "--init", "--recursive", NULL);
+		if (option_depth)
+			argv_array_pushf(&argv_submodule_cmd, "--depth=%d", atoi(option_depth));
+		if (!option_single_branch)
+			argv_array_pushl(&argv_submodule_cmd, "--no-single-branch", NULL);
+		err = run_command_v_opt(argv_submodule_cmd.argv, RUN_GIT_CMD);
+	}
 
 	return err;
 }
-- 
2.1.0.238.gce1d3a9.dirty
