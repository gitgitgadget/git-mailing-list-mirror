From: Cole Minnaar <cole.minnaar@gmail.com>
Subject: [PATCH/RFC v2 2/2] submodule: modify clone command to recursively shallow clone submodules
Date: Mon, 15 Sep 2014 12:42:01 +0200
Message-ID: <1410777721-602-2-git-send-email-cole.minnaar@gmail.com>
References: <1410777721-602-1-git-send-email-cole.minnaar@gmail.com>
Cc: Cole Minnaar <cole.minnaar@gmail.com>, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 12:42:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTTkD-00069C-E6
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 12:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427AbaIOKmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 06:42:19 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37723 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbaIOKmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 06:42:16 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so3921348wib.14
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lvm3uFBurNJnjXek6DdZNcU47TXtnoy9VGcN8SrULQw=;
        b=dlD6g+gp/ch1NjeTTa2RhbzULUS3l9HdrrobdrKa3mybP9Hkapymhxh7pxyydhp2qm
         /Fl5Liint4ESwirCnBuXVdBECdx1J+J7wziWwLYJtssdSANocoKZg5C9VoT3ZpPYdoHh
         nwXW0eUTd/7Q/aR8WcOxQGHiCwo7XpKOLV4V8cHp2MfG43juyNg8vUKxqot1zpIthwsO
         i8Qv8AXh9OxxB5rw4odo5wBVUtLb+moii2UoYTPARUF4wxawNpxfHlJof5KIKP2o0EpF
         Ewm97+cJcG7uEWt7Pk8HsSU6TY7ra+cvE6vMN/BNY22shVTaiuqRX/wvOn6/BgH7hbtY
         JiKQ==
X-Received: by 10.180.80.38 with SMTP id o6mr22430153wix.19.1410777734200;
        Mon, 15 Sep 2014 03:42:14 -0700 (PDT)
Received: from localhost.localdomain (196-210-108-164.dynamic.isadsl.co.za. [196.210.108.164])
        by mx.google.com with ESMTPSA id cj7sm14300982wjc.37.2014.09.15.03.42.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Sep 2014 03:42:13 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.240.g8a0e823
In-Reply-To: <1410777721-602-1-git-send-email-cole.minnaar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257048>

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
index 0363d00..7621251 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -178,7 +178,8 @@ objects from the source repository into a pack in the cloned repository.
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-	specified number of revisions.
+	specified number of revisions. If `--recursive` was also specified
+	the depth value will be passed to all submodules within when cloning.
 
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
@@ -192,6 +193,8 @@ objects from the source repository into a pack in the cloned repository.
 	initial cloning.  If the HEAD at the remote did not point at any
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
+	If `--recursive` was also specified, this option will be passed to
+	all submodules when cloning.
 
 --recursive::
 --recurse-submodules::
diff --git a/builtin/clone.c b/builtin/clone.c
index dd4092b..b27917c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -48,6 +48,7 @@ static int option_verbosity;
 static int option_progress = -1;
 static struct string_list option_config;
 static struct string_list option_reference;
+static struct argv_array argv_submodule_cmd = ARGV_ARRAY_INIT;
 
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
2.1.0.240.g8a0e823
